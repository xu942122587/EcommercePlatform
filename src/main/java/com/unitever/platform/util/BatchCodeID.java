package com.unitever.platform.util;

public class BatchCodeID {
	private static String oldDateVal = null;
	private static Long code = 0l;

	/**
	 * 生成21位长批次号
	 * 
	 * @param nowDateValue
	 *            格式为yyyyMMddHHmm的当前日期字符串
	 * @return String 创建好21位长的批次号
	 */
	public static synchronized String nextCode(String nowDateValue) {
		if (oldDateVal != null) {
			if (oldDateVal.equals(nowDateValue)) {
				code++;
			} else {
				oldDateVal = nowDateValue;
				code = 0l;
			}
		} else {
			oldDateVal = nowDateValue;
			code = 0l;
		}
		Long m = Long.parseLong(nowDateValue) * 10000;
		m += code;
		return m.toString();
	}

	/**
	 * 生成21位长批次号(以当前精确到分钟的日期开头)
	 * 
	 * @return String 创建好21位长的批次号
	 */
	public static synchronized String nextCode() {
		return nextCode(DateUtil.getCurrDateString("yyyyMMddHHmmssSSS"));
	}
}
