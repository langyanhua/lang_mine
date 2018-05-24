package 工作.兰州大数据.二期修改.过滤连续重复的记录.原版;

import java.text.DecimalFormat;

/**
 * <p>
 * {@link Number} number utils
 * </p>
 * 
 * @author admin
 *
 */
public class NumberUtils {

	/**
	 * default number is 0.
	 */
	public static final int ZERO = 0;

	private NumberUtils() {
	}

	/**
	 * check string is number.
	 * 
	 * @param str
	 *            source string
	 * @return true | false
	 */
	public static boolean isNumber(String str) {
		for (int i = str.length(); --i >= 0;) {
			int cha = str.charAt(i);
			if (cha < 48 || cha > 57) {
				return false;
			}
		}
		return true;
	}

	/**
	 * check value is zero.
	 * 
	 * @param num
	 *            source value
	 * @return true | false
	 */
	public static boolean isZero(Number num) {
		if (num.intValue() == 0) {
			return true;
		}
		if (num.doubleValue() == 0.0) {
			return true;
		}
		if (num.longValue() == 0L) {
			return true;
		}
		if (num.byteValue() == 0) {
			return true;
		}
		if (num.shortValue() == 0) {
			return true;
		}
		if (num.floatValue() == 0F) {
			return true;
		}
		return false;
	}

	/**
	 * check value is not zero.
	 * 
	 * @param num
	 *            source value
	 * @return true | false
	 */
	public static boolean isNotZero(Number num) {
		return !isZero(num);
	}

	/**
	 * check value is less than zero.
	 * 
	 * @param num
	 *            source value
	 * @return true | false
	 */
	public static boolean lessThanZero(Number num) {
		if (num.intValue() < 0) {
			return true;
		}
		if (num.doubleValue() < 0) {
			return true;
		}
		if (num.longValue() < 0) {
			return true;
		}
		if (num.byteValue() < 0) {
			return true;
		}
		if (num.shortValue() < 0) {
			return true;
		}
		if (num.floatValue() < 0) {
			return true;
		}
		return false;
	}

	public static String decimalFormat(Object value, String format) {
		try {
			if (value == null)
				return "";
			DecimalFormat df = null;
			if (format != null && format.length() > 0) {
				df = new DecimalFormat(format);
			} else {
				df = new DecimalFormat();
			}
			return df.format(value);
		} catch (Exception e) {
			System.out.println("["+value+"]数字格式化错误!");
		}
		return null;
	}

}