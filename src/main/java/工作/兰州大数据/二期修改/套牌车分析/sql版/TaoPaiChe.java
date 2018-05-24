package 工作.兰州大数据.二期修改.套牌车分析.sql版;

import org.apache.spark.SparkConf;
import org.apache.spark.SparkContext;
import org.apache.spark.sql.hive.HiveContext;
import org.apache.spark.sql.types.DataTypes;
import 工作.兰州大数据.二期修改.套牌车分析.原版.ExtendUtils;
import 工作.兰州大数据.二期修改.过滤连续重复的记录.原版.DateUtil;

import java.time.LocalDate;

/**
 * 套牌车分析 对每辆车的行车轨迹进行两两对比分析，筛选出在120KM/H速度下不可能出现在两个地方的车牌
 * 两次对比间隔时间必须大于300秒，且不能是同一卡口对比以及静止车辆对比
 * 
 * @author Administrator
 */
public class TaoPaiChe {
	public static void main(String[] args) {
		String taopai = " AND PLATE_COLOR != 3 AND PLATE_COLOR != 7 and plate_no not like '%11111' and vehicle_score>0.9"
				+ " and section_id !=4162 and section_id != 4163 and section_id !=4164 and section_id != 4166";
		String riqi = DateUtil.yestoday();
		String today = LocalDate.now().toString();
		String type = null;
		if (null != args && args.length != 0) {
			riqi = args[0];
			type = args[1];
		}
		String yue = riqi.substring(0, 7);
		SparkContext sc = new SparkContext(new SparkConf().setAppName("每日每车每卡口"));
		HiveContext spark = new HiveContext(sc);

		String sql = "SELECT a.ROWKEY, a.PLATE_NO, a.PLATE_COLOR, a.PLATE_COLOR_NAME,"
				+ " a.SECTION_ID, a.SECTION_NAME, a.SECTION_MAP_X, a.SECTION_MAP_Y,a.INDATE " + " from "
				+ " (select ROWKEY, PLATE_NO, PLATE_COLOR, PLATE_COLOR_NAME,"
				+ " SECTION_ID, SECTION_NAME, SECTION_MAP_X, SECTION_MAP_Y,INDATE from detection_vehicle_all "
				+ " WHERE 1=1 AND ri = '" + riqi + "' " + taopai + ")a" + " JOIN "
				+ "(select plate_no,plate_color from daily_count " + " WHERE 1=1 AND ri = '" + riqi + "'"
				+ " group by plate_no,plate_color having count(*) > 1) b "
				+ " on a.plate_no=b.plate_no and a.plate_color=b.plate_color ";
		spark.sql(sql).registerTempTable("t");
		// 不是套牌返回1，是套牌返回0
		spark.udf().register("judge", (Double x1, Double y1, Double x2, Double y2, String time1, String time2) -> {
			if (ExtendUtils.getSectionDistanceKm(x1, y1, x2, y2) <= ExtendUtils.getDriveDistanceKm(120.0, time1,
					time2)) {
				return 1;
			} else {
				return 0;
			}
		}, DataTypes.IntegerType);
		// 按车牌分组,时间排序，每组打序号
		spark.sql(
				"select *,unix_timestamp(indate) time ,row_number()over(partition by PLATE_NO,PLATE_COLOR_NAME,PLATE_COLOR order by indate) rank from t")
				.registerTempTable("a");

		// 套牌车结果集
		spark.sql(
				"select a.plate_no,a.plate_color,a.plate_color_name,a.rowkey rowkey1,a.indate indate1,a.section_id section_id1,a.section_name section_name1,a.section_mapx section_mapx1,a.section_mapy section_mapy1,"
						+ "b.indate indate2,b.section_id section_id2,b.section_name section_name2,b.section_mapx section_mapx2,b.section_mapy section_mapy2,substr(a.indate,0,10) day "
						+ "from a join a b "
						+ "on a.PLATE_NO = b.PLATE_NO and a.PLATE_COLOR=b.PLATE_COLOR and a.PLATE_COLOR_NAME = b.PLATE_COLOR_NAME and a.rank+1 = b.rank "
						+ "where b.time-a.time >300 and judge(a.SECTION_MAP_X, a.SECTION_MAP_Y,b.SECTION_MAP_X, b.SECTION_MAP_Y,a.indate,b.indate) = 0").registerTempTable("a");
		// 将结果放入daily_oneplate_morebrand
		spark.sql("INSERT OVERWRITE TABLE daily_oneplate_morebrand PARTITION(yue='"+yue+"',ri='"+riqi+"') SELECT * FROM a");
		//记录log
		spark.sql("insert into table daily_log partition(part='DAILY_ONEPLATE_MOREBRAND') SELECT "
				+ "'套牌车分析','DAILY_ONEPLATE_MOREBRAND','"+riqi+"','"+today+"','"+type+"'");
	}
}
