package 工作.兰州大数据.二期修改.套牌车分析.原版;

import java.io.PrintWriter;
import java.io.StringWriter;

import org.apache.commons.lang.StringUtils;

public class ExceptionUtilsExt {
	public static String printStackTrace(Exception e, Integer charNum){
		String errorInfo = null;
		try {
			StringWriter result = new StringWriter();
			PrintWriter pw = new PrintWriter(result);
			e.printStackTrace(pw);
			try {
				errorInfo = result.toString().substring(0, charNum);
			} catch (Exception e1) {
				errorInfo = result.toString();
			}
		} catch (Exception e1) {
		}
		if (StringUtils.isEmpty(errorInfo))
			errorInfo = e.getMessage() != null ? e.getMessage() : e.toString();
		return errorInfo;
	}
	
	public static String printStackTrace(Exception e){
		String errorInfo = null;
		try {
			StringWriter result = new StringWriter();
			PrintWriter pw = new PrintWriter(result);
			e.printStackTrace(pw);
			errorInfo = result.toString();
		} catch (Exception e1) {
		}
		if (StringUtils.isEmpty(errorInfo))
			errorInfo = e.getMessage() != null ? e.getMessage() : e.toString();
		return errorInfo;
	}
}
