/**
 *
 * <P> AlipayApiUtil.java(阿里巴巴支付ApiUtil) </p>
 *
 * @author 闫枫
 * @date Mar 14, 2017
 */
package com.unitever.module.weChat.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.ZhimaCreditScoreBriefGetRequest;
import com.alipay.api.response.ZhimaCreditScoreBriefGetResponse;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-daikuan->com.unitever.module.weChat.util->AlipayApiUtil.java
 * </p>
 * <P>
 * 阿里巴巴支付ApiUtil
 * </p>
 *
 * @author 闫枫
 * @date Mar 14, 2017
 */
public class AlipayApiUtil {

	private static Logger logger_alipayApiUtil = LoggerFactory.getLogger("AlipayApiUtil");

	/** 阿里--蚂蚁金服--后台配置的应用的appid **/
	private static final String appid_alipay = "2017051707261057";
	/** 阿里--蚂蚁金服--后台配置的应用的公钥所对应的私钥（这个由开发者自己生成，阿里有提供生成工具，可以使用） **/
	private static final String private_key_alipay = "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALjqV15F87iv4WaC5fLTXET/cvNlGCYSxHa9gqEle9DKFo/3ngBElB72um4SXyh6XWfuhixSGCScowX+xEc6lfM6iBcFpoWmjPDawJXVgOVUyhJjwdo2I48WDIL2BAvBFUUDybjP9zvPL6QJQrGjx6CuZHYMZkAySAjCrVMU3ienAgMBAAECgYBBYjMUVX2xDxePDLfMHaohh4WYxGU+iSJIrgezfTKDiAFkVHTcuWL6c9lFtF9LS8EdT7zHjRuWToBiTUwPt4pvQ/CGcVTqdy8dAZ2nin3NI/GQp0sT5crQcdIsQHHBihTlRzsByP9TEnM8bOMnSqaHQV2owRtDGJiyi8lXl7+FUQJBAPxy5h7Fiy5rOIrXvcjUTYDSt4kem6v4iLelbj6GhQ3H4KZ1pzXQLOglPB2fXaYHqFC61+IyoIbaB7wyezmR4Z8CQQC7hD7mgqLoLbF0aeiE/KsTRU8zX3SpfY6TUAY6FLK50MCCT83nbXCm39Hfxx6XLWUmcuvO4ligMmQXrophccz5AkEAxPAFoX/OIjo28+l1/pPQmmzIDUo5eyD51vpRVKmwZp3FHVavSQXL4pYZnapTblCO99uqyqVgIZM5cZGYG8M4VQJAT3tvuf9Xk/iCRmj54RzEWue++XSVm54XyANckFPjqfV9E/9FtLnjzSgD6smZAtWAEXsWztuMW2LgoFUgXMuC6QJBAKLmT5QdqcNP991Ywxccv46fa5otkY/TClKHzjIbLTU2MOYnG6aEWaQSZTnZejWIGw3FsgjxBgbVRYky0QL+WXw=";
	/** 阿里--蚂蚁金服--后台配置的应用的配置好公钥后，阿里给出的对应的阿里的公钥 **/
	private static final String alipay_public_key = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDI6d306Q8fIfCOaTXyiUeJHkrIvYISRcc73s3vF1ZT7XN8RNPwJxo8pWaJMmvyTn9N4HQ632qJBVHf8sxHi/fEsraprwCtzvzQETrNRwVxLO5jVmRGi60j8Ue1efIlzPXV9je9mkjzOmdssymZkh2QhUrCmZYI/FCEa3/cNMW0QIDAQAB";
	/** 阿里--蚂蚁金服--接口调用测试沙箱地址 **/
	private static final String http_test_yes = "https://openapi.alipaydev.com/gateway.do";
	/** 阿里--蚂蚁金服--接口调用正式地址 **/
	private static final String http_test_no = "https://openapi.alipay.com/gateway.do";

	/**
	 *
	 * <P>
	 * 调起阿里--芝麻信用普惠版
	 * </p>
	 *
	 * @author 闫枫
	 * @date Mar 14, 2017
	 * @param IDCard
	 *            要查询的客户身份证号
	 * @param customerName
	 *            要查询的客户姓名
	 * @return AjaxJson (isSuccess=true
	 *         时，接口调用成功，获取到数据；msg为Y时，为通过，为N时不通过，N/A时，查询不到结果)
	 */
	public static AjaxJson getZhimaCreditScoreBrief(String IDCard, String customerName) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			AlipayClient alipayClient = new DefaultAlipayClient(http_test_no, appid_alipay, private_key_alipay, "json",
					"utf-8", alipay_public_key);
			ZhimaCreditScoreBriefGetRequest request = new ZhimaCreditScoreBriefGetRequest();
			request.setBizContent("{" + "\"transaction_id\":\"" + UUID.getUUID() + "\","
					+ "    \"product_code\":\"w1010100000000002733\"," + "    \"cert_type\":\"IDENTITY_CARD\","
					+ "    \"cert_no\":\"" + IDCard + "\"," + "    \"name\":\"" + customerName + "\","
					+ "    \"admittance_score\":750" + "  }");
			ZhimaCreditScoreBriefGetResponse response = alipayClient.execute(request);
			if (response.isSuccess()) {
				ajaxJson.setSuccess(true);
				ajaxJson.setMsg(response.getIsAdmittance());
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg(response.getSubMsg());
				logger_alipayApiUtil.error("调起阿里--芝麻信用普惠版出错，阿里返回错误信息如下：\nErrCode：" + response.getSubCode() + "\nErrMsg："
						+ response.getSubMsg());
			}
		} catch (AlipayApiException e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg(e.getErrMsg());
			logger_alipayApiUtil
					.error("调起阿里--芝麻信用普惠版出错，阿里返回错误信息如下：\nErrCode：" + e.getErrCode() + "\nErrMsg：" + e.getErrMsg());
		}
		return ajaxJson;
	}
}
