package com.unitever.module.customer.controller;

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
import com.unitever.module.customer.service.CustomerService;
import com.unitever.module.order.service.OrderService;
import com.unitever.module.weChat.service.WeChatService;
import com.unitever.module.weChat.util.WeChatUtil;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;
import com.unitever.platform.util.ThreadPoolUtil;

@Controller
@RequestMapping(value = "/customer")
public class CustomerController extends SpringController {

	private Logger logger_customerController = LoggerFactory.getLogger("CustomerController");

	@Autowired
	private CustomerService customerService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private WeChatService weChatService;
	@Autowired
	private UserService userService;

	/**
	 *
	 * <P>
	 * 跳转到 CustomerList
	 * </p>
	 *
	 * @author 闫枫
	 * @date Dec 23, 2016
	 * @param page
	 * @param Order
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<Customer> page, @FormModel("model") Customer customer) {
		setAttribute("pageObj", customerService.getPage(page, customer));
		setAttribute("model", customer);
		return "module/customer/customer-list";
	}

	/**
	 *
	 * <P>
	 * 更新客户信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Dec 24, 2016
	 * @param customer
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/doUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doUpdate(@FormModel(value = "model") Customer customer) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			int i = customerService.update(customer);
			if (0 >= i) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("更新失败，请重试~");
			}
		} catch (Exception e) {
			e.printStackTrace();
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("服务器走丢了，请稍后重试~");
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 跳转到查看客户信息页面
	 * </p>
	 *
	 * @author 闫枫
	 * @date Dec 24, 2016
	 * @param customerId
	 * @return String
	 */
	@RequestMapping(value = "/view")
	public String view(@RequestParam(value = "customerId") String customerId) {
		Customer customer = customerService.getCustomerById(customerId);
		setAttribute("customer", customer);
		return "module/customer/customer-view";
	}

	/**
	 *
	 * <P>
	 * 跳转到查看客户信息页面
	 * </p>
	 *
	 * @author 闫枫
	 * @date Dec 24, 2016
	 * @param customerId
	 * @return String
	 */
	@RequestMapping(value = "/goUpdate")
	public String goUpdate(@RequestParam(value = "customerId") String customerId) {
		setAttribute("customer", customerService.getCustomerById(customerId));
		return "module/customer/customer-input";
	}

	/**
	 *
	 * <P>
	 * 拉黑会员
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/doIsBlank", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doIsBlank(@RequestParam(value = "id") String id) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(id)) {
				if (0 >= customerService.doIsBlank(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("拉黑失败，请稍后重试~");
				} else {
					final Customer customer = customerService.getCustomerById(id);
					ThreadPoolUtil.getPool().execute(new Runnable() {
						@Override
						public void run() {
							try {
								WeChatUtil.sendCustomerIsBlank(customer, weChatService.getWeChatList().get(0));
							} catch (Exception e) {
								logger_customerController.error("会员拉黑通知模板消息出错，具体错误如下："
										+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
							}
						}
					});
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("拉黑失败，请刷新页面后重试~");
				logger_customerController.warn("删除订单管理时，订单管理ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_customerController
					.error("拉黑出错，具体错误如下：\r\n" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 通过手机号获取会员信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 10, 2017
	 * @param phone
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/getCustomerByPhone", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson getCustomerByPhone(@RequestParam(value = "phone") String phone) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(phone)) {
				Customer customer = customerService.getCustomerByPhone(phone);
				if (null == customer || StringUtils.isBlank(customer.getId())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("无此会员信息~");
					return ajaxJson;
				}
				Customer customer_to_return = new Customer(customer.getId());
				customer_to_return.setEmployee(customer.getEmployee());
				customer_to_return.setName(customer.getName());
				ajaxJson.setSuccess(true);
				ajaxJson.setObj(customer_to_return);
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("手机号不可为空！");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("服务器走丢了，请稍后重试~");
			logger_customerController.error(
					"通过手机号获取会员信息出错，具体错误如下：" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}
}
