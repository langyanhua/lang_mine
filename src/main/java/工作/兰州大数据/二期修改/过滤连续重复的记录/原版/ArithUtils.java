package 工作.兰州大数据.二期修改.过滤连续重复的记录.原版;

import java.math.BigDecimal;

public class ArithUtils {
	private static final int DEF_DIV_SCALE = 10;

	/**
	 * 两个数相加
	 */
	public static BigDecimal add(Object v1, Object v2, int scale) {
		return round(add(v1, v2), scale);
	}

	public static BigDecimal add(Object v1, Object v2) {
		if (v1 == null)
			v1 = 0;
		if (v2 == null)
			v2 = 0;
		BigDecimal b1 = new BigDecimal(v1.toString());
		BigDecimal b2 = new BigDecimal(v2.toString());
		return b1.add(b2);
	}

	public static BigDecimal addAry(Object... vAry) {
		if (vAry == null || vAry.length == 0)
			return BigDecimal.ZERO;
		if (vAry.length == 1)
			return new BigDecimal(vAry[0].toString());
		BigDecimal firstBig = null;
		BigDecimal secondBig = null;
		for (int i = 0; i < vAry.length; i++) {
			if (firstBig == null && secondBig == null) {
				firstBig = new BigDecimal(vAry[0].toString());
				secondBig = new BigDecimal(vAry[1].toString());
				i++;
			} else {
				secondBig = new BigDecimal(vAry[i].toString());
			}
			firstBig = firstBig.add(secondBig);
		}
		return firstBig;
	}

	public static BigDecimal addAry(Object[] vAry, Integer scale) {
		return round(addAry(vAry), scale);
	}

	/**
	 * 两个数相减
	 */
	public static BigDecimal sub(Object v1, Object v2, Integer scale) {
		return round(sub(v1, v2), scale);
	}

	public static BigDecimal sub(Object v1, Object v2) {
		if (v1 == null)
			v1 = 0;
		if (v2 == null)
			v2 = 0;
		BigDecimal b1 = new BigDecimal(v1.toString());
		BigDecimal b2 = new BigDecimal(v2.toString());
		return b1.subtract(b2);
	}

	public static BigDecimal subAry(Object... vAry) {
		if (vAry == null || vAry.length == 0)
			return BigDecimal.ZERO;
		if (vAry.length == 1)
			return new BigDecimal(vAry[0].toString());
		BigDecimal firstBig = null;
		BigDecimal secondBig = null;
		for (int i = 0; i < vAry.length; i++) {
			if (firstBig == null && secondBig == null) {
				firstBig = new BigDecimal(vAry[0].toString());
				secondBig = new BigDecimal(vAry[1].toString());
				i++;
			} else {
				secondBig = new BigDecimal(vAry[i].toString());
			}
			firstBig = firstBig.subtract(secondBig);
		}
		return firstBig;
	}

	public static BigDecimal subAry(Object[] vAry, Integer scale) {
		return round(subAry(vAry), scale);
	}

	/**
	 * 两个数相乘
	 */

	public static BigDecimal mul(Object v1, Object v2, Integer scale) {
		return round(mul(v1, v2), scale);
	}

	public static BigDecimal mul(Object v1, Object v2) {
		if (v1 == null)
			v1 = 0;
		if (v2 == null)
			v2 = 0;
		BigDecimal b1 = new BigDecimal(v1.toString());
		BigDecimal b2 = new BigDecimal(v2.toString());
		return b1.multiply(b2);
	}

	public static BigDecimal mulAry(Object... vAry) {
		if (vAry == null || vAry.length == 0)
			return BigDecimal.ZERO;
		if (vAry.length == 1)
			return new BigDecimal(vAry[0].toString());
		BigDecimal firstBig = null;
		BigDecimal secondBig = null;
		for (int i = 0; i < vAry.length; i++) {
			if (firstBig == null && secondBig == null) {
				firstBig = new BigDecimal(vAry[0].toString());
				secondBig = new BigDecimal(vAry[1].toString());
				i++;
			} else {
				secondBig = new BigDecimal(vAry[i].toString());
			}
			firstBig = firstBig.multiply(secondBig);
		}
		return firstBig;
	}

	public static BigDecimal mulAry(Object[] vAry, Integer scale) {
		return round(mulAry(vAry), scale);
	}

	/**
	 * 两个数相除
	 */

	public static BigDecimal divide(Object v1, Object v2, Integer scale) {
		return round(divide(v1, v2), scale);
	}

	public static BigDecimal divide(Object v1, Object v2) {
		if (v1 == null)
			v1 = 0;
		if (v2 == null)
			v2 = 0;
		BigDecimal b1 = new BigDecimal(v1.toString());
		BigDecimal b2 = new BigDecimal(v2.toString());
		if(b2.equals(BigDecimal.ZERO))
			return BigDecimal.ZERO;
		return b1.divide(b2, DEF_DIV_SCALE, BigDecimal.ROUND_HALF_UP);
	}

	public static BigDecimal divideAry(Object... vAry) {
		if (vAry == null || vAry.length == 0)
			return BigDecimal.ZERO;
		if (vAry.length == 1)
			return new BigDecimal(vAry[0].toString());
		BigDecimal firstBig = null;
		BigDecimal secondBig = null;
		for (int i = 0; i < vAry.length; i++) {
			if (firstBig == null && secondBig == null) {
				firstBig = new BigDecimal(vAry[0].toString());
				secondBig = new BigDecimal(vAry[1].toString());
				i++;
			} else {
				secondBig = new BigDecimal(vAry[i].toString());
			}
			if(secondBig.equals(BigDecimal.ZERO))
				return BigDecimal.ZERO;
			firstBig = firstBig.divide(secondBig, DEF_DIV_SCALE, BigDecimal.ROUND_HALF_UP);
		}
		return firstBig;
	}
	
	public static BigDecimal divideAry(Object[] vAry, Integer scale) {
		return round(divideAry(vAry), scale);
	}

	/**
	 * 提供精确的小数位四舍五入处理。
	 * 
	 * @param v
	 *            需要四舍五入的数字
	 * @param scale
	 *            小数点后保留几位
	 * @return 四舍五入后的结果
	 */
	public static BigDecimal round(Object v, Integer scale) {
		if (scale < 0) {
			throw new IllegalArgumentException("The scale must be a positive integer or zero");
		}
		BigDecimal b = new BigDecimal(v.toString());
		BigDecimal one = new BigDecimal("1");
		return b.divide(one, scale, BigDecimal.ROUND_HALF_UP);
	}
}
