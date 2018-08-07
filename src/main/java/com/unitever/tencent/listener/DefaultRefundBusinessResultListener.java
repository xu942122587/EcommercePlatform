package com.unitever.tencent.listener;

import com.tencent.business.RefundBusiness;
import com.tencent.protocol.refund_protocol.RefundResData;

/**
 * User: rizenguo Date: 2014/12/2 Time: 18:32
 */
public class DefaultRefundBusinessResultListener implements RefundBusiness.ResultListener {

	public static final String ON_FAIL_BY_RETURN_CODE_ERROR = "on_fail_by_return_code_error";// PI返回ReturnCode不合法，支付请求逻辑错误，请仔细检测传过去的每一个参数是否合法，或是看API能否被正常访问
	public static final String ON_FAIL_BY_RETURN_CODE_FAIL = "on_fail_by_return_code_fail";// API返回ReturnCode为FAIL，支付API系统返回失败，请检测Post给API的数据是否规范合法
	public static final String ON_FAIL_BY_SIGN_INVALID = "on_fail_by_sign_invalid";// 支付请求API返回的数据签名验证失败，有可能数据被篡改了
	public static final String ON_REFUND_FAIL = "on_refund_fail";// 退款失败
	public static final String ON_REFUND_SUCCESS = "on_refund_success";// 退款成功

	private String result = "";

	// PI返回ReturnCode不合法，支付请求逻辑错误，请仔细检测传过去的每一个参数是否合法，或是看API能否被正常访问
	@Override
	public void onFailByReturnCodeError(RefundResData refundResData) {
		result = ON_FAIL_BY_RETURN_CODE_ERROR;
	}

	// API返回ReturnCode为FAIL，支付API系统返回失败，请检测Post给API的数据是否规范合法
	@Override
	public void onFailByReturnCodeFail(RefundResData refundResData) {
		result = ON_FAIL_BY_RETURN_CODE_FAIL;
	}

	// 支付请求API返回的数据签名验证失败，有可能数据被篡改了
	@Override
	public void onFailBySignInvalid(RefundResData refundResData) {
		result = ON_FAIL_BY_SIGN_INVALID;
	}

	// 退款失败
	@Override
	public void onRefundFail(RefundResData refundResData) {
		result = ON_REFUND_FAIL;
	}

	// 退款成功
	@Override
	public void onRefundSuccess(RefundResData refundResData) {
		result = ON_REFUND_SUCCESS;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

}
