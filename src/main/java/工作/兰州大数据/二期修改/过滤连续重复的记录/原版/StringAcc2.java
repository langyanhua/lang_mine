package 工作.兰州大数据.二期修改.过滤连续重复的记录.原版;

import org.apache.spark.AccumulatorParam;

/**
 * 自定义String类型的累加器
 */
public class StringAcc2 implements AccumulatorParam<String> {

	private static final long serialVersionUID = 1L;

	@Override
	public String addInPlace(String init, String v1) {
		if (init == null || init.length() == 0)
			return v1;
		if (v1 == null || v1.length() == 0)
			return init;
		return init + "," + v1;
	}

	@Override
	public String zero(String arg0) {
		return "";
	}

	@Override
	public String addAccumulator(String v1, String v2) {
		if (v1 == null || v1.length() == 0)
			return v2;
		if (v2 == null || v2.length() == 0)
			return v1;
		return v1 + "," + v2;
	}

}
