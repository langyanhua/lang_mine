package 工作.兰州大数据.kafkaConsumerAPI;

import com.alibaba.fastjson.JSONObject;
import kafka.consumer.Consumer;
import kafka.consumer.ConsumerConfig;
import kafka.consumer.ConsumerIterator;
import kafka.consumer.KafkaStream;
import kafka.javaapi.consumer.ConsumerConnector;
import org.apache.hadoop.fs.FSDataOutputStream;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.time.LocalDate;
import java.util.*;

public class Save2Hive {

	public static void main(String[] args) throws IOException {

		ConsumerConnector consum = new Save2Hive().createConsumer();
		Map<String, Integer> topicCountMap = new HashMap<String, Integer>();
		topicCountMap.put(Configs.Glob_KafkaTopic_save, 1);
		Map<String, List<KafkaStream<byte[], byte[]>>> messageStream = consum.createMessageStreams(topicCountMap);
		KafkaStream<byte[], byte[]> stream = messageStream.get(Configs.Glob_KafkaTopic_save).get(0);
		ConsumerIterator<byte[], byte[]> it = stream.iterator();
		// 定义一个list存放message的value,我觉得这里放一个数组资源占用会少点,但是会加大代码量
		ArrayList<String> list = new ArrayList<String>(3000);
		HdfsFileUtil fileUtil = new HdfsFileUtil();
		String tableName1 = "source_feature_hive";
		String tableName2 = "source_detection_vehicle_all";
		while (true) {

			while (it.hasNext()) {

				if (list.size() < 3000) {
					list.add(new String(it.next().message()));
				} else {
					String ri = LocalDate.now().toString();
					String yue = ri.substring(0, 7);
					FSDataOutputStream out1 = fileUtil.getOut(yue, ri, tableName1);
					FSDataOutputStream out2 = fileUtil.getOut(yue, ri, tableName2);
					list.forEach(x -> {
						try {
							JSONObject value = JSONObject.parseObject(x);

							out1.write((value.getString("rowkey") + "^" + value.getString("indate") + "^"
									+ value.getString("feature") + "\n").getBytes("UTF-8"));
							out1.hflush();

							out2.write((value.getString("rowkey") + "\n").getBytes("UTF-8"));
							out2.hflush();
						} catch (UnsupportedEncodingException e) {
//							LogSet.WriteLog("Error", "4", "06", "600", false, e,"encodingException");
						} catch (IOException e) {
//							LogSet.WriteLog("Error", "4", "06", "600", false, e,"kafka2HDFS failed");
						}
					});
					list.clear();
					if (null != out1 && null != out2) {


						try {
							out1.close();
							out2.close();
							consum.commitOffsets();
						} catch (Exception e) {
//							LogSet.WriteLog("Error", "4", "06", "600", false, e,"FSoutput close fail");
							e.printStackTrace();
						} finally {
							//TODO
						}
					}
				}

			}
		}

	}

	private ConsumerConnector createConsumer() {
		Properties properties = new Properties();
		properties.put("zookeeper.connect", Configs.Glob_KafkaZkQuorum);// 声明zk
		properties.put("group.id", Configs.SaveHive_KafkaConsumerGroup);// 指定消费组
		properties.put("rebalance.max.retries", "5");
		properties.put("refresh.leader.backoff.ms", "10000");
		properties.put("zookeeper.session.timeout.ms", "40000");
		properties.put("auto.commit.enable", "false");
		// properties.put("auto.offset.reset", "smallest");
		return Consumer.createJavaConsumerConnector(new ConsumerConfig(properties));
	}
}
