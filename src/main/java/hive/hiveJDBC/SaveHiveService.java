package hive.hiveJDBC;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import com.alibaba.fastjson.JSONObject;
import kafka.consumer.Consumer;
import kafka.consumer.ConsumerConfig;
import kafka.consumer.ConsumerIterator;
import kafka.consumer.KafkaStream;
import kafka.javaapi.consumer.ConsumerConnector;
import 工作.兰州大数据.kafkaConsumerAPI.Configs;

/**
 * 写数据到临时表 source_feature_hive 和 source_detection_vehicle_all
 */
public class SaveHiveService {

	public static void main(String[] args) {
		ConsumerConnector consum = new SaveHiveService().createConsumer();
		Map<String, Integer> topicCountMap = new HashMap<String, Integer>();
		topicCountMap.put(Configs.Glob_KafkaTopic_save, 1);
		Map<String, List<KafkaStream<byte[], byte[]>>> messageStream = consum.createMessageStreams(topicCountMap);
		KafkaStream<byte[], byte[]> stream = messageStream.get(Configs.Glob_KafkaTopic_save).get(0);
		ConsumerIterator<byte[], byte[]> it = stream.iterator();
		// 定义一个list存放message的value

		ArrayList<String> list = new ArrayList<String>();

		String tableName1 = "source_feature_hive";
		String tableName10 = "feature_hive";
		String tableName2 = "source_detection_vehicle_all";

		while (it.hasNext()) {

			if (list.size() < Integer.parseInt(Configs.Save_SyncBatchCount)) {
				list.add(new String(it.next().message()));
			} else {
				String ri = LocalDate.now().toString();
				String yue = ri.substring(0, 7);
				FileWriter stream1 = getStream(tableName1);
				FileWriter stream2 = getStream(tableName2);
				list.forEach(x -> {
					try {
						JSONObject value = JSONObject.parseObject(x);
						stream1.write((value.getString("rowkey") + "^" + value.getString("indate") + "^"
								+ value.getString("feature") + "\n"));
						stream1.flush();
						String kakouquan_id = value.getString("kakouquan_id");
						String plate_score = value.getString("plate_score");
						String plate_color = value.getString("plate_color");
						String vehicle_color = value.getString("vehicle_color");
						String vehicle_type = value.getString("vehicle_type");
						String vehicle_brand = value.getString("vehicle_brand");
						String vehicle_brand_score = value.getString("vehicle_brand_score");
						String vehicle_child_brand = value.getString("vehicle_child_brand");
						String plate_left_x = value.getString("plate_left_x");
						String plate_left_y = value.getString("plate_left_y");
						String plate_right_x = value.getString("plate_right_x");
						String plate_right_y = value.getString("plate_right_y");
						String vehicle_rect_score = value.getString("vehicle_rect_score");
						String device_id = value.getString("device_id");
						String data_type = value.getString("data_type");
						String out_id = value.getString("out_id");
						String section_id = value.getString("section_id");
						String section_map_x = value.getString("section_map_x");
						String section_map_y = value.getString("section_map_y");
						String direction_id = value.getString("direction_id");
						String districts_id = value.getString("districts_id");
						String vehicle_gj_score = value.getString("vehicle_gj_score");
						String vehicle_njb_score = value.getString("vehicle_njb_score");
						String vehicle_tc_score = value.getString("vehicle_tc_score");
						String vehicle_aqd_main_score = value.getString("vehicle_aqd_main_score");

						stream2.write((value.getString("rowkey") + "^" + value.getString("plate_no") + "^"
								+ Double.parseDouble(plate_score.equals("") ? "0" : plate_score) + "^"
								+ Double.parseDouble(plate_color.equals("") ? "0" : plate_color) + "^"
								+ value.getString("plate_color_name") + "^"
								+ Double.parseDouble(vehicle_color.equals("") ? "0" : vehicle_color) + "^"
								+ value.getString("vehicle_color_name") + "^"
								+ Double.parseDouble(vehicle_type.equals("") ? "0" : vehicle_type) + "^"
								+ value.getString("vehicle_type_name") + "^"
								+ Double.parseDouble(vehicle_brand.equals("") ? "0" : vehicle_brand) + "^"
								+ value.getString("vehicle_brand_name") + "^"
								+ Double.parseDouble(vehicle_brand_score.equals("") ? "0" : vehicle_brand_score) + "^"
								+ Double.parseDouble(vehicle_child_brand.equals("") ? "0" : vehicle_child_brand) + "^"
								+ value.getString("vehicle_child_brand_name") + "^"
								+ value.getString("vehicle_brand_year") + "^"
								+ Double.parseDouble(plate_left_x.equals("") ? "0" : plate_left_x) + "^"
								+ Double.parseDouble(plate_left_y.equals("") ? "0" : plate_left_y) + "^"
								+ Double.parseDouble(plate_right_x.equals("") ? "0" : plate_right_x) + "^"
								+ Double.parseDouble(plate_right_y.equals("") ? "0" : plate_right_y) + "^"
								+ Double.parseDouble(vehicle_rect_score.equals("") ? "0" : vehicle_rect_score) + "^"
								+ value.getString("indate") + "^"
								+ Double.parseDouble(device_id.equals("") ? "0" : device_id) + "^"
								+ value.getString("device_name") + "^" + value.getString("device_type") + "^"
								+ Double.parseDouble(data_type.equals("") ? "0" : data_type) + "^"
								+ value.getString("data_path") + "^"
								+ Double.parseDouble(out_id.equals("") ? "0" : out_id) + "^"
								+ value.getString("out_name") + "^"
								+ Double.parseDouble(section_id.equals("") ? "0" : section_id) + "^"
								+ value.getString("section_name") + "^"
								+ Double.parseDouble(section_map_x.equals("") ? "0" : section_map_x) + "^"
								+ Double.parseDouble(section_map_y.equals("") ? "0" : section_map_y) + "^"
								+ Double.parseDouble(direction_id.equals("") ? "0" : direction_id) + "^"
								+ Double.parseDouble(districts_id.equals("") ? "0" : districts_id) + "^"
								+ value.getString("districts_name") + "^"
								+ Double.parseDouble(kakouquan_id.equals("") ? "0" : kakouquan_id) + "^"
								+ value.getString("kakouquan_name") + "^" + value.getString("vehicle_gj") + "^"
								+ Double.parseDouble(vehicle_gj_score.equals("") ? "0" : vehicle_gj_score) + "^"
								+ value.getString("vehicle_njb") + "^"
								+ Double.parseDouble(vehicle_njb_score.equals("") ? "0" : vehicle_njb_score) + "^"
								+ value.getString("vehicle_tc") + "^"
								+ Double.parseDouble(vehicle_tc_score.equals("") ? "0" : vehicle_tc_score) + "^"
								+ value.getString("vehicle_aqd_main") + "^"
								+ Double.parseDouble(vehicle_aqd_main_score.equals("") ? "0" : vehicle_aqd_main_score)
								+ "^" + value.getString("vehicle_aqd_co") + "^"
								+ value.getString("vehicle_aqd_co_score") + "^" + value.getString("vehicle_ddh_main")
								+ "^" + value.getString("vehicle_ddh_main_score") + "^"
								+ value.getString("vehicle_ddh_co") + "^" + value.getString("vehicle_ddh_co_score")
								+ "^" + value.getString("vehicle_zyb_main") + "^"
								+ value.getString("vehicle_zyb_main_score") + "^" + value.getString("vehicle_zyb_co")
								+ "^" + value.getString("vehicle_zyb_co_score") + "^" + value.getString("vehicle_czh")
								+ "^" + value.getString("vehicle_czh_score") + "^" + value.getString("vehicle_crz")
								+ "^" + value.getString("vehicle_crz_score") + "^" + value.getString("vehicle_xsb")
								+ "^" + value.getString("vehicle_xsb_score") + "^" + value.getString("vehicle_jsy_main")
								+ "^" + value.getString("vehicle_jsy_main_score") + "^"
								+ value.getString("vehicle_jsy_co") + "^" + value.getString("vehicle_jsy_co_score")
								+ "^" + value.getString("vehicle_lt") + "^" + value.getString("vehicle_lt_score") + "^"
								+ value.getString("vehicle_cd") + "^" + value.getString("vehicle_cd_score") + "^"
								+ value.getString("vehicle_jsc") + "^" + value.getString("vehicle_jsc_score") + "^"
								+ value.getString("vehicle_hsj") + "^" + value.getString("vehicle_hsj_score") + "^"
								+ value.getString("device_code") + "\n"));
						stream2.flush();
					} catch (UnsupportedEncodingException e) {
//						LogSet.WriteLog("Error", "4", "06", "600", false, e, "encodingException");
					} catch (IOException e) {
//						LogSet.WriteLog("Error", "4", "06", "600", false, e, "kafka2local failed");
					}
				});

				if (null != stream1 && null != stream2) {
					try {
						stream1.close();
						stream2.close();
					} catch (Exception e) {
//						LogSet.WriteLog("Error", "4", "06", "600", false, e, "关闭流失败");
					}
				}
				try {
					SaveHiveService.getStmt()
							.execute("load data local inpath '/home/dispatch/hivedata/" + tableName1 + ".txt'"
									+ " into table " + tableName10 + " partition(yue='" + yue + "',ri='" + ri + "')");
					SaveHiveService.getStmt()
							.execute("load data local inpath '/home/dispatch/hivedata/" + tableName2 + ".txt'"
									+ " into table " + tableName2 + " partition(yue='" + yue + "',ri='" + ri + "')");
					consum.commitOffsets();
//					LogSet.WriteLog("info", "4", "06", "600", true, "data write success");
					list.clear();
				} catch (Exception e) {
//					LogSet.WriteLog("Error", "4", "06", "600", false, e, "hiveSql failed");
				}

			}

		}

	}

	private static Statement getStmt() {
		String driverName = "org.apache.hive.jdbc.HiveDriver";

		try {
			Class.forName(driverName);
		} catch (ClassNotFoundException e) {
//			LogSet.WriteLog("Error", "4", "06", "600", false, e, "hiveJDBC反射失败");
		}
		Connection con = null;
		try {
			con = DriverManager.getConnection(Configs.HiveUrl, Configs.HiveUserName, Configs.HiveUserPwd);
		} catch (SQLException e) {
//			LogSet.WriteLog("Error", "4", "06", "600", false, e, "hiveJDBC创建连接失败");
		}
		Statement stmt = null;
		try {
			stmt = con.createStatement();
		} catch (SQLException e) {
//			LogSet.WriteLog("Error", "4", "06", "600", false, e, "con.createStatement失败");
		}
		return stmt;
	}

	private static FileWriter getStream(String tableName) {
		FileWriter fw = null;
		File f = null;
		try {
			f = new File("/home/dispatch/hivedata/" + tableName + ".txt");
			if (!f.exists())
				f.createNewFile();
			fw = new FileWriter("/home/dispatch/hivedata/" + tableName + ".txt");
		} catch (IOException e) {
//			LogSet.WriteLog("error", "4", "06", "600", false, e, "FileWriter 创建流失败");
		}
		return fw;
	}

	private ConsumerConnector createConsumer() {
		Properties properties = new Properties();
		properties.put("zookeeper.connect", Configs.Glob_KafkaZkQuorum);// 声明zk
		properties.put("group.id", Configs.SaveHive_KafkaConsumerGroup);// 指定消费组
		properties.put("rebalance.max.retries", "5");
		properties.put("refresh.leader.backoff.ms", "10000");
		properties.put("zookeeper.session.timeout.ms", "40000");
		properties.put("auto.commit.enable", "false");
		properties.put("auto.offset.reset", "smallest");
		return Consumer.createJavaConsumerConnector(new ConsumerConfig(properties));
	}
}
