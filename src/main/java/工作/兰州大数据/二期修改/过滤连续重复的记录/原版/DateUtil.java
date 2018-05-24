package 工作.兰州大数据.二期修改.过滤连续重复的记录.原版;

import org.apache.commons.lang.StringUtils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 时间字符串转换为时间戳类 用于转换hbase中的时间字符串
 * 
 * @author Administrator
 *
 */

public class DateUtil {
	/**
	 *
	 * @return 昨天的日期  xxxx-xx-xx
	 */
	public static String yestoday() {
		final Long daySeconds = 86400l;
		SimpleDateFormat sp = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date(System.currentTimeMillis()-daySeconds);
		return sp.format(date);
	}
	private static String[] pattern = new String[] { "yyyy-MM", "yyyyMM", "yyyy/MM", "yyyyMMdd", "yyyy-MM-dd",
			"yyyy/MM/dd", "yyyyMMddHHmmss", "yyyy-MM-dd HH:mm:ss", "yyyy/MM/dd HH:mm:ss", "yyyy-MM-dd HH:mm",
			"yyyy.MM.dd", "yyyy年MM月dd日" };

	public static Date getNowDate() throws Exception {
		return getNow("yyyy-MM-dd");
	}

	public static Date getNowTime() throws Exception {
		return getNow("yyyy-MM-dd HH:mm:ss");
	}

	public static Date getNow(String format) throws Exception {
		return string2Date(getNowStr(format));
	}

	public static String getNowDateStr() {
		return date2String(new Date(), "yyyy-MM-dd");
	}

	public static String getNowTimeStr() {
		return date2String(new Date(), "yyyy-MM-dd HH:mm:ss");
	}

	public static String getNowStr(String format) {
		Calendar cal = Calendar.getInstance();
		Date date = cal.getTime();
		return date2String(date, format);
	}

	public static String getNowYear() {
		return date2String(new Date(), "yyyy");
	}

	public static Date distanceDay(Date date, int day) throws Exception {
		Calendar ca = Calendar.getInstance();
		ca.setTime(date);
		ca.set(5, ca.get(5) + day);
		Date newDate = ca.getTime();
		return newDate;
	}

	public static long getDate(String sdate) throws ParseException {

		// 2016-09-11 12:09:33.0 oracle导入数据有问题，截取正确的时间字符串
		String indate = sdate.substring(0, 19);

		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = simpleDateFormat.parse(indate);
		// 获取时间戳
		long timeStemp = date.getTime();
		return timeStemp;
	}

	/**
	 * 转换年月日为long类型
	 * 
	 * @param sdate
	 * @return
	 * @throws ParseException
	 */
	public static String getSerachDate(String sdate) throws ParseException {

		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = simpleDateFormat.parse(sdate);
		// 获取时间戳
		long timeStemp = date.getTime();
		return Long.toString(timeStemp);
	}

	/**
	 * 时间戳转为时间字符串类型，用于前台展现
	 * 
	 * @param l
	 * @return
	 */
	public static String getJsonDate(long l,String format ) {

		String res;
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
		Date date = new Date(l);
		res = simpleDateFormat.format(date);
		System.out.println(res);
		return res;

	}


	public static Date string2Date(String dateStr) throws Exception {
		if (StringUtils.isEmpty(dateStr))
			return null;
		Date date = org.apache.commons.lang.time.DateUtils.parseDate(dateStr, pattern);
		return date;
	}

	public static Date string2Date(String s, String format) throws Exception {
		if ((s == null) || (s.equals("")))
			return null;
		DateFormat formater = new SimpleDateFormat(format);
		return formater.parse(s);
	}

	public static Date string2DateSafe(String dateStr) {
		if (StringUtils.isEmpty(dateStr))
			return null;
		Date date = null;
		try {
			date = org.apache.commons.lang.time.DateUtils.parseDate(dateStr, pattern);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}

	public static Date string2DateSafe(String s, String format) {
		if ((s == null) || (s.equals("")))
			return null;
		Date date = null;
		DateFormat formater = new SimpleDateFormat(format);
		try {
			date = formater.parse(s);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}

	public static String date2String(Date date) {
		if (date == null)
			return "";
		return date2String(date, null);
	}

	public static String date2String(Date date, String format) {
		if (date == null)
			return "";
		if (format == null || "".equals(format))
			format = "yyyy-MM-dd HH:mm:ss";
		DateFormat formater = new SimpleDateFormat(format);
		return formater.format(date);
	}

	/**
	 * beforeDate日期是否在afterDate日期之前
	 * 
	 * @param beforeDate
	 * @param afterDate
	 * @return
	 */
	public static boolean isBefore(Date beforeDate, Date afterDate) {
		Calendar c1 = Calendar.getInstance();
		c1.setTime(beforeDate);
		Calendar c2 = Calendar.getInstance();
		c2.setTime(afterDate);
		return c1.before(c2);
	}

	/**
	 * afterDate日期是否在beforeDate日期之后
	 * 
	 * @param afterDate
	 * @param beforeDate
	 * @return
	 */
	public static boolean isAfter(Date afterDate, Date beforeDate) {
		Calendar c1 = Calendar.getInstance();
		c1.setTime(afterDate);
		Calendar c2 = Calendar.getInstance();
		c2.setTime(beforeDate);
		return c1.after(c2);
	}

	/**
	 * date1日期与date2日期是否相等
	 * 
	 * @param date1
	 * @param date2
	 * @return
	 */
	public static boolean isEqual(Date date1, Date date2) {
		Calendar c1 = Calendar.getInstance();
		c1.setTime(date1);
		Calendar c2 = Calendar.getInstance();
		c2.setTime(date2);
		return c1.equals(c2);
	}

	/**
	 * date1日期是否小于date2日期
	 * 
	 * @param date1
	 * @param date2
	 * @return
	 */
	public static boolean isLt(Date date1, Date date2) {
		return isBefore(date1, date2);
	}

	/**
	 * date1日期是否大于date2日期
	 * 
	 * @param date1
	 * @param date2
	 * @return
	 */
	public static boolean isGt(Date date1, Date date2) {
		return isAfter(date1, date2);
	}

	/**
	 * date1日期是否小于等于date2日期
	 * 
	 * @param date1
	 * @param date2
	 * @return
	 */
	public static boolean isLe(Date date1, Date date2) {
		return isBefore(date1, date2) || isEqual(date1, date2);
	}

	/**
	 * date1日期是否大于等于date2日期
	 * 
	 * @param date1
	 * @param date2
	 * @return
	 */
	public static boolean isGe(Date date1, Date date2) {
		return isAfter(date1, date2) || isEqual(date1, date2);
	}
	
	public static String getDuration(Date date1, Date date2){
		long sec = 0;
		if (DateUtil.isAfter(date2, date1)) {
			sec = (date2.getTime() - date1.getTime()) / 1000;
		} else if (DateUtil.isBefore(date2, date1)) {
			sec = (date1.getTime() - date2.getTime()) / 1000;
		}
		return secToMinute(sec);
	}

	public static String secToMinute(long miao) {
		String r = "";
		if (miao < 60L)
			return String.valueOf(miao) + "\u79D2";
		if (miao == 60L)
			return "1\u5206\u949F";
		if (miao > 60L) {
			r = NumberUtilsExt.numberFormat(miao / 60L) + "\u5206";
			r = r + String.valueOf(miao % 60L) + "\u79D2";
			return r;
		}
		return "";
	}

	public static void main(String[] args) throws ParseException {

		// getDate("2017/09/20 12:11:33.0");

	}

}
