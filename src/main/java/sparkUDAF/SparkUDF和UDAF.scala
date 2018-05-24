package sparkUDAF

/**
  * work：avg
  */
object SparkUDF和UDAF extends UserDefinedAggregateFunction {
  def main(args: Array[String]): Unit = {StructType(StructField("metric", DoubleType) :: StructField("timeCategory", DateType) :: Nil)
    val spark = SparkSession.builder().master("local").appName("动感光波biubiu").getOrCreate()


  }
//as it's name inputschema
  override def inputSchema: StructType = {
    StructType(StructField("metric", DoubleType) :: StructField("timeCategory", DateType) :: Nil)
  }
//Type of intermidiate result
  override def bufferSchema: StructType = {
    StructType(StructField("metric", DoubleType) :: StructField("timeCategory", DateType) :: Nil)
  }
//correspond to inputschema it's outputschema
  override def dataType: DataType = DoubleType

  override def deterministic: Boolean = true
//
  override def initialize(buffer: MutableAggregationBuffer): Unit = {
    buffer.update(0, 0.0)
    buffer.update(1, 0.0)
  }

  override def update(buffer: MutableAggregationBuffer, input: Row): Unit = {

  }

  override def merge(buffer1: MutableAggregationBuffer, buffer2: Row): Unit = ???

  override def evaluate(buffer: Row): Any = ???
}
