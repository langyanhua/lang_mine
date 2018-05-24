package 工作.兰州大数据.二期修改.过滤连续重复的记录.原版;


import org.apache.spark.AccumulatorParam;

import java.util.ArrayList;
import java.util.List;

/**
 * 自定义String类型的累加器
 * 
 * @author libaowei
 * @Time 2016-10-10 22:49:01
 */
public class ListAcc implements AccumulatorParam<List<String>> {

	private static final long serialVersionUID = 1L;

	@Override
	public List<String> addInPlace(List<String> arg0, List<String> arg1) {
		if(arg0 == null){
			return arg1;
		}else if(arg1 == null){
			return arg0;
		}else{ 
			arg0.addAll(arg1);
			arg1.clear();
			return arg0;
		}
	}

	@Override
	public List<String> zero(List<String> arg0) {
		return new ArrayList<String>();
	}

	@Override
	public List<String> addAccumulator(List<String> arg0, List<String> arg1) {
		if(arg0 == null){
			return arg1;
		}else if(arg1 == null){
			return arg0;
		}else{ 
			arg0.addAll(arg1);
			arg1.clear();
			return arg0;
		}
	}

}
