- 从库的数据都以ORCFile格式每天00:10开始全量导入HDFS中，整个过程需要大概不到4个小时（预计）
- HDFS上的数据格式在./job/下。以"job_mysql_hdfs_"开头，后面跟表名
- 数据在HDFS上：/user/hive/warehouse/juxin_ods_mysql.db/www_*/下。格式："www_" +表名
- 表的字段和类型可以通过job下的json文件查看。
- 读取orc格式代码示例：两种方式皆可
-     //方式1：
      val spark = SparkSession.builder().appName("asd").getOrCreate()
      val df = spark.read
        .format("orc")
        .option("delimiter", "\1") //数据分隔符'\1'
        .load("/user/hive/warehouse/juxin_ods_mysql.db/www_activity/")
      //方式2
      spark.read
        .option("delimiter", "\1")
        .orc("/user/hive/warehouse/juxin_ods_mysql.db/www_activity/")


