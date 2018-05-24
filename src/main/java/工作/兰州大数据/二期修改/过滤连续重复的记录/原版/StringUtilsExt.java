package 工作.兰州大数据.二期修改.过滤连续重复的记录.原版;

public class StringUtilsExt {

	public static boolean isEmpty(String input) {
		return (input == null || input.length() == 0) || "null".equals(input.toString());
	}

	public static Boolean isNullOrNone(Object source) {
		return source == null || "".equals(source.toString()) || "null".equals(source.toString());
	}
}
