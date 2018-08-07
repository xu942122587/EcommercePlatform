package com.unitever.module.order.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.auth.user.service.UserService;
import com.unitever.module.customer.model.Customer;
import com.unitever.module.goods.service.GoodsService;
import com.unitever.module.order.model.Order;
import com.unitever.module.order.service.OrderService;
import com.unitever.module.orderGoods.model.OrderGoods;
import com.unitever.module.orderGoods.service.OrderGoodsService;
import com.unitever.module.orderGoodsQrcode.model.OrderGoodsQrcode;
import com.unitever.module.promotionGroup.service.PromotionGroupService;
import com.unitever.module.qrcode.model.Qrcode;
import com.unitever.module.qrcode.service.QrcodeService;
import com.unitever.module.qrcode.vo.QrcodeVO;
import com.unitever.module.weChat.service.WeChatService;
import com.unitever.module.weChat.util.WeChatUtil;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.external.UserUtil;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.DoubleUtil;
import com.unitever.platform.util.ExceptionUtil;
import com.unitever.platform.util.ThreadPoolUtil;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.order.controller->OrderController. java
 * </p>
 * <P>
 * 订单
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月4日
 */
@Controller
@RequestMapping(value = "/order")
public class OrderController extends SpringController {

	@Autowired
	private OrderService orderService;
	@Autowired
	private UserService userService;
	@Autowired
	private WeChatService weChatService;
	@Autowired
	private QrcodeService qrcodeService;
	@Autowired
	private OrderGoodsService orderGoodsService;
	@Autowired
	private PromotionGroupService promotionGroupService;
	@Autowired
	private GoodsService goodsService;

	private Logger logger_orderController = LoggerFactory.getLogger("OrderController");

	/**
	 *
	 * <P>
	 * 跳转到换购页
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 9, 2017
	 * @return String
	 */
	@RequestMapping(value = "/changeEnoughOrderInput", method = RequestMethod.GET)
	public String changeEnoughOrderInput(@RequestParam(value = "orderCode", required = false) String orderCode) {
		setAttribute("orderCode", orderCode);
		if (StringUtils.isNotBlank(orderCode)) {
			setAttribute("model", orderService.getPaySuccessOrderByOrderCode(orderCode));
			setAttribute("changeEnoughGoodsList", goodsService.getChangeEnoughGoodsListByOrderCode(orderCode));
		}
		return "module/order/order-changeEnoughInput";
	}

	/**
	 *
	 * <P>
	 * 跳转到录入电子券页面（线下订单可跳转）
	 * </p>
	 * 
	 * @author 闫枫
	 * @date Sep 8, 2017
	 * @param orderId
	 *            主订单ID
	 * @return String
	 */
	@RequestMapping(value = "/goAddEticket", method = RequestMethod.GET)
	public String goAddEticket(@RequestParam(value = "orderId") String orderId) {
		if (StringUtils.isNotBlank(orderId)) {
			setAttribute("model", orderService.getOrderById(orderId));
		}
		return "module/order/order-addEticket";
	}

	/**
	 *
	 * <P>
	 * 线下订单绑定电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 10, 2017
	 * @param order
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/bindEticket", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson bindEticket(@RequestParam(value = "orderId") String orderId,
			@RequestParam(value = "eticketOutCode") String eticketOutCode) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			ajaxJson = orderService.bindEticket(orderId, eticketOutCode);
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲，服务器出错了，请稍后再试~");
			logger_orderController.error("线下订单绑定电子券--出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲，服务器出错了，请稍后再试~");
			logger_orderController.error("线下订单绑定电子券--出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 跳转到换购发货页
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 9, 2017
	 * @return String
	 */
	@RequestMapping(value = "/changeEnoughDelivery", method = RequestMethod.GET)
	public String changeEnoughDelivery(@RequestParam(value = "id", required = false) String id) {
		setAttribute("model", orderService.getOrderById(id));
		return "module/order/order-changeEnoughDelivery";
	}

	/**
	 *
	 * <P>
	 * 保存换购订单
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 4, 2017
	 * @param order
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveChangeEnough", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveChangeEnough(@FormModel(value = "model") Order order) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isBlank(order.getId())) {
				ajaxJson = orderService.saveChangeEnough(order);
			} else {
				Order order_by_get = orderService.getOrderById(order.getId());
				if (!order_by_get.getQrcodeCount().equals(order_by_get.getSumNumber())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("发货数量不足订单预约数量，请确认~");
					return ajaxJson;
				} else {
					order_by_get.setState(Order.STATE_SIX);
					if (0 >= orderService.update(order_by_get)) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("保存换购单失败，请稍后重试！");
					}
				}
			}
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("保存换购单失败，请重试~");
			logger_orderController.error("保存换购单出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("保存换购单失败，请重试~");
			logger_orderController.error("订单添加发货二维码--出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;

	}

	/**
	 *
	 * <P>
	 * 打印换购小票
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 31, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/changeEnoughPrintView", method = RequestMethod.GET)
	public String changeEnoughPrintView(@RequestParam(value = "id") String id) {
		setAttribute("model", orderService.getOrderById(id));
		return "module/order/order-changeEnoughPrintView";
	}

	/**
	 *
	 * <P>
	 * 跳转至换购单列表页面
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 5, 2017
	 * @param page
	 * @param order
	 * @return String
	 */
	@RequestMapping(value = "/changeEnoughList")
	public String changeEnoughList(@FormModel("page") Page<Order> page, @FormModel("model") Order order) {
		if (null != UserUtil.getCurrUser().getStore()
				&& StringUtils.isNotBlank(UserUtil.getCurrUser().getStore().getId())) {
			order.setStore(UserUtil.getCurrUser().getStore());
		}
		order.setType(Order.TYPE_THREE);
		setAttribute("pageObj", orderService.getSameChangePage(page, order));
		setAttribute("model", order);
		return "module/order/order-changeEnoughList";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看换购单
	 * </p>
	 * 
	 * @author 闫枫
	 * @date Sep 5, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/changeEnoughView", method = RequestMethod.GET)
	public String changeEnoughView(@RequestParam(value = "id", required = false) String id) {
		setAttribute("model", orderService.getOrderById(id));
		return "module/order/order-changeEnoughView";
	}

	/**
	 *
	 * <P>
	 * 跳转到发放赠品页面
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 9, 2017
	 * @return String
	 */
	@RequestMapping(value = "/putOutGoods", method = RequestMethod.GET)
	public String putOutGoods(@RequestParam(value = "orderCode", required = false) String orderCode) {
		setAttribute("orderCode", orderCode);
		if (StringUtils.isNotBlank(orderCode)) {
			setAttribute("model", orderService.getPaySuccessOrderByOrderCode(orderCode));
			setAttribute("putOutGoodsList", goodsService.getPutOutGoodsListByOrderCode(orderCode));
			setAttribute("putOutQrcodeList", qrcodeService.getPutOutQrcodeListByOrderCode(orderCode));
		}
		return "module/order/order-putOutGoods";
	}

	/**
	 *
	 * <P>
	 * 发放赠品
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 1, 2017
	 * @param orderId
	 *            订单ID
	 * @param QRCodeID
	 *            二维码ID
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/orderAddPutOutGoods", method = RequestMethod.POST)
	// TODO
	@ResponseBody
	public AjaxJson orderAddPutOutGoods(@RequestParam(value = "orderId") String orderId,
			@RequestParam(value = "QRCodeID") String QRCodeID) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			ajaxJson = orderService.orderAddPutOutGoods(orderId, QRCodeID);
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("录入赠品二维码失败，请重试~");
			logger_orderController.error("录入赠品二维码出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("录入赠品二维码失败，请重试~");
			logger_orderController.error("录入赠品二维码--出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除赠品发放
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 1, 2017
	 * @param orderId
	 *            订单ID
	 * @param QRCodeID
	 *            二维码ID
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/orderDeletePutOutGoods", method = RequestMethod.POST)
	@ResponseBody
	// TODO
	public AjaxJson orderDeletePutOutGoods(@RequestParam(value = "orderId") String orderId,
			@RequestParam(value = "QRCodeID") String QRCodeID) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			ajaxJson = orderService.orderDeletePutOutGoods(orderId, QRCodeID);
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("删除赠品发放失败，请重试~");
			logger_orderController.error("删除赠品发放出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("删除赠品发放失败，请重试~");
			logger_orderController.error("删除赠品发放二维码--出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 跳转至订单列表页面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param page
	 * @param order
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<Order> page, @FormModel("model") Order order,
			@RequestParam(value = "pageName", required = false) String pageName) {
		if (null != UserUtil.getCurrUser().getStore()
				&& StringUtils.isNotBlank(UserUtil.getCurrUser().getStore().getId())) {
			order.setStore(UserUtil.getCurrUser().getStore());
		}
		setAttribute("pageObj", orderService.getPage(page, order));
		setAttribute("model", order);
		setAttribute("pageName", pageName);
		return "module/order/order-list";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看订单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam(value = "id", required = false) String id) {
		Order order = orderService.getOrderById(id);
		setAttribute("model", order);
		setAttribute("orderCode", order.getCode());
		setAttribute("putOutQrcodeList", qrcodeService.getPutOutQrcodeListByOrderCode(order.getCode()));

		/*
		 * if (Order.TYPE_THREE.equals(order.getType())) { setAttribute("model",
		 * orderService.getFinishOrderByOrderCode(order.getCode()));
		 * setAttribute("putOutGoodsList",
		 * goodsService.getPutOutGoodsListByOrderCode(order.getCode())); }
		 */

		return "module/order/order-view";
	}

	/**
	 *
	 * <P>
	 * 跳转到开具购物小票页面
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 9, 2017
	 * @return String
	 */
	@RequestMapping(value = "/saleOrderInput", method = RequestMethod.GET)
	public String saleOrderInput(@RequestParam(value = "isOptions", required = false) String isOptions) {
		setAttribute("isOptions", isOptions);
		setAttribute("storeUserList", userService.getUserListByStoreId(UserUtil.getCurrUser().getStore().getId()));
		setAttribute("proGroupPayTypes",
				promotionGroupService.getProGroupPayTypesByStoreId(UserUtil.getCurrUser().getStore().getId()));
		return "module/order/order-saleOrderInput";
	}

	/**
	 *
	 * <P>
	 * 线下订单绑定电子券后调起发放叠加级换购活动
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 10, 2017
	 * @param order
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/bindNoScopeGroup", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson bindNoScopeGroup(@RequestParam(value = "orderId") String orderId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			orderService.bindNoScopeGroup(orderId);
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲，服务器出错了，请稍后再试~");
			logger_orderController.error("线下订单绑定电子券后调起发放叠加级换购活动--出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲，服务器出错了，请稍后再试~");
			logger_orderController.error("线下订单绑定电子券后调起发放叠加级换购活动--出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 保存导购开票信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 10, 2017
	 * @param order
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveSaleOrderInpute", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveSaleOrderInpute(@FormModel(value = "model") Order order) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			ajaxJson = orderService.saveSaleOrderInpute(order);
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲，保存订单失败了，可能原因：某二维码已被其他地区锁定或已卖出~或者稍后重试哦");
			logger_orderController.error("保存订单信息出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲，保存订单失败了，可能原因：某二维码已被其他地区锁定或已卖出~或者稍后重试哦");
			logger_orderController.error("保存订单信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 跳转到开具预约小票页面
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 9, 2017
	 * @return String
	 */
	@RequestMapping(value = "/reserveOrderInput", method = RequestMethod.GET)
	public String reserveOrderInput(@RequestParam(value = "isOptions", required = false) String isOptions,
			@RequestParam(value = "orderId", required = false) String orderId) {
		setAttribute("isOptions", isOptions);
		if (StringUtils.isNotBlank(orderId))
			setAttribute("model", orderService.getOrderById(orderId));
		if (StringUtils.isBlank(orderId)) {
			setAttribute("storeUserList", userService.getUserListByStoreId(UserUtil.getCurrUser().getStore().getId()));
			setAttribute("proGroupPayTypes",
					promotionGroupService.getProGroupPayTypesByStoreId(UserUtil.getCurrUser().getStore().getId()));
			setAttribute("goodsList", goodsService.getGoodsByStoreId(UserUtil.getCurrUser().getStore().getId()));
		}
		return "module/order/order-reserveOrderInput";
	}

	/**
	 *
	 * <P>
	 * 保存导购开票信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 10, 2017
	 * @param order
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveReserveOrderInpute", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveReserveOrderInpute(@FormModel(value = "model") Order order) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isBlank(order.getId())) {
				ajaxJson = orderService.saveReserveOrderInpute(order);
			} else {
				ajaxJson = orderService.reserveOrderUpdate(order);
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲，保存订单失败了，可能原因：某二维码已被其他地区锁定或已卖出~或者稍后重试哦");
			logger_orderController.error("保存订单信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 订单添加发货二维码
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 1, 2017
	 * @param orderId
	 *            订单ID
	 * @param QRCodeID
	 *            二维码ID
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/receiverAddQrcode", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson orderAddQrcode(@RequestParam(value = "orderId") String orderId,
			@RequestParam(value = "QRCodeID") String QRCodeID) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			ajaxJson = orderService.orderAddQrcode(orderId, QRCodeID);
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试");
			logger_orderController.error("订单添加发货二维码--出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("录入发货二维码失败，请重试~");
			logger_orderController.error("订单添加发货二维码--出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 订单删除发货二维码
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 1, 2017
	 * @param orderId
	 *            订单ID
	 * @param QRCodeID
	 *            二维码ID
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/receiverDeleteQrcode", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson receiverDeleteQrcode(@RequestParam(value = "orderId") String orderId,
			@RequestParam(value = "QRCodeID") String QRCodeID) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			ajaxJson = orderService.orderDeleteQrcode(orderId, QRCodeID);
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试");
			logger_orderController.error("订单删除发货二维码--出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("录入发货二维码失败，请重试~");
			logger_orderController.error("订单删除发货二维码--出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 同商品换货列表页面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param page
	 * @param order
	 * @return String
	 */
	@RequestMapping(value = "/sameChangeList")
	public String sameChangeList(@FormModel("page") Page<Order> page, @FormModel("model") Order order) {
		if (null != UserUtil.getCurrUser().getStore()
				&& StringUtils.isNotBlank(UserUtil.getCurrUser().getStore().getId())) {
			order.setStore(UserUtil.getCurrUser().getStore());
		}
		order.setType(Order.TYPE_SEVEN);
		setAttribute("pageObj", orderService.getSameChangePage(page, order));
		setAttribute("model", order);
		return "module/order/order-sameChangeList";
	}

	/**
	 *
	 * <P>
	 * 换货列表页面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param page
	 * @param order
	 * @return String
	 */
	@RequestMapping(value = "/changeList")
	public String changeList(@FormModel("page") Page<Order> page, @FormModel("model") Order order) {
		if (null != UserUtil.getCurrUser().getStore()
				&& StringUtils.isNotBlank(UserUtil.getCurrUser().getStore().getId())) {
			order.setStore(UserUtil.getCurrUser().getStore());
		}
		order.setType(Order.TYPE_SIX);
		setAttribute("pageObj", orderService.getSameChangePage(page, order));
		setAttribute("model", order);
		return "module/order/order-changeList";
	}

	/**
	 *
	 * <P>
	 * 退货列表页面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param page
	 * @param order
	 * @return String
	 */
	@RequestMapping(value = "/returnList")
	public String returnList(@FormModel("page") Page<Order> page, @FormModel("model") Order order) {
		if (null != UserUtil.getCurrUser().getStore()
				&& StringUtils.isNotBlank(UserUtil.getCurrUser().getStore().getId())) {
			order.setStore(UserUtil.getCurrUser().getStore());
		}
		order.setType(Order.TYPE_FIVE);
		setAttribute("pageObj", orderService.getSameChangePage(page, order));
		setAttribute("model", order);
		return "module/order/order-returnList";
	}

	/**
	 *
	 * <P>
	 * 赔偿列表页面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param page
	 * @param order
	 * @return String
	 */
	@RequestMapping(value = "/reparationList")
	public String reparationList(@FormModel("page") Page<Order> page, @FormModel("model") Order order) {
		if (null != UserUtil.getCurrUser().getStore()
				&& StringUtils.isNotBlank(UserUtil.getCurrUser().getStore().getId())) {
			order.setStore(UserUtil.getCurrUser().getStore());
		}
		order.setType(Order.TYPE_EIGHT);
		setAttribute("pageObj", orderService.getSameChangePage(page, order));
		setAttribute("model", order);
		return "module/order/order-reparationList";
	}

	/**
	 *
	 * <P>
	 * 跳转至添加同商品换货
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/sameChangeInput", method = RequestMethod.GET)
	public String sameChangeInput(@RequestParam(value = "qrcodeId") String qrcodeId,
			@RequestParam(value = "orderId") String orderId) {

		setAttribute("order", orderService.getOrderById(orderId));
		setAttribute("qrcode", qrcodeService.getQrcodeById(qrcodeId));
		return "module/order/order-sameChangeInput";
	}

	/**
	 *
	 * <P>
	 * 跳转至添加换货
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/changeInput", method = RequestMethod.GET)
	public String changeInput() {
		return "module/order/order-changeInput";
	}

	/**
	 *
	 * <P>
	 * 跳转至添加换货
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/returnInput", method = RequestMethod.GET)
	public String returnInput() {
		return "module/order/order-returnInput";
	}

	/**
	 *
	 * <P>
	 * 跳转至添加赔偿
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/reparationInput", method = RequestMethod.GET)
	public String reparationInput() {
		return "module/order/order-reparationInput";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看同商品换货单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/sameChangeView", method = RequestMethod.GET)
	public String sameChangeView(@RequestParam(value = "id") String id) {

		setAttribute("model", orderService.getOrderById(id));
		setAttribute("orderGoodsList", orderGoodsService.getAllByOrderId(id));
		return "module/order/order-sameChangeView";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看商品换货单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/changeView", method = RequestMethod.GET)
	public String changeView(@RequestParam(value = "id") String id) {

		setAttribute("model", orderService.getOrderById(id));
		setAttribute("orderGoodsList", orderGoodsService.getAllByOrderId(id));
		return "module/order/order-changeView";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看商品换货单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/returnView", method = RequestMethod.GET)
	public String returnView(@RequestParam(value = "id") String id) {

		setAttribute("model", orderService.getOrderById(id));
		setAttribute("orderGoodsList", orderGoodsService.getAllByOrderId(id));
		return "module/order/order-returnView";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看商品赔偿
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/reparationView", method = RequestMethod.GET)
	public String reparationView(@RequestParam(value = "id") String id) {

		setAttribute("model", orderService.getOrderById(id));
		setAttribute("orderGoodsList", orderGoodsService.getAllByOrderId(id));
		return "module/order/order-reparationView";
	}

	/**
	 *
	 * <P>
	 * 确认商品是否售出
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param order
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/qrcodeIsSale", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson qrcodeIsSale(@RequestParam(value = "qrcodeId") String qrcodeId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(qrcodeId)) {
				Qrcode qrcode = qrcodeService.getQrcodeById(qrcodeId);
				if (null == qrcode || StringUtils.isBlank(qrcode.getId())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("获取失败，请确认是否正确扫描产品二维码~");
					return ajaxJson;
				}
				if (Qrcode.STATE_TWO.equals(qrcode.getState())) {
					if (0 >= DoubleUtil.compareTo(orderService.getEightOrderCountByQrcodeId(qrcode.getId()), "0")) {
						List<String> qrcodeVO = new ArrayList<String>();
						Order order = orderService.getOrderByQrcodeId(qrcodeId);
						qrcodeVO.add(Qrcode.STATE_TWO);
						if (null != order && StringUtils.isNotBlank(order.getId())) {
							qrcodeVO.add(order.getId());
							qrcodeVO.add(order.getCode());
						}
						ajaxJson.setSuccess(true);
						ajaxJson.setObj(qrcodeVO);
					} else {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("该商品已赔偿！");
					}

				} else if (Qrcode.STATE_ONE.equals(qrcode.getState())) {
					List<String> qrcodeVO = new ArrayList<String>();
					qrcodeVO.add(Qrcode.STATE_ONE);
					ajaxJson.setSuccess(true);
					ajaxJson.setObj(qrcodeVO);
				} else if (Qrcode.STATE_FOUR.equals(qrcode.getState())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("该商品已锁定,请重试!");
				} else {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("该商品未售出,请重试!");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("二维码Id为空,错误!");
			}
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试");
			logger_orderController.error("确认商品是否售出出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_orderController.error("确认商品是否售出出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 确认商品是否售出
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param order
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/qrcodeIsSaleByChange", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson qrcodeIsSaleByChange(@RequestParam(value = "qrcodeId") String qrcodeId,
			@RequestParam(value = "orderId") String orderId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(qrcodeId)) {
				Qrcode qrcode = qrcodeService.getQrcodeById(qrcodeId);
				if (null == qrcode || StringUtils.isBlank(qrcode.getId())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("获取失败，请确认是否正确扫描产品二维码~");
					return ajaxJson;
				}
				if (Qrcode.STATE_TWO.equals(qrcode.getState())) {
					List<String> qrcodeVO = new ArrayList<String>();
					Order order = orderService.getOrderByQrcodeId(qrcodeId);
					List<Order> threeOrderList = orderService.getThreeOrderByOrderId(orderId);
					if (null != threeOrderList && 0 < threeOrderList.size()) {
						if (order.getId().equals(orderId)) {
							boolean isHave = false;
							for (Order childOrder : order.getOrderList()) {
								for (Order threeOrder : threeOrderList) {
									if (childOrder.getId().equals(threeOrder.getId())) {
										for (OrderGoods childOrderGoods : childOrder.getOrderGoodList()) {
											for (OrderGoodsQrcode childOrderQrcode : childOrderGoods.getoGQList()) {
												if (null != childOrderQrcode
														&& StringUtils.isNotBlank(childOrderQrcode.getId())) {
													if (childOrderQrcode.getQrcode().getId().equals(qrcodeId)) {
														isHave = true;
													}
												}
											}
										}
									}
								}
							}
							if (isHave) {
								ajaxJson.setSuccess(false);
								ajaxJson.setMsg("换购商品无法换货!");
							} else {
								qrcodeVO.add(Qrcode.STATE_TWO);
								if (null != order && StringUtils.isNotBlank(order.getId())) {
									qrcodeVO.add(order.getId());
									qrcodeVO.add(order.getCode());
								}
								ajaxJson.setSuccess(true);
								ajaxJson.setObj(qrcodeVO);
							}
						} else {
							ajaxJson.setSuccess(false);
							ajaxJson.setMsg("订单与商品不符，请检查！");
						}
					} else {
						List<String> qrcodeVO1 = new ArrayList<String>();
						Order order1 = orderService.getOrderByQrcodeId(qrcodeId);
						qrcodeVO1.add(Qrcode.STATE_TWO);
						if (null != order1 && StringUtils.isNotBlank(order1.getId())) {
							qrcodeVO1.add(order1.getId());
							qrcodeVO1.add(order1.getCode());
						}
						ajaxJson.setSuccess(true);
						ajaxJson.setObj(qrcodeVO1);
					}

				} else if (Qrcode.STATE_ONE.equals(qrcode.getState())) {
					List<String> qrcodeVO = new ArrayList<String>();
					qrcodeVO.add(Qrcode.STATE_ONE);
					ajaxJson.setSuccess(true);
					ajaxJson.setObj(qrcodeVO);
				} else if (Qrcode.STATE_FOUR.equals(qrcode.getState())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("该商品已锁定,请重试!");
				} else {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("该商品未售出,请重试!");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("二维码Id为空,错误!");
			}
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试");
			logger_orderController.error("确认商品是否售出出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_orderController.error("确认商品是否售出出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 确认商品是否售出
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param order
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/qrcodeIsSaleByReparation", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson qrcodeIsSaleByReparation(@RequestParam(value = "qrcodeId") String qrcodeId,
			@RequestParam(value = "orderId") String orderId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(qrcodeId)) {
				Qrcode qrcode = qrcodeService.getQrcodeById(qrcodeId);
				if (null == qrcode || StringUtils.isBlank(qrcode.getId())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("获取失败，请确认是否正确扫描产品二维码~");
					return ajaxJson;
				}
				if (Qrcode.STATE_TWO.equals(qrcode.getState())) {
					List<String> qrcodeVO = new ArrayList<String>();
					Order order = orderService.getOrderByQrcodeId(qrcodeId);
					Order subOrder = orderService.getOrderById(orderId);
					if (null == order || StringUtils.isBlank(order.getId())) {
						boolean isSendQrcode1 = false;
						List<Qrcode> qrcodeList1 = qrcodeService.getPutOutQrcodeListByOrderCode(subOrder.getCode());
						String qrcodeString1 = "";
						if (null != qrcodeList1 && !qrcodeList1.isEmpty()) {
							isSendQrcode1 = true;
							for (Qrcode qrcode_for : qrcodeList1) {
								qrcodeString1 += qrcode_for.getId() + ",";
							}
						}
						if (isSendQrcode1 && 0 <= qrcodeString1.indexOf(qrcodeId)) {
							qrcodeVO.add(Qrcode.STATE_TWO);
							qrcodeVO.add(subOrder.getId());
							qrcodeVO.add(subOrder.getCode());
							ajaxJson.setSuccess(true);
							ajaxJson.setObj(qrcodeVO);
						} else {
							ajaxJson.setSuccess(false);
							ajaxJson.setMsg("订单与商品不符，请检查！");
						}
					} else {
						boolean isSendQrcode = false;

						List<Qrcode> qrcodeList = qrcodeService.getPutOutQrcodeListByOrderCode(order.getCode());
						String qrcodeString = "";
						if (null != qrcodeList && !qrcodeList.isEmpty()) {
							isSendQrcode = true;
							for (Qrcode qrcode_for : qrcodeList) {
								qrcodeString += qrcode_for.getId() + ",";
							}
						}
						if (isSendQrcode && 0 <= qrcodeString.indexOf(qrcodeId)) {
							qrcodeVO.add(Qrcode.STATE_TWO);
							qrcodeVO.add(order.getId());
							qrcodeVO.add(order.getCode());
							ajaxJson.setSuccess(true);
							ajaxJson.setObj(qrcodeVO);
						} else {
							List<Order> threeOrderList = orderService.getThreeOrderByOrderId(orderId);
							if (null != threeOrderList && 0 < threeOrderList.size()) {
								if (order.getId().equals(orderId)) {
									boolean isHave = false;
									for (Order childOrder : order.getOrderList()) {
										for (Order threeOrder : threeOrderList) {
											if (childOrder.getId().equals(threeOrder.getId())) {
												for (OrderGoods childOrderGoods : childOrder.getOrderGoodList()) {
													for (OrderGoodsQrcode childOrderQrcode : childOrderGoods
															.getoGQList()) {
														if (null != childOrderQrcode
																&& StringUtils.isNotBlank(childOrderQrcode.getId())) {
															if (childOrderQrcode.getQrcode().getId().equals(qrcodeId)) {
																isHave = true;
															}
														}
													}
												}
											}
										}
									}
									if (isHave) {
										qrcodeVO.add(Qrcode.STATE_TWO);
										if (null != order && StringUtils.isNotBlank(order.getId())) {
											qrcodeVO.add(order.getId());
											qrcodeVO.add(order.getCode());
										}
										ajaxJson.setSuccess(true);
										ajaxJson.setObj(qrcodeVO);
									} else {
										ajaxJson.setSuccess(false);
										ajaxJson.setMsg("该商品无法赔偿！");
									}
								} else {
									ajaxJson.setSuccess(false);
									ajaxJson.setMsg("订单与商品不符，请检查！");
								}
							} else {
								ajaxJson.setSuccess(false);
								ajaxJson.setMsg("该商品无法赔偿！");
							}
						}
					}
				} else if (Qrcode.STATE_ONE.equals(qrcode.getState())) {
					List<String> qrcodeVO = new ArrayList<String>();
					qrcodeVO.add(Qrcode.STATE_ONE);
					ajaxJson.setSuccess(true);
					ajaxJson.setObj(qrcodeVO);
				} else if (Qrcode.STATE_FOUR.equals(qrcode.getState())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("该商品已锁定,请重试!");
				} else {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("该商品未售出,请重试!");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("二维码Id为空,错误!");
			}
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试");
			logger_orderController.error("确认商品是否售出出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_orderController.error("确认商品是否售出出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 确认商品是否售出
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param order
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/qrcodeIsSaleByAfterSale", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson qrcodeIsSaleByAfterSale(@RequestParam(value = "qrcodeId") String qrcodeId,
			@RequestParam(value = "orderId") String orderId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(qrcodeId)) {
				Qrcode qrcode = qrcodeService.getQrcodeById(qrcodeId);
				if (null == qrcode || StringUtils.isBlank(qrcode.getId())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("获取失败，请确认是否正确扫描产品二维码~");
					return ajaxJson;
				}
				if (Qrcode.STATE_TWO.equals(qrcode.getState())) {
					List<String> qrcodeVO = new ArrayList<String>();
					Order order = orderService.getOrderByQrcodeId(qrcodeId);
					Order subOrder = orderService.getOrderById(orderId);
					if (null == order || StringUtils.isBlank(order.getId())) {
						boolean isSendQrcode1 = false;
						List<Qrcode> qrcodeList1 = qrcodeService.getPutOutQrcodeListByOrderCode(subOrder.getCode());
						String qrcodeString1 = "";
						if (null != qrcodeList1 && !qrcodeList1.isEmpty()) {
							isSendQrcode1 = true;
							for (Qrcode qrcode_for : qrcodeList1) {
								qrcodeString1 += qrcode_for.getId() + ",";
							}
						}
						if (isSendQrcode1 && 0 <= qrcodeString1.indexOf(qrcodeId)) {
							ajaxJson.setSuccess(false);
							ajaxJson.setMsg("赠品不可进行售后！");
						} else {
							ajaxJson.setSuccess(false);
							ajaxJson.setMsg("订单与商品不符，请检查！");
						}
					} else {
						boolean isSendQrcode = false;

						List<Qrcode> qrcodeList = qrcodeService.getPutOutQrcodeListByOrderCode(order.getCode());
						String qrcodeString = "";
						if (null != qrcodeList && !qrcodeList.isEmpty()) {
							isSendQrcode = true;
							for (Qrcode qrcode_for : qrcodeList) {
								qrcodeString += qrcode_for.getId() + ",";
							}
						}
						if (isSendQrcode && 0 <= qrcodeString.indexOf(qrcodeId)) {
							ajaxJson.setSuccess(false);
							ajaxJson.setMsg("赠品不可进行售后！");
						} else {
							Order order1 = orderService.getOrderByQrcodeId(qrcodeId);
							qrcodeVO.add(Qrcode.STATE_TWO);
							if (null != order1 && StringUtils.isNotBlank(order1.getId())) {
								qrcodeVO.add(order1.getId());
								qrcodeVO.add(order1.getCode());
							}
							ajaxJson.setSuccess(true);
							ajaxJson.setObj(qrcodeVO);
						}
					}
				} else if (Qrcode.STATE_ONE.equals(qrcode.getState())) {
					List<String> qrcodeVO = new ArrayList<String>();
					qrcodeVO.add(Qrcode.STATE_ONE);
					ajaxJson.setSuccess(true);
					ajaxJson.setObj(qrcodeVO);
				} else if (Qrcode.STATE_FOUR.equals(qrcode.getState())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("该商品已锁定,请重试!");
				} else {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("该商品未售出,请重试!");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("二维码Id为空,错误!");
			}
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试");
			logger_orderController.error("确认商品是否售出出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_orderController.error("确认商品是否售出出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 根据qrcodeId获取order
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param order
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/getOrderByQrcodeId", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson getOrderByQrcodeId(@RequestParam(value = "qrcodeId") String qrcodeId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(qrcodeId)) {
				Qrcode qrcode = qrcodeService.getQrcodeById(qrcodeId);
				if (null == qrcode || StringUtils.isBlank(qrcode.getId())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("获取失败，请确认是否正确扫描产品二维码~");
					return ajaxJson;
				}
				if (Qrcode.STATE_TWO.equals(qrcode.getState())) {
					List<String> qrcodeVO = new ArrayList<String>();
					qrcodeVO.add(orderService.getOrderByQrcodeId(qrcodeId).getId());
					ajaxJson.setSuccess(true);
					ajaxJson.setObj(qrcodeVO);
				} else {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("该商品未售出,请重试!");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("二维码Id为空,错误!");
			}
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试");
			logger_orderController.error("根据qrcodeId获取order出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_orderController.error("根据qrcodeId获取order出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 保存同商品换货订单信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param order
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/sameChangeSaveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson sameChangeSaveOrUpdate(@RequestParam(value = "orderId") String orderId,
			@RequestParam(value = "oldQrcodeId") String oldQrcodeId,
			@RequestParam(value = "newQrcodeId") String newQrcodeId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(orderId)) {
				if (StringUtils.isNotBlank(oldQrcodeId) && StringUtils.isNotBlank(newQrcodeId)) {
					Qrcode newQrcode = qrcodeService.getQrcodeById(newQrcodeId);
					Qrcode oldQrcode = qrcodeService.getQrcodeById(oldQrcodeId);
					if (Qrcode.STATE_TWO.equals(oldQrcode.getState()) && Qrcode.STATE_ONE.equals(newQrcode.getState())) {
						ajaxJson = orderService.sameChangeSave(orderId, oldQrcodeId, newQrcodeId);
					} else {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("换货失败,商品异常,请稍后重试~");
					}
				} else {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("换货失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("换货失败，请稍后重试~");
			}
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试");
			logger_orderController.error("保存订单信息出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_orderController.error("保存订单信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 保存商品换货订单信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param order
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/changeSaveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson changeSaveOrUpdate(@FormModel(value = "oldQrcodeVOList") List<QrcodeVO> oldQrcodeVOList,
			@FormModel(value = "order") Order order,
			@FormModel(value = "newQrcodeVOList") List<QrcodeVO> newQrcodeVOList) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (null != oldQrcodeVOList && !oldQrcodeVOList.isEmpty() && null != newQrcodeVOList
					&& !newQrcodeVOList.isEmpty() && null != order && StringUtils.isNotBlank(order.getId())) {
				ajaxJson = orderService.changeSave(order.getId(), oldQrcodeVOList, newQrcodeVOList);
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("换货失败，请稍后重试~");
			}
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试");
			logger_orderController.error("保存换货订单信息出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_orderController.error("保存换货订单信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 保存商品退货订单信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param order
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/returnSaveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson returnSaveOrUpdate(@FormModel(value = "oldQrcodeVOList") List<QrcodeVO> oldQrcodeVOList,
			@FormModel(value = "order") Order order) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (null != oldQrcodeVOList && !oldQrcodeVOList.isEmpty() && null != order
					&& StringUtils.isNotBlank(order.getId())) {
				ajaxJson = orderService.returnSave(order.getId(), oldQrcodeVOList);
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("退货失败，请稍后重试~");
			}
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试");
			logger_orderController.error("保存退货订单信息出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_orderController.error("保存退货订单信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 保存商品赔偿订单信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param order
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/reparationSaveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson reparationSaveOrUpdate(@FormModel(value = "oldQrcodeVOList") List<QrcodeVO> oldQrcodeVOList,
			@FormModel(value = "order") Order order) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (null != oldQrcodeVOList && !oldQrcodeVOList.isEmpty() && null != order
					&& StringUtils.isNotBlank(order.getId())) {
				ajaxJson = orderService.reparationSave(order.getId(), oldQrcodeVOList);
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("赔偿失败，请稍后重试~");
			}
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试");
			logger_orderController.error("保存赔偿订单信息出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_orderController.error("保存赔偿订单信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 放弃未支付订单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param order
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/updateOrderStateBySeven", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson updateOrderStateBySeven(@RequestParam(value = "id") String orderId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(orderId)) {
				if (0 >= orderService.updateOrderStateBySeven(orderId)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("放弃订单失败,请重试!");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("放弃订单成功!");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("订单Id为空,错误!");
			}
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试");
			logger_orderController.error("放弃订单出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_orderController.error("放弃订单信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 保存订单信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param order
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") Order order) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(order.getId())) {
				ajaxJson.setMsg("修改订单成功！");
				if (0 >= orderService.update(order)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("修改订单失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("修改订单成功！");
				}
			} else {
				if (0 >= orderService.save(order)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("添加订单失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("添加订单成功！");
				}
			}
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试");
			logger_orderController.error("保存订单出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_orderController.error("保存订单信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除订单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/doDelete", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doDelete(@RequestParam(value = "id") String id) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(id)) {
				if (0 >= orderService.deleteOrder(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("删除订单失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("删除订单失败，请刷新页面后重试~");
				logger_orderController.warn("删除订单时，订单ID为空，请检查代码实现~");
			}
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试");
			logger_orderController.error("删除订单出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_orderController.error("删除订单出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 打印同商品换货小票
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/sameChangePrintView", method = RequestMethod.GET)
	public String sameChangePrintView(@RequestParam(value = "id") String id) {

		setAttribute("model", orderService.getOrderById(id));
		setAttribute("orderGoodsList", orderGoodsService.getAllByOrderId(id));
		return "module/order/order-sameChangePrintView";
	}

	/**
	 *
	 * <P>
	 * 打印换货小票
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/changePrintView", method = RequestMethod.GET)
	public String changePrintView(@RequestParam(value = "id") String id) {

		setAttribute("model", orderService.getOrderById(id));
		setAttribute("orderGoodsList", orderGoodsService.getAllByOrderId(id));
		return "module/order/order-changePrintView";
	}

	/**
	 *
	 * <P>
	 * 打印退货小票
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/returnPrintView", method = RequestMethod.GET)
	public String returnPrintView(@RequestParam(value = "id") String id) {

		setAttribute("model", orderService.getOrderById(id));
		setAttribute("orderGoodsList", orderGoodsService.getAllByOrderId(id));
		return "module/order/order-returnPrintView";
	}

	/**
	 *
	 * <P>
	 * 打印退货小票
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/reparationPrintView", method = RequestMethod.GET)
	public String reparationPrintView(@RequestParam(value = "id") String id) {

		setAttribute("model", orderService.getOrderById(id));
		setAttribute("orderGoodsList", orderGoodsService.getAllByOrderId(id));
		return "module/order/order-reparationPrintView";
	}

	/**
	 *
	 * <P>
	 * 打印销售小票
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/salePrintView", method = RequestMethod.GET)
	public String salePrintView(@RequestParam(value = "id") String id) {
		setAttribute("model", orderService.getOrderById(id));
		setAttribute("orderGoodsList", orderGoodsService.getAllByParentOrderId(id));
		return "module/order/order-salePrintView";
	}

	/**
	 *
	 * <P>
	 * 打印预约小票
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 31, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/reservePrintView", method = RequestMethod.GET)
	public String reservePrintView(@RequestParam(value = "id") String id) {
		setAttribute("model", orderService.getOrderById(id));
		setAttribute("orderGoodsList", orderGoodsService.getAllByParentOrderId(id));
		return "module/order/order-reservePrintView";
	}

	/**
	 *
	 * <P>
	 * 线上订单发货
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/receiverOrderInput", method = RequestMethod.GET)
	public String receiverOrderInput(@RequestParam(value = "orderId") String orderId) {
		Order order = orderService.getOrderById(orderId);

		setAttribute("model", order);
		return "module/order/order-receiverOrderInput";
	}

	/**
	 *
	 * <P>
	 * 打印销售小票
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/receiverPrintView", method = RequestMethod.GET)
	public String receiverPrintView(@RequestParam(value = "id") String id) {
		setAttribute("model", orderService.getOrderById(id));
		setAttribute("orderGoodsList", orderGoodsService.getAllByParentOrderId(id));
		return "module/order/order-receiverPrintView";
	}

	/**
	 *
	 * <P>
	 * 线上出库
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年1月26日
	 * @param order
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/receiverSaveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson receiverSaveOrUpdate(@FormModel(value = "model") Order order) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isBlank(order.getId())) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("保存线上出库失败，请稍后重试！");
				return ajaxJson;
			} else {
				Order order_by_get = orderService.getOrderById(order.getId());
				if (!order_by_get.getQrcodeCount().equals(order_by_get.getSumNumber())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("发货数量不足换购数量，请确认~");
					return ajaxJson;
				} else {
					if (0 >= orderService.updateStateTwoToThree(order_by_get.getId())) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("线上出库失败，请稍后重试！");
					} else {
						ajaxJson.setSuccess(true);
						ajaxJson.setObj(order_by_get.getId());
						ajaxJson.setMsg("保存线上出库成功！");
					}
				}
			}
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("线上出库失败，请重试~");
			logger_orderController.error("保存线上出库出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("线上出库失败，请重试~");
			logger_orderController.error("线上出库--出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;

	}

	/**
	 *
	 * <P>
	 * 线上订单发货
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/sendGoodsOrder", method = RequestMethod.GET)
	public String sendGoodsOrder(@RequestParam(value = "orderId") String orderId) {
		Order order = orderService.getOrderById(orderId);
		setAttribute("model", order);
		return "module/order/order-sendGoodsOrder";
	}

	/**
	 *
	 * <P>
	 * 线上订单确认发货
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月12日
	 * @param order
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/updateSendGoodsOrder", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson updateSendGoodsOrder(@FormModel(value = "model") Order order) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			Order order_by_get = orderService.getOrderById(order.getId());
			if (!order_by_get.getQrcodeCount().equals(order_by_get.getSumNumber())) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("发货数量不足线上订单数量，请确认~");
				return ajaxJson;
			} else {
				if (0 >= orderService.updateStateThreeToFour(order)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("线上订单确认发货失败，请稍后重试！");
				} else {
					List<Order> orderList = orderService.getOrderByBatchCode(order_by_get.getBatchCode());
					if (null != orderList && 0 < orderList.size()) {
						int i = 0;
						for (Order order1 : orderList) {
							if (!Order.STATE_FOUR.equals(order1.getState())) {
								i++;
							}
						}
						if (0 >= i) {
							final Customer customer1 = order_by_get.getCustomer();
							final List<Order> orderList1 = orderList;
							ThreadPoolUtil.getPool().execute(new Runnable() {
								@Override
								public void run() {
									try {
										WeChatUtil.sendCustomerGoodsOrder(customer1, orderList1, weChatService
												.getWeChatList().get(0));
									} catch (Exception e) {
										logger_orderController.error("订单确认发货通知(线上)模板消息出错，具体错误如下："
												+ ExceptionUtil
														.getExceptionAllinformation(e, this.getClass().getName()));
									}
								}
							});
						}
					}
					ajaxJson.setSuccess(true);
					ajaxJson.setObj(order_by_get.getId());
					ajaxJson.setMsg("线上订单确认发货成功！");
				}
			}
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("线上订单确认发货失败，请重试~");
			logger_orderController.error("线上订单确认发货出错，具体错误如下：\r\n" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("线上订单确认发货失败，请重试~");
			logger_orderController.error("线上订单确认发货--出错，具体错误如下："
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;

	}

	/**
	 *
	 * <P>
	 * 根据小票code获取主订单Id
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月14日
	 * @param orderId
	 * @param eticketOutCode
	 * @return
	 * @throws Exception
	 *             int
	 */
	@RequestMapping(value = "/getOrderIdByCode", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson getOrderIdByCode(String code) throws Exception {
		AjaxJson ajaxJson = new AjaxJson();
		if (StringUtils.isNotBlank(code)) {
			Order order = orderService.getPaySuccessOrderByOrderCode(code);
			if (null != order && StringUtils.isNotBlank(order.getId())) {
				if (Order.TYPE_ONE.equals(order.getType())) {
					if (Order.STATE_FIVE.equals(order.getState()) || Order.STATE_SIX.equals(order.getState())) {
						if (null != order.getOrder() && StringUtils.isNotBlank(order.getOrder().getId())) {
							ajaxJson.setObj(order.getOrder().getId());
						} else {
							ajaxJson.setObj(order.getId());
						}
						ajaxJson.setSuccess(true);
						ajaxJson.setMsg("获取订单成功!");
					} else {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("线上订单,请先确认收货!");
					}
				} else {
					if (null != order.getOrder() && StringUtils.isNotBlank(order.getOrder().getId())) {
						ajaxJson.setObj(order.getOrder().getId());
					} else {
						ajaxJson.setObj(order.getId());
					}
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("获取订单成功!");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("该订单不存在,请重试!");
			}
		} else {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("获取失败!");
		}
		return ajaxJson;
	}
}