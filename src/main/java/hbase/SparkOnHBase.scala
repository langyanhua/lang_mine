package hbase

import org.apache.hadoop.hbase.HBaseConfiguration
import org.apache.hadoop.hbase.client.{Result, Scan}
import org.apache.hadoop.hbase.spark.HBaseContext
import org.apache.hadoop.hbase.util.Bytes
import org.apache.spark.sql.SparkSession

object SparkOnHBase {
  def main(args: Array[String]): Unit = {

//    val hbaseConf = HBaseConfiguration.create()
//    val tablename = ""
//    var maxUid = 0L
//    var minUid = 0L
//    val spark = SparkSession.builder().appName("asd").getOrCreate()
//    val sc = spark.sparkContext
//    val conf = HBaseConfiguration.create()
//    //zookeeper
//    conf.set("hbase.zookeeper.quorum", "jx-1-14,jx-1-3,jx-1-9,jx-1-35,jx-1-11")
//    //端口
//    conf.set("hbase.zookeeper.property.clientPort", "2181")
//
//    spark.read.json("/juxin/data-warehouse/fact-OnlineInfo/2017-09-10/*.json").selectExpr("max(uid)", "min(uid)").map(row => {
//      maxUid = row.getLong(0)
//      minUid = row.getLong(1)
//    })
//    val scan = new Scan()
//    scan.setStartRow(Bytes.toBytes(minUid))
//    scan.setStopRow(Bytes.toBytes(maxUid))
//    scan.addColumn(Bytes.toBytes("cf1"), Bytes.toBytes("gender"))
//    val hbcontext = new HBaseContext(sc, conf)
//    hbcontext.hbaseRDD(tablename, scan)
  }
}
