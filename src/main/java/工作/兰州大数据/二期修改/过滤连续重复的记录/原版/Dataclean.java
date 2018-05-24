package 工作.兰州大数据.二期修改.过滤连续重复的记录.原版;

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

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

public class Dataclean {
	private static final Logger logger = LoggerFactory.getLogger(Dataclean.class);
	static String data_clean="AND SECTION_ID is not null AND PLATE_NO not like '%\u65E0\u724C\u8F66%' "
			+ "and PLATE_NO not like '%\u672A%' and PLATE_COLOR_NAME !='\u672A\u77E5' AND VEHICLE_COLOR_NAME !='\u672A\u77E5' and  "
			+ "plate_right_y>200 and section_id != 4141 and device_id!=306";
	public static void main(String [] args) throws IOException {
		// TODO Auto-generated method stub
		String table="source_detection_vehicle_all";
		String date="2018-05-20";
		if (args != null && args.length != 0) {
			if (args[0] != null && args[0] != "") {
				table = args[0];
				date = args[1];
			}
		}
		JavaSparkContext sparkContext = null;
		SQLContext sqlContext = null;
		//hdfs 写文件
		FileSystem fs = null;
		Path path = null;
		try {	
				String sql="select * from " + table + " where 1=1 AND ri= '" +date+ "'" + data_clean;
				System.out.println(sql);
				SparkConf conf = new SparkConf();
				conf.setAppName("jcbigdata-dataclean");
				sparkContext = new JavaSparkContext(conf);
				sqlContext = new HiveContext(sparkContext);
				
				Configuration hdfsconf = new Configuration();
				fs = FileSystem.get(hdfsconf);
				path = new Path("/user/spark/import.txt");
				FSDataOutputStream out = fs.create(path);
				
				Date nowDate = DateUtil.getNowDate(); // 当前执行日期(不含时分秒)
				String nowTime = DateUtil.getNowTimeStr();
				Date yesterday = DateUtil.distanceDay(nowDate, -1); // 当前凌晨计算昨天一天的数据
				sqlContext.sql("use default");
				DataFrame jdbcDF = sqlContext.sql(sql);

				JavaRDD<Row> resultRowRDD = jdbcDF.javaRDD();

				JavaPairRDD<String,String> pairRDD = resultRowRDD.mapToPair(new PairFunction<Row,String,String>(){
					private static final long serialVersionUID = 1L;

					@Override
					public Tuple2<String, String> call(Row row) throws Exception {
						// TODO Auto-generated method stub
						String rowkey = row.getAs("ROWKEY");
						String PLATE_NO = row.getAs("PLATE_NO");
						Double PLATE_COLOR = TypeCaseHelper.convert2DoubleSafe(row.getAs("PLATE_COLOR"));
						Double SECTION_ID = TypeCaseHelper.convert2DoubleSafe(row.getAs("SECTION_ID"));
						Double id =  TypeCaseHelper.convert2DoubleSafe(row.getAs("ID"));
						Double detection_vehicle_id =  TypeCaseHelper.convert2DoubleSafe(row.getAs("DETECTION_VEHICLE_ID"));
						Double vehicle_color = TypeCaseHelper.convert2DoubleSafe(row.getAs("VEHICLE_COLOR"));
						Double vehicle_type =  TypeCaseHelper.convert2DoubleSafe(row.getAs("VEHICLE_TYPE"));
						Double vehicle_brand =  TypeCaseHelper.convert2DoubleSafe(row.getAs("VEHICLE_BRAND"));
						Double vehicle_child_brand =  TypeCaseHelper.convert2DoubleSafe(row.getAs("VEHICLE_CHILD_BRAND"));
						Double vehicle_sunvisor =  TypeCaseHelper.convert2DoubleSafe(row.getAs("VEHICLE_SUNVISOR"));
						Double vehicle_safetybelt =  TypeCaseHelper.convert2DoubleSafe(row.getAs("VEHICLE_SAFETYBELT"));
						Double vehicle_practice =  TypeCaseHelper.convert2DoubleSafe(row.getAs("VEHICLE_PRACTICE"));
						Double detection_model = TypeCaseHelper.convert2DoubleSafe(row.getAs("DETECTION_MODEL"));
						Double plate_left_x = TypeCaseHelper.convert2DoubleSafe(row.getAs("PLATE_LEFT_X"));
						Double plate_left_y = TypeCaseHelper.convert2DoubleSafe(row.getAs("PLATE_LEFT_Y"));
						Double plate_right_x = TypeCaseHelper.convert2DoubleSafe(row.getAs("PLATE_RIGHT_X"));
						Double plate_right_y = TypeCaseHelper.convert2DoubleSafe(row.getAs("PLATE_RIGHT_Y"));
						String indate =  row.getAs("INDATE");
						Double vehicle_score =  TypeCaseHelper.convert2DoubleSafe(row.getAs("VEHICLE_SCORE"));
						Double marklocation =  TypeCaseHelper.convert2DoubleSafe(row.getAs("MARKLOCATION"));
						Double markposition_left_x = TypeCaseHelper.convert2DoubleSafe(row.getAs("MARKPOSITION_LEFT_X"));
						Double markposition_left_y = TypeCaseHelper.convert2DoubleSafe(row.getAs("MARKPOSITION_LEFT_Y"));
						Double markposition_right_x =  TypeCaseHelper.convert2DoubleSafe(row.getAs("MARKPOSITION_RIGHT_X"));
						Double markposition_right_y = TypeCaseHelper.convert2DoubleSafe(row.getAs("MARKPOSITION_RIGHT_Y"));
						String model_year = row.getAs("MODEL_YEAR");
						String view_model_year = row.getAs("VIEW_MODEL_YEAR");
						Double device_id = TypeCaseHelper.convert2DoubleSafe(row.getAs("DEVICE_ID"));
						Double data_type = TypeCaseHelper.convert2DoubleSafe(row.getAs("DATA_TYPE"));
						String data_path =  row.getAs("DATA_PATH");
						String plate_color_name = row.getAs("PLATE_COLOR_NAME");
						String vehicle_color_name = row.getAs("VEHICLE_COLOR_NAME");
						String vehicle_type_name = row.getAs("VEHICLE_TYPE_NAME");
						String vehicle_brand_name = row.getAs("VEHICLE_BRAND_NAME");
						String vehicle_child_brand_name = row.getAs("VEHICLE_CHILD_BRAND_NAME");
						String device_name = row.getAs("DEVICE_NAME");
						String device_type = row.getAs("DEVICE_TYPE");
						Double outtown_id = TypeCaseHelper.convert2DoubleSafe(row.getAs("OUTTOWN_ID"));
						String outtown_name = row.getAs("OUTTOWN_NAME");
						String section_name = row.getAs("SECTION_NAME");
						Double section_map_x = TypeCaseHelper.convert2DoubleSafe(row.getAs("SECTION_MAP_X"));
						Double section_map_y = TypeCaseHelper.convert2DoubleSafe(row.getAs("SECTION_MAP_Y"));

						return new Tuple2<String, String>(PLATE_NO + "%" + PLATE_COLOR,
								rowkey + "%" +  SECTION_ID + "%" + id + "%" + detection_vehicle_id + "%" +vehicle_color  + "%" + vehicle_type + "%" + vehicle_brand
								+ "%" +vehicle_child_brand	+ "%" +vehicle_sunvisor + "%" +vehicle_safetybelt + "%" +vehicle_practice+ "%" +detection_model
								+ "%" +plate_left_x+ "%" +plate_left_y + "%" +plate_right_x+ "%" +plate_right_y + "%" +indate + "%" +vehicle_score
								+ "%" +marklocation+ "%" +markposition_left_x + "%" +markposition_left_y +"%" +markposition_right_x+ "%" +markposition_right_y + "%" +model_year
								+ "%" +view_model_year + "%" +device_id+ "%" +data_type + "%" +data_path+ "%" +plate_color_name+ "%" +vehicle_color_name
								+ "%" +vehicle_type_name+ "%" +vehicle_brand_name + "%" +vehicle_child_brand_name+ "%" +device_name	+"%" +device_type
								+ "%" +outtown_id+ "%" +outtown_name + "%" +section_name + "%" +section_map_x+ "%" +section_map_y);
					}

				});
			// 使用reducebykey算子合并同车牌号数据
				JavaPairRDD<String,String> reduceRDD = pairRDD.reduceByKey(new Function2<String,String,String>(){
					private static final long serialVersionUID = 1L;

					@Override
					public String call(String v1, String v2) throws Exception {
						// TODO Auto-generated method stub
						return v1 + "@" + v2;
					}

				});
				//创建累加器
				final Accumulator<List<String>> acc = sparkContext.accumulator(null,new ListAcc());
				//使用foreach算子过滤数据
				reduceRDD.foreach(new VoidFunction<Tuple2<String, String>>() {
					private static final long serialVersionUID = 1L;

					@Override
					public void call(Tuple2<String, String> t2) throws Exception {
						// TODO Auto-generated method stub
						List<QuerySort> list2=new ArrayList<QuerySort>();
		            	String key = t2._1;
						String value = t2._2;
						String[] values = value.split("@");
						int n=values.length;

						for(int i=0;i<n;i++){
							QuerySort sort=new QuerySort();
							String va1=values[i];
							String v1[]=va1.split("%");
							String indate=v1[16];
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
								sb.append(v+"@");
							
							}
							value=sb.toString();
							values = value.split("@");					
						int i=0;
							for(int j=i+1;j<n;j++){
								String va1=values[i];
								String v1[]=va1.split("%");
								String section_id1=v1[1];
								String indate1=v1[16];
								
								String va2=values[j];
								String v2[]=va2.split("%");
								String section_id2=v2[1];
								String indate2=v2[16];
								if(!section_id1.equals(section_id2) && !indate1.equals(indate2)){
									List a = new ArrayList();
									a.add(key+ "%" +va1);
									acc.add(a);
									a.clear();
									a = null;
									i=j;
								}
							}
							String van=values[n-1];
							List a = new ArrayList();
							a.add(key+ "%" +van);
							acc.add(a);
							a.clear();
							a = null;
						}
					});
				List<String> accValue=acc.value();
				for(String result:accValue){

					String rs="\n"+result +"%";
					out.writeUTF(rs);
				}
				System.out.println("_____"+accValue.size());
				out.flush();
//				out.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				if (sparkContext != null)
					sparkContext.close();
					fs.close();
			}

	}

}
