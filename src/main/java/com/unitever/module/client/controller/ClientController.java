package com.unitever.module.client.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.auth.user.service.UserService;
import com.unitever.module.cashierUserLoginAndLogout.service.CashierUserLoginAndLogoutServices;
import com.unitever.module.client.service.ClientShoppingcartService;
import com.unitever.module.customer.service.CustomerService;
import com.unitever.module.goods.service.GoodsService;
import com.unitever.module.order.model.Order;
import com.unitever.module.order.service.OrderService;
import com.unitever.module.rechargeRecord.service.RechargeRecordService;
import com.unitever.module.store.service.StoreService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.DateUtil;
import com.unitever.platform.util.ExceptionUtil;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.client.controller->ClientController.java
 * </p>
 * <P>
 * 客户端controller
 * </p>
 *
 * @author 闫枫
 * @date Jul 19, 2017
 */
@Controller
@RequestMapping(value = "/client")
public class ClientController extends SpringController {

	@Autowired
	private UserService userService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private ClientShoppingcartService clientShoppingcartService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private CustomerService customerService;
	@Autowired
	private RechargeRecordService rechargeRecordService;
	@Autowired
	private StoreService storeService;
	@Autowired
	private CashierUserLoginAndLogoutServices cashierUserLoginAndLogoutServices;

	private Logger logger_clientController = LoggerFactory.getLogger("ClientController");

	/**
	 *
	 * <P>
	 * 客户端登录-验证账号密码是否正确，正确时返回用户信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 19, 2017 void
	 */
	@RequestMapping(value = "/ajaxValidationUser", method = RequestMethod.POST)
	@ResponseBody
	public String ajaxValidationUser(@RequestParam(value = "username") String username,
			@RequestParam(value = "password") String password,
			@RequestParam(value = "cashierCode") String cashierCode) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			ajaxJson = userService.validationUserByClient(username, password, cashierCode);
			return ajaxJson.getJsonStr();
		} catch (Error e) {
			logger_clientController.error("客户端登录-验证账号密码是否正确--出错，具体错误如下：" + e.getMessage());
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("登录失败，服务器内部错误，请重试~");
		} catch (Exception e) {
			logger_clientController.error("客户端登录-验证账号密码是否正确--出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("登录失败，服务器内部错误，请重试~");
		}
		return ajaxJson.getJsonStr();
	}

	/**
	 *
	 * <P>
	 * 客户端添加到购物车
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 22, 2017
	 * @param qrcodeId
	 *            产品二维码ID（由客户端扫码枪扫码获得）
	 * @param type
	 *            类型（1：卖出，2：退回。ps:卖出在卖出、换货单出现，退回在退货单和换货单中出现）
	 * @param userId
	 *            收银员ID
	 * @return String
	 */
	@RequestMapping(value = "/addClientGoods", method = RequestMethod.POST)
	@ResponseBody
	public String addClientGoods(@RequestParam(value = "qrcodeId") String qrcodeId,
			@RequestParam(value = "type") String type, @RequestParam(value = "userId") String userId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			ajaxJson = clientShoppingcartService.addClientGoods(qrcodeId, type, userId);
			return ajaxJson.getJsonStr();
		} catch (Error e) {
			logger_clientController.error("客户端添加到购物车--出错，具体错误如下：" + e.getMessage());
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("添加商品失败，请联系技术人员~");
		} catch (Exception e) {
			logger_clientController.error(
					" 客户端添加到购物车--出错，具体错误如下：" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("添加商品失败，服务器内部错误，请重试~");
		}
		return ajaxJson.getJsonStr();
	}

	/**
	 *
	 * <P>
	 * 客户端获取订单信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 23, 2017
	 * @param orderCode
	 * @return String
	 */
	@RequestMapping(value = "/getTianheOrderByOrderCode", method = RequestMethod.POST)
	@ResponseBody
	public String getTianheOrderByOrderCode(@RequestParam(value = "orderCode") String orderCode,
			@RequestParam(value = "cashierCode") String cashierCode,
			@RequestParam(value = "cashierUser_id") String cashierUser_id) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			ajaxJson = orderService.getClientOrderByOrderCode(orderCode, cashierCode, cashierUser_id);
			return ajaxJson.getJsonStr();
		} catch (Error e) {
			logger_clientController.error("客户端获取订单--出错，具体错误如下：" + e.getMessage());
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("获取订单失败失败，请联系技术人员~");
		} catch (Exception e) {
			logger_clientController.error(
					" 客户端获取订单--出错，具体错误如下：" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("获取订单失败，服务器内部错误，请重试~");
		}
		return ajaxJson.getJsonStr();
	}

	/**
	 *
	 * <P>
	 * 接收客户端订单支付成功通知
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 12, 2017
	 * @param orderId
	 *            订单Id
	 * @param cashierUserId
	 *            收银员ID
	 * @param cashierCode
	 *            款台号
	 * @param payType
	 *            支付方式
	 * @param customerId
	 *            客户Id
	 * @param payCode
	 *            微信或支付宝支付交易流水号
	 * @param customerPayCode
	 *            天和钱包支付动态密码
	 * @param getMoney
	 *            现金或银行卡刷卡支付实付金额
	 * @return String
	 */
	@RequestMapping(value = "/orderPaySuccess", method = RequestMethod.POST)
	@ResponseBody
	public String orderPaySuccess(@RequestParam(value = "orderId") String orderId,
			@RequestParam(value = "cashierUserId") String cashierUserId,
			@RequestParam(value = "cashierCode") String cashierCode,
			@RequestParam(value = "payType", required = false) String payType,
			@RequestParam(value = "customerId", required = false) String customerId,
			@RequestParam(value = "payCode", required = false) String payCode,
			@RequestParam(value = "customerPayCode", required = false) String customerPayCode,
			@RequestParam(value = "getMoney", required = false) String getMoney) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			ajaxJson = orderService.orderPaySuccess(orderId, cashierUserId, cashierCode, payType, customerId,
					customerPayCode, payCode, false, getMoney);
			return ajaxJson.getJsonStr();
		} catch (Error e) {
			logger_clientController.error("确认支付失败--出错，具体错误如下：" + e.getMessage());
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("确认支付失败，请联系技术人员~");
		} catch (Exception e) {
			logger_clientController.error(
					" 确认支付失败--出错，具体错误如下：" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("确认支付失败，请联系技术人员~");
		}
		return ajaxJson.getJsonStr();
	}

	/**
	 *
	 * <P>
	 * 发送天和钱包支付动态密码
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 23, 2017
	 * @param orderCode
	 * @return String
	 */
	@RequestMapping(value = "/sendCustomerPayCode", method = RequestMethod.POST)
	@ResponseBody
	public String sendCustomerPayCode(@RequestParam(value = "customerPhone") String customerPhone) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			ajaxJson = customerService.sendCustomerPayCode(customerPhone);
			return ajaxJson.getJsonStr();
		} catch (Error e) {
			logger_clientController.error("发送天和钱包支付动态密码--出错，具体错误如下：" + e.getMessage());
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("发送天和钱包支付动态密码失败，请联系技术人员~");
		} catch (Exception e) {
			logger_clientController.error(" 发送天和钱包支付动态密码--出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("发送天和钱包支付动态密码失败，请联系技术人员~");
		}
		return ajaxJson.getJsonStr();
	}

	/**
	 *
	 * <P>
	 * 创建线下充值预定单（现金和银行卡pos支付方式直接完成）
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 10, 2017
	 * @param customerId
	 *            充值客户ID
	 * @param money
	 *            充值金额
	 * @param cashierUserId
	 *            收银ID
	 * @param cashierCode
	 *            款台号
	 * @param rechargeCode
	 *            充值动态密码
	 * @param payType
	 *            支付方式
	 * @return String
	 */
	@RequestMapping(value = "/createOffLineRechargeRecord", method = RequestMethod.POST)
	@ResponseBody
	public String createOffLineRechargeRecord(@RequestParam(value = "customerId") String customerId,
			@RequestParam(value = "money") String money, @RequestParam(value = "cashierUserId") String cashierUserId,
			@RequestParam(value = "cashierCode") String cashierCode,
			@RequestParam(value = "rechargeCode") String rechargeCode,
			@RequestParam(value = "payType") String payType) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			ajaxJson = rechargeRecordService.createOffLineRechargeRecord(customerId, money, cashierUserId, cashierCode,
					rechargeCode, payType);
			return ajaxJson.getJsonStr();
		} catch (Error e) {
			logger_clientController.error("创建线下充值预定单--出错，具体错误如下：" + e.getMessage());
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("创建线下充值预定单失败，请联系技术人员~");
		} catch (Exception e) {
			logger_clientController.error(
					"创建线下充值预定单--出错，具体错误如下：" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("创建线下充值预定单失败，请联系技术人员~");
		}
		return ajaxJson.getJsonStr();
	}

	/**
	 *
	 * <P>
	 * 充值单支付完成回调
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 10, 2017
	 * @param rechargeId
	 *            充值预定单ID
	 * @param payType
	 *            支付方式
	 * @param payCode
	 *            微信或支付宝支付交易单号
	 * @return String
	 */
	@RequestMapping(value = "/rechargePaySuccess", method = RequestMethod.POST)
	@ResponseBody
	public String rechargePaySuccess(@RequestParam(value = "rechargeId") String rechargeId,
			@RequestParam(value = "payType") String payType, @RequestParam(value = "payCode") String payCode) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			rechargeRecordService.rechargePaySuccess(rechargeId, null, null, payType, payCode);
			return ajaxJson.getJsonStr();
		} catch (Error e) {
			logger_clientController.error("确认充值成功--出错，具体错误如下：" + e.getMessage());
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("确认充值完成出错，请联系技术人员~");
		} catch (Exception e) {
			logger_clientController.error(
					"确认充值成功--出错，具体错误如下：" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("确认充值完成出错，请联系技术人员~");
		}
		return ajaxJson.getJsonStr();
	}

	/**
	 *
	 * <P>
	 * 获取要打印订单信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 11, 2017
	 * @param printOrderId
	 *            要打印订单Id
	 * @return String
	 */
	@RequestMapping(value = "/getPrintOrderByPrintOrderId", method = RequestMethod.POST)
	@ResponseBody
	public String getPrintOrderByPrintOrderId(@RequestParam(value = "printOrderId") String printOrderId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			ajaxJson = orderService.getPrintOrderByPrintOrderId(printOrderId);
			return ajaxJson.getJsonStr();
		} catch (Error e) {
			logger_clientController.error("获取要打印订单信息--出错，具体错误如下：" + e.getMessage());
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("获取要打印订单信息出错，请联系技术人员~");
		} catch (Exception e) {
			logger_clientController.error(
					"获取要打印订单信息--出错，具体错误如下：" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("获取要打印订单信息出错，请联系技术人员~");
		}
		return ajaxJson.getJsonStr();
	}

	/**
	 *
	 * <P>
	 * 客户端获取门店信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 11, 2017
	 * @param storeCode
	 *            门店code
	 * @return String
	 */
	@RequestMapping(value = "/getStoreMsg", method = RequestMethod.POST)
	@ResponseBody
	public String getStoreMsg(@RequestParam(value = "storeCode") String storeCode) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			ajaxJson = storeService.getClisentStoreMsgByStoreCode(storeCode);
			return ajaxJson.getJsonStr();
		} catch (Error e) {
			logger_clientController.error("客户端获取门店信息--出错，具体错误如下：" + e.getMessage());
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("获取门店信息出错，请联系技术人员~");
		} catch (Exception e) {
			logger_clientController.error(
					"客户端获取门店信息--出错，具体错误如下：" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("获取门店信息失败了，请联系技术人员~");
		}
		return ajaxJson.getJsonStr();
	}

	/**
	 *
	 * <P>
	 * 客户端获取客户信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 11, 2017
	 * @param storeCode
	 *            门店code
	 * @return String
	 */
	@RequestMapping(value = "/getCustomerMsg", method = RequestMethod.POST)
	@ResponseBody
	public String getCustomerMsg(@RequestParam(value = "customerPhone") String customerPhone) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			ajaxJson = customerService.getClisentCustomerMsgByPhone(customerPhone);
			return ajaxJson.getJsonStr();
		} catch (Error e) {
			logger_clientController.error("客户端获取门店信息--出错，具体错误如下：" + e.getMessage());
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("获取门店信息出错，请联系技术人员~");
		} catch (Exception e) {
			logger_clientController.error(
					"客户端获取门店信息--出错，具体错误如下：" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("获取门店信息失败了，请联系技术人员~");
		}
		return ajaxJson.getJsonStr();
	}

	/**
	 *
	 * <P>
	 * 保存客户端订单信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 13, 2017
	 * @param order
	 *            待保存订单信息
	 * @param upOrderCode
	 *            上单Code
	 * @return String
	 */
	@RequestMapping(value = "/createOrderNoTianhe", method = RequestMethod.POST)
	@ResponseBody
	public String createOrderNoTianhe(@FormModel(value = "model") Order order,
			@RequestParam(value = "upOrderCode", required = false) String upOrderCode) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			ajaxJson = orderService.saveClientOrder(order, upOrderCode);
			if (ajaxJson.isSuccess()) {
				if ("returnMoney".equals(ajaxJson.getMsg())) {
					ajaxJson = orderService
							.returnMoneyAll(orderService.getOrderById(String.valueOf(ajaxJson.getObj())));
				}
			}
			return ajaxJson.getJsonStr();
		} catch (Error e) {
			logger_clientController.error("保存客户端订单信息--出错，具体错误如下：" + e.getMessage());
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("保存订单失败，请联系技术人员~");
		} catch (Exception e) {
			logger_clientController.error(
					"保存客户端订单信息--出错，具体错误如下：" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("保存订单失败，请联系技术人员~");
		}
		return ajaxJson.getJsonStr();
	}

	/**
	 *
	 * <P>
	 * 客户端--商家店订单--绑定电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 13, 2017
	 * @param order
	 *            待保存订单信息
	 * @param upOrderCode
	 *            上单Code
	 * @return String
	 */
	@RequestMapping(value = "/bindEticket", method = RequestMethod.POST)
	@ResponseBody
	public String bindEticket(@RequestParam(value = "orderId") String orderId,
			@RequestParam(value = "eticketCode") String eticketCode) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			ajaxJson = orderService.bindEticket(orderId, eticketCode);
			return ajaxJson.getJsonStr();
		} catch (Error e) {
			logger_clientController.error("客户端--商家店订单--绑定电子券--出错，具体错误如下：" + e.getMessage());
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("绑定电子券失败，请联系技术人员~");
		} catch (Exception e) {
			logger_clientController.error("客户端--商家店订单--绑定电子券--出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("绑定电子券失败，请联系技术人员~");
		}
		return ajaxJson.getJsonStr();
	}

	/**
	 *
	 * <P>
	 * 客户端--商家店订单--绑定叠加活动
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 13, 2017
	 * @param order
	 *            待保存订单信息
	 * @param upOrderCode
	 *            上单Code
	 * @return String
	 */
	@RequestMapping(value = "/bindNoScopeGroup", method = RequestMethod.POST)
	@ResponseBody
	public String bindNoScopeGroup(@RequestParam(value = "orderId") String orderId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			orderService.bindNoScopeGroup(orderId);
			return ajaxJson.getJsonStr();
		} catch (Error e) {
			logger_clientController.error("客户端--商家店订单--绑定叠加活动--出错，具体错误如下：" + e.getMessage());
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("服务器内部错误，请联系技术人员~");
		} catch (Exception e) {
			logger_clientController.error("客户端--商家店订单--绑定叠加活动--出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("服务器内部错误，请联系技术人员~");
		}
		return ajaxJson.getJsonStr();
	}

	/**
	 *
	 * <P>
	 * 客户端--获取交接班信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 13, 2017
	 * @param order
	 *            待保存订单信息
	 * @param upOrderCode
	 *            上单Code
	 * @return String
	 */
	@RequestMapping(value = "/getSubmitMoneyMsg", method = RequestMethod.POST)
	@ResponseBody
	public String getSubmitMoneyMsg(@RequestParam(value = "userId") String userId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			ajaxJson = cashierUserLoginAndLogoutServices.getSubmitMoneyMsg(userId);
			return ajaxJson.getJsonStr();
		} catch (Error e) {
			logger_clientController.error("客户端--获取交接班信息--出错，具体错误如下：" + e.getMessage());
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("服务器内部错误，请联系技术人员~");
		} catch (Exception e) {
			logger_clientController.error("客户端--获取交接班信息--出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("服务器内部错误，请联系技术人员~");
		}
		return ajaxJson.getJsonStr();
	}

	/**
	 *
	 * <P>
	 * 客户端--获取交接班信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 13, 2017
	 * @param order
	 *            待保存订单信息
	 * @param upOrderCode
	 *            上单Code
	 * @return String
	 */
	@RequestMapping(value = "/hello", method = RequestMethod.POST)
	@ResponseBody
	public void hello(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		try {
			BufferedReader in = new BufferedReader(new InputStreamReader(request.getInputStream(), "gb2312"));
			StringBuilder sb = new StringBuilder();
			String line = null;
			while ((line = in.readLine()) != null) {
				sb.append(line);
			}
			System.err.println(DateUtil.getCurrDateMillisecondString() + "::::" + sb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}