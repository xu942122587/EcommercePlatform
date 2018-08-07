package com.unitever.module.weChat.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;
import net.sf.json.util.PropertyFilter;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import weixin.popular.support.TicketManager;

import com.unitever.auth.user.model.User;
import com.unitever.auth.user.service.UserService;
import com.unitever.module.address.model.Address;
import com.unitever.module.address.service.AddressService;
import com.unitever.module.backCash.service.BackCashService;
import com.unitever.module.banner.service.BannerService;
import com.unitever.module.classification.service.ClassificationService;
import com.unitever.module.classification.vo.ClassificationVO;
import com.unitever.module.consume.service.ConsumeService;
import com.unitever.module.customer.model.Customer;
import com.unitever.module.customer.service.CustomerService;
import com.unitever.module.employee.model.Employee;
import com.unitever.module.employee.service.EmployeeService;
import com.unitever.module.eticketoutRecord.model.EticketOutRecord;
import com.unitever.module.eticketoutRecord.service.EticketOutRecordService;
import com.unitever.module.evaluation.model.Evaluation;
import com.unitever.module.evaluation.service.EvaluationService;
import com.unitever.module.goods.controller.GoodsController;
import com.unitever.module.goods.model.Goods;
import com.unitever.module.goods.service.GoodsService;
import com.unitever.module.order.model.Order;
import com.unitever.module.order.model.OrderVo;
import com.unitever.module.order.service.OrderService;
import com.unitever.module.orderGoods.model.OrderGoods;
import com.unitever.module.orderSubremark.model.OrderSubremark;
import com.unitever.module.postageBonus.service.PostageBonusService;
import com.unitever.module.promotion.model.Promotion;
import com.unitever.module.rechargeRecord.model.RechargeRecord;
import com.unitever.module.rechargeRecord.service.RechargeRecordService;
import com.unitever.module.shoppingcart.model.Shoppingcart;
import com.unitever.module.shoppingcart.service.ShoppingcartService;
import com.unitever.module.store.model.Store;
import com.unitever.module.store.service.StoreService;
import com.unitever.module.weChat.model.WeChat;
import com.unitever.module.weChat.service.WeChatService;
import com.unitever.module.weChat.util.CookieUtil;
import com.unitever.module.weChat.util.MessageUtil;
import com.unitever.module.weChat.util.SignUtil;
import com.unitever.module.weChat.util.WeChatUtil;
import com.unitever.module.weChat.vo.GoodsPageVo;
import com.unitever.platform.component.attachment.util.AttachmentUtil;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.BatchCodeID;
import com.unitever.platform.util.DoubleUtil;
import com.unitever.platform.util.ExceptionUtil;
import com.unitever.platform.util.FileUtil;
import com.unitever.platform.util.OrderCodeID;
import com.unitever.platform.util.RequestParamUtil;
import com.unitever.platform.util.ThreadPoolUtil;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.weChat.controller->WeChatController.java
 * </p>
 * <P>
 * 微信端controller
 * </p>
 *
 * @author 闫枫
 * @date Jun 27, 2017
 */
@Controller
@RequestMapping(value = "/weChat")
public class WeChatController extends SpringController {

	@Autowired
	private WeChatService weChatService;
	@Autowired
	private PostageBonusService postageBonusService;
	@Autowired
	private EvaluationService evaluationService;
	@Autowired
	private EmployeeService employeeService;
	@Autowired
	private EticketOutRecordService eticketOutRecordService;
	@Autowired
	private ConsumeService consumeService;
	@Autowired
	private AddressService addressService;
	@Autowired
	private UserService userService;
	@Autowired
	private CustomerService customerService;
	@Autowired
	private RechargeRecordService rechargeRecordService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private BackCashService backCashService;
	@Autowired
	private BannerService bannerService;
	@Autowired
	private StoreService storeService;
	@Autowired
	private ClassificationService classificationService;
	@Autowired
	private ShoppingcartService shoppingcartService;
	@Autowired
	private OrderService orderService;

	private Logger logger_weChatController = LoggerFactory.getLogger("WeChatController");

	/**
	 * 处理微信响应请求
	 * 
	 * @param signature
	 * @param timestamp
	 * @param nonce
	 * @param echostr
	 * @return
	 */
	@RequestMapping(value = "/weChatHandler")
	@ResponseBody
	public String weChatHandler(@RequestParam(value = "signature", required = false) String signature,
			@RequestParam(value = "timestamp", required = false) String timestamp,
			@RequestParam(value = "nonce", required = false) String nonce,
			@RequestParam(value = "echostr", required = false) String echostr) {
		try {
			if ("GET".equals(getRequest().getMethod())) {
				if (SignUtil.checkSignature(signature, timestamp, nonce)) {
					return echostr;
				}
			} else if ("POST".equals(getRequest().getMethod())) {
				if (SignUtil.checkSignature(signature, timestamp, nonce)) {
					return weChatService.weChatHandler(getRequest());
				}
			}
			return null;
		} catch (Exception e) {
			return "module/weChat/jsp/weChat_404";
		}

	}

	/**
	 * 付款成功 (接收微信 支付结果通用通知)
	 */
	@RequestMapping(value = "/mchNotifyPaySuccess", method = RequestMethod.POST)
	@ResponseBody
	public void mchNotifyPaySuccess() {
		try {
			Map<String, String> requestMap = MessageUtil.parseXml(getRequest());
			String orderId = requestMap.get("orderId");
			String transaction_id = requestMap.get("transaction_id");
			List<Order> orderList = orderService.getOrderByIdString(orderId);
			Customer customer = new Customer();
			for (Order order : orderList) {
				if (Order.STATE_ONE.equals(order.getState())) {
					orderService.inlineOrderPaySuccess(order.getId(), null, null, Order.PAYTYPE_THREE, null, null,
							transaction_id, true);
				}
				customer = order.getCustomer();
			}
			final Customer customer1 = customer;
			final List<Order> orderList1 = orderList;
			ThreadPoolUtil.getPool().execute(new Runnable() {
				@Override
				public void run() {
					try {
						WeChatUtil
								.sendCustomerOrderSuccess(customer1, orderList1, weChatService.getWeChatList().get(0));
					} catch (Exception e) {
						logger_weChatController.error("订单支付成功的通知(线上)出错，具体错误如下："
								+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
					}
				}
			});
			this.print("<xml><return_code><![CDATA[SUCCESS" + "]]></return_code><return_msg><![CDATA["
					+ "]]></return_msg></xml>");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 付款成功 (接收微信 支付结果通用通知)
	 */
	@RequestMapping(value = "/recharPaySuccess", method = RequestMethod.POST)
	@ResponseBody
	public void recharPaySuccess() {
		try {
			Map<String, String> requestMap = MessageUtil.parseXml(getRequest());
			String id = requestMap.get("id");
			String transaction_id = requestMap.get("transaction_id");
			RechargeRecord rechargeRecord = rechargeRecordService.getRechargeRecordById(id);
			if (RechargeRecord.STATE_TWO.equals(rechargeRecord.getState())) {
				rechargeRecordService.rechargePaySuccess(rechargeRecord.getId(), null, null,
						RechargeRecord.PAYTYPE_THREE, transaction_id);
			}
			this.print("<xml><return_code><![CDATA[SUCCESS" + "]]></return_code><return_msg><![CDATA["
					+ "]]></return_msg></xml>");
		} catch (Error e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 *
	 * <P>
	 * 通过微信验证,前往首页
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月1日
	 * @param code
	 * @param state
	 * @param page
	 * @param employeeId
	 * @return String
	 */
	@RequestMapping(value = "/weChatIndex", method = RequestMethod.GET)
	public String weChatIndex(@RequestParam(value = "code", required = false) String code,
			@RequestParam(value = "state", required = false) String state,
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "employeeId", required = false) String employeeId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "code,page,state,employeeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			// 授权链或者依据employeeId获取用户信息-↓-↓-↓-↓-↓----Start----=↓=↓=↓=↓=↓=↓=↓=↓=↓=↓=↓=↓=↓=↓=↓=↓
			// CookieUtil.removeCookie(getResponse(), "openid"+state);
			WeChat weChat = weChatService.getWeChatWithWeChatNum(state);
			Employee employee = new Employee();
			if (StringUtils.isNotBlank(code) && StringUtils.isNotBlank(state)) {
				if ("authdeny".equals(code)) {// 判断用户取消授权的情况
					CookieUtil.removeCookie(getResponse(), "openid" + state);
					return "module/weChat/jsp/weChat_404";
				}
				if (CookieUtil.getCookieByName(getRequest(), "openid" + state) == null) {
					employee = employeeService.getEmployeeWithCodeWeChat(code, weChat);
					if (employee == null) {
						CookieUtil.removeCookie(getResponse(), "openid" + state);
						return "module/weChat/jsp/weChat_404";
					} else if (StringUtils.isBlank(employee.getId())) {
						if (StringUtils.isBlank(employee.getOpenid())) {
							CookieUtil.removeCookie(getResponse(), "openid" + state);
							return "module/weChat/jsp/weChat_404";
						} else {
							employee = employeeService.getEmployeeWithOpenId(employee.getOpenid());
						}
					}
					CookieUtil.addCookie(getResponse(), "openid" + state, employee.getOpenid(), 60 * 60 * 5);
				} else {
					String openid = CookieUtil.getCookieByName(getRequest(), "openid" + state).getValue();
					if (StringUtils.isBlank(openid)) {
						// 避免cookie里的openid为空
						logger_weChatController.info("cookie里的openid为空~");
						CookieUtil.removeCookie(getResponse(), "openid" + state);
						return "module/weChat/jsp/weChat_404";
					}
					employee = employeeService.getEmployeeWithOpenId(openid);
				}
			} else if (StringUtils.isNotBlank(employeeId)) {
				employee = employeeService.getEmployeeById(employeeId);
			} else {
				logger_weChatController.info("code、state和employeeId  3个参数同时为空，请检查代码实现~");
				CookieUtil.removeCookie(getResponse(), "openid" + state);
				return "module/weChat/jsp/weChat_404";
			}
			// 授权链或者依据employeeId获取用户信息-↑-↑-↑-↑-↑----End----=↑=↑=↑=↑=↑=↑=↑=↑=↑=↑=↑=↑=↑=↑=↑=↑

			setAttribute("employeeId", employee.getId());
			setAttribute("banner", bannerService.getBannerFirst());
			setAttribute("isRecommedGoodsList", goodsService.getGoodsForIsRecommed());
			setAttribute("storeList", storeService.getAllStartStore());
			return "module/weChat/jsp/weChat_index";
		} catch (Exception e) {
			CookieUtil.removeCookie(getResponse(), "openid" + state);
			e.printStackTrace();
			logger_weChatController.error("通过微信验证,前往首页出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 前往注册页面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月27日
	 * @param employeeId
	 * @param flag
	 * @return String
	 */
	@RequestMapping(value = "/goRegister")
	public String goRegister(@RequestParam(value = "employeeId", required = true) String employeeId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "employeeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			setAttribute("employee", employeeService.getEmployeeById(employeeId));
			setAttribute("guideUserList", userService.getGuideUserList());
			return "module/weChat/jsp/weChat_register";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("前往注册页面出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 * 提交注册
	 * 
	 * @author XiaoYu
	 * @date 2017年2月25日
	 * @param customer
	 * @param smsCode
	 * @param employeeId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/doRegister", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doRegister(@FormModel(value = "model") Customer customer,
			@RequestParam(value = "smsCode", required = true) String smsCode,
			@RequestParam(value = "employeeId", required = true) String employeeId) {
		AjaxJson json = new AjaxJson();
		try {
			json = customerService.saveRegister(customer, smsCode, employeeId);
		} catch (Exception e) {
			e.printStackTrace();
			json.setSuccess(false);
			json.setMsg("注册失败~请稍后重试");
			logger_weChatController.error("注册出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return json;
	}

	/**
	 *
	 * <P>
	 * 登陆
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月31日
	 * @param customer
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/doLogin", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doLogin(@FormModel(value = "model") Customer customer) {
		AjaxJson json = new AjaxJson();

		try {
			if (null != customer) {
				json = customerService.loginVerification(customer);
			} else {
				json.setMsg("参数错误");
				json.setSuccess(false);
				return json;
			}
		} catch (Exception e) {
			e.printStackTrace();
			json.setSuccess(false);
			json.setMsg("登陆失败~请稍后重试");
			logger_weChatController.error(" 登陆出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return json;
	}

	/**
	 *
	 * <P>
	 * 跳转到PC用户绑定微信账号页面
	 * </p>
	 *
	 * @author 闫枫
	 * @date Dec 23, 2016
	 * @param code
	 * @param state
	 * @param employeeId
	 * @return String
	 */
	@RequestMapping(value = "/weChatUserLogin", method = RequestMethod.GET)
	public String weChatUserLogin(@RequestParam(value = "code", required = false) String code,
			@RequestParam(value = "state", required = false) String state,
			@RequestParam(value = "employeeId", required = false) String employeeId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "code,state,employeeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			// 授权链或者依据employeeId获取用户信息-↓-↓-↓-↓-↓----Start----=↓=↓=↓=↓=↓=↓=↓=↓=↓=↓=↓=↓=↓=↓=↓=↓
			// CookieUtil.removeCookie(getResponse(), "openid"+state);
			WeChat weChat = weChatService.getWeChatWithWeChatNum(state);
			Employee employee = new Employee();
			if (StringUtils.isNotBlank(code) && StringUtils.isNotBlank(state)) {
				if ("authdeny".equals(code)) {// 判断用户取消授权的情况
					CookieUtil.removeCookie(getResponse(), "openid" + state);
					return "module/weChat/jsp/weChat_404";
				}
				if (CookieUtil.getCookieByName(getRequest(), "openid" + state) == null) {
					employee = employeeService.getEmployeeWithCodeWeChat(code, weChat);
					if (employee == null) {
						CookieUtil.removeCookie(getResponse(), "openid" + state);
						return "module/weChat/jsp/weChat_404";
					} else if (StringUtils.isBlank(employee.getId())) {
						if (StringUtils.isBlank(employee.getOpenid())) {
							CookieUtil.removeCookie(getResponse(), "openid" + state);
							return "module/weChat/jsp/weChat_404";
						} else {
							employee = employeeService.getEmployeeWithOpenId(employee.getOpenid());
						}
					}
					CookieUtil.addCookie(getResponse(), "openid" + state, employee.getOpenid(), 60 * 60 * 5);
				} else {
					String openid = CookieUtil.getCookieByName(getRequest(), "openid" + state).getValue();
					if (StringUtils.isBlank(openid)) {
						// 避免cookie里的openid为空
						logger_weChatController.info("cookie里的openid为空~");
						CookieUtil.removeCookie(getResponse(), "openid" + state);
						return "module/weChat/jsp/weChat_404";
					}
					employee = employeeService.getEmployeeWithOpenId(openid);
				}
			} else if (StringUtils.isNotBlank(employeeId)) {
				employee = employeeService.getEmployeeById(employeeId);
			} else {
				logger_weChatController.info("code、state和employeeId  3个参数同时为空，请检查代码实现~");
				CookieUtil.removeCookie(getResponse(), "openid" + state);
				return "module/weChat/jsp/weChat_404";
			}
			// 授权链或者依据employeeId获取用户信息-↑-↑-↑-↑-↑----End----=↑=↑=↑=↑=↑=↑=↑=↑=↑=↑=↑=↑=↑=↑=↑=↑

			setAttribute("employee", employee);
			return "module/weChat/jsp/weChat_user_login";
		} catch (Exception e) {
			CookieUtil.removeCookie(getResponse(), "openid" + state);
			logger_weChatController.error("跳转到PC用户绑定微信账号页面出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 用户绑定微信号
	 * </p>
	 *
	 * @author 闫枫
	 * @date Dec 24, 2016
	 * @param username
	 *            PC端用户名
	 * @param password
	 *            PC端密码
	 * @param employeeId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/doUserLogin", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doUserLogin(@RequestParam(value = "username") String username,
			@RequestParam(value = "password") String password, @RequestParam(value = "employeeId") String employeeId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isBlank(username) || StringUtils.isBlank(password)) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("用户名或密码不能为空！");
				return ajaxJson;
			}
			User user = userService.getUserWithLoginName(username);
			if (null == user) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("用户名或密码错误~");
				return ajaxJson;
			}
			String passwordMD5 = new Md5PasswordEncoder().encodePassword(password, null);
			if (passwordMD5.equals(user.getPassword())) {
				Employee employee = employeeService.getEmployeeById(employeeId);
				user.setOpenId(employee.getOpenid());
				user.setPassword(null);// 设置密码为空，防止二次加密引起的密码错误问题
				userService.update(user);
				ajaxJson.setSuccess(true);
				ajaxJson.setMsg("绑定成功~");
				return ajaxJson;
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("用户名或密码错误~");
				return ajaxJson;
			}
		} catch (Exception e) {
			e.printStackTrace();
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("用户绑定微信号失败~请稍后重试");
			logger_weChatController.error("用户绑定微信号出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 * 跳转后台用户绑定成功页面
	 * 
	 * @author 闫枫
	 * @date Oct 13, 2016
	 * @param state
	 * @param employeeId
	 * @return
	 */
	@RequestMapping(value = "/goUserLoginSuccess", method = RequestMethod.GET)
	public String goUserLoginSuccess() {
		this.setJsSdkMsg();
		return "module/weChat/jsp/weChat_user_login_success";
	}

	/**
	 *
	 * <P>
	 * 前往个人中心
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月31日
	 * @param code
	 * @param state
	 * @param employeeId
	 * @return String
	 */
	@RequestMapping(value = "/goPersonalCenter")
	public String goPersonalCenter(@RequestParam(value = "code", required = false) String code,
			@RequestParam(value = "state", required = false) String state,
			@RequestParam(value = "employeeId", required = false) String employeeId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "code,state,employeeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			// 授权链或者依据employeeId获取用户信息-↓-↓-↓-↓-↓----Start----=↓=↓=↓=↓=↓=↓=↓=↓=↓=↓=↓=↓=↓=↓=↓=↓
			// CookieUtil.removeCookie(getResponse(), "openid"+state);
			WeChat weChat = weChatService.getWeChatWithWeChatNum(state);
			Employee employee = new Employee();
			if (StringUtils.isNotBlank(code) && StringUtils.isNotBlank(state)) {
				if ("authdeny".equals(code)) {// 判断用户取消授权的情况
					CookieUtil.removeCookie(getResponse(), "openid" + state);
					return "module/weChat/jsp/weChat_404";
				}
				if (CookieUtil.getCookieByName(getRequest(), "openid" + state) == null) {
					employee = employeeService.getEmployeeWithCodeWeChat(code, weChat);
					if (employee == null) {
						CookieUtil.removeCookie(getResponse(), "openid" + state);
						return "module/weChat/jsp/weChat_404";
					} else if (StringUtils.isBlank(employee.getId())) {
						if (StringUtils.isBlank(employee.getOpenid())) {
							CookieUtil.removeCookie(getResponse(), "openid" + state);
							return "module/weChat/jsp/weChat_404";
						} else {
							employee = employeeService.getEmployeeWithOpenId(employee.getOpenid());
						}
					}
					CookieUtil.addCookie(getResponse(), "openid" + state, employee.getOpenid(), 60 * 60 * 5);
				} else {
					String openid = CookieUtil.getCookieByName(getRequest(), "openid" + state).getValue();
					if (StringUtils.isBlank(openid)) {
						// 避免cookie里的openid为空
						logger_weChatController.info("cookie里的openid为空~");
						CookieUtil.removeCookie(getResponse(), "openid" + state);
						return "module/weChat/jsp/weChat_404";
					}
					employee = employeeService.getEmployeeWithOpenId(openid);
				}
			} else if (StringUtils.isNotBlank(employeeId)) {
				employee = employeeService.getEmployeeById(employeeId);
			} else {
				logger_weChatController.info("code、state和employeeId  3个参数同时为空，请检查代码实现~");
				CookieUtil.removeCookie(getResponse(), "openid" + state);
				return "module/weChat/jsp/weChat_404";
			}
			// 授权链或者依据employeeId获取用户信息-↑-↑-↑-↑-↑----End----=↑=↑=↑=↑=↑=↑=↑=↑=↑=↑=↑=↑=↑=↑=↑=↑

			Customer customer = customerService.getCustomerByEmployeeId(employeeId);

			setAttribute("employeeId", employee.getId());

			if (null == customer || StringUtils.isBlank(customer.getId())) {
				return "module/weChat/jsp/weChat_login";
			} else {
				setAttribute("customer", customerService.getCustomerByEmployeeId(employeeId));
			}
			return "module/weChat/jsp/weChat_personalcenter";
		} catch (Exception e) {
			CookieUtil.removeCookie(getResponse(), "openid" + state);
			e.printStackTrace();
			logger_weChatController.error("前往个人中心出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 个人中心帮助
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月4日
	 * @param employeeId
	 * @return String
	 */
	@RequestMapping(value = "/goHelpCenter")
	public String goHelpCenter(@RequestParam(value = "employeeId", required = true) String employeeId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "employeeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			setAttribute("employee", employeeService.getEmployeeById(employeeId));
			return "module/weChat/jsp/weChat_personal_Helpcenter";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("个人中心帮助出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 个人中心设置
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月4日
	 * @param employeeId
	 * @return String
	 */
	@RequestMapping(value = "/goSetting")
	public String goSetting(@RequestParam(value = "employeeId", required = true) String employeeId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "employeeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			setAttribute("employee", employeeService.getEmployeeById(employeeId));
			return "module/weChat/jsp/weChat_personal_setting";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("个人中心设置出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 个人信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月31日
	 * @param customerId
	 * @return String
	 */
	@RequestMapping(value = "/goPersonalInfo")
	public String goPersonalInfo(@RequestParam(value = "customerId", required = true) String customerId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "customerId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			Customer customer = customerService.getCustomerById(customerId);
			Employee employee = customer.getEmployee();
			setAttribute("employee", employee);
			setAttribute("customer", customer);
			return "module/weChat/jsp/weChat_personalinformation";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("个人中心设置出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 前往修改密码
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月31日
	 * @param customerId
	 * @return String
	 */
	@RequestMapping(value = "/goModPassword")
	public String goModPassword(@RequestParam(value = "employeeId", required = true) String employeeId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "employeeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			Customer customer = customerService.getCustomerById(customerService.getCustomerByEmployeeId(employeeId)
					.getId());
			setAttribute("employee", customer.getEmployee());
			setAttribute("customer", customer);
			return "module/weChat/jsp/weChat_revisepassword";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("前往修改密码出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 进行修改密码
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月31日
	 * @param customerId
	 * @param oldPassword
	 * @param newPassword
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/doModPassword", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doModPassword(@RequestParam(value = "customerId", required = true) String customerId,
			@RequestParam(value = "oldPassword") String oldPassword,
			@RequestParam(value = "newPassword") String newPassword) {
		AjaxJson json = new AjaxJson();
		json.setSuccess(false);
		try {
			Customer customer = customerService.getCustomerById(customerId);

			if (null != customer && StringUtils.isNotBlank(customer.getId())) {
				if (!customer.getLoginPassword().equals(oldPassword)) {
					json.setMsg("原密码错误！");
				} else if (customer.getLoginPassword().equals(newPassword)) {
					json.setMsg("原密码与新密码不可相同！");
				} else {
					customer.setLoginPassword(newPassword);
					customerService.update(customer);
					json.setSuccess(true);
					json.setMsg("密码修改成功！");
				}
			} else {
				json.setMsg("操作错误");
			}
		} catch (Exception e) {
			e.printStackTrace();
			json.setSuccess(false);
			json.setMsg("退出登陆失败~请稍后重试");
			logger_weChatController.error("进行修改密码出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return json;
	}

	/**
	 *
	 * <P>
	 * 退出登陆
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月31日
	 * @param employeeId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/doLogOut", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doLogOut(@RequestParam(value = "employeeId", required = true) String employeeId) {
		AjaxJson json = new AjaxJson();
		json.setSuccess(false);
		try {
			if (StringUtils.isNotBlank(employeeId)) {
				Customer customer = customerService.getCustomerByEmployeeId(employeeId);
				if (0 >= customerService.doLogOutService(customer)) {
					json.setMsg("尚未登陆");
				} else {
					json.setSuccess(true);
					json.setMsg("退出登陆成功");
				}
			} else {
				json.setSuccess(false);
				json.setMsg("退出登陆失败");
			}
		} catch (Exception e) {
			e.printStackTrace();
			json.setSuccess(false);
			json.setMsg("退出登陆失败~请稍后重试");
			logger_weChatController.error("退出登陆出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return json;
	}

	/**
	 * 更新个人信息
	 * 
	 * @author XiaoYu
	 * @date 2017年1月3日
	 * @param model
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/updateInfo", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson updateInfo(@FormModel(value = "model") Customer model) {
		AjaxJson json = customerService.updateInfo(model);
		return json;
	}

	/**
	 * 保存flex提交的文件
	 * 
	 * @return
	 */
	@RequestMapping("/saveUploadFile")
	@ResponseBody
	public String saveUploadFile(MultipartFile file, String fileType) {
		String newFileName = UUID.getUUID() + "." + fileType.split("/")[1];
		if (0 < newFileName.indexOf("jpeg")) {
			newFileName = newFileName.replace("jpeg", "jpg");
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("path", newFileName);
		Map<String, Map<String, String>> map_ = new HashMap<String, Map<String, String>>();
		map_.put("imagedata", map);
		try {
			File dir = new File(AttachmentUtil.getTempDir());
			if (!dir.exists()) {
				dir.mkdirs();
			}
			File newFile = new File(FileUtil.getTempDir() + "/" + newFileName);
			file.transferTo(newFile);
			// this.print(newFileName);
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("保存flex提交的文件出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
		return JSONObject.fromObject(map_).toString();
	}

	/**
	 * 付款成功 (接收微信 支付结果通用通知)
	 */
	@RequestMapping(value = "/mchNotify", method = RequestMethod.POST)
	@ResponseBody
	public void mchNotify() {
		try {
			// MchPayNotify
			// mchPayNotify=XMLConverUtil.convertToObject(MchPayNotify.class,
			// getRequest().getInputStream());
			Map<String, String> requestMap = MessageUtil.parseXml(getRequest());
			String orderId = requestMap.get("orderId");
			String subappid = requestMap.get("sub_appid");
			WeChat weChat = weChatService.getWeChatWithAppId(subappid);
			// 以下这行，切换为order，格式类似
			// depositAuctionService.payment(depositAuctionService.getDepositAuctionById(orderId));
			this.print("<xml><return_code><![CDATA[SUCCESS" + "]]></return_code><return_msg><![CDATA["
					+ "]]></return_msg></xml>");
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("付款成功出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
	}

	/**
	 *
	 * <P>
	 * 跳转支付成功
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月4日
	 * @param employeeId
	 * @param flag
	 * @return String
	 */
	@RequestMapping(value = "/paySuccess")
	public String paySuccess(@RequestParam(value = "employeeId", required = true) String employeeId,
			@RequestParam(value = "flag", required = false) String flag) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "employeeId,flag")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			setAttribute("employeeId", employeeId);
			if (StringUtils.isNotBlank(flag)) {
				setAttribute("customer", customerService.getCustomerByEmployeeId(employeeId));
			}
			setAttribute("flag", flag);
			return "module/weChat/jsp/weChat_pay_success";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("跳转支付成功出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 跳转支付失败
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月4日
	 * @param employeeId
	 * @param flag
	 * @return String
	 */
	@RequestMapping(value = "/payFail")
	public String payFail(@RequestParam(value = "employeeId", required = true) String employeeId,
			@RequestParam(value = "flag", required = false) String flag) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "employeeId,flag")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			setAttribute("employeeId", employeeId);
			if (StringUtils.isNotBlank(flag)) {
				setAttribute("customer", customerService.getCustomerByEmployeeId(employeeId));
			}
			setAttribute("flag", flag);
			return "module/weChat/jsp/weChat_pay_fail";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("跳转支付失败出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 获取短信验证码
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月31日
	 * @param phone
	 * @param flag
	 *            R:注册 F:忘记密码
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/getSMSCode", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson getSMSCode(@RequestParam(value = "phone", required = true) String phone,
			@RequestParam(value = "flage", required = true) String flage) {
		if ("R".equals(flage)) {
			return customerService.getSMSCodeR(phone);
		} else if ("F".equals(flage)) {
			return customerService.getSMSCodeF(phone);
		}
		return null;
	}

	/**
	 *
	 * <P>
	 * 前往商品详情
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月24日
	 * @param goodsId
	 * @param employeeId
	 * @return String
	 */
	@RequestMapping(value = "/goGoodsDetail")
	public String goGoodsDetail(@RequestParam(value = "goodsId", required = true) String goodsId,
			@RequestParam(value = "employeeId") String employeeId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "goodsId,employeeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			Goods goods = goodsService.getGoodsById(goodsId);
			setAttribute("evaluationList", evaluationService.getEvaluationListByGoodsId(goodsId));
			setAttribute("employeeId", employeeId);
			setAttribute("goods", goods);

			setAttribute("classStringList",
					ClassificationService.getClassificationAttrForClassification(classificationService
							.getClassificationById(goods.getClassification().getId())));
			return "module/weChat/jsp/weChat_goodsDetail";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("前往商品详情出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}

	}

	/**
	 *
	 * <P>
	 * 拿取商品遮罩层属性
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月25日
	 * @param goodsId
	 * @param goodsAttr
	 * @param employeeId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/getClassStringListByGoodsId", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@RequestParam(value = "goodsId") String goodsId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			Map<Object, Object> map = new HashMap<Object, Object>();
			Goods goods = goodsService.getGoodsById(goodsId);
			List<ClassificationVO> classStringList = ClassificationService
					.getClassificationAttrForClassification(classificationService.getClassificationById(goods
							.getClassification().getId()));
			map.put(classStringList, classStringList);
			map.put(goods, goods);
			ajaxJson.setObj(map);
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_weChatController.error("添加购物车出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 前往商店
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月24日
	 * @param goodsId
	 * @param employeeId
	 * @return String
	 */
	@RequestMapping(value = "/goStore")
	public String goStore(@RequestParam(value = "storeId", required = true) String storeId,
			@RequestParam(value = "classList", required = false) String[] classList,
			@RequestParam(value = "goodsName", required = false) String goodsName,
			@RequestParam(value = "employeeId", required = true) String employeeId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(),
				"storeId,goodsName,classList,employeeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			setAttribute("employeeId", employeeId);
			List<String> classList1 = new ArrayList<String>();
			if (null != classList && 0 < classList.length) {
				classList1 = Arrays.asList(classList);
			}
			GoodsPageVo goodsPageVo = goodsService.getGoodsListForIndex(null, null, storeId, classList1, goodsName);
			goodsPageVo.setGoodsList(GoodsController.getGoodsListToJsp(goodsPageVo.getGoodsList()));
			setAttribute("goodsPageVo", goodsPageVo);

			if (StringUtils.isNotBlank(storeId)) {
				Store store = storeService.getStoreById(storeId);
				setAttribute("store", store);
				setAttribute("parentClassList", classificationService.getParentClassByStoreId(storeId));
				setAttribute("childClassList", classificationService.getChildClassByStoreId(storeId));
				setAttribute("threeClassList", classificationService.getThreeClassByStoreId(storeId));
				return "module/weChat/jsp/weChat_goStore";
			} else {
				return "module/weChat/jsp/weChat_404";
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("前往商店--出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 获取分段加载数据(多)
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月27日
	 * @param page
	 * @param isRecommed
	 * @return String
	 */
	@RequestMapping(value = "/getGoodsListData", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson getGoodsListData(@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "storeId", required = false) String storeId,
			@RequestParam(value = "classList", required = false) String[] classList,
			@RequestParam(value = "goodsName", required = false) String goodsName,
			@RequestParam(value = "isRecommed", required = false) String isRecommed) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			List<String> classList1 = new ArrayList<String>();
			if (null != classList && 0 < classList.length) {
				classList1 = Arrays.asList(classList);
			}
			GoodsPageVo goodsPageVo = goodsService.getGoodsListForIndex(page, isRecommed, storeId, classList1,
					goodsName);
			goodsPageVo.setGoodsList(GoodsController.getGoodsListToJsp(goodsPageVo.getGoodsList()));
			ajaxJson.setObj(goodsPageVo);
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_weChatController.error("获取分段加载数据出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 获取分段加载数据
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月27日
	 * @param page
	 * @param isRecommed
	 * @return String
	 */
	@RequestMapping(value = "/getGoodsData", method = RequestMethod.POST)
	@ResponseBody
	public String getGoodsData(@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "storeId", required = false) String storeId,
			@RequestParam(value = "classId", required = false) String classId,
			@RequestParam(value = "goodsName", required = false) String goodsName,
			@RequestParam(value = "isRecommed", required = false) String isRecommed) {
		GoodsPageVo goodsPageVo = goodsService.getGoodsForIndex(page, isRecommed, storeId, classId, goodsName);
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setJavaPropertyFilter(new PropertyFilter() {

			@Override
			public boolean apply(Object source, String name, Object value) {
				System.out.println(source + ":" + name + ":" + value);
				if (value == null || String.valueOf(value).equals("")) {
					return true;
				}
				return false;
			}
		});
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		JSONObject jsonObj = JSONObject.fromObject(goodsPageVo, jsonConfig);
		return jsonObj.toString();
	}

	/**
	 *
	 * <P>
	 * 前往购物车
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月24日
	 * @param goodsId
	 * @param employeeId
	 * @return String
	 */
	@RequestMapping(value = "/goShoppingcart")
	public String goShoppingcart(@RequestParam(value = "employeeId", required = true) String employeeId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "employeeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			setAttribute("employeeId", employeeId);
			Customer customer = customerService.getCustomerByEmployeeId(employeeId);
			if (null == customer || StringUtils.isBlank(customer.getId())) {
				return "module/weChat/jsp/weChat_login";
			} else {
				setAttribute("customer", customer);
			}
			List<Shoppingcart> shoppingcartList = shoppingcartService.getShoppingcartByCustomerId(customer.getId());
			setAttribute("storeList", storeService.getStoreByCustomerId(customer.getId()));
			setAttribute("shoppingcartList", shoppingcartList);

			return "module/weChat/jsp/weChat_shoppingCart";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("前往购物车出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 保存或修改购物车
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月25日
	 * @param goodsId
	 * @param goodsAttr
	 * @param employeeId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdateShoppingcart", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@RequestParam(value = "goodsId") String goodsId,
			@RequestParam(value = "goodsAttr", required = false) String[] goodsAttr,
			@RequestParam(value = "goodsCount") String goodsCount, @RequestParam(value = "employeeId") String employeeId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			Customer customer = customerService.getCustomerByEmployeeId(employeeId);
			if (null != customer && StringUtils.isNotBlank(customer.getId())) {
				String GoodsId = goodsId;
				if (null != goodsAttr && 0 < goodsAttr.length) {
					List<String> goodsAttrList = Arrays.asList(goodsAttr);
					Goods goods = goodsService.getGoodsByGoodsAttr(GoodsId, goodsAttrList);
					if (null == goods || StringUtils.isBlank(goods.getId())) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("抱歉,该样式没有库存,请选择其他样式");
						return ajaxJson;
					}
					GoodsId = goods.getId();
				}
				Shoppingcart shoppingcart = shoppingcartService.getShoppingcartByCustomerIdAndGoodsId(customer.getId(),
						GoodsId);
				if (shoppingcart != null && StringUtils.isNotBlank(shoppingcart.getId())) {
					shoppingcart.setCount(String.valueOf((Integer.parseInt(shoppingcart.getCount()) + Integer
							.parseInt(goodsCount))));
					if (0 >= shoppingcartService.update(shoppingcart)) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("修改购物车失败，请稍后重试~");
					} else {
						ajaxJson.setSuccess(true);
						ajaxJson.setMsg("修改购物车成功！");
					}
				} else {
					if (0 >= shoppingcartService.save(GoodsId, customer.getId(), goodsCount)) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("添加购物车失败，请稍后重试~");
					} else {
						ajaxJson.setSuccess(true);
						ajaxJson.setMsg("添加购物车成功！");
					}
				}

			} else {
				ajaxJson.setObj("noLogin");
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("未登录，即将前往登录!");
			}

		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_weChatController.error("添加购物车出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除购物车
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月25日
	 * @param goodsId
	 * @param goodsAttr
	 * @param employeeId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/deleteShoppingcart", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson deleteShoppingcart(@RequestParam(value = "goodsId") String goodsId,
			@RequestParam(value = "employeeId") String employeeId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			Customer customer = customerService.getCustomerByEmployeeId(employeeId);
			if (null != customer && StringUtils.isNotBlank(customer.getId())) {
				Shoppingcart shoppingcart = shoppingcartService.getShoppingcartByCustomerIdAndGoodsId(customer.getId(),
						goodsId);
				if (0 >= shoppingcartService.doDelete(shoppingcart.getId())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("删除购物车失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("删除购物车成功！");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("未登录，请稍后重试~");
			}

		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_weChatController.error("添加购物车出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 前往商品查询
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月24日
	 * @param goodsId
	 * @param employeeId
	 * @return String
	 */
	@RequestMapping(value = "/selectGoods")
	public String selectGoods(@RequestParam(value = "storeId", required = false) String storeId,
			@RequestParam(value = "classList", required = false) String[] classList,
			@RequestParam(value = "goodsName", required = false) String goodsName,
			@RequestParam(value = "employeeId", required = true) String employeeId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(),
				"goodsName,classList,storeId,employeeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			if (StringUtils.isNotBlank(storeId)) {
				Store store = storeService.getStoreById(storeId);
				setAttribute("store", store);
			}
			setAttribute("employeeId", employeeId);
			setAttribute("goodsName", goodsName);
			List<String> classList1 = new ArrayList<String>();
			if (null != classList && 0 < classList.length) {
				classList1 = Arrays.asList(classList);
			}
			GoodsPageVo goodsPageVo = goodsService.getGoodsListForIndex(null, null, storeId, classList1, goodsName);
			goodsPageVo.setGoodsList(GoodsController.getGoodsListToJsp(goodsPageVo.getGoodsList()));
			setAttribute("goodsPageVo", goodsPageVo);
			return "module/weChat/jsp/weChat_selectGoods";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("前往商品查询出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 前往登录界面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月1日
	 * @param employeeId
	 * @return String
	 */
	@RequestMapping(value = "/goLogin")
	public String goLogin(@RequestParam(value = "employeeId") String employeeId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "employeeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			Customer customer = customerService.getCustomerByEmployeeId(employeeId);
			if (null != customer && StringUtils.isNotBlank(customer.getId())) {
				setAttribute("employeeId", employeeId);
				setAttribute("customer", customerService.getCustomerByEmployeeId(employeeId));
				return "module/weChat/jsp/weChat_personalcenter";
			} else {
				setAttribute("employeeId", employeeId);
				return "module/weChat/jsp/weChat_login";
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("前往登录界面出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 前往忘记密码界面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月1日
	 * @param employeeId
	 * @return String
	 */
	@RequestMapping(value = "/goForgetPassword")
	public String goForgetPassword(@RequestParam(value = "employeeId") String employeeId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "employeeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			setAttribute("employeeId", employeeId);
			return "module/weChat/jsp/weChat_forgetPassword";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("前往忘记密码界面出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 忘记密码-修改密码
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月1日
	 * @param smsCode
	 * @param employeeId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/doForgetPassword", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doForgetPassword(@RequestParam(value = "phone", required = true) String phone,
			@RequestParam(value = "newPassword", required = true) String newPassword,
			@RequestParam(value = "smsCode", required = true) String smsCode) {
		AjaxJson json = new AjaxJson();
		try {
			if (StringUtils.isBlank(phone)) {
				json.setSuccess(false);
				json.setMsg("获取电话失败,请重试!");
			} else {
				Customer customer = new Customer();
				customer.setPhone(phone);
				json = customerService.updatePassword(customerService.getCustomerByCustomer(customer).get(0), smsCode,
						newPassword);
			}

		} catch (Exception e) {
			e.printStackTrace();
			json.setSuccess(false);
			json.setMsg("修改失败~请稍后重试");
			logger_weChatController.error("忘记密码 出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return json;
	}

	/**
	 *
	 * <P>
	 * 前往我的钱包界面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月1日
	 * @param employeeId
	 * @return String
	 */
	@RequestMapping(value = "/goMyWallet")
	public String goMyWallet(@RequestParam(value = "employeeId") String employeeId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "employeeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			Customer customer = customerService.getCustomerByEmployeeId(employeeId);
			setAttribute("customer", customer);
			setAttribute("employeeId", employeeId);
			return "module/weChat/jsp/wechat_myWallet";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("前往我的钱包界面出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 前往支付密码设置界面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月1日
	 * @param employeeId
	 * @return String
	 */
	@RequestMapping(value = "/goPayPassword")
	public String goPayPassword(@RequestParam(value = "employeeId") String employeeId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "employeeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			Customer customer = customerService.getCustomerByEmployeeId(employeeId);
			setAttribute("customer", customer);
			setAttribute("employeeId", employeeId);
			return "module/weChat/jsp/weChat_payPassword";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("前往支付密码设置界面出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 进行修改支付密码
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月1日
	 * @param customerId
	 * @param flage
	 * @param oldPassword
	 * @param newPassword
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/doPayPassword", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doPayPassword(@RequestParam(value = "customerId", required = true) String customerId,
			@RequestParam(value = "flage") String flage, @RequestParam(value = "oldPassword") String oldPassword,
			@RequestParam(value = "newPassword") String newPassword) {
		AjaxJson json = new AjaxJson();
		json.setSuccess(false);
		try {
			if (StringUtils.isNotBlank(flage)) {
				if ("new".equals(flage)) {
					Customer customer = customerService.getCustomerById(customerId);

					if (null != customer && StringUtils.isNotBlank(customer.getId())) {
						if (!newPassword.equals(oldPassword)) {
							json.setMsg("两次密码不同！");
						} else {
							customer.setPayPassword(newPassword);
							customerService.update(customer);
							json.setSuccess(true);
							json.setMsg("密码设置成功！");
						}
					} else {
						json.setMsg("操作错误");
					}
				} else if ("update".equals(flage)) {
					Customer customer = customerService.getCustomerById(customerId);

					if (null != customer && StringUtils.isNotBlank(customer.getId())) {
						if (!customer.getPayPassword().equals(oldPassword)) {
							json.setMsg("原密码错误！");
						} else if (customer.getPayPassword().equals(newPassword)) {
							json.setMsg("原密码与新密码不可相同！");
						} else {
							customer.setPayPassword(newPassword);
							customerService.update(customer);
							json.setSuccess(true);
							json.setMsg("密码修改成功！");
						}
					} else {
						json.setMsg("操作错误");
					}
				} else {
					json.setMsg("密码修改flage错误");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			json.setSuccess(false);
			json.setMsg("修改失败~请稍后重试");
			logger_weChatController.error("修改支付密码 出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}

		return json;
	}

	/**
	 *
	 * <P>
	 * 前往忘记密码界面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月1日
	 * @param employeeId
	 * @return String
	 */
	@RequestMapping(value = "/goForgetPayPassword")
	public String goForgetPayPassword(@RequestParam(value = "employeeId") String employeeId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "employeeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			setAttribute("employeeId", employeeId);
			return "module/weChat/jsp/weChat_forgetPayPassword";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("前往忘记密码界面出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 忘记密码-修改密码
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月1日
	 * @param smsCode
	 * @param employeeId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/doForgetPayPassword", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doForgetPayPassword(@RequestParam(value = "phone", required = true) String phone,
			@RequestParam(value = "newPassword", required = true) String newPassword,
			@RequestParam(value = "smsCode", required = true) String smsCode) {
		AjaxJson json = new AjaxJson();
		try {
			if (StringUtils.isBlank(phone)) {
				json.setSuccess(false);
				json.setMsg("电话获取失败,请重试!");
			} else {
				Customer customer = new Customer();
				customer.setPhone(phone);
				json = customerService.updatePayPassword(customerService.getCustomerByCustomer(customer).get(0),
						smsCode, newPassword);
			}
		} catch (Exception e) {
			e.printStackTrace();
			json.setSuccess(false);
			json.setMsg("修改失败~请稍后重试");
			logger_weChatController.error("忘记支付密码 出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return json;
	}

	/**
	 *
	 * <P>
	 * 前往交易流水界面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月1日
	 * @param employeeId
	 * @return String
	 */
	@RequestMapping(value = "/goConsume")
	public String goConsume(@RequestParam(value = "employeeId") String employeeId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "employeeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			Customer customer = customerService.getCustomerByEmployeeId(employeeId);
			setAttribute("consumeList", consumeService.getConsumeByCustomerId(customer.getId()));
			setAttribute("employeeId", employeeId);
			return "module/weChat/jsp/wechat_consume";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("前往交易流水界面出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 前往交易流水详情界面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月2日
	 * @param consumeId
	 * @return String
	 */
	@RequestMapping(value = "/goConsumeDetails")
	public String goConsumeDetails(@RequestParam(value = "consumeId") String consumeId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "consumeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			setAttribute("consume", consumeService.getConsumeById(consumeId));
			return "module/weChat/jsp/wechat_consume_details";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("前往交易流水详情界面出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 前往地址管理界面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月2日
	 * @param consumeId
	 * @return String
	 */
	@RequestMapping(value = "/goReviseaddr")
	public String goReviseaddr(@RequestParam(value = "employeeId") String employeeId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "employeeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			Customer customer = customerService.getCustomerByEmployeeId(employeeId);
			setAttribute("addressList", addressService.getAddressByCustomerId(customer.getId()));
			setAttribute("employeeId", employeeId);
			return "module/weChat/jsp/weChat_reviseaddr";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("前往地址管理界面出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 更新默认地址
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月2日
	 * @param consumeId
	 * @return String
	 */
	@RequestMapping(value = "/selectIsDefault")
	@ResponseBody
	public AjaxJson selectIsDefault(@RequestParam(value = "employeeId") String employeeId,
			@RequestParam(value = "oldSelectId") String oldSelectId,
			@RequestParam(value = "newSelectId") String newSelectId) {
		AjaxJson json = new AjaxJson();
		json.setSuccess(false);
		try {
			if (StringUtils.isNotBlank(oldSelectId) && StringUtils.isNotBlank(newSelectId)) {
				if (0 >= addressService.selectIsDefault(oldSelectId, "2")
						|| 0 >= addressService.selectIsDefault(newSelectId, "1")) {
					json.setSuccess(false);
					json.setMsg("设置默认地址失败");
				} else {
					json.setSuccess(true);
					json.setMsg("设置默认地址成功");
				}

			} else if (StringUtils.isBlank(oldSelectId) && StringUtils.isNotBlank(newSelectId)) {
				if (0 >= addressService.selectIsDefault(newSelectId, "1")) {
					json.setSuccess(false);
					json.setMsg("设置默认地址失败");
				} else {
					json.setSuccess(true);
					json.setMsg("设置默认地址成功");
				}
			} else if (StringUtils.isNotBlank(oldSelectId) && StringUtils.isBlank(newSelectId)) {
				if (0 >= addressService.selectIsDefault(oldSelectId, "2")) {
					json.setSuccess(false);
					json.setMsg("取消默认地址失败");
				} else {
					json.setSuccess(true);
					json.setMsg("取消默认地址成功");
				}
			} else {
				json.setSuccess(false);
				json.setMsg("传参错误,修改失败");
			}
		} catch (Exception e) {
			e.printStackTrace();
			json.setSuccess(false);
			json.setMsg("修改失败~请稍后重试");
			logger_weChatController.error("默认地址出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return json;
	}

	/**
	 *
	 * <P>
	 * 前往收获地址新建/修改界面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月2日
	 * @param consumeId
	 * @return String
	 */
	@RequestMapping(value = "/goNewAddress")
	public String goNewAddress(@RequestParam(value = "employeeId") String employeeId,
			@RequestParam(value = "addressId", required = false) String addressId,
			@RequestParam(value = "oldSelectId", required = true) String oldSelectId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "oldSelectId,addressId,employeeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			Customer customer = customerService.getCustomerByEmployeeId(employeeId);
			if (StringUtils.isNotBlank(addressId)) {
				setAttribute("address", addressService.getAddressById(addressId));
			}
			setAttribute("oldSelectId", oldSelectId);
			setAttribute("customerId", customer.getId());
			setAttribute("employeeId", employeeId);
			return "module/weChat/jsp/weChat_new_address";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("前往收获地址新建/修改界面出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 修改/保存收获地址
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月3日
	 * @param address
	 *            地址对象
	 * @param employeeId
	 * @param oldSelectId
	 *            旧默认地址
	 * @param isSelect
	 *            本地址对象是否选择为默认
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/doNewAddress")
	@ResponseBody
	public AjaxJson doNewAddress(@FormModel(value = "model") Address address,
			@RequestParam(value = "employeeId") String employeeId,
			@RequestParam(value = "oldSelectId") String oldSelectId, @RequestParam(value = "isSelect") Boolean isSelect) {
		AjaxJson json = new AjaxJson();
		json.setSuccess(false);
		try {
			if (address != null && StringUtils.isNotBlank(address.getId())) {
				if (isSelect) {
					address.setIsDefault(Address.ISDEFAULT_TRUE);
					if (0 >= addressService.update(address)) {
						json.setSuccess(false);
						json.setMsg("修改地址失败");
					} else {
						if (!oldSelectId.equals(address.getId()) && StringUtils.isNotBlank(oldSelectId)) {
							addressService.selectIsDefault(oldSelectId, "2");
						}
						json.setSuccess(true);
						json.setMsg("修改地址成功");
					}
				} else {
					address.setIsDefault(Address.ISDEFAULT_FALSE);
					if (0 >= addressService.update(address)) {
						json.setSuccess(false);
						json.setMsg("修改地址失败");
					} else {
						json.setSuccess(true);
						json.setMsg("修改地址成功");
					}
				}
			} else {
				if (isSelect) {
					address.setIsDefault(Address.ISDEFAULT_TRUE);
					if (0 >= addressService.save(address)) {
						json.setSuccess(false);
						json.setMsg("保存地址失败");
					} else {
						if (!oldSelectId.equals(address.getId()) && StringUtils.isNotBlank(oldSelectId)) {
							addressService.selectIsDefault(oldSelectId, "2");
						}
						json.setSuccess(true);
						json.setMsg("保存地址成功");
					}
				} else {
					address.setIsDefault(Address.ISDEFAULT_FALSE);
					if (0 >= addressService.save(address)) {
						json.setSuccess(false);
						json.setMsg("保存地址失败");
					} else {
						json.setSuccess(true);
						json.setMsg("保存地址成功");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			json.setSuccess(false);
			json.setMsg("修改失败~请稍后重试");
			logger_weChatController.error("修改/保存地址出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return json;
	}

	/**
	 *
	 * <P>
	 * 删除收获地址
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月4日
	 * @param addressId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/doDeleteAddress")
	@ResponseBody
	public AjaxJson doDeleteAddress(@RequestParam(value = "addressId") String addressId) {
		AjaxJson json = new AjaxJson();
		json.setSuccess(false);
		try {
			if (StringUtils.isNotBlank(addressId)) {
				if (0 >= addressService.deleteAddress(new Address(addressId))) {
					json.setSuccess(false);
					json.setMsg("删除地址失败");
				} else {
					json.setSuccess(true);
					json.setMsg("删除地址成功");
				}
			} else {
				json.setSuccess(false);
				json.setMsg("删除地址失败");
			}
		} catch (Exception e) {
			e.printStackTrace();
			json.setSuccess(false);
			json.setMsg("删除失败~请稍后重试");
			logger_weChatController.error("删除地址出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return json;
	}

	/**
	 *
	 * <P>
	 * 前往订单创建页面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月2日
	 * @param employeeId
	 * @param goType
	 *            购物车(sc)或手提袋(icon)图标
	 * @param addressId
	 * @param shoppingcart
	 * @return String
	 */
	@RequestMapping(value = "/goCreatOrder")
	public String goCreatOrder(@RequestParam(value = "employeeId") String employeeId,
			@RequestParam(value = "goType", required = true) String goType,
			@RequestParam(value = "goodsId", required = false) String goodsId,
			@RequestParam(value = "shoppingcartList", required = false) String[] shoppingcartList) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(),
				"employeeId,goType,goodsId,shoppingcartList")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			Customer customer = customerService.getCustomerByEmployeeId(employeeId);
			if (null != customer && StringUtils.isNotBlank(customer.getId())) {
				if ("sc".equals(goType)) {
					setAttribute("goType", goType);
					if (null != shoppingcartList && 0 < shoppingcartList.length) {
						String countGoods = "0";
						List<String> shoppingcartListId = Arrays.asList(shoppingcartList);
						List<Shoppingcart> shoppingcartList1 = new ArrayList<Shoppingcart>();
						for (String shoppingcartId : shoppingcartListId) {
							shoppingcartList1.add(shoppingcartService.getShoppingcartById(shoppingcartId));
						}
						for (Shoppingcart shoppingcart : shoppingcartList1) {
							countGoods = String.valueOf((Integer.parseInt(countGoods) + Integer.parseInt(shoppingcart
									.getCount())));
						}
						setAttribute("countGoods", countGoods);
						setAttribute("shoppingcartList", shoppingcartList1);
					} else {
						return "module/weChat/jsp/weChat_param_error";
					}
				} else if ("icon".equals(goType)) {
					setAttribute("goType", goType);
					Goods goods = goodsService.getGoodsById(goodsId);
					setAttribute("goods", goods);
					setAttribute("classStringList",
							ClassificationService.getClassificationAttrForClassification(classificationService
									.getClassificationById(goods.getClassification().getId())));
				}
				Address defaultAddress = addressService.getDefaultAddressByCustomerId(customer.getId());
				if (null != defaultAddress && StringUtils.isNotBlank(defaultAddress.getId())) {
					setAttribute("defaultAddress", defaultAddress);
				} else {
					if (null != addressService.getAddressByCustomerId(customer.getId())
							&& 0 < addressService.getAddressByCustomerId(customer.getId()).size()) {
						setAttribute("defaultAddress", addressService.getAddressByCustomerId(customer.getId()).get(0));
					} else {
						setAttribute("defaultAddress", null);
					}
				}
				setAttribute("addressList", addressService.getAddressByCustomerId(customer.getId()));
				setAttribute("customerId", customer.getId());
				setAttribute("employeeId", employeeId);
				return "module/weChat/jsp/weChat_makesure_order_buy";
			} else {
				setAttribute("employeeId", employeeId);
				return "module/weChat/jsp/weChat_login";
			}

		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("前往订单创建界面出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 确认选择商品
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月25日
	 * @param goodsId
	 * @param goodsAttr
	 * @param employeeId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/selectGoodsForAttr", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson selectGoodsForAttr(@RequestParam(value = "goodsId") String goodsId,
			@RequestParam(value = "goodsAttr", required = false) String[] goodsAttr) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			String GoodsId = goodsId;
			if (null != goodsAttr && 0 < goodsAttr.length) {
				List<String> goodsAttrList = Arrays.asList(goodsAttr);
				Goods goods = goodsService.getGoodsByGoodsAttr(GoodsId, goodsAttrList);
				if (null == goods || StringUtils.isBlank(goods.getId())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("抱歉,该样式没有库存,请选择其他样式");
					return ajaxJson;
				}
				goods = GoodsController.getGoodsToJsp(goods);
				ajaxJson.setObj(goods);
			} else {
				Goods goods = goodsService.getGoodsByGoodsAttr(GoodsId, null);
				goods = GoodsController.getGoodsToJsp(goods);
				ajaxJson.setObj(goods);
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_weChatController.error("确认选择商品出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 确认选择商品
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月25日
	 * @param goodsId
	 * @param goodsAttr
	 * @param employeeId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrder", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrder(@RequestParam(value = "employeeId") String employeeId,
			@RequestParam(value = "goodsId", required = false) String goodsId,
			@RequestParam(value = "leaveMessage") String leaveMessage,
			@RequestParam(value = "count", required = false) String count,
			@RequestParam(value = "addressId") String addressId, @RequestParam(value = "goType") String goType,
			@RequestParam(value = "payType") String payType,
			@RequestParam(value = "shoppingcartIdList", required = false) String shoppingcartIdList) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (null != employeeId && StringUtils.isNotBlank(employeeId)) {
				if (null == addressId || StringUtils.isBlank(addressId) || "undefined".equals(addressId)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("地址为空,请选择!");
					return ajaxJson;
				}
				String batchCode = BatchCodeID.nextCode();
				Customer customer = customerService.getCustomerByEmployeeId(employeeId);
				String inLinePayMoney = "0";
				if ("sc".equals(goType)) {
					String erroGoodsName = goodsService.getErroGoodsNameByShoppingCart(shoppingcartIdList);
					if (null != erroGoodsName && StringUtils.isNotBlank(erroGoodsName)) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("商品:" + erroGoodsName + "已下架,请更换商品!");
						return ajaxJson;
					}
					List<Shoppingcart> shoppingcartList = shoppingcartService
							.getShoppingcartByShoppingcartList(shoppingcartIdList);
					HashMap<String, List<OrderGoods>> storeMap = new HashMap<String, List<OrderGoods>>();
					for (Shoppingcart shoppingcart : shoppingcartList) {
						if (storeMap.containsKey(shoppingcart.getGoods().getStore().getId())) {
							List<OrderGoods> orderGoodsList = storeMap.get(shoppingcart.getGoods().getStore().getId());
							OrderGoods orderGoods = new OrderGoods();
							orderGoods.setId(UUID.getUUID());
							orderGoods.setGoods(shoppingcart.getGoods());
							orderGoods.setCount(shoppingcart.getCount());
							orderGoods.setPrice(shoppingcart.getGoods().getSalesPrice());
							orderGoods.setType(OrderGoods.TYPE_OUT);
							orderGoods.setCreateTime(new Date());
							orderGoodsList.add(orderGoods);
							// list排序，依据自定义的排序条件（商品单价）降序排序
							Collections.sort(orderGoodsList);
							storeMap.put(shoppingcart.getGoods().getStore().getId(), orderGoodsList);
						} else {
							List<OrderGoods> orderGoodsList = new ArrayList<OrderGoods>();
							OrderGoods orderGoods = new OrderGoods();
							orderGoods.setId(UUID.getUUID());
							orderGoods.setGoods(shoppingcart.getGoods());
							orderGoods.setCount(shoppingcart.getCount());
							orderGoods.setPrice(shoppingcart.getGoods().getSalesPrice());
							orderGoods.setType(OrderGoods.TYPE_OUT);
							orderGoods.setCreateTime(new Date());
							orderGoodsList.add(orderGoods);
							// list排序，依据自定义的排序条件（商品单价）降序排序
							Collections.sort(orderGoodsList);
							storeMap.put(shoppingcart.getGoods().getStore().getId(), orderGoodsList);
						}
					}
					List<Order> parentOrderList = new ArrayList<Order>();
					List<String> orderIdList = new ArrayList<String>();
					for (Map.Entry<String, List<OrderGoods>> entry : storeMap.entrySet()) {
						String sumMoney = "0";
						String sumNumber = "0";
						String payMoney = "0";
						String subMoney = "0";
						Address address = addressService.getAddressById(addressId);
						for (OrderGoods orderGoods : entry.getValue()) {
							sumMoney = DoubleUtil.add(sumMoney,
									DoubleUtil.mul(orderGoods.getPrice(), orderGoods.getCount()).toString()).toString();
							sumNumber = String.valueOf((Integer.parseInt(sumNumber) + Integer.parseInt(orderGoods
									.getCount())));
						}
						Order order = new Order();
						order.setId(UUID.getUUID());
						order.setBatchCode(batchCode);
						order.setCustomer(customer);
						order.setStore(new Store(entry.getKey()));
						order.setCode(OrderCodeID.nextCode());
						order.setType(Order.TYPE_ONE);
						order.setCreateTime(new Date());
						order.setPayType(payType);
						order.setState(Order.STATE_ONE);
						order.setSumMoney(sumMoney);
						order.setSumNumber(sumNumber);
						order.setLeaveMessage(leaveMessage);
						order.setReceiverName(address.getReceiver());
						order.setReceiverAddress(address.getContent());
						order.setReceiverPhone(address.getPhone());
						order.setIsHide(Order.ISHIDE_TWO);
						order.setCreateTime(new Date());
						order.setOnePayType(payType);
						Map<String, Order> orderMap = orderService.splitOrderGoods(entry.getValue(), order,
								Order.TYPE_ONE);
						List<Order> orderList = new ArrayList<Order>();
						for (Map.Entry<String, Order> entryOrder : orderMap.entrySet()) {
							if ("otherOrder".equals(entryOrder.getKey())) {
								String otherOrderSumMoney = "0";
								String otherOrderSumNumber = "0";
								entryOrder.getValue().setId(UUID.getUUID());
								entryOrder.getValue().setOrder(order);
								entryOrder.getValue().setCustomer(customer);
								entryOrder.getValue().setStore(new Store(entry.getKey()));
								entryOrder.getValue().setCode(OrderCodeID.nextCode());
								entryOrder.getValue().setType(Order.TYPE_ONE);
								entryOrder.getValue().setCreateTime(new Date());
								entryOrder.getValue().setPayType(payType);
								entryOrder.getValue().setState(Order.STATE_ONE);
								entryOrder.getValue().setProType("otherOrder");
								List<OrderGoods> otherOrderOrderGoodsList = entryOrder.getValue().getOrderGoodList();
								for (OrderGoods orderGoods : otherOrderOrderGoodsList) {
									orderGoods.setOrder(entryOrder.getValue());
									orderGoods.setSubMoney("0");
									otherOrderSumMoney = DoubleUtil.add(otherOrderSumMoney,
											DoubleUtil.mul(orderGoods.getPrice(), orderGoods.getCount()).toString())
											.toString();
									otherOrderSumNumber = String
											.valueOf((Integer.parseInt(otherOrderSumNumber) + Integer
													.parseInt(orderGoods.getCount())));
								}
								entryOrder.getValue().setOrderGoodList(otherOrderOrderGoodsList);
								entryOrder.getValue().setSumMoney(otherOrderSumMoney);
								entryOrder.getValue().setSumNumber(otherOrderSumNumber);
								entryOrder.getValue().setPayMoney(otherOrderSumMoney);
								entryOrder.getValue().setSubMoney("0");

							}
							payMoney = DoubleUtil.add(payMoney, entryOrder.getValue().getPayMoney()).toString();
							subMoney = DoubleUtil.add(subMoney, entryOrder.getValue().getSubMoney()).toString();
							orderList.add(entryOrder.getValue());
						}
						order.setOrderList(orderList);
						order.setPayMoney(DoubleUtil.toDecimalString(payMoney, 2));
						inLinePayMoney = DoubleUtil.add(inLinePayMoney, order.getPayMoney()).toString();
						order.setSubMoney(DoubleUtil.toDecimalString(subMoney, 2));
						order.setEticketMoney("0");
						order.setOnePayMoney(order.getPayMoney());
						order.setOneReturnMoney(order.getPayMoney());
						order.setTwoPayMoney("0");
						order.setTwoReturnMoney("0");
						parentOrderList.add(order);
						orderIdList.add(order.getId());
					}
					if (0 >= orderService.saveOrderListAll(parentOrderList, inLinePayMoney)) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("提交订单失败!");
					} else {
						for (Shoppingcart shoppingcart : shoppingcartList) {
							if (0 >= shoppingcartService.doDelete(shoppingcart.getId())) {
								ajaxJson.setSuccess(false);
								ajaxJson.setMsg("提交订单失败!");
							} else {
								ajaxJson.setSuccess(true);
								ajaxJson.setMsg("提交订单成功!");
								ajaxJson.setObj(orderIdList);
							}
						}
					}

				} else if ("icon".equals(goType)) {
					HashMap<String, List<OrderGoods>> storeMap = new HashMap<String, List<OrderGoods>>();
					Goods goods = goodsService.getGoodsById(goodsId);

					List<OrderGoods> orderGoodsList = new ArrayList<OrderGoods>();
					OrderGoods orderGoods = new OrderGoods();
					orderGoods.setId(UUID.getUUID());
					orderGoods.setGoods(goods);
					orderGoods.setCount(count);
					orderGoods.setPrice(goods.getSalesPrice());
					orderGoods.setType(OrderGoods.TYPE_OUT);
					orderGoods.setCreateTime(new Date());
					orderGoodsList.add(orderGoods);
					// list排序，依据自定义的排序条件（商品单价）降序排序
					Collections.sort(orderGoodsList);
					storeMap.put(goods.getStore().getId(), orderGoodsList);

					List<Order> parentOrderList = new ArrayList<Order>();
					List<String> orderIdList = new ArrayList<String>();
					for (Map.Entry<String, List<OrderGoods>> entry : storeMap.entrySet()) {
						String sumMoney = "0";
						String sumNumber = "0";
						String payMoney = "0";
						String subMoney = "0";
						Address address = addressService.getAddressById(addressId);
						for (OrderGoods orderGoods1 : entry.getValue()) {
							sumMoney = DoubleUtil.add(sumMoney,
									DoubleUtil.mul(orderGoods1.getPrice(), orderGoods1.getCount()).toString())
									.toString();
							sumNumber = String.valueOf((Integer.parseInt(sumNumber) + Integer.parseInt(orderGoods1
									.getCount())));
						}
						Order order = new Order();
						order.setId(UUID.getUUID());
						order.setBatchCode(batchCode);
						order.setCustomer(customer);
						order.setStore(new Store(entry.getKey()));
						order.setCode(OrderCodeID.nextCode());
						order.setType(Order.TYPE_ONE);
						order.setCreateTime(new Date());
						order.setPayType(payType);
						order.setState(Order.STATE_ONE);
						order.setSumMoney(sumMoney);
						order.setSumNumber(sumNumber);
						order.setLeaveMessage(leaveMessage);
						order.setReceiverName(address.getReceiver());
						order.setReceiverAddress(address.getContent());
						order.setReceiverPhone(address.getPhone());
						order.setIsHide(Order.ISHIDE_TWO);
						order.setCreateTime(new Date());
						order.setOnePayType(payType);
						Map<String, Order> orderMap = orderService.splitOrderGoods(entry.getValue(), order,
								Order.TYPE_ONE);
						List<Order> orderList = new ArrayList<Order>();
						for (Map.Entry<String, Order> entryOrder : orderMap.entrySet()) {
							if ("otherOrder".equals(entryOrder.getKey())) {
								String otherOrderSumMoney = "0";
								String otherOrderSumNumber = "0";
								entryOrder.getValue().setId(UUID.getUUID());
								entryOrder.getValue().setOrder(order);
								entryOrder.getValue().setCustomer(customer);
								entryOrder.getValue().setStore(new Store(entry.getKey()));
								entryOrder.getValue().setCode(OrderCodeID.nextCode());
								entryOrder.getValue().setType(Order.TYPE_ONE);
								entryOrder.getValue().setCreateTime(new Date());
								entryOrder.getValue().setPayType(payType);
								entryOrder.getValue().setState(Order.STATE_ONE);
								entryOrder.getValue().setCreateTime(new Date());
								entryOrder.getValue().setProType("otherOrder");
								List<OrderGoods> otherOrderOrderGoodsList = entryOrder.getValue().getOrderGoodList();
								for (OrderGoods orderGoods1 : otherOrderOrderGoodsList) {
									orderGoods1.setOrder(entryOrder.getValue());
									orderGoods1.setSubMoney("0");
									otherOrderSumMoney = DoubleUtil.add(otherOrderSumMoney,
											DoubleUtil.mul(orderGoods1.getPrice(), orderGoods1.getCount()).toString())
											.toString();
									otherOrderSumNumber = String
											.valueOf((Integer.parseInt(otherOrderSumNumber) + Integer
													.parseInt(orderGoods1.getCount())));
								}
								entryOrder.getValue().setOrderGoodList(otherOrderOrderGoodsList);
								entryOrder.getValue().setSumMoney(otherOrderSumMoney);
								entryOrder.getValue().setSumNumber(otherOrderSumNumber);
								entryOrder.getValue().setPayMoney(otherOrderSumMoney);
								entryOrder.getValue().setSubMoney("0");

							}
							payMoney = DoubleUtil.add(payMoney, entryOrder.getValue().getPayMoney()).toString();
							subMoney = DoubleUtil.add(subMoney, entryOrder.getValue().getSubMoney()).toString();
							orderList.add(entryOrder.getValue());
						}
						order.setOrderList(orderList);
						order.setPayMoney(DoubleUtil.toDecimalString(payMoney, 2));
						inLinePayMoney = DoubleUtil.add(inLinePayMoney, order.getPayMoney()).toString();
						order.setSubMoney(DoubleUtil.toDecimalString(subMoney, 2));
						order.setEticketMoney("0");
						order.setOnePayMoney(order.getPayMoney());
						order.setOneReturnMoney(order.getPayMoney());
						order.setTwoPayMoney("0");
						order.setTwoReturnMoney("0");
						parentOrderList.add(order);
						orderIdList.add(order.getId());
					}
					if (0 >= orderService.saveOrderListAll(parentOrderList, inLinePayMoney)) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("提交订单失败!");
					} else {
						ajaxJson.setSuccess(true);
						ajaxJson.setMsg("提交订单成功!");
						ajaxJson.setObj(orderIdList);
					}
				}
			} else {

			}

		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_weChatController.error("确认选择商品出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 订单展示页
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月5日
	 * @param employeeId
	 * @param orderIdList
	 * @return String
	 */
	@RequestMapping(value = "/showOrder")
	public String showOrder(@RequestParam(value = "employeeId") String employeeId,
			@RequestParam(value = "batchCode", required = false) String batchCode,
			@RequestParam(value = "payType") String payType,
			@RequestParam(value = "receiverName", required = false) String receiverName,
			@RequestParam(value = "receiverAddress", required = false) String receiverAddress,
			@RequestParam(value = "receiverPhone", required = false) String receiverPhone,
			@RequestParam(value = "addressId", required = false) String addressId,
			@RequestParam(value = "orderIdList", required = false) String[] orderIdList) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(),
				"employeeId,payType,receiverName,receiverAddress,receiverPhone,batchCode,addressId,orderIdList")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			List<String> orderIdList1 = new ArrayList<String>();
			if (StringUtils.isNotBlank(batchCode)) {
				orderIdList1 = orderService.getOrderIdListByBatchCode(batchCode);
			} else if (null != orderIdList && StringUtils.isNotBlank(orderIdList.toString())) {
				orderIdList1 = Arrays.asList(orderIdList);
			} else {
				return "module/weChat/jsp/weChat_404";
			}
			List<Order> orderList = new ArrayList<Order>();
			String orderIdList2 = "";
			String sumNumber = "0";
			String sumMoney = "0";
			String payMoney = "0";
			String subMoney = "0";
			String eticketMoney = "0";
			String postage = "0";
			String eticketNumber = "0";
			String promotionGoods = "";
			List<String> promotionGoodsList = new ArrayList<String>();
			for (String orderId : orderIdList1) {
				Order order = orderService.getOrderById(orderId);
				if (StringUtils.isNotBlank(orderIdList2)) {
					orderIdList2 = orderIdList2 + "," + order.getId();
				} else {
					orderIdList2 = orderIdList2 + order.getId();
				}
				for (Order order1 : order.getOrderList()) {
					if ("otherOrder".equals(order1.getProType())) {
						Order otherOrder = order1;
						eticketNumber = String.valueOf((Integer.parseInt(eticketNumber) + otherOrder
								.getEticketUseRecordList().size()));
					}
					for (OrderGoods orderGoods : order1.getOrderGoodList()) {
						if (null != orderGoods && StringUtils.isNotBlank(orderGoods.getId())
								&& null != orderGoods.getOrderSubremark()
								&& StringUtils.isNotBlank(orderGoods.getOrderSubremark().getId())
								&& null != orderGoods.getOrderSubremark().getPromotionLadder()
								&& StringUtils.isNotBlank(orderGoods.getOrderSubremark().getPromotionLadder().getId())) {
							if (Promotion.TYPE_7.equals(orderGoods.getOrderSubremark().getPromotionLadder()
									.getPromotion().getType())
									|| Promotion.TYPE_8.equals(orderGoods.getOrderSubremark().getPromotionLadder()
											.getPromotion().getType())) {
								promotionGoods = orderGoods.getOrderSubremark().getPromotionLadder().getGoods()
										.getName()
										+ ":"
										+ orderGoods.getOrderSubremark().getPromotionLadder().getGoodsNumber()
										+ "个";
								promotionGoodsList.add(promotionGoods);
							}
						}
					}
					if (null != order1.getOrderSubremarkList() && 0 < order1.getOrderSubremarkList().size()) {
						for (OrderSubremark orderSubremark : order1.getOrderSubremarkList()) {
							if (null != orderSubremark && StringUtils.isNotBlank(orderSubremark.getId())
									&& null != orderSubremark.getPromotionLadder()
									&& StringUtils.isNotBlank(orderSubremark.getPromotionLadder().getId())) {
								if (Promotion.TYPE_7.equals(orderSubremark.getPromotionLadder().getPromotion()
										.getType())
										|| Promotion.TYPE_8.equals(orderSubremark.getPromotionLadder().getPromotion()
												.getType())) {
									promotionGoods = orderSubremark.getPromotionLadder().getGoods().getName() + ":"
											+ orderSubremark.getPromotionLadder().getGoodsNumber() + "个";
									promotionGoodsList.add(promotionGoods);
								}
							}
						}
					}
				}
				if (null != order.getOrderSubremarkList() && 0 < order.getOrderSubremarkList().size()) {
					for (OrderSubremark orderSubremark : order.getOrderSubremarkList()) {
						if (null != orderSubremark && StringUtils.isNotBlank(orderSubremark.getId())
								&& null != orderSubremark.getPromotionLadder()
								&& StringUtils.isNotBlank(orderSubremark.getPromotionLadder().getId())) {
							if (Promotion.TYPE_7.equals(orderSubremark.getPromotionLadder().getPromotion().getType())
									|| Promotion.TYPE_8.equals(orderSubremark.getPromotionLadder().getPromotion()
											.getType())) {
								promotionGoods = orderSubremark.getPromotionLadder().getGoods().getName() + ":"
										+ orderSubremark.getPromotionLadder().getGoodsNumber() + "个";
								promotionGoodsList.add(promotionGoods);
							}
						}
					}
				}
				orderList.add(order);
				postage = order.getPostage();
				sumMoney = DoubleUtil.add(sumMoney, order.getSumMoney()).toString();
				payMoney = DoubleUtil.add(payMoney, order.getPayMoney()).toString();
				subMoney = DoubleUtil.add(subMoney, order.getSubMoney()).toString();
				eticketMoney = DoubleUtil.add(eticketMoney, order.getEticketMoney()).toString();
				sumNumber = String.valueOf((Integer.parseInt(sumNumber) + Integer.parseInt(order.getSumNumber())));
			}

			subMoney = DoubleUtil.sub(subMoney, eticketMoney, 2).toString();
			if (StringUtils.isNotBlank(addressId)) {
				Address address = addressService.getAddressById(addressId);
				receiverName = address.getReceiver();
				receiverAddress = address.getContent();
				receiverPhone = address.getPhone();
			}
			setAttribute("promotionGoodsList", promotionGoodsList);
			setAttribute("receiverName", receiverName);
			setAttribute("receiverAddress", receiverAddress);
			setAttribute("receiverPhone", receiverPhone);
			setAttribute("payType", payType);
			setAttribute("sumNumber", sumNumber);
			setAttribute("postage", postage);
			setAttribute("sumMoney", sumMoney);
			setAttribute("payMoney", payMoney);
			setAttribute("subMoney", subMoney);
			setAttribute("eticketMoney", eticketMoney);
			setAttribute("eticketNumber", eticketNumber);
			setAttribute("orderList", orderList);
			setAttribute("orderIdList", orderIdList2);
			setAttribute("payMoneyAndPostage", DoubleUtil.add(payMoney, postage, 2).toString());
			Customer customer = customerService.getCustomerByEmployeeId(employeeId);
			setAttribute("customer", customer);
			setAttribute("employeeId", employeeId);
			return "module/weChat/jsp/weChat_makesure_order";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("前往订单创建界面出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 订单可用电子券
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月25日
	 * @param goodsId
	 * @param goodsAttr
	 * @param employeeId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/getUseEticketByOrderId", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson getUseEticketByOrderId(@RequestParam(value = "orderId") String orderId,
			@RequestParam(value = "employeeId") String employeeId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(employeeId)) {
				List<EticketOutRecord> EticketOutRecordList = eticketOutRecordService
						.getEticketOutListWithOrderId(orderId);
				if (null != EticketOutRecordList && 0 < EticketOutRecordList.size()) {
					ajaxJson.setObj(EticketOutRecordList);
					ajaxJson.setSuccess(true);
				} else {
					ajaxJson.setMsg("抱歉,该订单无可用优惠劵!");
					ajaxJson.setSuccess(false);
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("用户异常，请稍后重试~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_weChatController.error("绑定优惠劵出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 订单绑定电子券
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月25日
	 * @param goodsId
	 * @param goodsAttr
	 * @param employeeId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/orderUseEticket", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson orderUseEticket(@RequestParam(value = "orderId") String orderId,
			@RequestParam(value = "eticketOutCode") String eticketOutCode,
			@RequestParam(value = "employeeId") String employeeId) {
		AjaxJson ajaxJson = new AjaxJson();
		ajaxJson.setSuccess(false);
		AjaxJson ajaxJson1 = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(employeeId)) {
				ajaxJson = orderService.bindEticket(orderId, eticketOutCode);
				Map<String, Object> map = new HashMap<String, Object>();
				if (ajaxJson.isSuccess()) {
					ajaxJson1 = orderService.updatePostageByBatchCode(orderId, eticketOutCode);
					map = ajaxJson.getAttributes();
					map.putAll(ajaxJson1.getAttributes());
				}
				ajaxJson.setAttributes(map);
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("用户异常，请稍后重试~");
			}
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("绑定优惠劵出错，请重试~");
			logger_weChatController.error("绑定优惠劵出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_weChatController.error("绑定优惠劵出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 * 微信支付
	 * 
	 * @author 徐昊
	 * @date 2017年9月5日
	 * @param request
	 * @param orderIds
	 * @param employeeId
	 *            void
	 */
	@RequestMapping(value = "/doPay", method = RequestMethod.POST)
	@ResponseBody
	public void doPay(HttpServletRequest request, String orderIds, String employeeId) {
		Employee employee = employeeService.getEmployeeById(employeeId);
		List<Order> orderList = orderService.getOrderByIdString(orderIds);
		if (null != orderList && !orderList.isEmpty()) {
			String json = weChatService.getWeChatPaymentJsonWithOrder(orderList, request, employee.getOpenid(),
					weChatService.getWeChatList().get(0).getWechatnum());
			System.out.println("给页面的：：：：" + json);
			this.print(json);
		} else {
			this.print("请检查网络设置");
		}
	}

	/**
	 *
	 * <P>
	 * 余额支付
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月25日
	 * @param goodsId
	 * @param goodsAttr
	 * @param employeeId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/walletPay", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson walletPay(@RequestParam(value = "passWord") String passWord,
			@RequestParam(value = "orderIds") String orderIds, @RequestParam(value = "employeeId") String employeeId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(employeeId)) {
				Customer customer = customerService.getCustomerByEmployeeId(employeeId);
				if (null == customer || null == customer.getPayPassword()
						|| StringUtils.isBlank(customer.getPayPassword())) {
					ajaxJson.setObj("noPassword");
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("您还没有支付密码,即将跳转至密码设置页面,请稍后!");
					return ajaxJson;
				}
				List<Order> orderList = orderService.getOrderByIdString(orderIds);
				ajaxJson = orderService.walletPay(orderList, customer, passWord);
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("用户异常，请稍后重试~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_weChatController.error("保存充值记录出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 前往订单页
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月1日
	 * @param employeeId
	 * @return String
	 */
	@RequestMapping(value = "/goOrder")
	public String goOrder(@RequestParam(value = "employeeId") String employeeId,
			@RequestParam(value = "orderState") String orderState) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "orderState,employeeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			Customer customer = customerService.getCustomerByEmployeeId(employeeId);
			Map<String, List<Order>> batchCodeMap = new LinkedHashMap<>();
			List<OrderVo> orderVoList = orderService.getOrderGroupByBatchCodeByCustomerIdAndState(customer.getId(),
					orderState);
			setAttribute("orderVoList", orderVoList);
			setAttribute("orderState", orderState);
			setAttribute("customer", customer);
			setAttribute("employeeId", employeeId);
			return "module/weChat/jsp/weChat_order_whole";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("前往订单页出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 前往订单详情
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月1日
	 * @param employeeId
	 * @return String
	 */
	@RequestMapping(value = "/goOrderDetails")
	public String goOrderDetails(@RequestParam(value = "employeeId") String employeeId,
			@RequestParam(value = "orderId") String orderId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "orderId,employeeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			Order order = orderService.getOrderById(orderId);
			setAttribute("order", order);
			setAttribute("employeeId", employeeId);
			return "module/weChat/jsp/weChat_order_details";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("前往订单详情出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 前往充值界面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月2日
	 * @param consumeId
	 * @return String
	 */
	@RequestMapping(value = "/goWalletRecharge")
	public String goWalletRecharge(@RequestParam(value = "employeeId") String employeeId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "employeeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			setAttribute("backCashList", backCashService.getAll());
			setAttribute("guideUserList", userService.getGuideUserList());
			Customer customer = customerService.getCustomerByEmployeeId(employeeId);
			setAttribute("customer", customer);
			setAttribute("employeeId", employeeId);
			return "module/weChat/jsp/wechat_wallet_recharge";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("前往充值界面出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 保存充值记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月25日
	 * @param goodsId
	 * @param goodsAttr
	 * @param employeeId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveRecharge", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveRecharge(HttpServletRequest request,
			@RequestParam(value = "rechargeMoney") String rechargeMoney,
			@RequestParam(value = "guideUserId") String guideUserId,
			@RequestParam(value = "employeeId") String employeeId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(employeeId)) {
				ajaxJson = customerService.rechargeWithInline(request, employeeId, guideUserId, rechargeMoney);
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("用户异常，请稍后重试~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_weChatController.error("保存充值记录出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 前往评价界面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月2日
	 * @param consumeId
	 * @return String
	 */
	@RequestMapping(value = "/goEvaluate")
	public String goEvaluate(@RequestParam(value = "employeeId") String employeeId,
			@RequestParam(value = "orderId") String orderId, @RequestParam(value = "goodsId") String goodsId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "employeeId,orderId,goodsId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			setAttribute("goodsId", goodsId);
			Customer customer = customerService.getCustomerByEmployeeId(employeeId);
			setAttribute("customer", customer);
			setAttribute("employeeId", employeeId);
			setAttribute("orderId", orderId);
			return "module/weChat/jsp/weChat_evaluation";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("前往评价界面出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 保存评价
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月25日
	 * @param goodsId
	 * @param goodsAttr
	 * @param employeeId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveEvaluation", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveRecharge(@FormModel("model") Evaluation evaluation,
			@RequestParam(value = "orderId") String orderId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (0 >= evaluationService.doSaveEvalute(evaluation)) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("保存评价失败~");
			} else {
				Order order = orderService.getOrderById(orderId);
				if (Order.STATE_FIVE.equals(order.getState())) {
					if (0 >= orderService.updateStateFiveToSix(orderId)) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("保存评价失败~");
					} else {
						ajaxJson.setSuccess(true);
						ajaxJson.setMsg("保存评价成功!");
					}
				}
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_weChatController.error("保存评价出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 前往电子券
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月2日
	 * @param consumeId
	 * @return String
	 */
	@RequestMapping(value = "/goEticket")
	public String goEticket(@RequestParam(value = "employeeId") String employeeId) {
		this.setJsSdkMsg();
		if (!RequestParamUtil.getUrlParamIsTrue(getRequest().getParameterNames(), "employeeId")) {
			return "module/weChat/jsp/weChat_param_error";
		}
		try {
			Customer customer = customerService.getCustomerByEmployeeId(employeeId);
			List<EticketOutRecord> normalList = eticketOutRecordService.getAllByStateAndCustomerId(customer.getId(),
					EticketOutRecord.STATUS_NORMAL);
			List<EticketOutRecord> usedList = eticketOutRecordService.getAllByStateAndCustomerId(customer.getId(),
					EticketOutRecord.STATUS_USED);
			List<EticketOutRecord> failList = eticketOutRecordService.getAllByStateAndCustomerId(customer.getId(),
					EticketOutRecord.STATUS_FAIL);
			setAttribute("normalList", normalList);
			setAttribute("usedList", usedList);
			setAttribute("failList", failList);
			setAttribute("customer", customer);
			setAttribute("employeeId", employeeId);
			return "module/weChat/jsp/weChat_eticket";
		} catch (Exception e) {
			e.printStackTrace();
			logger_weChatController.error("前往电子券界面出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/weChat_404";
		}
	}

	/**
	 *
	 * <P>
	 * 确认收货
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月25日
	 * @param goodsId
	 * @param goodsAttr
	 * @param employeeId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/sendGoodsByBatchCode", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson sendGoodsByBatchCode(@RequestParam(value = "batchCode") String batchCode,
			@RequestParam(value = "employeeId") String employeeId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(employeeId)) {
				if (0 >= orderService.sendGoodsByBatchCode(batchCode)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("确认收货失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("确认收货成功!");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("用户异常，请稍后重试~");
			}
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("确认收货出错，请重试~");
			logger_weChatController.error("确认收货出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_weChatController.error("确认收货出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 确认支付金额大于0
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月25日
	 * @param goodsId
	 * @param goodsAttr
	 * @param employeeId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/selectINLinePayMoneyZero", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson selectINLinePayMoneyZero(@RequestParam(value = "orderIds") String orderIds,
			@RequestParam(value = "employeeId") String employeeId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(employeeId)) {
				List<Order> orderList = orderService.getOrderByIdString(orderIds);
				Customer customer = customerService.getCustomerByEmployeeId(employeeId);
				int i = 0;
				if (null != orderList && 0 < orderList.size()) {
					String inLinePayMoney = "0";
					for (Order order : orderList) {
						inLinePayMoney = DoubleUtil.add(order.getInLinePayMoney(), order.getPostage()).toString();
						if (0 >= DoubleUtil.compareTo(inLinePayMoney, "0")) {
							i++;
						}
					}
					if (0 >= i) {
						ajaxJson.setSuccess(true);
						ajaxJson.setObj("true");
						return ajaxJson;
					} else {
						ajaxJson = orderService.zeroPay(orderList, customer);
					}

				} else {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("订单获取失败!");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("用户异常，请稍后重试~");
			}
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("确认收货出错，请重试~");
			logger_weChatController.error("确认收货出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_weChatController.error("确认收货出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 余额支付
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月25日
	 * @param goodsId
	 * @param goodsAttr
	 * @param employeeId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/walletPayIsHavePassword", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson walletPayIsHavePassword(@RequestParam(value = "employeeId") String employeeId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(employeeId)) {
				Customer customer = customerService.getCustomerByEmployeeId(employeeId);
				if (null == customer || null == customer.getPayPassword()
						|| StringUtils.isBlank(customer.getPayPassword())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("您还没有支付密码,即将跳转至密码设置页面,请稍后!");
					ajaxJson.setObj("noPassword");
					return ajaxJson;
				} else {
					ajaxJson.setSuccess(true);
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("用户异常，请稍后重试~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_weChatController.error("保存充值记录出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 跳转到分享链接
	 * </p>
	 *
	 * @author 闫枫
	 * @date Oct 12, 2017
	 * @param response
	 * @return String
	 */
	@RequestMapping(value = "/goCompanyIndex")
	public String goCompanyIndex(HttpServletResponse response) {
		try {
			WeChat weChat = weChatService.getWeChatList().get(0);
			response.sendRedirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + weChat.getAppid()
					+ "&redirect_uri=" + weChat.getDomainName()
					+ "/platform/weChat/weChatIndex&response_type=code&scope=snsapi_userinfo&state="
					+ weChat.getWechatnum() + "#wechat_redirect");
			return "";
		} catch (Exception e) {
			logger_weChatController.error("跳转到分享链接--出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			return "module/weChat/jsp/404";
		}
	}

	/**
	 *
	 * <P>
	 * 页面分享拦截必要参数设置
	 * </p>
	 *
	 * @author 闫枫
	 * @date Oct 12, 2017 void
	 */
	private void setJsSdkMsg() {
		try {
			WeChat weChat = weChatService.getWeChatList().get(0);
			setAttribute("ticket", TicketManager.getTicket(weChat.getAppid()));
			setAttribute("appId", weChat.getAppid());
			setAttribute("timeStamp", new Date().getTime() + "");
			setAttribute("nonceStr", "Wm3WZYTPz0wzccnW");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}