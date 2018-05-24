package 工作.兰州大数据.二期修改.过滤连续重复的记录.第二版;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataOutputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.spark.Accumulator;
import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaPairRDD;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
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
import 工作.兰州大数据.二期修改.过滤连续重复的记录.原版.ListAcc;
import 工作.兰州大数据.二期修改.过滤连续重复的记录.原版.QuerySort;
import 工作.兰州大数据.二期修改.过滤连续重复的记录.原版.TypeCaseHelper;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

public class Dataclean2 {
	private static final Logger logger = LoggerFactory.getLogger(Dataclean2.class);
	static String data_clean = "AND SECTION_ID is not null AND PLATE_NO not like '%\u65E0\u724C\u8F66%' "
			+ "and PLATE_NO not like '%\u672A%' and PLATE_COLOR_NAME !='\u672A\u77E5' AND VEHICLE_COLOR_NAME !='\u672A\u77E5' and  "
			+ "plate_right_y>200 and section_id != 4141 and device_id!=306";

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		String table = "source_detection_vehicle_all";
		String date =LocalDate.now().toString();
		String yue = date.substring(0, 7);
		if (args != null && args.length != 0) {
			if (args[0] != null && args[0] != "") {
				table = args[0];
				date = args[1];
				yue = date.substring(0, 7);
			}
		}
		JavaSparkContext sparkContext = null;
		SQLContext sqlContext = null;
		// hdfs 写文件
		FileSystem fs = null;
		Path path = null;
		try {
			String sql = " select * from " + table + " where 1=1 AND ri= '" + date + "'" + data_clean;
			System.out.println(sql);
			SparkConf conf = new SparkConf();
			conf.setAppName("jcbigdata-dataclean");
			conf.set("spark.storage.memoryFraction", "0.4");
			conf.set("spark.shuffle.memoryFraction", "0.4");
			conf.set("spark.shuffle.file.buffer", "64k");
			conf.set("spark.reducer.maxSizeInFlight", "96m");
			conf.set("spark.shuffle.io.retryWait", "10s");
			conf.set("spark.serializer", "org.apache.spark.serializer.KryoSerializer");
			conf.registerKryoClasses(new Class[] {Dataclean2.class,TypeCaseHelper.class});
			
			
			sparkContext = new JavaSparkContext(conf);
			sqlContext = new HiveContext(sparkContext);
			sqlContext.sql("ALTER TABLE source_detection_vehicle_all ADD IF NOT EXISTS PARTITION (yue='" + yue
					+ "',ri='" + date + "')");

			Configuration hdfsconf = new Configuration();
			fs = FileSystem.get(hdfsconf);
			path = new Path("/user/spark/import.txt");
			FSDataOutputStream out = fs.create(path);

			Date nowDate = DateUtil.getNowDate(); // 当前执行日期(不含时分秒)

			DataFrame jdbcDF = sqlContext.sql(sql);

			// 根据条件筛选出的数据
			JavaRDD<Row> resultRowRDD = jdbcDF.javaRDD();

			JavaPairRDD<String, String> pairRDD = resultRowRDD.mapToPair(new PairFunction<Row, String, String>() {
				private static final long serialVersionUID = 1L;

				@Override
				public Tuple2<String, String> call(Row r) throws Exception {
					// TODO Auto-generated method stub
					String rowkey = r.getAs("rowkey");
					String plate_no = r.getAs("plate_no");
					Double plate_score = TypeCaseHelper.convert2DoubleSafe(r.getAs("plate_score"));
					Double plate_color = TypeCaseHelper.convert2DoubleSafe(r.getAs("plate_color"));
					String plate_color_name = r.getAs("plate_color_name");
					Double vehicle_color = TypeCaseHelper.convert2DoubleSafe(r.getAs("vehicle_color"));
					String vehicle_color_name = r.getAs("vehicle_color_name");
					Double vehicle_type = TypeCaseHelper.convert2DoubleSafe(r.getAs("vehicle_type"));
					String vehicle_type_name = r.getAs("vehicle_type_name");
					Double vehicle_brand = TypeCaseHelper.convert2DoubleSafe(r.getAs("vehicle_brand"));
					String vehicle_brand_name = r.getAs("vehicle_brand_name");
					Double vehicle_brand_score = TypeCaseHelper.convert2DoubleSafe(r.getAs("vehicle_brand_score"));
					Double vehicle_child_brand = TypeCaseHelper.convert2DoubleSafe(r.getAs("vehicle_child_brand"));
					String vehicle_child_brand_name = r.getAs("vehicle_child_brand_name");
					String vehicle_brand_year = r.getAs("vehicle_brand_year");
					Double plate_left_x = TypeCaseHelper.convert2DoubleSafe(r.getAs("plate_left_x"));
					Double plate_left_y = TypeCaseHelper.convert2DoubleSafe(r.getAs("plate_left_y"));
					Double plate_right_x = TypeCaseHelper.convert2DoubleSafe(r.getAs("plate_right_x"));
					Double plate_right_y = TypeCaseHelper.convert2DoubleSafe(r.getAs("plate_right_y"));
					Double vehicle_rect_score = TypeCaseHelper.convert2DoubleSafe(r.getAs("vehicle_rect_score"));
					String indate = r.getAs("indate");
					Double device_id = TypeCaseHelper.convert2DoubleSafe(r.getAs("device_id"));
					String device_name = r.getAs("device_name");
					String device_type = r.getAs("device_type");
					Double data_type = TypeCaseHelper.convert2DoubleSafe(r.getAs("data_type"));
					String data_path = r.getAs("data_path");
					Double outtown_id = TypeCaseHelper.convert2DoubleSafe(r.getAs("outtown_id"));
					String outtown_name = r.getAs("outtown_name");
					Double section_id = TypeCaseHelper.convert2DoubleSafe(r.getAs("section_id"));
					String section_name = r.getAs("section_name");
					Double section_map_x = TypeCaseHelper.convert2DoubleSafe(r.getAs("section_map_x"));
					Double section_map_y = TypeCaseHelper.convert2DoubleSafe(r.getAs("section_map_y"));
					Double direction_id = TypeCaseHelper.convert2DoubleSafe(r.getAs("direction_id"));
					Double districts_id = TypeCaseHelper.convert2DoubleSafe(r.getAs("districts_id"));
					String districts_name = r.getAs("districts_name");
					Double kakouquan_id = TypeCaseHelper.convert2DoubleSafe(r.getAs("kakouquan_id"));
					String kakouquan_name = r.getAs("kakouquan_name");
					Integer vehicle_gj = TypeCaseHelper.convert2Integer(r.getAs("vehicle_gj"));
					Double vehicle_gj_score = TypeCaseHelper.convert2DoubleSafe(r.getAs("vehicle_gj_score"));
					Integer vehicle_njb = TypeCaseHelper.convert2Integer(r.getAs("vehicle_njb"));
					Double vehicle_njb_score = TypeCaseHelper.convert2DoubleSafe(r.getAs("vehicle_njb_score"));
					Integer vehicle_tc = TypeCaseHelper.convert2Integer(r.getAs("vehicle_tc"));
					Double vehicle_tc_score = TypeCaseHelper.convert2DoubleSafe(r.getAs("vehicle_tc_score"));
					Integer vehicle_aqd_main = TypeCaseHelper.convert2Integer(r.getAs("vehicle_aqd_main"));
					Double vehicle_aqd_main_score = TypeCaseHelper
							.convert2DoubleSafe(r.getAs("vehicle_aqd_main_score"));
					Integer vehicle_aqd_co = TypeCaseHelper.convert2Integer(r.getAs("vehicle_aqd_co"));
					Double vehicle_aqd_co_score = TypeCaseHelper.convert2DoubleSafe(r.getAs("vehicle_aqd_co_score"));
					Integer vehicle_ddh_main = TypeCaseHelper.convert2Integer(r.getAs("vehicle_ddh_main"));

					Double vehicle_ddh_main_score = TypeCaseHelper
							.convert2DoubleSafe(r.getAs("vehicle_ddh_main_score"));

					Integer vehicle_ddh_co = TypeCaseHelper.convert2Integer(r.getAs("vehicle_ddh_co"));
					Double vehicle_ddh_co_score = TypeCaseHelper.convert2DoubleSafe(r.getAs("vehicle_ddh_co_score"));
					Integer vehicle_zyb_main = TypeCaseHelper.convert2Integer(r.getAs("vehicle_zyb_main"));
					Double vehicle_zyb_main_score = TypeCaseHelper
							.convert2DoubleSafe(r.getAs("vehicle_zyb_main_score"));
					Integer vehicle_zyb_co = TypeCaseHelper.convert2Integer(r.getAs("vehicle_zyb_co"));
					Double vehicle_zyb_co_score = TypeCaseHelper.convert2DoubleSafe(r.getAs("vehicle_zyb_co_score"));
					Integer vehicle_czh = TypeCaseHelper.convert2Integer(r.getAs("vehicle_zyb_co"));

					Double vehicle_czh_score = TypeCaseHelper.convert2DoubleSafe(r.getAs("vehicle_czh_score"));

					Integer vehicle_crz = TypeCaseHelper.convert2Integer(r.getAs("vehicle_crz"));
					Double vehicle_crz_score = TypeCaseHelper.convert2DoubleSafe(r.getAs("vehicle_crz_score"));

					Integer vehicle_xsb = TypeCaseHelper.convert2Integer(r.getAs("vehicle_xsb"));
					Double vehicle_xsb_score = TypeCaseHelper.convert2DoubleSafe(r.getAs("vehicle_xsb_score"));
					Integer vehicle_jsy_main = TypeCaseHelper.convert2Integer(r.getAs("vehicle_jsy_main"));
					Double vehicle_jsy_main_score = TypeCaseHelper
							.convert2DoubleSafe(r.getAs("vehicle_jsy_main_score"));
					Integer vehicle_jsy_co = TypeCaseHelper.convert2Integer(r.getAs("vehicle_jsy_co"));
					Double vehicle_jsy_co_score = TypeCaseHelper.convert2DoubleSafe(r.getAs("vehicle_jsy_co_score"));

					Integer vehicle_lt = TypeCaseHelper.convert2Integer(r.getAs("vehicle_lt"));

					Double vehicle_lt_score = TypeCaseHelper.convert2DoubleSafe(r.getAs("vehicle_lt_score"));
					Integer vehicle_cd = TypeCaseHelper.convert2Integer(r.getAs("vehicle_cd"));
					Double vehicle_cd_score = TypeCaseHelper.convert2DoubleSafe(r.getAs("vehicle_cd_score"));

					Integer vehicle_jsc = TypeCaseHelper.convert2Integer(r.getAs("vehicle_jsc"));
					Double vehicle_jsc_score = TypeCaseHelper.convert2DoubleSafe(r.getAs("vehicle_jsc_score"));

					Integer vehicle_hsj = TypeCaseHelper.convert2Integer(r.getAs("vehicle_hsj"));

					Double vehicle_hsj_score = TypeCaseHelper.convert2DoubleSafe(r.getAs("vehicle_hsj_score"));
					String device_code = r.getAs("device_code");

					return new Tuple2<String, String>(plate_no + "%" + plate_color, rowkey + "%" + plate_score + "%"
							+ plate_color_name + "%" + vehicle_color + "%" + vehicle_color_name + "%" + vehicle_type
							+ "%" + vehicle_type_name + "%" + vehicle_brand + "%" + vehicle_brand_name + "%"
							+ vehicle_brand_score + "%" + vehicle_child_brand + "%" + vehicle_child_brand_name + "%"
							+ vehicle_brand_year + "%" + plate_left_x + "%" + plate_left_y + "%" + plate_right_x + "%"
							+ plate_right_y + "%" + vehicle_rect_score + "%" + indate + "%" + device_id + "%"
							+ device_name + "%" + device_type + "%" + data_type + "%" + data_path + "%" + outtown_id
							+ "%" + outtown_name + "%" + section_id + "%" + section_name + "%" + section_map_x + "%"
							+ section_map_y + "%" + direction_id + "%" + districts_id + "%" + districts_name + "%"
							+ kakouquan_id + "%" + kakouquan_name + "%" + vehicle_gj + "%" + vehicle_gj_score + "%"
							+ vehicle_njb + "%" + vehicle_njb_score + "%" + vehicle_tc + "%" + vehicle_tc_score + "%"
							+ vehicle_aqd_main + "%" + vehicle_aqd_main_score + "%" + vehicle_aqd_co + "%"
							+ vehicle_aqd_co_score + "%" + vehicle_ddh_main + "%" + vehicle_ddh_main_score + "%"
							+ vehicle_ddh_co + "%" + vehicle_ddh_co_score + "%" + vehicle_zyb_main + "%"
							+ vehicle_zyb_main_score + "%" + vehicle_zyb_co + "%" + vehicle_zyb_co_score + "%"
							+ vehicle_czh + "%" + vehicle_czh_score + "%" + vehicle_crz + "%" + vehicle_crz_score + "%"
							+ vehicle_xsb + "%" + vehicle_xsb_score + "%" + vehicle_jsy_main + "%"
							+ vehicle_jsy_main_score + "%" + vehicle_jsy_co + "%" + vehicle_jsy_co_score + "%"
							+ vehicle_lt + "%" + vehicle_lt_score + "%" + vehicle_cd + "%" + vehicle_cd_score + "%"
							+ vehicle_jsc + "%" + vehicle_jsc_score + "%" + vehicle_hsj + "%" + vehicle_hsj_score + "%"
							+ device_code);
				}

			});
			// 使用reducebykey算子合并同车牌号数据
			// (key,value@value..)
			JavaPairRDD<String, String> reduceRDD = pairRDD.reduceByKey(new Function2<String, String, String>() {
				private static final long serialVersionUID = 1L;

				@Override
				public String call(String v1, String v2) throws Exception {
					// TODO Auto-generated method stub
					return v1 + "@" + v2;
				}

			});
			// 创建累加器
			final Accumulator<List<String>> acc = sparkContext.accumulator(null, new ListAcc());
			// 使用foreach算子过滤数据
			reduceRDD.foreach(new VoidFunction<Tuple2<String, String>>() {
				private static final long serialVersionUID = 1L;

				// (key,value@value..)
				@Override
				public void call(Tuple2<String, String> t2) throws Exception {
					// TODO Auto-generated method stub
					List<QuerySort> list2 = new ArrayList<QuerySort>();
					String key = t2._1;
					// (key,value@value..)
					String value = t2._2;// value@value..
					String[] values = value.split("@");
					int n = values.length;
					// 遍历每一个value,选时间和value 包装成QuerySort类,然后添加到list2
					for (int i = 0; i < n; i++) {
						QuerySort sort = new QuerySort();
						String va1 = values[i];
						String v1[] = va1.split("%");
						String indate = v1[18];
						Date timeDate = DateUtil.string2DateSafe(indate, "yyyy-MM-dd HH:mm:ss");
						Long time = timeDate.getTime() / 1000;
						sort.setDatetime(time);
						sort.setId(va1);
						list2.add(sort);
					}
					Collections.sort(list2);// 安照 QuerySort 排序 ????????????
					String v = null;
					StringBuffer sb = new StringBuffer();
					for (QuerySort l : list2) {
						v = l.getId();
						sb.append(v + "@");
					}
					// 排序之后再拼接成一条字符串???有序的字符串
					value = sb.toString();
					// 然后再转成value数组
					values = value.split("@");
					int i = 0;
					// 第一个位置的和剩下的对比
					for (int j = i + 1; j < n; j++) {
						String va1 = values[i];
						String v1[] = va1.split("%");// 字段数组
						String section_id1 = v1[26];
						String indate1 = v1[18];

						String va2 = values[j];
						String v2[] = va2.split("%");
						String section_id2 = v2[26];
						String indate2 = v2[18];
						// 发现不同的记录就放到累加器里,起始位置偏移
						if (!section_id1.equals(section_id2) && !indate1.equals(indate2)) {
							List a = new ArrayList();
							a.add(key + "%" + va1);
							acc.add(a);
							a.clear();
							a = null;
							i = j;
						}
					}
					String van = values[n - 1];// 最后一个位置的元素
					List a = new ArrayList();
					a.add(key + "%" + van);
					acc.add(a);
					a.clear();
					a = null;
				}
			});
			List<String> accValue = acc.value();
			for (String result : accValue) {

				String rs = "\n" + result + "%";
				out.writeUTF(rs);
			}
			System.out.println("_____" + accValue.size());
			out.flush();
			out.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (sparkContext != null)
				sparkContext.close();
			fs.close();
		}

	}

}
