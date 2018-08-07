package com.unitever.platform.util;

import java.math.BigDecimal;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.tencent.WXPay;
import com.tencent.protocol.refund_protocol.RefundReqData;
import com.unitever.module.weChat.model.WeChat;
import com.unitever.platform.core.web.filter.RequestResponseContextHolderFilter;
import com.unitever.tencent.bridge.BridgeForRefundBusinessTest;
import com.unitever.tencent.listener.DefaultRefundBusinessResultListener;

/**
 *
 * <P>
 * wxpay_scanpay_submch->com.scanpay.scanPayUtil->ScanPayUtil.java
 * </p>
 * <P>
 * 微信刷卡支付Util
 * </p>
 *
 * @author 闫枫
 * @date Nov 9, 2016
 */
public class WeChatScanPayUtil {

	private static Logger logger_weChatScanPayUtil = LoggerFactory.getLogger("WeChatScanPayUtil");;

	/**
	 *
	 * <P>
	 * 初始化微信支付所必须的数据
	 * </p>
	 *
	 * @author 闫枫
	 * @date Nov 9, 2016
	 */
	public static void initScanPay(WeChat weChat) {
		try {
			WXPay.initSDKConfiguration(
					// 签名算法需要用到的秘钥 "服务商的",
					weChat.getFatherApisecret(),
					// 公众账号ID，成功申请公众账号后获得 "服务商的",
					weChat.getFatherAppid(),
					// 商户ID，成功申请微信支付功能之后通过官方发出的邮件获得 "服务商的",
					weChat.getFatherMchid(),
					// 子商户ID，受理模式下必填； "特约商户的",
					weChat.getMchid(),
					// HTTP证书在服务器中的路径，用来加载证书用 "服务商的",
					RequestResponseContextHolderFilter.getPath() + "/WEB-INF/weixinCert/1277235501.p12",
					// HTTP证书的密码，默认等于MCHID "服务商的"
					weChat.getFatherMchid());
		} catch (Exception e) {
			logger_weChatScanPayUtil.error("初始化微信退款所需内容出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, WeChatScanPayUtil.class.getName()));
		}
	}

	/**
	 *
	 * <P>
	 * 微信支付退款接口，用于意外情况下支付成功但通知服务器出错时，退款给用户避免纠纷（ps：但是还是避免不了银行卡退款到账延时所引起的纠纷）
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 26, 2017
	 * @throws Exception
	 *             void
	 */
	public static boolean refundBusinessRun(BridgeForRefundBusinessTest bridge) {
		try {
			// 第一步：创建一个可以用来生成数据的bridge，这里用的是一个专门用来测试用的Bridge，商户需要自己实现这个Bridge来准备好数据
			// BridgeForRefundBusinessTest bridge = new
			// BridgeForRefundBusinessTest(order);
			// 第二步：从bridge里面拿到数据，构建提交被扫支付API需要的数据对象
			RefundReqData refundReqData = new RefundReqData(bridge.getTransactionID(), // 是微信系统为每一笔支付交易分配的订单号，通过这个订单号可以标识这笔交易，它由支付订单API支付成功时返回的数据里面获取到。建议优先使用
					bridge.getOutTradeNo(), // 商户系统内部的订单号,transaction_id
											// 、out_trade_no
											// 二选一，如果同时存在优先级：transaction_id>out_trade_no
					bridge.getDeviceInfo(), // 微信支付分配的终端设备号，与下单一致
					bridge.getOutRefundNo(), // 商户系统内部的退款单号，商户系统内部唯一，同一退款单号多次请求只退一笔
					bridge.getTotalFee(), // 订单总金额，单位为分
					bridge.getRefundFee(), // 退款总金额，单位为分,可以做部分退款
					bridge.getOpUserID(), // 操作员帐号, 默认为商户号
					bridge.getRefundFeeType()// 货币类型，符合ISO
												// 4217标准的三位字母代码，默认为CNY（人民币）
			);
			// 第三步：创建一个用来处理被扫支付业务逻辑各种结果分支的监听器resultListener
			DefaultRefundBusinessResultListener resultListener = new DefaultRefundBusinessResultListener();
			// 第四步：执行业务逻辑
			WXPay.doRefundBusiness(refundReqData, resultListener);
			if (DefaultRefundBusinessResultListener.ON_REFUND_SUCCESS.equals(resultListener.getResult())) {
				return true;
			} else if (DefaultRefundBusinessResultListener.ON_FAIL_BY_RETURN_CODE_ERROR
					.equals(resultListener.getResult())) {
				logger_weChatScanPayUtil.warn("微信支付退款接口参数不合法，请联系技术人员~");
			} else if (DefaultRefundBusinessResultListener.ON_FAIL_BY_RETURN_CODE_FAIL
					.equals(resultListener.getResult())) {
				logger_weChatScanPayUtil.warn("微信支付退款接口数据存在被篡改风险，请杀毒后重试或联系技术人员~");
			} else if (DefaultRefundBusinessResultListener.ON_FAIL_BY_SIGN_INVALID.equals(resultListener.getResult())) {
				logger_weChatScanPayUtil.warn("微信支付退款接口数据存在被篡改风险，请杀毒后重试或联系技术人员~");
			} else if (DefaultRefundBusinessResultListener.ON_REFUND_FAIL.equals(resultListener.getResult())) {
				logger_weChatScanPayUtil.warn("微信支付退款接口失败，请联系管理员通过微信支付后台重试~");
			}
		} catch (Exception e) {
			logger_weChatScanPayUtil.warn("微信支付退款出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, WeChatScanPayUtil.class.getName()));
		}
		return false;
	}

	public static int mul(String v1, String v2) {
		BigDecimal b1 = new BigDecimal(v1);
		BigDecimal b2 = new BigDecimal(v2);
		return b1.multiply(b2).intValue();
	}
}
