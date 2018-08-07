package com.unitever.module.orderAfterSale.controller;

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
import com.unitever.module.order.model.Order;
import com.unitever.module.order.service.OrderService;
import com.unitever.module.orderAfterSale.model.OrderAfterSale;
import com.unitever.module.orderAfterSale.service.OrderAfterSaleService;
import com.unitever.module.orderGoodsQrcode.model.OrderGoodsQrcode;
import com.unitever.module.orderGoodsQrcode.service.OrderGoodsQrcodeService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.orderAfterSale.controller->
 * OrderAfterSaleController. java
 * </p>
 * <P>
 * 订单
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月4日
 */
@Controller
@RequestMapping(value = "/orderAfterSale")
public class OrderAfterSaleController extends SpringController {

	@Autowired
	private OrderAfterSaleService orderAfterSaleService;
	@Autowired
	private UserService userService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private OrderGoodsQrcodeService orderGoodsQrcodeService;

	private Logger logger_orderAfterSaleController = LoggerFactory.getLogger("OrderAfterSaleController");

	/**
	 *
	 * <P>
	 * 跳转至售后管理列表页面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月31日
	 * @param page
	 * @param orderAfterSale
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<OrderAfterSale> page, @FormModel("model") OrderAfterSale orderAfterSale) {
		setAttribute("pageObj", orderAfterSaleService.getPage(page, orderAfterSale));
		setAttribute("model", orderAfterSale);
		return "module/orderAfterSale/orderAfterSale-list";
	}

	/**
	 *
	 * <P>
	 * 跳转至添加更新售后管理
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月31日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/input", method = RequestMethod.GET)
	public String input(@RequestParam(value = "id", required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			setAttribute("model", orderAfterSaleService.getOrderAfterSaleById(id));
		}
		return "module/orderAfterSale/orderAfterSale-input";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看售后管理
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月31日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam(value = "id") String id) {
		setAttribute("model", orderAfterSaleService.getOrderAfterSaleById(id));
		return "module/orderAfterSale/orderAfterSale-view";
	}

	/**
	 *
	 * <P>
	 * 保存售后管理信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月31日
	 * @param orderAfterSale
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") OrderAfterSale orderAfterSale,
			@FormModel(value = "Order") Order order) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(orderAfterSale.getId())) {
				ajaxJson.setMsg("修改售后管理成功！");
				if (0 >= orderAfterSaleService.update(orderAfterSale)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("修改售后管理失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("修改售后管理成功！");
				}
			} else {
				OrderGoodsQrcode orderGoodsQrcode = orderGoodsQrcodeService.getAllByQrcodeId(orderAfterSale
						.getOrderGoodsQrcode().getQrcode().getId());
				orderAfterSale.setOrderGoodsQrcode(orderGoodsQrcode);
				if (0 >= orderAfterSaleService.save(orderAfterSale)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("添加售后管理失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("添加售后管理成功！");
				}
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_orderAfterSaleController.error("保存售后管理信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除售后管理
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月31日
	 * @param id
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/doDelete", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doDelete(@RequestParam(value = "id") String id) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(id)) {
				if (0 >= orderAfterSaleService.deleteOrderAfterSale(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("删除售后管理失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("删除售后管理失败，请刷新页面后重试~");
				logger_orderAfterSaleController.warn("删除售后管理时，售后管理ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_orderAfterSaleController.error("删除售后管理出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}
}