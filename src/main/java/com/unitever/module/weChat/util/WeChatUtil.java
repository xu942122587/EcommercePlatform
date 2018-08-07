package com.unitever.module.weChat.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.InetAddress;
import java.net.URL;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import weixin.popular.api.MessageAPI;
import weixin.popular.api.SnsAPI;
import weixin.popular.bean.SnsToken;
import weixin.popular.bean.templatemessage.TemplateMessage;
import weixin.popular.bean.templatemessage.TemplateMessageItem;
import weixin.popular.bean.templatemessage.TemplateMessageResult;
import weixin.popular.support.TokenManager;

import com.unitever.module.customer.model.Customer;
import com.unitever.module.eticketoutRecord.model.EticketOutRecord;
import com.unitever.module.order.model.Order;
import com.unitever.module.orderGoods.model.OrderGoods;
import com.unitever.module.rechargeRecord.model.RechargeRecord;
import com.unitever.module.weChat.model.WeChat;
import com.unitever.module.weChat.service.WeChatService;
import com.unitever.platform.core.spring.SpringContextHolder;
import com.unitever.platform.core.web.context.ServletContextMonitor;
import com.unitever.platform.util.DateUtil;
import com.unitever.platform.util.JsonUtil;

@Component
public class WeChatUtil implements ServletContextMonitor {
	private static Logger logger_weChatUtil = LoggerFactory.getLogger("WeChatUtil");

	@Override
	public void init(ServletContext context) {
		// initMenu(null);
	}

	/**
	 * 发起https请求并获取结果
	 * 
	 * @param requestUrl
	 *            请求地址
	 * @param requestMethod
	 *            请求方式（GET、POST）
	 * @param outputStr
	 *            提交的数据
	 * @return JSONObject(通过JSONObject.get(key)的方式获取json对象的属性值)
	 */
	public static String httpRequest(String requestUrl, String requestMethod, String outputStr) {
		String jsonObject = null; // nmbaidai
		StringBuffer buffer = new StringBuffer();
		try {
			// 创建SSLContext对象，并使用我们指定的信任管理器初始化
			TrustManager[] tm = { new MyX509TrustManager() };
			SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
			sslContext.init(null, tm, new java.security.SecureRandom());
			// 从上述SSLContext对象中得到SSLSocketFactory对象
			SSLSocketFactory ssf = sslContext.getSocketFactory();
			URL url = new URL(requestUrl);
			HttpsURLConnection httpUrlConn = (HttpsURLConnection) url.openConnection();
			httpUrlConn.setSSLSocketFactory(ssf);
			httpUrlConn.setDoOutput(true);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			// 设置请求方式（GET/POST）
			httpUrlConn.setRequestMethod(requestMethod);
			if ("GET".equalsIgnoreCase(requestMethod))
				httpUrlConn.connect();
			// 当有数据需要提交时
			if (null != outputStr) {
				OutputStream outputStream = httpUrlConn.getOutputStream();
				// 注意编码格式，防止中文乱码
				outputStream.write(outputStr.getBytes("UTF-8"));
				outputStream.close();
			}
			// 将返回的输入流转换成字符串
			InputStream inputStream = httpUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				buffer.append(str);
			}
			bufferedReader.close();
			inputStreamReader.close();
			// 释放资源
			inputStream.close();
			inputStream = null;
			httpUrlConn.disconnect();
			jsonObject = buffer.toString();
		} catch (ConnectException ce) {
		} catch (Exception e) {
		}
		return jsonObject;
	}

	public static weixin.popular.bean.User getUserFromOauth2(String code, WeChat weChat) {
		SnsToken snsToken = SnsAPI.oauth2AccessToken(weChat.getAppid(), weChat.getAppsecret(), code);
		return SnsAPI.userinfo(snsToken.getAccess_token(), snsToken.getOpenid(), "zh_CN");
	}

	/**
	 * 获取accessToken
	 * 
	 * @param user
	 * @return
	 */
	public static String getAccessToken(WeChat user) {
		if (DateUtil.getDateSecond(DateUtil.getCurrDateSecondString()).getTime() > Long
				.parseLong(user.getExpirestime())) {
			WeChatService userService = SpringContextHolder.getBean(WeChatService.class);
			String getAccessTokenStr = httpRequest(
					RequestUrlUtil.getAccessTokenUrl(user.getAppid(), user.getAppsecret()), "GET", null);
			Map<String, String> map = JsonUtil.json2Map(getAccessTokenStr);
			String getJSApiTicketStr = httpRequest(RequestUrlUtil.getJSApiTicketUrl(map.get("access_token")), "GET",
					null);
			Map<String, String> map2 = JsonUtil.json2Map(getJSApiTicketStr);
			user.setJsapiticket(map2.get("ticket"));
			user.setAccesstoken(map.get("access_token"));
			user.setExpirestime(DateUtil.getDateSecond(DateUtil.getCurrDateSecondString()).getTime() + 7000000 + "");
			userService.update(user);
		}
		return user.getAccesstoken();
	}

	/**
	 * 获取JsApiToken
	 * 
	 * @param user
	 * @return
	 */
	public static String getJsApiTicket(WeChat user) {
		if (DateUtil.getDateSecond(DateUtil.getCurrDateSecondString()).getTime() > Long
				.parseLong(user.getExpirestime())) {
			WeChatService userService = SpringContextHolder.getBean(WeChatService.class);
			String getAccessTokenStr = httpRequest(
					RequestUrlUtil.getAccessTokenUrl(user.getAppid(), user.getAppsecret()), "GET", null);
			Map<String, String> map = JsonUtil.json2Map(getAccessTokenStr);
			String getJSApiTicketStr = httpRequest(RequestUrlUtil.getJSApiTicketUrl(map.get("access_token")), "GET",
					null);
			Map<String, String> map2 = JsonUtil.json2Map(getJSApiTicketStr);
			user.setJsapiticket(map2.get("ticket"));
			user.setAccesstoken(map.get("access_token"));
			user.setExpirestime(DateUtil.getDateSecond(DateUtil.getCurrDateSecondString()).getTime() + 7000000 + "");
			userService.update(user);
		}
		return user.getJsapiticket();
	}

	/**
	 * 获取ip地址
	 * 
	 * @param request
	 * @return
	 */
	public static String getIp(HttpServletRequest request) {
		if (request == null)
			return "";
		String ip = request.getHeader("X-Requested-For");
		if (StringUtils.isEmpty(ip) || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-Forwarded-For");
		}
		if (StringUtils.isEmpty(ip) || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (StringUtils.isEmpty(ip) || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (StringUtils.isEmpty(ip) || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (StringUtils.isEmpty(ip) || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (StringUtils.isEmpty(ip) || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	/**
	 *
	 * <P>
	 * 获取本件IP，无http请求时，获取Ip地址使用
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jan 4, 2017
	 * @return String
	 */
	public static String getIp() {
		String ip = "127.0.0.1";
		try {
			ip = InetAddress.getLocalHost().getHostAddress();
		} catch (UnknownHostException e) {
			e.printStackTrace();
			ip = "127.0.0.1";
		}
		return ip;
	}

	@Override
	public void destroyed(ServletContext context) {
	}

	/**
	 *
	 * <P>
	 * 会员注册成功通知
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月17日
	 * @param customer
	 * @param weChat
	 *            void
	 */
	public static void sendCustomerRegister(Customer customer, WeChat weChat) {
		LinkedHashMap<String, TemplateMessageItem> data = new LinkedHashMap<String, TemplateMessageItem>();
		TemplateMessageItem first = new TemplateMessageItem("恭喜您，注册成为天和商城会员！祝您购物愉快！", "#000000");

		TemplateMessageItem item1 = new TemplateMessageItem(customer.getEmployee().getName(), "#000000");
		TemplateMessageItem item2 = new TemplateMessageItem(DateUtil.getDateSecondString(customer.getCreateTime()),
				"#000000");
		TemplateMessageItem remark = new TemplateMessageItem("恭喜您注册为会员,您将享受到会员所有权利!", "#000000");
		data.put("first", first);
		data.put("keyword1", item1);
		data.put("keyword2", item2);
		data.put("remark", remark);

		TemplateMessage templateMessage = new TemplateMessage();
		templateMessage.setTemplate_id("MW9dfAbrRGG3KuteZvcJDVSZBZX8q5DKuuRFX9BgH90");
		templateMessage.setData(data);
		templateMessage.setTouser(customer.getEmployee().getOpenid());
		TemplateMessageResult result = MessageAPI.messageTemplateSend(TokenManager.getToken(weChat.getAppid()),
				templateMessage);
		logger_weChatUtil.info(weChat.getAppid() + ">>>" + customer.getEmployee().getOpenid());
		logger_weChatUtil.info(TokenManager.getToken(weChat.getAppid()));
		logger_weChatUtil.info("会员注册成功通知" + result.getErrcode() + "---" + result.getErrmsg());
	}

	/**
	 *
	 * <P>
	 * 发放电子劵通知
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月17日
	 * @param customer
	 * @param weChat
	 *            void
	 */
	public static void getNewEticket(EticketOutRecord eticketOutRecordById, WeChat weChat) {
		LinkedHashMap<String, TemplateMessageItem> data = new LinkedHashMap<String, TemplateMessageItem>();
		TemplateMessageItem first = new TemplateMessageItem("您好,您有一份礼品到帐", "#000000");

		TemplateMessageItem item1 = new TemplateMessageItem(eticketOutRecordById.getEticket().getName() + "电子劵",
				"#000000");
		TemplateMessageItem item2 = new TemplateMessageItem("满" + eticketOutRecordById.getEticket().getUseLimit()
				+ "可用", "#000000");
		TemplateMessageItem item3 = new TemplateMessageItem(DateUtil.getDateSecondString(eticketOutRecordById
				.getCreateDate()), "#000000");
		TemplateMessageItem remark = new TemplateMessageItem("请尽快使用哦!", "#000000");
		data.put("first", first);
		data.put("keyword1", item1);
		data.put("keyword2", item2);
		data.put("keyword3", item3);
		data.put("remark", remark);

		TemplateMessage templateMessage = new TemplateMessage();
		templateMessage.setTemplate_id("ovnVnNC1hANKQtUB8hWsbJEXPSZJ3RQZDQTzMlk06zE");
		templateMessage.setData(data);
		templateMessage.setTouser(eticketOutRecordById.getCustomer().getEmployee().getOpenid());
		TemplateMessageResult result = MessageAPI.messageTemplateSend(TokenManager.getToken(weChat.getAppid()),
				templateMessage);
		logger_weChatUtil
				.info(weChat.getAppid() + ">>>" + eticketOutRecordById.getCustomer().getEmployee().getOpenid());
		logger_weChatUtil.info(TokenManager.getToken(weChat.getAppid()));
		logger_weChatUtil.info("发放电子劵通知" + result.getErrcode() + "---" + result.getErrmsg());
	}

	/**
	 *
	 * <P>
	 * 充值通知
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月17日
	 * @param customer
	 * @param weChat
	 *            void
	 */
	public static void sendCustomerWalletRecharge(Customer customer, RechargeRecord rechargeRecord, WeChat weChat) {
		LinkedHashMap<String, TemplateMessageItem> data = new LinkedHashMap<String, TemplateMessageItem>();
		TemplateMessageItem first = new TemplateMessageItem("尊敬的会员，您已成功充值，祝您购物愉快！", "#000000");

		TemplateMessageItem item1 = new TemplateMessageItem("充值单号", "#000000");
		TemplateMessageItem item2 = new TemplateMessageItem(rechargeRecord.getId(), "#000000");
		TemplateMessageItem item3 = new TemplateMessageItem(rechargeRecord.getMoney(), "#000000");
		TemplateMessageItem item4 = new TemplateMessageItem("充值成功", "#000000");
		TemplateMessageItem remark = new TemplateMessageItem("如有疑问,请联系我们!", "#000000");
		data.put("first", first);
		data.put("accountType", item1);
		data.put("account", item2);
		data.put("amount", item3);
		data.put("result", item4);
		data.put("remark", remark);

		TemplateMessage templateMessage = new TemplateMessage();
		templateMessage.setTemplate_id("SK2ESer2nakP_4ZOvoXs53j14ZQcbXQIec0ABO4DIbk");
		templateMessage.setData(data);
		templateMessage.setTouser(customer.getEmployee().getOpenid());
		TemplateMessageResult result = MessageAPI.messageTemplateSend(TokenManager.getToken(weChat.getAppid()),
				templateMessage);
		logger_weChatUtil.info(weChat.getAppid() + ">>>" + customer.getEmployee().getOpenid());
		logger_weChatUtil.info(TokenManager.getToken(weChat.getAppid()));
		logger_weChatUtil.info("充值通知" + result.getErrcode() + "---" + result.getErrmsg());
	}

	/**
	 *
	 * <P>
	 * 返现通知
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月17日
	 * @param customer
	 * @param weChat
	 *            void
	 */
	public static void sendCustomerBackCash(Customer customer, String backCash, Date createTime, WeChat weChat) {
		LinkedHashMap<String, TemplateMessageItem> data = new LinkedHashMap<String, TemplateMessageItem>();
		TemplateMessageItem first = new TemplateMessageItem("尊敬的会员，您返现的金额已存入钱包，请查看！", "#000000");

		TemplateMessageItem item1 = new TemplateMessageItem(backCash, "#000000");
		TemplateMessageItem item2 = new TemplateMessageItem(DateUtil.getDateSecondString(createTime), "#000000");
		TemplateMessageItem remark = new TemplateMessageItem("谢谢您的参与!", "#000000");
		data.put("first", first);
		data.put("keyword1", item1);
		data.put("keyword2", item2);
		data.put("remark", remark);

		TemplateMessage templateMessage = new TemplateMessage();
		templateMessage.setTemplate_id("LEprNS3lxEQRdklD9S5bBfr2459DRvX1bD2Shfkud-w");
		templateMessage.setData(data);
		templateMessage.setTouser(customer.getEmployee().getOpenid());
		TemplateMessageResult result = MessageAPI.messageTemplateSend(TokenManager.getToken(weChat.getAppid()),
				templateMessage);
		logger_weChatUtil.info(weChat.getAppid() + ">>>" + customer.getEmployee().getOpenid());
		logger_weChatUtil.info(TokenManager.getToken(weChat.getAppid()));
		logger_weChatUtil.info("返现通知" + result.getErrcode() + "---" + result.getErrmsg());
	}

	/**
	 *
	 * <P>
	 * 发送天和钱包支付动态密码模板消息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月17日
	 * @param customer
	 * @param weChat
	 *            void
	 */
	public static void sendCustomerPayCode(Customer customer, WeChat weChat) {
		LinkedHashMap<String, TemplateMessageItem> data = new LinkedHashMap<String, TemplateMessageItem>();
		TemplateMessageItem first = new TemplateMessageItem("尊敬的会员，您正在天和商城进行消费/充值操作，仅限本人在收银台当面消费/充值时使用", "#000000");

		TemplateMessageItem item1 = new TemplateMessageItem(customer.getPayCode(), "#000000");
		TemplateMessageItem item2 = new TemplateMessageItem(DateUtil.getDateSecondString(customer
				.getPayCodeCreateTime()), "#000000");
		TemplateMessageItem remark = new TemplateMessageItem("支付动态密码10分钟内有效，请尽快使用！", "#000000");
		data.put("first", first);
		data.put("keyword1", item1);
		data.put("keyword2", item2);
		data.put("remark", remark);

		TemplateMessage templateMessage = new TemplateMessage();
		templateMessage.setTemplate_id("SLHmkDo32wNyA47FLebYl4ayE4WVEEko1IOpO5RBtiA");
		templateMessage.setData(data);
		templateMessage.setTouser(customer.getEmployee().getOpenid());
		TemplateMessageResult result = MessageAPI.messageTemplateSend(TokenManager.getToken(weChat.getAppid()),
				templateMessage);
		logger_weChatUtil.info(weChat.getAppid() + ">>>" + customer.getEmployee().getOpenid());
		logger_weChatUtil.info(TokenManager.getToken(weChat.getAppid()));
		logger_weChatUtil.info("支付动态密码模板消息" + result.getErrcode() + "---" + result.getErrmsg());
	}

	/**
	 *
	 * <P>
	 * 订单支付成功的通知(线上)
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月17日
	 * @param customer
	 * @param orderList
	 * @param weChat
	 *            void
	 */
	public static void sendCustomerOrderSuccess(Customer customer, List<Order> orderList, WeChat weChat) {
		LinkedHashMap<String, TemplateMessageItem> data = new LinkedHashMap<String, TemplateMessageItem>();
		TemplateMessageItem first = new TemplateMessageItem("您好,您的订单已支付成功!", "#000000");
		List<String> goodsNameList = new ArrayList<String>();
		List<String> OrderIdList = new ArrayList<String>();
		String batchCode = "";
		String inlInePayMoney = "";
		for (Order order : orderList) {
			OrderIdList.add(order.getCode());
			for (Order childOrder : order.getOrderList()) {
				for (OrderGoods orderGoods : childOrder.getOrderGoodList()) {
					if (StringUtils.isNotBlank(orderGoods.getGoods().getName())) {
						goodsNameList.add(orderGoods.getGoods().getName());
					} else {
						goodsNameList.add(orderGoods.getGoods().getGoods().getName());
					}
				}
			}
			batchCode = order.getBatchCode();
			inlInePayMoney = order.getInLinePayMoney();
		}

		TemplateMessageItem item1 = new TemplateMessageItem(goodsNameList.get(0) + ".....", "#000000");
		TemplateMessageItem item2 = new TemplateMessageItem(OrderIdList.get(0) + ".....", "#000000");
		TemplateMessageItem item3 = new TemplateMessageItem(inlInePayMoney, "#000000");
		TemplateMessageItem remark = new TemplateMessageItem("订单详情请登录查看,感谢您的光临!", "#000000");
		data.put("first", first);
		data.put("keyword1", item1);
		data.put("keyword2", item2);
		data.put("keyword3", item3);
		data.put("remark", remark);

		TemplateMessage templateMessage = new TemplateMessage();
		templateMessage.setTemplate_id("lWTGuUM2Rttz2g0zE1egcfC4BghoB6w8BO95wAV1-7I");
		templateMessage.setData(data);
		templateMessage.setTouser(customer.getEmployee().getOpenid());
		TemplateMessageResult result = MessageAPI.messageTemplateSend(TokenManager.getToken(weChat.getAppid()),
				templateMessage);
		logger_weChatUtil.info(weChat.getAppid() + ">>>" + customer.getEmployee().getOpenid());
		logger_weChatUtil.info(TokenManager.getToken(weChat.getAppid()));
		logger_weChatUtil.info("订单支付成功的通知(线上)" + result.getErrcode() + "---" + result.getErrmsg());
	}

	/**
	 *
	 * <P>
	 * 订单确认发货通知(线上)
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月17日
	 * @param customer
	 * @param orderList
	 * @param weChat
	 *            void
	 */
	public static void sendCustomerGoodsOrder(Customer customer, List<Order> orderList, WeChat weChat) {
		LinkedHashMap<String, TemplateMessageItem> data = new LinkedHashMap<String, TemplateMessageItem>();
		TemplateMessageItem first = new TemplateMessageItem("您购买的货品已发出，请注意查收！", "#000000");
		List<String> goodsNameList = new ArrayList<String>();
		String Logistics = "";
		String LogisticsCode = "";
		String goodsNumber = "0";
		for (Order order : orderList) {
			for (Order childOrder : order.getOrderList()) {
				for (OrderGoods orderGoods : childOrder.getOrderGoodList()) {
					if (StringUtils.isNotBlank(orderGoods.getGoods().getName())) {
						goodsNameList.add(orderGoods.getGoods().getName());
					} else {
						goodsNameList.add(orderGoods.getGoods().getGoods().getName());
					}
				}
			}
			Logistics = order.getLogistics();
			LogisticsCode = order.getLogisticsCode();
			goodsNumber = String.valueOf(Integer.parseInt(goodsNumber) + Integer.parseInt(order.getSumNumber()));
		}

		TemplateMessageItem item1 = new TemplateMessageItem(Logistics, "#000000");
		TemplateMessageItem item2 = new TemplateMessageItem(LogisticsCode, "#000000");
		TemplateMessageItem item3 = new TemplateMessageItem(goodsNameList.get(0) + "......", "#000000");
		TemplateMessageItem item4 = new TemplateMessageItem(goodsNumber, "#000000");
		TemplateMessageItem remark = new TemplateMessageItem("订单详情请前往商城查看,货品请注意查收!", "#000000");
		data.put("first", first);
		data.put("keyword1", item1);
		data.put("keyword2", item2);
		data.put("keyword3", item3);
		data.put("keyword4", item4);
		data.put("remark", remark);

		TemplateMessage templateMessage = new TemplateMessage();
		templateMessage.setTemplate_id("jWE84qoEkcv2w_krceg8ftWpIwEz_O0qGDRSJXOdBwk");
		templateMessage.setData(data);
		templateMessage.setTouser(customer.getEmployee().getOpenid());
		TemplateMessageResult result = MessageAPI.messageTemplateSend(TokenManager.getToken(weChat.getAppid()),
				templateMessage);
		logger_weChatUtil.info(weChat.getAppid() + ">>>" + customer.getEmployee().getOpenid());
		logger_weChatUtil.info(TokenManager.getToken(weChat.getAppid()));
		logger_weChatUtil.info("线上订单确认发货(线上)" + result.getErrcode() + "---" + result.getErrmsg());
	}

	/**
	 *
	 * <P>
	 * 预定到货通知
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月17日
	 * @param customer
	 * @param orderList
	 * @param weChat
	 *            void
	 */
	public static void sendCustomerReserveOrder(Customer customer, Order order, WeChat weChat) {
		LinkedHashMap<String, TemplateMessageItem> data = new LinkedHashMap<String, TemplateMessageItem>();
		TemplateMessageItem first = new TemplateMessageItem("您好，您在天和商城预约的商品已到货，请尽快到店取货", "#000000");

		TemplateMessageItem item1 = new TemplateMessageItem(order.getPayMoney(), "#000000");
		TemplateMessageItem item2 = new TemplateMessageItem(order.getSumNumber(), "#000000");
		TemplateMessageItem item3 = new TemplateMessageItem(DateUtil.getDateString(order.getCreateTime()), "#000000");
		TemplateMessageItem item4 = new TemplateMessageItem(order.getCode(), "#000000");
		TemplateMessageItem item5 = new TemplateMessageItem(order.getStore().getName(), "#000000");
		TemplateMessageItem remark = new TemplateMessageItem("如有疑问请联系我们!", "#000000");
		data.put("first", first);
		data.put("keyword1", item1);
		data.put("keyword2", item2);
		data.put("keyword3", item3);
		data.put("keyword4", item4);
		data.put("keyword5", item5);
		data.put("remark", remark);

		TemplateMessage templateMessage = new TemplateMessage();
		templateMessage.setTemplate_id("Mp8a6EL4E_4Oxqrv2ujWN2IqbMBxRG7aM9dJa3taywU");
		templateMessage.setData(data);
		templateMessage.setTouser(customer.getEmployee().getOpenid());
		TemplateMessageResult result = MessageAPI.messageTemplateSend(TokenManager.getToken(weChat.getAppid()),
				templateMessage);
		logger_weChatUtil.info(weChat.getAppid() + ">>>" + customer.getEmployee().getOpenid());
		logger_weChatUtil.info(TokenManager.getToken(weChat.getAppid()));
		logger_weChatUtil.info("预定到货通知" + result.getErrcode() + "---" + result.getErrmsg());
	}

	/**
	 *
	 * <P>
	 * 退款申请通知
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月17日
	 * @param customer
	 * @param weChat
	 * @param OrderCode
	 *            订单编号
	 * @param StoreName
	 *            门店名称
	 * @param payMoney
	 *            交易金额
	 * @param backMoney
	 *            退款金额
	 * @param createTime
	 *            申请时间
	 * @param payType
	 *            退款方式 void
	 */
	public static void sendCustomerFiveOrder(Customer customer, WeChat weChat, String OrderCode, String StoreName,
			String payMoney, String backMoney, Date createTime, String payType) {
		LinkedHashMap<String, TemplateMessageItem> data = new LinkedHashMap<String, TemplateMessageItem>();
		TemplateMessageItem first = new TemplateMessageItem("您好，您在天和商城的订单发起退款成功，3-5个工作日到帐，请注意查收", "#000000");

		TemplateMessageItem item1 = new TemplateMessageItem(OrderCode, "#000000");
		TemplateMessageItem item2 = new TemplateMessageItem(StoreName, "#000000");
		TemplateMessageItem item3 = new TemplateMessageItem(payMoney, "#000000");
		TemplateMessageItem item4 = new TemplateMessageItem(backMoney, "#000000");
		TemplateMessageItem item5 = new TemplateMessageItem(DateUtil.getDateString(createTime), "#000000");
		TemplateMessageItem remark = new TemplateMessageItem("支付方式:" + payType + "\r\n" + "退款成功!", "#000000");
		data.put("first", first);
		data.put("keyword1", item1);
		data.put("keyword2", item2);
		data.put("keyword3", item3);
		data.put("keyword4", item4);
		data.put("keyword5", item5);
		data.put("remark", remark);

		TemplateMessage templateMessage = new TemplateMessage();
		templateMessage.setTemplate_id("HLjGpPJrtUmZHG6OAunmNRkcNhFzLCSmCOBRmkfcVPs");
		templateMessage.setData(data);
		templateMessage.setTouser(customer.getEmployee().getOpenid());
		TemplateMessageResult result = MessageAPI.messageTemplateSend(TokenManager.getToken(weChat.getAppid()),
				templateMessage);
		logger_weChatUtil.info(weChat.getAppid() + ">>>" + customer.getEmployee().getOpenid());
		logger_weChatUtil.info(TokenManager.getToken(weChat.getAppid()));
		logger_weChatUtil.info("退款申请通知" + result.getErrcode() + "---" + result.getErrmsg());
	}

	/**
	 *
	 * <P>
	 * 会员冻结通知
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月17日
	 * @param customer
	 * @param weChat
	 *            void
	 */
	public static void sendCustomerIsBlank(Customer customer, WeChat weChat) {
		LinkedHashMap<String, TemplateMessageItem> data = new LinkedHashMap<String, TemplateMessageItem>();
		TemplateMessageItem first = new TemplateMessageItem("您好，您的会员帐号已被冻结，如有疑问请联系客服", "#000000");

		TemplateMessageItem item1 = new TemplateMessageItem(customer.getName(), "#000000");
		TemplateMessageItem item2 = new TemplateMessageItem(DateUtil.getDateSecondString(new Date()), "#000000");
		TemplateMessageItem remark = new TemplateMessageItem("如有疑问请联系我们!", "#000000");
		data.put("first", first);
		data.put("keyword1", item1);
		data.put("keyword2", item2);
		data.put("remark", remark);

		TemplateMessage templateMessage = new TemplateMessage();
		templateMessage.setTemplate_id("EJX9g6RGp1MinPcG-87CM9OFqExzkZxNbqyRfHzQ6BQ");
		templateMessage.setData(data);
		templateMessage.setTouser(customer.getEmployee().getOpenid());
		TemplateMessageResult result = MessageAPI.messageTemplateSend(TokenManager.getToken(weChat.getAppid()),
				templateMessage);
		logger_weChatUtil.info(weChat.getAppid() + ">>>" + customer.getEmployee().getOpenid());
		logger_weChatUtil.info(TokenManager.getToken(weChat.getAppid()));
		logger_weChatUtil.info("会员冻结通知" + result.getErrcode() + "---" + result.getErrmsg());
	}

	/**
	 *
	 * <P>
	 * 电子券到期提醒模板消息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 7, 2017
	 * @param eticketOutRecord
	 * @param weChat
	 *            void
	 */
	public static void recycleEticket(EticketOutRecord eticketOutRecord, WeChat weChat) {
		// TODO Auto-generated method stub
		System.err.println("发送电子券到期提醒模板消息--未实现");
	}

}