package 工作.兰州大数据.二期修改.过滤连续重复的记录.原版;

import org.apache.spark.AccumulatorParam;

/**
 * 自定义StringBuffer类型的累加器
 * 
 * @author libaowei
 * @Time 2016-10-10 22:49:01
 */
public class StringBufferAcc2 implements AccumulatorParam<StringBuffer> {

	private static final long serialVersionUID = 1L;

	@Override
	public StringBuffer addInPlace(StringBuffer init, StringBuffer v1) {
		if (init == null || init.length() == 0) {
			return v1;
		} else if (v1 == null || v1.length() == 0) {
			return init;
		} else {
			return init.append(",").append(v1);
		}
	}

	@Override
	public StringBuffer zero(StringBuffer arg0) {
		// TODO Auto-generated method stub
		return new StringBuffer();
	}

	@Override
	public StringBuffer addAccumulator(StringBuffer str1, StringBuffer str2) {
		if (str1 == null || str1.length() == 0) {
			return str2;
		} else if (str2 == null || str2.length() == 0) {
			return str1;
		} else {
			return str1.append(",").append(str2);
		}
	}
}
