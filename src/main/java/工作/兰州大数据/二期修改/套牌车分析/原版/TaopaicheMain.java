package 工作.兰州大数据.二期修改.套牌车分析.原版;

import org.apache.commons.lang.StringUtils;
import org.apache.spark.Accumulator;
import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaPairRDD;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.api.java.function.Function;
import org.apache.spark.api.java.function.Function2;
import org.apache.spark.api.java.function.PairFunction;
import org.apache.spark.api.java.function.VoidFunction;
import org.apache.spark.sql.DataFrame;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SQLContext;
import org.apache.spark.sql.hive.HiveContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import scala.Tuple2;
import 工作.兰州大数据.二期修改.过滤连续重复的记录.原版.DateUtil;
import 工作.兰州大数据.二期修改.过滤连续重复的记录.原版.QuerySort;
import 工作.兰州大数据.二期修改.过滤连续重复的记录.原版.StringBufferAcc2;
import 工作.兰州大数据.二期修改.过滤连续重复的记录.原版.TypeCaseHelper;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

public class TaopaicheMain {
	private static final Logger logger = LoggerFactory.getLogger(TaopaicheMain.class);
	static String taopai=" AND PLATE_COLOR != 3 AND PLATE_COLOR != 7 and plate_no not like '%11111' and vehicle_score>0.9"
			+ " and section_id !=4162 and section_id != 4163 and section_id !=4164 and section_id != 4166";

	/**
	 * 核心数据处理，出现问题一律往上抛出异常 套牌车定位 spark实现测试类 实现思路： 用jdbc方式获取数据到spark
	 * --->拆分数据为(车牌号：唯一标识_通过时间_卡口X坐标_卡口Y坐标) --->使用reducebykey算子合并同车牌号数据
	 * --->创建累加器 --->使用foreach算子过滤数据，将符合条件的数据主键id放入累加器中 --->创建广播变量
	 * --->使用foreachPartition算子过滤数据，与广播变量中的套牌车ID比较，将符合条件的数据存入数据库中
	 * 
	 * @throws Exception
	 */

	public static void main(String[] args) {
		String runDate = null;
		String type=null;
		if (args != null && args.length != 0) {
			if (args[0] != null && args[0] != "") {
				runDate = args[0];
				type=args[1];
			}
		}
		JavaSparkContext sparkContext = null;
		SQLContext sqlContext = null;
		try {
			SparkConf conf = new SparkConf();
			conf.setAppName("jcbigdata-taopaiche");
			sparkContext = new JavaSparkContext(conf);
			sqlContext = new HiveContext(sparkContext);

			Date nowDate = DateUtil.getNowDate(); // 当前执行日期(不含时分秒)
			String nowTime = DateUtil.getNowTimeStr();
			Date yesterday = DateUtil.distanceDay(nowDate, -1); // 当前凌晨计算昨天一天的数据
			String jisuanRi = (runDate != null ? runDate : DateUtil.date2String(yesterday, "yyyy-MM-dd"));
			String jisuanYue = DateUtil.date2String(DateUtil.string2Date(jisuanRi, "yyyy-MM-dd"), "yyyy-MM");
			sqlContext.sql("use default");
			String sql = "select a.ROWKEY, a.PLATE_NO, a.PLATE_COLOR, a.PLATE_COLOR_NAME,"
					+ " a.SECTION_ID, a.SECTION_NAME, a.SECTION_MAP_X, a.SECTION_MAP_Y,a.INDATE "
					+ " from "
					+ " (select ROWKEY, PLATE_NO, PLATE_COLOR, PLATE_COLOR_NAME,"
					+ " SECTION_ID, SECTION_NAME, SECTION_MAP_X, SECTION_MAP_Y,INDATE from detection_vehicle_all "
					+ " WHERE 1=1 AND ri = '" + jisuanRi + "' " + taopai +")a"
					+ " JOIN "
					+ "(select plate_no,plate_color from daily_count "
					+ " WHERE 1=1 AND ri = '" + jisuanRi + "'"
					+ " group by plate_no,plate_color having count(*) > 1) b "
					+ " on a.plate_no=b.plate_no and a.plate_color=b.plate_color ";
			DataFrame jdbcDF = sqlContext.sql(sql);
			System.out.println(sql);
					
			JavaRDD<Row> resultRowRDD = jdbcDF.javaRDD().coalesce(300,true);

			// 拆分数据为(车牌号：唯一标识_通过时间_卡口X坐标_卡口Y坐标)
			JavaPairRDD<String, String> pairRDD = resultRowRDD.mapToPair(new PairFunction<Row, String, String>() {
				private static final long serialVersionUID = 1L;

				@Override
				public Tuple2<String, String> call(Row row) throws Exception {
					String ROWKEY = row.getAs("ROWKEY");
					String PLATE_NO = row.getAs("PLATE_NO");
					Double PLATE_COLOR = TypeCaseHelper.convert2DoubleSafe(row.getAs("PLATE_COLOR"));
					String PLATE_COLOR_NAME = row.getAs("PLATE_COLOR_NAME");
					String INDATE = row.getAs("INDATE");
					Double SECTION_MAP_X = TypeCaseHelper.convert2DoubleSafe(row.getAs("SECTION_MAP_X"));
					Double SECTION_MAP_Y = TypeCaseHelper.convert2DoubleSafe(row.getAs("SECTION_MAP_Y"));
					String SECTION_NAME = row.getAs("SECTION_NAME");
					Double SECTION_ID = TypeCaseHelper.convert2DoubleSafe(row.getAs("SECTION_ID"));
					return new Tuple2<String, String>(PLATE_NO + "_" + PLATE_COLOR_NAME + "_" + PLATE_COLOR,
							ROWKEY + "_" + SECTION_MAP_X + "_" + SECTION_MAP_Y + "_" + INDATE + "_" + SECTION_NAME + "_"
									+ SECTION_ID);
				}
			});
		
			// 使用reducebykey算子合并同车牌号数据
			JavaPairRDD<String, String> reduceRDD = pairRDD.reduceByKey(new Function2<String, String, String>() {
				private static final long serialVersionUID = 1L;

				@Override
				public String call(String v1, String v2) throws Exception {
					return v1 + "&" + v2;
				}
			});
			//12345--> rowkey+indate
			JavaPairRDD<String, String> filterRDD = reduceRDD.filter(new Function<Tuple2<String,String>, Boolean>() {
				
				@Override
		        public Boolean call(Tuple2<String, String> v1)
		                throws Exception
		              {
		                return Boolean.valueOf(((String)v1._2).contains("&"));
		              }

			});
			// 创建累加器
			final Accumulator<StringBuffer> acc = sparkContext.accumulator(null, new StringBufferAcc2());

			// 使用foreach算子过滤数据，将符合条件的数据放到累加器中
			filterRDD.foreach(new VoidFunction<Tuple2<String, String>>() {
				private static final long serialVersionUID = 1L;
				@Override
				public void call(Tuple2<String, String> t2) throws Exception {
					
					// "ID+"_"+SECTION_MAP_X+"_"+SECTION_MAP_Y+"_"+INDATE &
					List<QuerySort> list2=new ArrayList<QuerySort>();
	            	String key = t2._1;
					String value = t2._2;
					String[] values = value.split("&");
					int n=values.length;
					
					for(int i=0;i<n;i++){
						QuerySort sort=new QuerySort();
						String va1=values[i];
						String v1[]=va1.split("_");
						String indate=v1[3];
						Date timeDate = DateUtil.string2DateSafe(indate, "yyyy-MM-dd HH:mm:ss");
						Long time = timeDate.getTime() / 1000;
						sort.setDatetime(time);
						sort.setId(va1);
						list2.add(sort);
					}
					Collections.sort(list2);
						String v=null;
						StringBuffer sb=new StringBuffer();
						for(QuerySort l:list2){
							v=l.getId();
							sb.append(v+"&");
						
						}
						value=sb.toString();
						values = value.split("&");
//					for(int i=0;i<n;i++){
//						String va1=values[i];
//						String v1[]=va1.split("_");
//						String indate=v1[3];
//					System.out.println(N+"---"+key+"___"+indate);
//					}
					// 遍历values 进行业务逻辑处理
					for (int i = 0; i < n; i++) {
						String value1 = values[i];
						String[] items1 = value1.split("_");
						String rowkey1 = items1[0];
						String mapX1 = items1[1];
						String mapY1 = items1[2];
						String indate1 = items1[3];
						String sectionName1 = items1[4];
						String sectionId1 = items1[5];
						for (int k = i + 1; k < n; k++) {
							String value2 = values[k];
							String[] items2 = value2.split("_");
							String rowkey2 = items2[0];
							String mapX2 = items2[1];
							String mapY2 = items2[2];
							String indate2 = items2[3];
							String sectionName2 = items2[4];
							String sectionId2 = items2[5];
							double driveDistance = ExtendUtils.getDriveDistanceKm(120.0, indate1, indate2);
							Date date1 = DateUtil.string2Date(indate1, "yyyy-MM-dd HH:mm:ss");
							Date date2 = DateUtil.string2Date(indate2, "yyyy-MM-dd HH:mm:ss");
							long sec = (date2.getTime() - date1.getTime()) / 1000;
							double sectionDistance = ExtendUtils.getSectionDistanceKm(mapX1, mapY1, mapX2, mapY2);
							if (sec>300 && sectionDistance > 0 && driveDistance > 0 && driveDistance < sectionDistance) {
								// 行驶距离<卡口距离 则为套牌车
								acc.add(new StringBuffer(key + "_" +  rowkey1 + "@" + rowkey2 + "_" + indate1 + "_" + indate2 + "_" 
										+ sectionName1 + "_" + sectionName2 + "_"
										+ sectionId1 + "_" + sectionId2 + "_" + mapX1 + "_" + mapY1 + "_" + mapX2 + "_" + mapY2));
					
							}
						}
					}
				}
			});
			String accValue = acc.value().toString();// 累加器中字符串例如
//											 {"key":"京123_蓝色_1","value":["2016-07-10
//											 10:01:00_凤阳A交接处_3","2016-07-10蓝色_1","infos":["2016-07-10
//											 10:01:00_凤阳A交接处_3","2016-07-10
//											 10:03:00_凤阳B交接处_3"]}
			List<TaopaicheResult> resultList = new ArrayList<TaopaicheResult>();
			if(!StringUtils.isEmpty(accValue)){
				String[] result = accValue.split(",");
				if(result != null && result.length > 0){
					for(int h=0; h<result.length; h++){
						TaopaicheResult tp= new TaopaicheResult();
						String oneValue = result[h];
			        	String res[] = oneValue.split("_");
			        	String plate_no=res[0];
			        	String plate_color_name=res[1];
			        	Double plate_color=TypeCaseHelper.convert2DoubleSafe(res[2]);
			        	String rowkey1=res[3];
			        	String indate1=res[4];
			        	String indate2=res[5];
			        	String section_name1=res[6];
			        	String section_name2=res[7];
			        	Double section_id1=TypeCaseHelper.convert2DoubleSafe(res[8]);
			        	Double section_id2=TypeCaseHelper.convert2DoubleSafe(res[9]);
			        	Double section_mapx1=TypeCaseHelper.convert2DoubleSafe(res[10]);
			        	Double section_mapy1=TypeCaseHelper.convert2DoubleSafe(res[11]);
			        	Double section_mapx2=TypeCaseHelper.convert2DoubleSafe(res[12]);
			        	Double section_mapy2=TypeCaseHelper.convert2DoubleSafe(res[13]);

			        	tp.setPlate_no(plate_no);
			        	tp.setPlate_color(plate_color);
			        	tp.setPlate_color_name(plate_color_name);
			        	tp.setRowkey1(rowkey1);
			        	tp.setIndate1(indate1);
			        	tp.setIndate2(indate2);
			        	tp.setSection_id1(section_id1);
			        	tp.setSection_id2(section_id2);
			        	tp.setSection_name1(section_name1);
			        	tp.setSection_name2(section_name2);
			        	tp.setSection_mapx1(section_mapx1);
			        	tp.setSection_mapy1(section_mapy1);
			        	tp.setSection_mapx2(section_mapx2);
			        	tp.setSection_mapy2(section_mapy2);
			        	tp.setDay(indate1.substring(0,10));
			        	resultList.add(tp);
					}
				}
			}
		
			// 把数据创建到DataFrame，存入hive表里
			DataFrame dataFrame = sqlContext.createDataFrame(resultList, TaopaicheResult.class);
			dataFrame.registerTempTable("daily_oneplate_morebrand2_tmp");
			String hql = "insert overwrite table daily_oneplate_morebrand partition(yue='" + jisuanYue + "',ri='"
					+ jisuanRi
					+ "')" 
					+ "select plate_no,plate_color,plate_color_name,rowkey1,indate1,section_id1,section_name1,section_mapx1,section_mapy1,"
					+ "indate2,section_id2,section_name2,section_mapx2,section_mapy2,day "
					+ "from"
					+ " daily_oneplate_morebrand2_tmp";
			sqlContext.sql("use default");
			sqlContext.sql(hql);
			List<Log> log=new ArrayList<Log>();
			Log t= new Log();
			String project="套牌车分析";
			String table_name="DAILY_ONEPLATE_MOREBRAND";
			String data_time=jisuanRi;
			String run_time=nowTime;
			String run_type=type;
			t.setProject(project);
			t.setTable_name(table_name);
			t.setData_time(data_time);
			t.setRun_time(run_time);
			t.setRun_type(run_type);
			log.add(t);
			DataFrame run_log=sqlContext.createDataFrame(log,Log.class);
			run_log.registerTempTable("log_cm");
			sqlContext.sql("use default");
			sqlContext.sql("insert into table daily_log partition(part='DAILY_ONEPLATE_MOREBRAND') "
					+ "select project,table_name,data_time,run_time,run_type from log_cm");
		} catch (Exception e) {// 记载日志
			logger.error(ExceptionUtilsExt.printStackTrace(e));
			e.printStackTrace();
		} finally {
			if (sparkContext != null)
				sparkContext.close();
		}
	}
}
