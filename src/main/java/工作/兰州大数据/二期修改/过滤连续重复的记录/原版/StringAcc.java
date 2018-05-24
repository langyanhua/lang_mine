package 工作.兰州大数据.二期修改.过滤连续重复的记录.原版;

import org.apache.spark.AccumulatorParam;

/**
 * 自定义String类型的累加器
 * @author libaowei
 * @Time 2016-10-10 22:49:01 
 */
public class StringAcc implements AccumulatorParam<String> {

	private static final long serialVersionUID = 1L;

	@Override
	public String addInPlace(String init, String v1) {
		return init+"&"+v1;
	}

	@Override
	public String zero(String arg0) {
		return "";
	}

	@Override
	public String addAccumulator(String v1, String v2) {
		return v1+"&"+v2;
	}

}
