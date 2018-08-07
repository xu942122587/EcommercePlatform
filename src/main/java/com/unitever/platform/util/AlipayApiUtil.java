/**
 *
 * <P> AlipayApiUtil.java </p>
 *
 * @author 闫枫
 * @date Aug 28, 2017
 */
package com.unitever.platform.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSONObject;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradeRefundRequest;
import com.alipay.api.response.AlipayTradeRefundResponse;
import com.unitever.module.weChat.model.WeChat;

/**
 *
 * <P>
 * client-tianhe->com.scanpay.scanPayUtil->AlipayApiUtil.java
 * </p>
 * <P>
 * 支付宝当面付-条码支付Util
 * </p>
 *
 * @author 闫枫
 * @date Aug 28, 2017
 */
public class AlipayApiUtil {

	private static Logger logger_alipayApiUtil = LoggerFactory.getLogger("AlipayApiUtil");
	private static AlipayClient alipayClient = null;

	/**
	 *
	 * <P>
	 * 初始化支付宝当面付-条码支付所必须的数据
	 * </p>
	 *
	 * @author 闫枫
	 * @date Nov 9, 2016
	 */
	public static void initScanPay(WeChat weChat) {
		try {
			// 读取属性文件httpUrlPath.properties
			AliPay.initSDKConfiguration(
					// 应用的appid,
					weChat.getAliAppid(),
					// prop.getProperty("APPID"),
					// 公钥所对应的私钥,
					weChat.getAliPayPrivateKey(),
					// prop.getProperty("PRIVATE_KEY"),
					// 阿里的公钥,
					weChat.getAliPublicKey(),
					// prop.getProperty("ALI_PUBLIC_KEY"),
					// 接口调用URL,
					weChat.getAliHttpURL()
			// 查询等待时间,
			// ,Integer.parseInt(prop.getProperty("SELECT_STOP_TIME")),
			// 查询次数
			// Integer.parseInt(prop.getProperty("SELECT_NUMBER"))
			);
			alipayClient = new DefaultAlipayClient(AliPay.HTTP_URL, AliPay.APPID, AliPay.PRIVATE_KEY, "json", "utf-8",
					AliPay.ALI_PUBLIC_KEY, "RSA2"); // 获得初始化的AlipayClient
		} catch (Exception e) {
			logger_alipayApiUtil.error("支付宝初始化退款所需内容出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, AlipayApiUtil.class.getName()));
		}
	}

	/**
	 *
	 * <P>
	 * 支付宝退款接口--单次调用
	 * </p>
	 *
	 * @date Sep 2, 2017
	 * @param aliPayPayCode
	 *            支付宝支付交易号
	 * @param returnMoney
	 *            退款金额
	 * @return boolean
	 */
	public static boolean refund(String aliPayPayCode, String returnMoney) {
		boolean isPaySuccess = false;
		try {
			if (null == alipayClient)
				alipayClient = new DefaultAlipayClient(AliPay.HTTP_URL, AliPay.APPID, AliPay.PRIVATE_KEY, "json",
						"utf-8", AliPay.ALI_PUBLIC_KEY, "RSA2"); // 获得初始化的AlipayClient

			AlipayTradeRefundRequest request = new AlipayTradeRefundRequest();// 创建API对应的request类
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("trade_no", aliPayPayCode);
			jsonObject.put("out_request_no", UUID.getUUID());
			jsonObject.put("refund_amount", returnMoney);
			request.setBizContent(jsonObject.toJSONString()); // 设置业务参数
			AlipayTradeRefundResponse response = alipayClient.execute(request);// 通过alipayClient调用API，获得对应的response类
			logger_alipayApiUtil.info("支付宝退款接口返回数据：" + response.getBody());
			if ("10000".equals(response.getCode())) {
				isPaySuccess = true;
			}
		} catch (AlipayApiException e) {
			logger_alipayApiUtil.error(
					"调起阿里支付api出错，具体错误如下：" + ExceptionUtil.getExceptionAllinformation(e, AlipayApiUtil.class.getName()));
		}
		return isPaySuccess;
	}
}
