package com.unitever.module.weChat.util;

import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.unitever.module.weChat.model.pay.PayPackage;
import com.unitever.platform.util.UUID;
import com.utils.GetWxOrderno;
import com.utils.MD5Util;

import weixin.popular.bean.pay.PayJsRequest;
import weixin.popular.util.MapUtil;
import weixin.popular.util.XMLConverUtil;

public class PayUtil {
	/**
	 * 获取openId后调用统一下单API
	 * 
	 * @param openid
	 *            用户唯一标识openid
	 * @param request
	 * @param key
	 *            微信商户API安全里面获得的密匙
	 * @return 预订单号prepay_id
	 */
	public static String getPrepayId(PayPackage payPackage, HttpServletRequest request, String key) {
		// payPackage.setTotal_fee("1");
		String sign = createSign(MapUtil.objectToMap(payPackage), key);
		payPackage.setSign(sign);
		String xml = XMLConverUtil.convertToXML(payPackage);
		String createOrderURL = "https://api.mch.weixin.qq.com/pay/unifiedorder";
		return new GetWxOrderno().getPayNo(createOrderURL, xml);
	}

	/**
	 * 创建md5摘要,规则是:按参数名称a-z排序,遇到空值的参数不参加签名。
	 */
	public static String createSign(Map<String, String> map, String key) {
		Map<String, String> packageParams = MapUtil.order(map);
		StringBuffer sb = new StringBuffer();
		Set es = packageParams.entrySet();
		Iterator it = es.iterator();
		while (it.hasNext()) {
			Map.Entry entry = (Map.Entry) it.next();
			String k = (String) entry.getKey();
			String v = (String) entry.getValue();
			if (null != v && !"".equals(v) && !"sign".equals(k) && !"key".equals(k)) {
				// 因为微信支付的package字段和java的关键字重复，所以实体类中是使用的package_，现在要替换过来
				if ("package_".equals(k)) {
					k = "package";
				}
				sb.append(k + "=" + v + "&");
			}
		}
		sb.append("key=" + key);
		String sign = MD5Util.MD5Encode(sb.toString(), "UTF-8").toUpperCase();
		return sign;

	}

	/**
	 * 生成支付JS请求JSON
	 * 
	 * @param payPackage
	 * @param prepay_id
	 * @param key
	 * @return
	 */
	public static String generatePayJsRequestJson(PayPackage payPackage, String prepay_id, String key) {
		PayJsRequest payJsRequest = new PayJsRequest();
		payJsRequest.setAppId(payPackage.getAppid());
		payJsRequest.setTimeStamp(System.currentTimeMillis() / 1000 + "");
		payJsRequest.setNonceStr(UUID.getUUID());
		payJsRequest.setPackage_("prepay_id=" + prepay_id);
		payJsRequest.setSignType("MD5");

		Map<String, String> mapS = MapUtil.objectToMap(payJsRequest, "paySign");
		String paySign = createSign(mapS, key);
		payJsRequest.setPaySign(paySign);

		// 此处如果用JSON.toJSONString(object)会出问题
		JSONObject json = new JSONObject();
		json.put("appId", payJsRequest.getAppId());
		json.put("timeStamp", payJsRequest.getTimeStamp());
		json.put("nonceStr", payJsRequest.getNonceStr());
		json.put("package", payJsRequest.getPackage_());
		json.put("paySign", paySign);
		json.put("signType", payJsRequest.getSignType());
		return json.toString();
	}

}
