package com.unitever.platform.util;

public class EticketCodeID {
	private static String oldDateVal = null;
	private static Long code = 0l;

	/**
	 * 生成18位长电子券编号
	 * 
	 * @param nowDateValue
	 *            格式为yyyyMMddHHmmss的当前日期字符串
	 * @return String 创建好18位长的订单号
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
	 * 生成18位长电子券编号
	 * 
	 * @return String 创建好18位长的订单号
	 */
	public static synchronized String nextCode() {
		return nextCode(DateUtil.getCurrDateString("yyyyMMddHHmmss"));
	}
}
