package com.unitever.module.orderSubremark.controller;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.module.orderSubremark.model.OrderSubremark;
import com.unitever.module.orderSubremark.service.OrderSubremarkService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

@Controller
@RequestMapping(value = "/orderSubremark")
public class OrderSubremarkController extends SpringController {

	@Autowired
	private OrderSubremarkService orderSubremarkService;

	private Logger logger_orderSubremarkController = LoggerFactory.getLogger("OrderSubremarkController");

	/**
	 *
	 * <P>
	 * 跳转至订单减免记录列表页面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param page
	 * @param orderSubremark
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<OrderSubremark> page, @FormModel("model") OrderSubremark orderSubremark) {
		setAttribute("pageObj", orderSubremarkService.getPage(page, orderSubremark));
		setAttribute("model", orderSubremark);
		return "module/orderSubremark/orderSubremark-list";
	}

	/**
	 *
	 * <P>
	 * 跳转至添加更新订单减免记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/input", method = RequestMethod.GET)
	public String input(@RequestParam(value = "id", required = false) String id) {
		String inputKind = getRequest().getParameter("inputKind");
		setAttribute("inputKind", inputKind);
		if ("update".equals(inputKind)) {
			setAttribute("model", orderSubremarkService.getOrderSubremarkById(id));
		}
		return "module/orderSubremark/orderSubremark-input";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看订单减免记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam(value = "id", required = false) String id) {
		setAttribute("model", orderSubremarkService.getOrderSubremarkById(id));
		return "module/orderSubremark/orderSubremark-view";
	}

	/**
	 *
	 * <P>
	 * 保存订单减免记录信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param orderSubremark
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") OrderSubremark orderSubremark) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(orderSubremark.getId())) {
				ajaxJson.setMsg("修改订单减免记录成功！");
				if (0 >= orderSubremarkService.update(orderSubremark)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("修改订单减免记录失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("修改订单减免记录成功！");
				}
			} else {
				if (0 >= orderSubremarkService.save(orderSubremark)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("添加订单减免记录失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("添加订单减免记录成功！");
				}
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_orderSubremarkController.error("保存订单减免记录信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除订单减免记录
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
				if (0 >= orderSubremarkService.deleteOrderSubremark(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("删除订单减免记录失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("删除订单减免记录失败，请刷新页面后重试~");
				logger_orderSubremarkController.warn("删除订单减免记录时，订单减免记录ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_orderSubremarkController.error("删除订单减免记录出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}
}