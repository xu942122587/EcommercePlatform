package com.unitever.module.cashierUserLoginAndLogout.controller;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.module.cashierUserLoginAndLogout.model.CashierUserLoginAndLogout;
import com.unitever.module.cashierUserLoginAndLogout.service.CashierUserLoginAndLogoutServices;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.cashierUserLoginAndLogout.controller->
 * CashierUserLoginAndLogoutController.java
 * </p>
 * <P>
 * 收银交接班
 * </p>
 *
 * @author 闫枫
 * @date Sep 18, 2017
 */
@Controller
@RequestMapping(value = "/CashierUserLoginAndLogout")
public class CashierUserLoginAndLogoutController extends SpringController {

	@Autowired
	private CashierUserLoginAndLogoutServices cashierUserLoginAndLogoutServices;

	private Logger logger_clientController = LoggerFactory.getLogger("CashierUserLoginAndLogoutController");

	/**
	 *
	 * <P>
	 * 跳转至交接班列表页面
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param page
	 * @param jiaojie
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<CashierUserLoginAndLogout> page,
			@FormModel("model") CashierUserLoginAndLogout jiaojie) {
		setAttribute("pageObj", cashierUserLoginAndLogoutServices.getPage(page, jiaojie));
		setAttribute("model", jiaojie);
		return "module/jiaojie/jiaojie-list";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看交接班
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam(value = "id", required = false) String id) {
		CashierUserLoginAndLogout cashierUserLoginAndLogout = cashierUserLoginAndLogoutServices.getLogoutById(id);
		setAttribute("model", cashierUserLoginAndLogout);
		setAttribute("jiaojie_map",
				cashierUserLoginAndLogoutServices.getSubmitMoneyMsgMap(
						cashierUserLoginAndLogout.getCashierUser().getId(), cashierUserLoginAndLogout.getLoginTime(),
						cashierUserLoginAndLogout.getLogoutTime()));
		return "module/jiaojie/jiaojie-view";
	}

	/**
	 *
	 * <P>
	 * 交接班结算
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return int
	 */
	@RequestMapping(value = "/doLogoutStart", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doLogoutStart(@RequestParam(value = "id") String id) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(id)) {
				if (0 >= cashierUserLoginAndLogoutServices.doFinish(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("交接班结算失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("交接班结算成功");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("交接班结算失败，请刷新页面后重试~");
				logger_clientController.warn("交接班结算时，交接班ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_clientController.error(
					"交接班结算出错，具体错误如下：\r\n" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}
}