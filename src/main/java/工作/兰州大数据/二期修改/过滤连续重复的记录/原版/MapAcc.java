package 工作.兰州大数据.二期修改.过滤连续重复的记录.原版;

import org.apache.spark.AccumulatorParam;

import java.util.HashMap;
import java.util.Map;

/**
 * 自定义Map类型的累加器
 */
public class MapAcc implements AccumulatorParam<Map> {

	private static final long serialVersionUID = 1L;

	@Override
	public Map addInPlace(Map arg0, Map arg1) {
		arg0.putAll(arg1);
		return arg0;
	}

	@Override
	public Map zero(Map arg0) {
		return new HashMap();
	}

	@Override
	public Map addAccumulator(Map arg0, Map arg1) {
		arg0.putAll(arg1);
		return arg0;
	}

}
