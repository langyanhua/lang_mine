package 工作.兰州大数据.kafkaConsumerAPI;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataOutputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;

import java.io.IOException;

/**
 * hdfs文件操作类
 * 
 * @author Administrator
 *
 */
public class HdfsFileUtil {

	/**
	 * 获取hdfs文件流
	 * 
	 * @return
	 * @throws Exception
	 */
	public FSDataOutputStream getOut(String yue, String ri, String tableName) {
		String file_path = "/user/hive/warehouse/" + tableName + "/yue=" + yue + "/ri=" + ri + "/" + "source.txt";
		FSDataOutputStream out = null;
		try {
			FileSystem fs = getFileSystem();
			if (!fs.exists(new Path(file_path))) {
				out = fs.create(new Path(file_path), true);
			} else {
				out = fs.append(new Path(file_path));
			}
		} catch (IllegalArgumentException e) {
			// logger.error("|info|4|03|004|连接建立失败,参数异常，异常信息==>{}",StackTraceStringUtil.getStackTraceStr(e));
		} catch (IOException e) {
			// logger.warn("|info|4|03|004|连接建立失败,异常信息==>{}",StackTraceStringUtil.getStackTraceStr(e));
		} catch (Exception e) {
			System.out.println("3");
			// logger.warn("|info|4|03|004|连接建立失败,异常信息==>{}",StackTraceStringUtil.getStackTraceStr(e));
		}
		return out;
	}

	/**
	 * 取得FileSystem
	 * 
	 * @return
	 * @throws Exception
	 */
	public final FileSystem getFileSystem() {
		Configuration conf = new Configuration();
		conf.set("dfs.client.block.write.replace-datanode-on-failure.policy", "NEVER");
		conf.set("dfs.client.block.write.replace-datanode-on-failure.enable", "true");
		conf.set("fs.hdfs.impl", org.apache.hadoop.hdfs.DistributedFileSystem.class.getName());
//		conf.set("fs.defaultFS", "hdfs://nameservice1");
//        conf.set("dfs.nameservices", "nameservice1");
//        conf.set("dfs.ha.namenodes.nameservice1", "master,slave64");
//        conf.set("dfs.namenode.rpc-address.nameservice1.master", "62.11.2.93:8020");
//        conf.set("dfs.namenode.rpc-address.nameservice1.slave64", "62.11.4.64:8020");
		conf.set("fs.defaultFS", Configs.FS_Defaults);
		conf.set("dfs.nameservices", Configs.DFS_Nameserves);
		conf.set("dfs.ha.namenodes."+Configs.DFS_Nameserves, Configs.DFS_HA_NnameNodes_Nameserves);
		conf.set("dfs.namenode.rpc-address."+Configs.DFS_Nameserves+"."+Configs.DFS_HA_NnameNodes_Nameserves.split(",")[0], Configs.NameNode_Master_IP);
		conf.set("dfs.namenode.rpc-address."+Configs.DFS_Nameserves+"."+Configs.DFS_HA_NnameNodes_Nameserves.split(",")[1], Configs.NameNode_Slave_IP);
		conf.set("dfs.client.failover.proxy.provider.nameservice1","org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider");

		FileSystem fs = null;
		try {
			fs = FileSystem.get(conf);
		} catch (IOException e) {
		}
		return fs;
	}

}
