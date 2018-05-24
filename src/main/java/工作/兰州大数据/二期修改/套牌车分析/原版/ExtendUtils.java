package 工作.兰州大数据.二期修改.套牌车分析.原版;

import 工作.兰州大数据.二期修改.过滤连续重复的记录.原版.ArithUtils;
import 工作.兰州大数据.二期修改.过滤连续重复的记录.原版.DateUtil;

import java.math.BigDecimal;
import java.util.Date;

public class ExtendUtils {
	
	/**
	 * 获取两个卡口之间的距离(公里)
	 * 
	 * @param mapX1
	 * @param mapY1
	 * @param mapX2
	 * @param mapY2
	 * @return
	 */
	public static double getSectionDistanceKm(String mapX1, String mapY1, String mapX2, String mapY2) {
		double d = getSectionDistanceM(mapX1, mapY1, mapX2, mapY2);
		return ArithUtils.round(d/1000, 3).doubleValue();
	}
	public static double getSectionDistanceKm(Double mapX1, Double mapY1, Double mapX2, Double mapY2) {
		double d = getSectionDistanceM(mapX1, mapY1, mapX2, mapY2);
		return ArithUtils.round(d/1000, 3).doubleValue();
	}
	/**
	 * 获取两个卡口之间的距离(米)
	 * 
	 * @param mapX1
	 * @param mapY1
	 * @param mapX2
	 * @param mapY2
	 * @return
	 */
	public static double getSectionDistanceM(String mapX1, String mapY1, String mapX2, String mapY2) {
		double mapX1_double = Double.parseDouble(mapX1);
		double mapY1_double = Double.parseDouble(mapY1);
		double mapX2_double = Double.parseDouble(mapX2);
		double mapY2_double = Double.parseDouble(mapY2);
		double a, b, R;
		R = 6378137; // 地球半径
		mapY1_double = mapY1_double * Math.PI / 180.0;
		mapY2_double = mapY2_double * Math.PI / 180.0;
		a = mapY1_double - mapY2_double;
		b = (mapX1_double - mapX2_double) * Math.PI / 180.0;
		double d;
		double sa2, sb2;
		sa2 = Math.sin(a / 2.0);
		sb2 = Math.sin(b / 2.0);
		d = 2 * R * Math.asin(Math.sqrt(sa2 * sa2 + Math.cos(mapY1_double) * Math.cos(mapY2_double) * sb2 * sb2));
		return d;
	}
	public static double getSectionDistanceM(Double mapX1_double, Double mapY1_double, Double mapX2_double, Double mapY2_double) {
		double a, b, R;
		R = 6378137; // 地球半径
		mapY1_double = mapY1_double * Math.PI / 180.0;
		mapY2_double = mapY2_double * Math.PI / 180.0;
		a = mapY1_double - mapY2_double;
		b = (mapX1_double - mapX2_double) * Math.PI / 180.0;
		double d;
		double sa2, sb2;
		sa2 = Math.sin(a / 2.0);
		sb2 = Math.sin(b / 2.0);
		d = 2 * R * Math.asin(Math.sqrt(sa2 * sa2 + Math.cos(mapY1_double) * Math.cos(mapY2_double) * sb2 * sb2));
		return d;
	}

	/**
	 * 获取车辆两次拍照时间之间的行驶距离(公里)
	 * 
	 * @param indate1
	 * @param indate2
	 * @return
	 */
	public static double getDriveDistanceKm(Double kmhour, String indate1, String indate2) {
		double distance = 0.0;
		try {
			Date date1 = DateUtil.string2Date(indate1, "yyyy-MM-dd HH:mm:ss");
			Date date2 = DateUtil.string2Date(indate2, "yyyy-MM-dd HH:mm:ss");
			if (DateUtil.isAfter(date2, date1)) {
				long sec = (date2.getTime() - date1.getTime()) / 1000;
				distance = ArithUtils.round(ArithUtils.mul(ArithUtils.divide(new BigDecimal(sec), 3600), kmhour), 2).doubleValue();
			} else if (DateUtil.isBefore(date2, date1)) {
				long sec = (date1.getTime() - date2.getTime()) / 1000;
				distance = ArithUtils.round(ArithUtils.mul(ArithUtils.divide(new BigDecimal(sec), 3600), kmhour), 2).doubleValue();
			}
		} catch (Exception e) {
		}
		return distance;
	}
	
	public static void main(String[] args){
		double d1 = ExtendUtils.getSectionDistanceKm("112.554606", "37.888443", "112.566678", "37.888443");
		double d2 = ExtendUtils.getSectionDistanceKm("112.854760", "35.490000", "112.855080", "35.484380");
		System.out.println(d1 + "     " + d2);

		double juli = getDriveDistanceKm(120.0, "2016-11-04 10:00:00", "2016-11-04 11:00:00");
		System.out.println("######"+juli);
	}
}
