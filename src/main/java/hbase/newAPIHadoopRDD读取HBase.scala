package hbase

import org.apache.hadoop.hbase.HBaseConfiguration
import org.apache.hadoop.hbase.client.Result
import org.apache.hadoop.hbase.io.ImmutableBytesWritable
import org.apache.hadoop.hbase.mapreduce.TableInputFormat
import org.apache.spark.sql.{DataFrame, SparkSession}

object newAPIHadoopRDD读取HBase {
  private var htableName = "jxdata:userinfo"
  private var hbaseFamily = "cf1"
  private var chatset = "utf-8"

  val spark = SparkSession.builder().appName("h").getOrCreate()
  val hbaseConf = HBaseConfiguration.create()
  //zookeeper
  hbaseConf.set("hbase.zookeeper.quorum", "jx-1-14,jx-1-3,jx-1-9,jx-1-35,jx-1-11")
  //端口
  hbaseConf.set("hbase.zookeeper.property.clientPort", "2181")
  //表名
  hbaseConf.set(TableInputFormat.INPUT_TABLE, htableName)

  def a(dataFrame: DataFrame): DataFrame = {

    // TODO: 这里设置scan,Filter

    //hbaseRDD
    val hbaseRDD = spark.sparkContext.newAPIHadoopRDD(hbaseConf,
      classOf[TableInputFormat], classOf[ImmutableBytesWritable], classOf[Result])
???
  }
}
