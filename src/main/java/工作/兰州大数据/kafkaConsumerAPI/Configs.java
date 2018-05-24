package 工作.兰州大数据.kafkaConsumerAPI;

import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

/**
 * 公共配置类
 * 
 * @author hexiaogang
 *
 */
public class Configs {

	private static Properties props;

	// 系统默认使用项(无特殊情况不进行修改)
	public static final String Glob_KafkaTopic_down = "recv_message";// 接收数据，等待下载消息队列
	public static final String Glob_KafkaTopic_reco = "waitingreco_message";// 下载完成，等待识别消息队列
	public static final String Glob_KafkaTopic_trns = "recoresult_message";// 识别结果，等待转换数据消息队列
	public static final String Glob_KafkaTopic_save = "waitingsave_message";// 存储、业务等消息队列
	public static final String Glob_KafkaTopic_log = "logsave";// 日志消息队列
	public static final String Glob_HbaseImageTableName = "image_hbase";// Hbase存储图片的表名(列簇ImageInfo)
	public static final String Glob_HbaseVehicleTableName = "vehicle_hbase";// Hbase存储车辆特征的表名(列簇VehicleInfo)
	public static final String Glob_HbasePersonTableName = "person_hbase";// Hbase存储行人特征的表名(列簇PersonInfo)
	public static final String Glob_HbaseLogTableName = "log_hbase";// Hbase存储日志的表名(列族LogInfo)
	public static final String Down_KafkaConsumeGroup = "downloadgroup";// 下载消费组名
	public static final String Reco_KafkaConsumeGroup = "recogroup";// 识别消费组名
	public static final String Trns_KafkaConsumerGroup = "transformgroup";// 数据转换消费组名
	public static final String SaveVeh_KafkaConsumerGroup = "vehall_group";// 保存车辆/行人消费组名
	public static final String SaveFea_KafkaConsumerGroup = "feature_group";// 保存车辆特征消费组名
	public static final String SaveHive_KafkaConsumerGroup = "hive_group";// 保存hive表消费组名
	public static final String SaveAlarm_KafkaConsumerGroup = "baojing_group";// 报警判断消费组名
	public static final String SaveFile_KafkaConsumerGroup = "savefile_group";// 结果生成文件消费组名
	public static final String SaveLog_KafkaConsumerGroup = "log_group";// 日志存储消费组名
	public static final String Glob_SolrVehicleCollection = "test1";// Solr车辆索引采集器名
	public static final String Glob_SolrPersonCollection = "xingren";// Solr行人索引采集器名
	public static final String Glob_SolrAlarmCollection = "baojing_manager";// Solr报警索引采集器名
	public static final String Glob_SolrLogCollection = "log";// Solr日志索引库
   /**
    * HDFSconfig配置
    */
	public static String FS_Defaults="hdfs://nameservice1";
	public static String DFS_Nameserves ="nameservice1";
	public static String DFS_HA_NnameNodes_Nameserves="master,slave64";
	public static String NameNode_Master_IP = "62.11.2.93:8020";
	public static String NameNode_Slave_IP ="62.11.4.64:8020";
	/**
	 * kafka Zookeeper配置
	 */
	public static String Glob_KafkaZkQuorum = "slave43:2181,slave44:2181,slave45:2181/kafka";
	/**
	 * kafka消息队列代理
	 */
	public static String Glob_Kafkabroker = "slave43:9092,slave44:9092,slave45:9092";
	/**
	 * Kafka分区，用来确定本程序消费时同时开启的消费线程数
	 */
	public static String Glob_kafkaPartition = "3";
	/**
	 * Solr Zookeeper配置
	 */
	public static String Glob_SolrZkQuorum = "slave59:2181,slave60:2181,slave61:2181,slave62:2181,slave63:2181/solr";
	/**
	 * HBase Zookeeper配置
	 */
	public static String Glob_HbaseZkQuorum = "slave59,slave60,slave61,slave62,slave63";
	/**
	 * HBase Zookeeper客户端端口
	 */
	public static String Glob_HbaseZkClientPort = "2181";
	/**
	 * 数据库连接字段
	 */
	public static String Glob_SqlUrl = "jdbc:mysql://slave41:3306/bigdata?useUnicode=true&characterEncoding=UTF-8";
	/**
	 * 数据库用户名
	 */
	public static String Glob_SqlUser = "root";
	/**
	 * 数据库密码
	 */
	public static String Glob_SqlPassword = "zhuoshi";
	/**
	 * RedisIP
	 */
	public static String Glob_RedisIP = "slave38";
	/**
	 * Redis端口
	 */
	public static String Glob_RedisPort = "6379";
	/**
	 * Redis密码
	 */
	public static String Glob_RedisPassword = "";
	/**
	 * 默认设备编码(用于前端设备上传点位匹配不到数据库现有点位的情况)
	 */
	public static String Glob_DefaultDeviceCode = "1";
	/**
	 * 日志存放路径
	 */
	public static String Glob_LogFilePath = "";

	// 接收服务配置
	/**
	 * 接收服务开启协议类型，多个协议标准用','分隔
	 */
	// 0 TCP标准协议
	// 1 海康对接
	// 2 大华对接
	// 3 海信对接(MQ消息队列)
	// 4 天地伟业对接(Webservice)
	// 5 新中新对接(Webservice)
	// 6 英泰智对接(Webservice)
	// 7 博康对接(数据库方式)
	// 98 公司IDC遍历文件服务
	// 99 自主上传服务
	public static String Recv_ProtocolType = "0,99";
	/**
	 * 0标准协议TCP监听-监听端口
	 */
	public static String Recv_ListenPort = "8888";
	/**
	 * 99自主上传-监听上传文件目录
	 */
	public static String Recv_MonitorDir = "/home/manualpics/";
	/**
	 * 99自主上传-图片复制到的对应URL的文件路径
	 */
	public static String Recv_RecvImagePath = "/tools/images/";
	/**
	 * 99自主上传-图片对应URL路径
	 */
	public static String Recv_RecvImageUrl = "http://192.168.4.105:8080/pic/download/";
	/**
	 * 99自主上传-数据归档设备编号
	 */
	public static String Recv_ManualDeviceCode = "1";
	/**
	 * 3海信MQ-消息队列地址URL
	 */
	public static String Recv_MQBrokerURL = "tcp://192.168.232.16:61616/";
	/**
	 * 3海信MQ-消息队列订阅主题名
	 */
	public static String Recv_MQTopic = "HIATMP.HISENSE.PASS.PASSINF";
	/**
	 * 3海信MQ-消息队列用户名
	 */
	public static String Recv_MQUsername = "hiatmp";
	/**
	 * 3海信MQ-消息队列密码
	 */
	public static String Recv_MQPassword = "hiatmp";
	/**
	 * 4/5/6 Webservice-服务URL
	 */
	public static String Recv_WebserviceUrl = "http://221.122.77.9:9002/service.asmx";
	/**
	 * 4/5/6 Webservice-协议类型(1新中新 2天地伟业 3英泰智)
	 */
	public static String Recv_WebserviceType = "2";

	// 下载服务配置
	/**
	 * 下载URL图片超时设置(秒)，支持小数如0.5
	 */
	public static String Down_URLTimeout = "1";
	/**
	 * 同时下载URL图片开启的线程池数
	 */
	public static String Down_URLThread = "20";

	// 识别服务配置
	/**
	 * 识别通信超时时间(秒)
	 */
	public static String Reco_Timeout = "3";
	/**
	 * 识别服务器数量
	 */
	public static String Reco_Number = "1";
	/**
	 * 识别服务器IP
	 */
	public static List<String> Reco_VecarSvrIP = new ArrayList<>();
	/**
	 * 识别服务器每台开启的线程数
	 */
	public static List<String> Reco_VecarSvrCoreNum = new ArrayList<>();

	// 转换服务配置

	// 存储业务服务配置
	/**
	 * 一次提交条数
	 */
	public static String Save_SyncBatchCount = "20";
	/**
	 * 将存储数据保存到文件的文件目录
	 */
	public static String Save_FilePath = "";
	/**
	 * 存储数据写文件方式 1按秒 2按条数
	 */
	public static String Save_FileMethod = "1";
	/**
	 * 存储文件的间隔秒数
	 */
	public static String Save_FilePerSeconds = "1";
	/**
	 * 存储文件的数据条数
	 */
	public static String Save_FilePerData = "1000";
	/**
	 * 本地车牌号
	 */
	public static String Save_LocalPlateNo = "";

	static {
		LoadConfigFile();
	}

	public static void LoadConfigFile() {
		String filename = System.getProperty("user.dir") + "/config.properties";
		// String filename = "config.properties";
		try {
			props = new Properties();
			props.load(new InputStreamReader(new FileInputStream(filename), "UTF-8"));
			// File file = new File(filename);
			// FileReader fileReader;
			// fileReader = new FileReader(file);
			// props.load(fileReader);
			System.out.println("从以下位置加载配置文件：" + filename + "成功");

			// 公共变量
			Glob_KafkaZkQuorum = props.getProperty("Glob_KafkaZkQuorum");
			Glob_Kafkabroker = props.getProperty("Glob_Kafkabroker");
			Glob_kafkaPartition = props.getProperty("Glob_kafkaPartition");
			Glob_SolrZkQuorum = props.getProperty("Glob_SolrZkQuorum");
			Glob_HbaseZkQuorum = props.getProperty("Glob_HbaseZkQuorum");
			Glob_HbaseZkClientPort = props.getProperty("Glob_HbaseZkClientPort");
			Glob_SqlUrl = props.getProperty("Glob_SqlUrl");
			Glob_SqlUser = props.getProperty("Glob_SqlUser");
			Glob_SqlPassword = props.getProperty("Glob_SqlPassword");
			Glob_RedisIP = props.getProperty("Glob_RedisIP");
			Glob_RedisPort = props.getProperty("Glob_RedisPort");
			Glob_RedisPassword = props.getProperty("Glob_RedisPassword");
			Glob_DefaultDeviceCode = props.getProperty("Glob_DefaultDeviceCode");
			Glob_LogFilePath = props.getProperty("Glob_LogFilePath");
			//HDFS Config
			FS_Defaults = props.getProperty("FS_Defaults");

			DFS_Nameserves = props.getProperty("DFS_Nameserves");
	
			DFS_HA_NnameNodes_Nameserves= props.getProperty("DFS_HA_NnameNodes_Nameserves");
		
			NameNode_Master_IP = props.getProperty("NameNode_Master_IP");
			
			NameNode_Slave_IP = props.getProperty("NameNode_Slave_IP");

			// 接收
			Recv_ProtocolType = props.getProperty("Recv_ProtocolType");
			Recv_ListenPort = props.getProperty("Recv_ListenPort");
			Recv_MonitorDir = props.getProperty("Recv_MonitorDir");
			Recv_RecvImagePath = props.getProperty("Recv_RecvImagePath");
			Recv_RecvImageUrl = props.getProperty("Recv_RecvImageUrl");
			Recv_ManualDeviceCode = props.getProperty("Recv_ManualDeviceCode");
			Recv_MQBrokerURL = props.getProperty("Recv_MQBrokerURL");
			Recv_MQTopic = props.getProperty("Recv_MQTopic");
			Recv_MQUsername = props.getProperty("Recv_MQUsername");
			Recv_MQPassword = props.getProperty("Recv_MQPassword");
			Recv_WebserviceUrl = props.getProperty("Recv_WebserviceUrl");
			Recv_WebserviceType = props.getProperty("Recv_WebserviceType");
			// 下载
			Down_URLTimeout = props.getProperty("Down_URLTimeout");
			Down_URLThread = props.getProperty("Down_URLThread");
			// 识别
			Reco_Timeout = props.getProperty("Reco_Timeout");
			Reco_Number = props.getProperty("Reco_Number");
			try {
				for (int i = 1; i < Integer.parseInt(Reco_Number) + 1; i++) {
					Reco_VecarSvrIP.add(props.getProperty("Reco_VecarSvrIP" + i));
					Reco_VecarSvrCoreNum.add(props.getProperty("Reco_VecarSvrCoreNum" + i));
				}
			} catch (Exception e) {
				System.out.println("识别服务器配置读取异常" + e.toString());
			}
			// 转换服务

			// 存储业务服务
			Save_SyncBatchCount = props.getProperty("Save_SyncBatchCount");
			Save_FilePath = props.getProperty("Save_FilePath");
			Save_FileMethod = props.getProperty("Save_FileMethod");
			Save_FilePerSeconds = props.getProperty("Save_FilePerSeconds");
			Save_FilePerData = props.getProperty("Save_FilePerData");
			Save_LocalPlateNo = props.getProperty("Save_LocalPlateNo");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("配置文件" + filename + "读取异常，使用默认配置:" + e.toString());
		}
	}
}
