/**
 *
 * <P> Snippet.java </p>
 *
 * @author 闫枫
 * @date Dec 30, 2016
 */
package com.unitever.platform.util;

import org.apache.commons.lang.StringUtils;

/**
 *
 * <P>
 * platform-daikuan->com.unitever.platform.util->StringReplace.java
 * </p>
 * <P>
 * 字符串替换关键字封装
 * </p>
 *
 * @author 闫枫
 * @date Dec 30, 2016
 */
public class StringReplace {
	/**
	 *
	 * <P>
	 * 替换html中的< > " '为转义字符
	 * </p>
	 *
	 * @author 闫枫
	 * @date Dec 30, 2016 void
	 * @param noReplaceString
	 *            ！
	 * @return String
	 */
	public static String replaceHtmlToOther(String noReplaceString) {
		if (StringUtils.isBlank(noReplaceString))
			return noReplaceString;
		return noReplaceString.replace("?", "&#63;").replace("？", "&#63;").replace("%", "&#37;").replace("！", "&#33;")
				.replace("!", "&#33;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;")
				.replace("'", "&#39;").replace("+", "&#43;").replace(",", "&#44;").replace("-", "&#45;")
				.replace(".", "&#46;").replace("/", "&#47;").replace(":", "&#58;").replace(";", "&#58;");
	}
}
