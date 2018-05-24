package 工作.兰州大数据.二期修改.过滤连续重复的记录.sparkSql版;

import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.sql.DataFrame;
import org.apache.spark.sql.SaveMode;
import org.apache.spark.sql.hive.HiveContext;

import java.time.LocalTime;

public class HiveFilter2HDFS {
	public static void main(String[] args) {
		String table = "source_detection_vehicle_all";
		String date = "2018-05-20";
		String yue = date.substring(0, 7);
		if (null != args && args.length != 0) {
			if (args[0] != null && args[0] != "") {
				table = args[0];
				date = args[1];
				yue = date.substring(0, 7);
			}
		}
		SparkConf conf = new SparkConf().setAppName("过滤hive总表到HDFS");
		conf.set("spark.shuffle.sort.bypassMergeThreshold", "200");
		conf.set("spark.storage.memoryFraction", "0.4");
		conf.set("spark.shuffle.memoryFraction", "0.4");
		conf.set("spark.shuffle.file.buffer", "64k");
		conf.set("spark.reducer.maxSizeInFlight", "96m");
		conf.set("spark.shuffle.io.retryWait", "10s");
		conf.set("spark.serializer", "org.apache.spark.serializer.KryoSerializer");
		conf.registerKryoClasses(new Class[] {HiveFilter2HDFS.class});
		
		JavaSparkContext jsc = new JavaSparkContext(conf);
		HiveContext spark = new HiveContext(jsc);
		// 必须先load一下
		spark.sql("ALTER TABLE source_detection_vehicle_all ADD IF NOT EXISTS PARTITION (yue='" + yue + "',ri='" + date
				+ "')");
		String sql = "select * from " + table + " where ri = '" + date + "'" ;
		// 读取hive总表的数据
		 spark.sql(sql).repartition(100).registerTempTable("source_table");
		 // 按照时间排序,给每行打上一个自增id,新增的列为num1,全排序，数据会只有一个partition,所以效率很低
		 spark.sql("select *,row_number()over(order by indate) num1 from source_table").registerTempTable("t1");
		 // 按照车(车牌和牌色)与卡口id分组,按照时间排序,给每组打自增id,列名num2
		 spark.sql(
		 "select *,row_number()over(partition by PLATE_NO,PLATE_COLOR,SECTION_ID order by indate) num2 from t1")
		 .registerTempTable("t2");
		 // num1-num2形成一列num
		 spark.sql("select *,num1-num2 num from t2").drop("num1").drop("num2").registerTempTable("t3");
		 System.out.println(LocalTime.now());
		 // 根据车(车牌和牌色)与卡口id分组与num分组,取每组第一个序号即为最终结果
		 DataFrame df = spark.sql("select * from (select *,row_number()over(partition by PLATE_NO,PLATE_COLOR,SECTION_ID,num order by indate) rank from t3) a where rank = 1")
		 .drop("rank").drop("num");
		 df.printSchema();
		 df.write().mode(SaveMode.Overwrite).saveAsTable("source_zong");
	}
}
