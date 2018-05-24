package hbase

import org.apache.hadoop.hbase.HBaseConfiguration
import org.apache.hadoop.hbase.client.{HTable, ResultScanner, Scan}
import org.apache.hadoop.hbase.filter.{BinaryComparator, CompareFilter, RowFilter}
import org.apache.hadoop.hbase.util.Bytes

object HBaseFilter {
  private val hbaseFamily = "cf1"
  val columnName = ""
  private var chatset = "utf-8"
  val conf = HBaseConfiguration.create()

  val table = new HTable(conf, "")

  //RowFilter
  val scan = new Scan


  scan.addColumn(hbaseFamily.getBytes(chatset), columnName.getBytes(chatset))
  val filter = new RowFilter(CompareFilter.CompareOp.LESS,
    new BinaryComparator(Bytes.toBytes("asd")))
  scan.setFilter(filter)


  val scanner: ResultScanner = table.getScanner(scan)






  scanner.close()
}
