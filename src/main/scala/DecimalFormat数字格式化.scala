import java.text.DecimalFormat

/**
  * Created by juxin on 2017/7/12.
  */
object DecimalFormat数字格式化 {
  def main(args: Array[String]): Unit = {
    /**
      *superclass   abstract   NumFormat
      * subclass java.text.DecimalFormat
      */
    //Create instanse
    val df = new DecimalFormat()
    //maximum of 2 fraction digit
    var i = 1
    df.setMinimumIntegerDigits(2)
    println(df.format(i))    // no carry   default groupSize 3

//    df.setMinimumIntegerDigits(2)
//    println(df.formatted("1"))
//
//    df.applyPattern("##")
//    println(df.format(i))    //no carry     no groupSize
//
//    //nimimum of 4 fraction digit
//    df.setMinimumFractionDigits(4)
//    println(df.format(i))
//
//    df.applyPattern("#.0000")
//    println(df.format(i))
  }
}
