import java.io.{BufferedReader, File, FileReader}

object ParquetTest {
  def main(args: Array[String]): Unit = {
    val schema = MessageTypeParser.parseMessageType(
      """
        |
      """.stripMargin)

    val schema2 = Types.buildMessage()
      .required(PrimitiveTypeName.BINARY).as(OriginalType.UTF8).named("name")
      .required(PrimitiveTypeName.BINARY).as(OriginalType.UTF8).named("age")
      .repeatedGroup()
      .required(PrimitiveTypeName.INT32).named("one")
      .required(PrimitiveTypeName.BINARY).as(OriginalType.UTF8).named("tow").named("hobby")
      .named("info")
    val factory = new SimpleGroupFactory(schema2)

    val conf = new Configuration()
    val writerSipport = new GroupWriteSupport()
    writerSipport.init(conf)

    val br = new BufferedReader(new FileReader(new File("/Users/juxin/Downloads/q.txt")))
    var line = ""
    while ((line = br.readLine()) != null) {
      val strs = line.split(".")
      val group = factory.newGroup().append("name", strs(0)).append("age", strs(1)).addGroup("hobby").append("one", strs(2)).append("tow", strs(3))

    }
  }
}
