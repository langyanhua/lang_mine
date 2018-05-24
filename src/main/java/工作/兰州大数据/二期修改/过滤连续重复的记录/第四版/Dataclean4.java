package 工作.兰州大数据.二期修改.过滤连续重复的记录.第四版;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataOutputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaPairRDD;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.sql.DataFrame;
import org.apache.spark.sql.SQLContext;
import org.apache.spark.sql.hive.HiveContext;
import scala.Tuple2;
import 工作.兰州大数据.二期修改.过滤连续重复的记录.原版.DateUtil;
import 工作.兰州大数据.二期修改.过滤连续重复的记录.原版.QuerySort;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

/**
 * 20号
 * 数据量4.66G文本  9542925(954万条) 1G=204万条多点
 * 经过sql过滤之后剩下6613872(661万条)
 * @author Administrator
 *
 */
public class Dataclean4 {
	static String data_clean = "AND SECTION_ID is not null AND PLATE_NO not like '%\u65E0\u724C\u8F66%' "
			+ "and PLATE_NO not like '%\u672A%' and PLATE_COLOR_NAME !='\u672A\u77E5' AND VEHICLE_COLOR_NAME !='\u672A\u77E5' and  "
			+ "plate_right_y>200 and section_id != 4141 and device_id!=306";

	public static void main(String[] args) throws IOException {
		String table = "source_detection_vehicle_all";
//		String date = LocalDate.now().toString();
		String date = "2018-05-20";
		String yue = date.substring(0, 7);
		if (args != null && args.length != 0) {
			if (args[0] != null && args[0] != "") {
				table = args[0];
				date = args[1];
				yue = date.substring(0, 7);
			}
		}
		SparkConf conf = new SparkConf().setAppName("jcbigdata-dataclean");
		conf.set("spark.storage.memoryFraction", "0.4");
		conf.set("spark.shuffle.memoryFraction", "0.4");
		conf.set("spark.shuffle.file.buffer", "96k");
		conf.set("spark.reducer.maxSizeInFlight", "96m");
		conf.set("spark.shuffle.io.retryWait", "10s");
//		conf.set("spark.driver.maxResultSize", "6g");
//		conf.set("spark.serializer", "org.apache.spark.serializer.KryoSerializer");
//		conf.registerKryoClasses(new Class[] {Dataclean3.class,TypeCaseHelper.class});
		JavaSparkContext jsc = new JavaSparkContext(conf);
		SQLContext sqlContext = new HiveContext(jsc);
		FileSystem fs = FileSystem.get(new Configuration());
		Path path = new Path("/user/spark/import.txt");
		FSDataOutputStream out = fs.create(path, true);
		sqlContext.sql("ALTER TABLE source_detection_vehicle_all ADD IF NOT EXISTS PARTITION (yue='" + yue + "',ri='"
				+ date + "')");
		String sql = " select * from " + table + " where ri= '" + date + "'" + data_clean;
		DataFrame df = sqlContext.sql(sql);
		//value之间的分隔符是'@',value字段的分隔符是'%'
		JavaPairRDD<String, String> reduceRDD = df.javaRDD().mapToPair(r -> new Tuple2("" + r.get(1) + r.get(3), r.mkString("%")))
				.reduceByKey((x, y) -> x + "@" + y);
		
		JavaRDD<String> flatMap = reduceRDD.flatMap(x->{
			List<QuerySort> list2 = new ArrayList<QuerySort>();
			//每條
			String value = x._2;
			String[] values = value.split("@");
			int n = values.length;
			for (int i = 0; i < n; i++) {
				QuerySort sort = new QuerySort();
				String va1 = values[i];
				String v1[] = va1.split("%");
				String indate = v1[20];
				Date timeDate = DateUtil.string2DateSafe(indate, "yyyy-MM-dd HH:mm:ss");
				Long time = timeDate.getTime() / 1000;
				sort.setDatetime(time);
				sort.setId(va1);
				list2.add(sort);
			}
			Collections.sort(list2);
			StringBuffer sb = new StringBuffer();
			list2.forEach(l->sb.append(l.getId() + "@"));
			values=sb.toString().split("@");
			int i = 0;
			
			List<String> arrayList = new ArrayList<>();
			for (int j = i + 1; j < n; j++) {
				String va1 = values[i];
				String v1[] = va1.split("%");// 字段数组
				String section_id1 = v1[28];
				String indate1 = v1[20];
				String va2 = values[j];
				String v2[] = va2.split("%");
				String section_id2 = v2[28];
				String indate2 = v2[20];
				// 发现不同的记录就放到list,起始位置偏移
				if (!section_id1.equals(section_id2) && !indate1.equals(indate2)) {
					i = j;	
				arrayList.add(va1);
				}
			}
			return  arrayList;
		});
		 
		if (fs.exists(new Path("/usr/lang/b"))) {
			fs.delete(new Path("/usr/lang/b"),true);
		}
        flatMap.saveAsTextFile("/usr/lang/b");
	}
}