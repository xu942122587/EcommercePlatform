package com.unitever.platform.util;

import java.util.Enumeration;

public class RequestParamUtil {
	/**
	 *
	 * <P>
	 * </p>
	 *
	 * @author 闫枫
	 * @date Nov 1, 2016
	 * @param allUrlRequestParam
	 *            请求所携带的参数
	 * @param allUserIngUrlParams
	 *            正常请求所包含的参数
	 * @return
	 */
	public static boolean getUrlParamIsTrue(Enumeration allUrlRequestParam, String allUserIngUrlParams) {
		int requestParamCount = 0;
		boolean paramIsTrue = true;
		while (allUrlRequestParam.hasMoreElements()) {
			requestParamCount++;
			String paramName = (String) allUrlRequestParam.nextElement();
			if (-1 >= allUserIngUrlParams.indexOf(paramName))
				paramIsTrue = false;
		}
		if (0 >= requestParamCount)
			return true;
		return paramIsTrue;
	}
}
