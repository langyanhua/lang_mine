

/**
  * Created by juxin on 2017/7/26.
  */
object HiveAndSpark {
  def main(args: Array[String]): Unit = {
    /**
      * JDBC直连hive，测试成功
      */
    //   val driverName = "org.apache.hive.jdbc.HiveDriver"
    //    Class.forName(driverName)
    //    val con = DriverManager.getConnection("jdbc:hive2://192.168.1.19:10000/juxin_ods_mysql","langyanhua","langyanhua")
    //    val stmt = con.createStatement()
    //    var res = stmt.executeQuery("select * from www_user limit 10")
    //    while (res.next()){
    //      println(res.getString(1)+" "+res.getString(2))
    //    }
    /**
      * 下面的这种操作，查询出来只有表结构。下一步尝试是不是Hive内外表的问题2017-07-27 11:13:00
      */
    //    val spark = SparkSession.builder().appName("asd").getOrCreate()
    //    val jdbcDF = spark.read.format("jdbc")
    //      .option("url", "jdbc:hive2://192.168.1.19:10000/juxin_ods_mysql")
    //      .option("driver", "org.apache.hive.jdbc.HiveDriver")
    //      .option("dbtable", "www_area")
    //      .option("user", "langyanhua")
    //      .option("password", "langyanhua")
    //      .load().show()
    /**
      * 尝试spark直接加载ORCFile,两种方式都可以
      */
    //方式1：
    val spark = SparkSession.builder().appName("asd").getOrCreate()
    val df = spark.read
      .format("orc")
      .option("delimiter", "\1")
      .load("/user/hive/warehouse/juxin_ods_mysql.db/www_activity/")
    //方式2
    spark.read
      .option("delimiter", "\1")
      .orc("/user/hive/warehouse/juxin_ods_mysql.db/www_activity/")
    /**
      * spark直接读取MySQL，测试成功。但是MySQL并发不行，遇到大表就慢，所以还是用上面的方法
      */
    //    val spark = SparkSession.builder().appName("asd").getOrCreate()
    //    spark.read
    //      .format("jdbc")
    //      .option("driver", "com.mysql.jdbc.Driver")
    //      .option("url", "jdbc:mysql://192.168.2.83:3306/yuanfenba_www")
    //      .option("dbtable", "activity")
    //      .option("user", "yfbwapuser")
    //      .option("password", "vd8YXII4e33qStDFMiyf")
    //      .load().show()

    val people = spark.read.parquet("...")
    val department = spark.read.parquet("...")

    people.filter("age > 30")
      .join(department, people("deptId") === department("id"))
      .groupBy(department("name"), people("gender"))
      .agg(avg(people("salary")), max(people("age")))

    spark.read.json("")
  }
}

