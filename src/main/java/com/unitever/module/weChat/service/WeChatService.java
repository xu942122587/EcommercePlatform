package com.unitever.module.weChat.service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.hamster.weixinmp.constant.WxMsgEventType;
import org.hamster.weixinmp.constant.WxMsgType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONObject;
import com.unitever.module.employee.model.Employee;
import com.unitever.module.employee.service.EmployeeService;
import com.unitever.module.order.model.Order;
import com.unitever.module.rechargeRecord.model.RechargeRecord;
import com.unitever.module.weChat.dao.manual.WeChatDAO;
import com.unitever.module.weChat.model.WeChat;
import com.unitever.module.weChat.model.pay.PayPackage;
import com.unitever.module.weChat.util.MessageUtil;
import com.unitever.module.weChat.util.PayUtil;
import com.unitever.module.weChat.util.WeChatUtil;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.DoubleUtil;
import com.unitever.platform.util.UUID;

import weixin.popular.bean.xmlmessage.XMLTextMessage;

@Service
@Transactional
public class WeChatService {

	@Autowired
	private WeChatDAO weChatDAO;
	@Autowired
	private EmployeeService employeeService;

	private Logger logger_weChatService = LoggerFactory.getLogger("WeChatService");

	/**
	 * <p>
	 * 根据ID获取WeChat信息
	 * </p>
	 * 
	 * @param id
	 *            ：WeChat的id
	 * @return WeChat
	 */
	public WeChat getWeChatById(String id) {
		if (StringUtils.isBlank(id)) {
			return null;
		}
		return weChatDAO.get(id);
	}

	/**
	 * <p>
	 * 更新员工信息记录
	 * </p>
	 * 
	 */
	public void update(WeChat weChat) {
		if (weChat != null) {
			weChatDAO.update(weChat);
		}
	}

	/**
	 *
	 * <P>
	 * </p>
	 *
	 * @author 闫枫
	 * @date Nov 14, 2016
	 * @param prizeMaxCount
	 */
	public void updatePrizeMaxCount(String prizeMaxCount) {
		if (StringUtils.isNotBlank(prizeMaxCount))
			weChatDAO.updatePrizeMaxCount(prizeMaxCount);
	}

	/**
	 * <p>
	 * 删除员工信息记录(设置员工信息为离职)
	 * </p>
	 * 
	 */
	public void delete(String id) {
		if (StringUtils.isNotBlank(id)) {
			weChatDAO.delete(id);
		}
	}

	/**
	 * <p>
	 * 获取WeChat分页对象
	 * </p>
	 * 
	 * @param page
	 * @param WeChat
	 * @return
	 */
	public Page<WeChat> getPage(Page<WeChat> page, WeChat weChat) {

		List<WeChat> weChatList = weChatDAO.getWeChatByWeChat(weChat);
		page.setTotalRecord(weChatList.size());
		if (weChatList.size() >= (page.getStartOfPage() + page.getPageSize())) {
			page.setResults(weChatList.subList(page.getStartOfPage(), page.getStartOfPage() + page.getPageSize()));
		} else {
			page.setResults(weChatList.subList(page.getStartOfPage(), weChatList.size()));
		}
		return page;
	}

	public WeChat getWeChatWithWeChatNum(String weChatNum) {
		return weChatDAO.getWeChatWithWeChatNum(weChatNum);
	}

	/**
	 * 处理微信响应请求
	 * 
	 * @param request
	 * @return
	 */
	public String weChatHandler(HttpServletRequest request) {
		String respMessage = null;
		try {
			Map<String, String> requestMap = MessageUtil.parseXml(request);// xml请求解析
			String fromUserName = requestMap.get("FromUserName");// 发送方帐号（open_id）
			String toUserName = requestMap.get("ToUserName");// 公众帐号
			String msgType = requestMap.get("MsgType");// 消息类型
			WeChat weChat = this.getWeChatWithWeChatNum(toUserName);
			if (msgType.equals(WxMsgType.TEXT)) {// 文本消息
				/*
				 * // 接收用户发送的文本消息内容 String content = requestMap.get("Content");
				 */
				Employee employee = employeeService.getEmployeeWithOpenId(fromUserName);
				if (Employee.kefuState_one.equals(employee.getKefuState())) {
					StringBuilder sb = new StringBuilder();
					sb.append("<xml>");
					sb.append("<ToUserName><![CDATA[" + fromUserName + "]]></ToUserName>");
					sb.append("<FromUserName><![CDATA[" + toUserName + "]]></FromUserName>");
					sb.append("<CreateTime>" + System.currentTimeMillis() / 1000 + "</CreateTime>");
					sb.append("<MsgType><![CDATA[transfer_customer_service]]></MsgType>");
					sb.append("</xml>");
					respMessage = sb.toString();
				} else {
					// 默认回复此文本消息
					respMessage = new XMLTextMessage(fromUserName, toUserName, "感谢您的留言，我们会尽快处理。").toXML();
				}

			} else if (msgType.equals(WxMsgType.EVENT)) {// 事件
				// 接收用户发送的事件请求内容
				String event = requestMap.get("Event");
				if (WxMsgEventType.SUBSCRIBE.equals(event)) {// 关注
					respMessage = new XMLTextMessage(fromUserName, toUserName, "天和商城欢迎您！").toXML();
				} else if (WxMsgEventType.UNSUBSCRIBE.equals(event)) {// 取消关注

				} else if (MessageUtil.EVENT_TYPE_CLICK.equals(event)) {// 点击自定义菜单
					String eventKey = requestMap.get("EventKey");
					if ("tel".equals(eventKey)) {
						Employee employee = employeeService.getEmployeeWithOpenId(fromUserName);
						if (Employee.kefuState_one.equals(employee.getKefuState())) {
							employeeService.kefuEnd(fromUserName);
							respMessage = new XMLTextMessage(fromUserName, toUserName, "您已退出客服模式").toXML();
						} else {
							employeeService.kefuStart(fromUserName);
							respMessage = new XMLTextMessage(fromUserName, toUserName,
									"您已进入客服模式，退出请再次点击客服按钮，系统默认第二天退出客服模式").toXML();
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return respMessage;
	}

	/**
	 *
	 * <P>
	 * 获取所有wechat列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jan 10, 2017
	 * @return List<WeChat>
	 */
	public List<WeChat> getWeChatList() {
		return weChatDAO.getAll();
	}

	/**
	 * <p>
	 * 使用微信js--sdk的签名算法
	 * </p>
	 * 
	 * @param user
	 *            User类型
	 * @param jspURI
	 *            要使用js--sdk的页面除去服务器域名后的地址，String类型
	 * 
	 * @return String
	 */
	public String getJsApiData(WeChat user, String jspURI) {
		String noncestr = "Wm3WZYTPz0wzccnW";
		String timestamp = new Date().getTime() + "";
		String ticket = WeChatUtil.getJsApiTicket(user);
		// String url = user.getDomainName() + jspURI;
		String string = "jsapi_ticket=" + ticket + "&noncestr=" + noncestr + "&timestamp=" + timestamp + "&url="
				+ jspURI;
		MessageDigest md = null;
		String signature = null;
		try {
			md = MessageDigest.getInstance("SHA-1");
			// 将三个参数字符串拼接成一个字符串进行sha1加密
			byte[] digest = md.digest(string.getBytes());
			signature = byteToStr(digest);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		JSONObject json = new JSONObject();
		json.put("appId", user.getAppid());
		json.put("timeStamp", timestamp);
		json.put("nonceStr", noncestr);
		json.put("signature", signature);
		return json.toString();
	}

	/**
	 * 将字节数组转换为十六进制字符串
	 * 
	 * @param byteArray
	 * @return
	 */
	private static String byteToStr(byte[] byteArray) {
		String strDigest = "";
		for (int i = 0; i < byteArray.length; i++) {
			strDigest += byteToHexStr(byteArray[i]);
		}
		return strDigest;
	}

	/**
	 * 将字节转换为十六进制字符串
	 * 
	 * @param mByte
	 * @return
	 */
	private static String byteToHexStr(byte mByte) {
		char[] Digit = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
		char[] tempArr = new char[2];
		tempArr[0] = Digit[(mByte >>> 4) & 0X0F];
		tempArr[1] = Digit[mByte & 0X0F];
		String s = new String(tempArr);
		return s;
	}

	public PayPackage generatePayPackage(List<Order> orderSrc, HttpServletRequest request, WeChat weChat,
			String openId) {
		int totalPrice = 0;
		String orderIds = "", sumMoney = orderSrc.get(0).getPostage();

		// 计算总金额
		for (Order order : orderSrc) {
			sumMoney = DoubleUtil.add(sumMoney, order.getOnePayMoney()).toString();
			orderIds += order.getId();
		}
		totalPrice = DoubleUtil.mul(sumMoney + "", "100").intValue();
		PayPackage payPackage = new PayPackage();
		payPackage.setAppid(weChat.getFatherAppid());
		payPackage.setSub_appid(weChat.getAppid());
		payPackage.setMch_id(weChat.getFatherMchid());
		payPackage.setSub_mch_id(weChat.getMchid());
		payPackage.setSub_openid(openId);
		// 这里notify_url是支付完成后微信发给该链接信息，可以判断会员是否支付成功，改变订单状态等。
		payPackage.setNotify_url(weChat.getDomainName() + "/platform/weChat/mchNotifyPaySuccess?orderId=" + orderIds);
		payPackage.setTrade_type("JSAPI");
		payPackage.setOut_trade_no(UUID.getUUID());
		payPackage.setSpbill_create_ip(request.getRemoteAddr());// 订单生成的机器 IP
		payPackage.setNonce_str(UUID.getUUID());
		payPackage.setBody(weChat.getName());
		payPackage.setAttach("微信支付");
		payPackage.setTotal_fee(totalPrice + "");
		return payPackage;
	}

	public String getWeChatPaymentJsonWithOrder(List<Order> orderList, HttpServletRequest request, String openId,
			String wechatNum) {
		WeChat src = weChatDAO.getWeChatWithWeChatNum(wechatNum);
		PayPackage payPackage = generatePayPackage(orderList, request, src, openId);
		String prepay_id = PayUtil.getPrepayId(payPackage, request, src.getFatherApisecret());// 获取预订单号
		return PayUtil.generatePayJsRequestJson(payPackage, prepay_id, src.getFatherApisecret());// 使用预订单号生成支付请求JSON
	}

	/**
	 *
	 * <P>
	 * 生成充值PayPackage
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月9日
	 * @param rechargeRecord
	 * @param request
	 * @param weChat
	 * @param openId
	 * @return PayPackage
	 */
	public PayPackage generatePayPackage_recharge(RechargeRecord rechargeRecord, HttpServletRequest request,
			WeChat weChat, String openId) {
		int totalPrice = 0;
		// 计算总金额
		totalPrice = DoubleUtil.mul(rechargeRecord.getMoney(), "100").intValue();
		PayPackage payPackage = new PayPackage();
		payPackage.setAppid(weChat.getFatherAppid());
		payPackage.setSub_appid(weChat.getAppid());
		payPackage.setMch_id(weChat.getFatherMchid());
		payPackage.setSub_mch_id(weChat.getMchid());
		payPackage.setSub_openid(openId);
		// 这里notify_url是支付完成后微信发给该链接信息，可以判断会员是否支付成功，改变订单状态等。
		payPackage.setNotify_url(
				weChat.getDomainName() + "/platform/weChat/recharPaySuccess?id=" + rechargeRecord.getId());
		payPackage.setTrade_type("JSAPI");
		payPackage.setOut_trade_no(UUID.getUUID());
		payPackage.setSpbill_create_ip(request.getRemoteAddr());// 订单生成的机器 IP
		payPackage.setNonce_str(UUID.getUUID());
		payPackage.setBody(weChat.getName());
		payPackage.setAttach("微信支付");
		payPackage.setTotal_fee(totalPrice + "");
		return payPackage;
	}

	/**
	 *
	 * <P>
	 * 获取充值json
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月9日
	 * @param rechargeRecord
	 * @param request
	 * @param openId
	 * @param wechatNum
	 * @return String
	 */
	public String getWeChatPaymentJson_recharge(RechargeRecord rechargeRecord, HttpServletRequest request,
			String openId, String wechatNum) {
		WeChat src = weChatDAO.getWeChatWithWeChatNum(wechatNum);
		PayPackage payPackage = this.generatePayPackage_recharge(rechargeRecord, request, src, openId);
		String prepay_id = PayUtil.getPrepayId(payPackage, request, src.getFatherApisecret());// 获取预订单号
		return PayUtil.generatePayJsRequestJson(payPackage, prepay_id, src.getFatherApisecret());// 使用预订单号生成支付请求JSON
	}

	public WeChat getWeChatWithAppId(String appid) {
		return weChatDAO.getWeChatWithAppId(appid);
	}

}