package 工作.兰州大数据.二期修改.过滤连续重复的记录.原版;

import org.apache.commons.lang.math.NumberUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.text.DecimalFormat;
import java.text.NumberFormat;

public class NumberUtilsExt extends NumberUtils {
    private static Logger logger = LoggerFactory.getLogger(NumberUtilsExt.class);

    public static String numberFormat(int formatNum, char append, int length) {
        String result = "";
        StringBuffer format = new StringBuffer();
        for (int i = 0; i < length; i++) {
            format.append(String.valueOf(append));
        }
        DecimalFormat decimalFormat = new DecimalFormat(format.toString());
        result = decimalFormat.format(formatNum);
        return result;
    }

    /**
     * @param value
     * @param format #0.00
     * @return
     */
    public static String decimalFormat(Object value, String format) {
        try {
        	if(value==null)return "";
            DecimalFormat df = null;
            if (format != null && format.length() > 0) {
                df = new DecimalFormat(format);
            } else {
                df = new DecimalFormat();
            }
            return df.format(value);
        } catch (Exception e) {
            logger.warn("出错",e);
        }
        return null;
    }

    /**
     * 数字转为字符型
     *
     * @param value
     * @param isGroupingUsed 如果数据大，是否用逗号隔开
     * @return
     */
    public static String numberFormat(Object value, boolean isGroupingUsed) {
        try {
            if (value == null)
                return null;
            String result = null;
            if (value instanceof String) {
                String vStr = (String) value;
                return vStr;
            } else if (value instanceof Integer) {
                Integer vInteger = (Integer) value;
                NumberFormat format = NumberFormat.getInstance();
                format.setGroupingUsed(isGroupingUsed);
                result = format.format(vInteger.intValue());
            } else if (value instanceof Long) {
                Long vLong = (Long) value;
                NumberFormat format = NumberFormat.getInstance();
                format.setGroupingUsed(isGroupingUsed);
                result = format.format(vLong.longValue());
            } else if (value instanceof Double) {
                Double vDouble = (Double) value;
                NumberFormat format = NumberFormat.getInstance();
                format.setGroupingUsed(isGroupingUsed);
                result = format.format(vDouble.doubleValue());
            }

            return result;
        } catch (Exception e) {
            logger.warn("出错", e);
        }
        return null;
    }

    /**
     * 安全转换，如果是null值，则返回字符""值
     *
     * @param value
     * @param isGroupingUsed
     * @param defaultValue
     * @return
     */
    public static String numberSafeFormat(Object value, boolean isGroupingUsed, String defaultValue) {
        try {
            if (value == null) {
                if (defaultValue != null)
                    return defaultValue;
                else
                    return "";
            } else {
                return NumberUtilsExt.numberFormat(value, isGroupingUsed);
            }
        } catch (Exception e) {
            logger.warn("出错", e);
        }
        return null;
    }

    public static String numberFormat(Object value) {
        return NumberUtilsExt.numberFormat(value, false);
    }

    public static String numberSafeFormat(Object value) {
        return NumberUtilsExt.numberSafeFormat(value, false, "");
    }

    public static double getDouble(String s) {
        double d = 0.0D;
        NumberFormat nf = NumberFormat.getInstance();
        try {
            if (s.indexOf("%") >= 0)
                d = NumberFormat.getPercentInstance().parse(s).doubleValue();
            else if (s.indexOf("\uFFE5") >= 0)
                d = NumberFormat.getCurrencyInstance().parse(s).doubleValue();
            else
                d = nf.parse(s).doubleValue();
        } catch (Exception e) {
            logger.warn("出错",e);
        }

        return d;
    }

    public static String format(double d, int places) {
        NumberFormat nf = NumberFormat.getInstance();
        nf.setMinimumFractionDigits(places);
        nf.setMaximumFractionDigits(places);
        return nf.format(d);
    }

    public static String format(Double d, int places) {
        return format(d.doubleValue(), places);
    }

    public static String format(String d, int places) {
        return format(Double.parseDouble(d), places);
    }

    public static String getPrecent(float a, float b, int cnt) {
        String Precent = "";
        if (b == 0.0F) {
            Precent = "0";
            Precent = Precent + ".";
            Precent = Precent + "0";
            Precent = Precent + "%";
            return Precent;
        }
        if (a == b) {
            Precent = "100";
            Precent = Precent + "%";
            return Precent;
        }
        float result = (a * 100F) / b;
        String vresult = String.valueOf(result);
        int nn = vresult.indexOf(".");
        if (vresult.length() >= nn + cnt + 1) {
            Precent = vresult.substring(0, nn + cnt + 1);
            Precent = format(Precent, cnt);
        } else {
            Precent = vresult;
            String pointStr = Precent.substring(Precent.lastIndexOf(".") + 1, Precent.length());
            for (int i = 0; i < cnt - pointStr.length(); i++)
                Precent = Precent + 0;

        }
        Precent = Precent + "%";
        return Precent;
    }

    /**
     * 提供精确的小数位四舍五入处理。
     *
     * @param v     需要四舍五入的数字
     * @param scale 小数点后保留几位
     * @return 四舍五入后的结果
     */
    public static double round(double v, int scale) {
        return ArithUtils.round(Double.valueOf(v), scale).doubleValue();
    }

    public static void main(String[] args) throws Exception {
        NumberFormat nf = NumberFormat.getNumberInstance();
        System.out.println(nf.format(0.0534567D));
        System.out.println(NumberUtilsExt.round(20.12D, 4));
        double d = 1655645454.000000000000;
        System.out.println(NumberUtilsExt.numberFormat(d));
        Long t = 333333L;
        System.out.println(NumberUtilsExt.decimalFormat(t, "###"));
    }
}