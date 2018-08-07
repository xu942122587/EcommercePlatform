package com.unitever.module.registerBonus.controller;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.module.registerBonus.model.RegisterBonus;
import com.unitever.module.registerBonus.service.RegisterBonusService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.registerBonus.controller->
 * RegisterBonusController. java
 * </p>
 * <P>
 * 注册返现比例
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月5日
 */
@Controller
@RequestMapping(value = "/registerBonus")
public class RegisterBonusController extends SpringController {

	@Autowired
	private RegisterBonusService registerBonusService;

	private Logger logger_registerBonusController = LoggerFactory.getLogger("RegisterBonusController");

	/**
	 *
	 * <P>
	 * 跳转至注册提成列表页面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param page
	 * @param registerBonus
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<RegisterBonus> page, @FormModel("model") RegisterBonus registerBonus) {
		setAttribute("pageObj", registerBonusService.getPage(page, registerBonus));
		setAttribute("model", registerBonus);
		return "module/registerBonus/registerBonus-list";
	}

	/**
	 *
	 * <P>
	 * 跳转至添加更新注册提成
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/input", method = RequestMethod.GET)
	public String input() {
		setAttribute("model", registerBonusService.getFirstRegisterBonus());
		return "module/registerBonus/registerBonus-input";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看注册提成
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam(value = "id", required = false) String id) {
		setAttribute("model", registerBonusService.getRegisterBonusById(id));
		return "module/registerBonus/registerBonus-view";
	}

	/**
	 *
	 * <P>
	 * 保存注册提成信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param registerBonus
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") RegisterBonus registerBonus) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(registerBonus.getId())) {
				if (0 >= registerBonusService.update(registerBonus)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("修改注册提成失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("修改注册提成成功！");
				}
			} else {
				if (0 >= registerBonusService.save(registerBonus)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("添加注册提成失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("添加注册提成成功！");
				}
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_registerBonusController.error(
					"保存注册提成信息出错，具体错误如下：\r\n" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除注册提成
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
				if (0 >= registerBonusService.deleteRegisterBonus(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("删除注册提成失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("删除注册提成失败，请刷新页面后重试~");
				logger_registerBonusController.warn("删除注册提成时，注册提成ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_registerBonusController.error(
					"删除注册提成出错，具体错误如下：\r\n" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

}