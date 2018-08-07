package com.unitever.module.consumeBonus.controller;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.module.consumeBonus.model.ConsumeBonus;
import com.unitever.module.consumeBonus.service.ConsumeBonusService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.consumeBonus.controller->
 * ConsumeBonusController. java
 * </p>
 * <P>
 * 充值返现比例
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月5日
 */
@Controller
@RequestMapping(value = "/consumeBonus")
public class ConsumeBonusController extends SpringController {

	@Autowired
	private ConsumeBonusService consumeBonusService;

	private Logger logger_consumeBonusController = LoggerFactory.getLogger("ConsumeBonusController");

	/**
	 *
	 * <P>
	 * 跳转至充值提成列表页面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param page
	 * @param consumeBonus
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<ConsumeBonus> page, @FormModel("model") ConsumeBonus consumeBonus) {
		setAttribute("pageObj", consumeBonusService.getPage(page, consumeBonus));
		setAttribute("model", consumeBonus);
		return "module/consumeBonus/consumeBonus-list";
	}

	/**
	 *
	 * <P>
	 * 跳转至添加更新充值提成
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/input", method = RequestMethod.GET)
	public String input(@RequestParam(value = "id", required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			setAttribute("model", consumeBonusService.getConsumeBonusById(id));
		}
		return "module/consumeBonus/consumeBonus-input";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看充值提成
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam(value = "id", required = false) String id) {
		setAttribute("model", consumeBonusService.getConsumeBonusById(id));
		return "module/consumeBonus/consumeBonus-view";
	}

	/**
	 *
	 * <P>
	 * 保存充值提成信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param consumeBonus
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") ConsumeBonus consumeBonus) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(consumeBonus.getId())) {
				if (0 >= consumeBonusService.update(consumeBonus)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("修改充值提成失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("修改充值提成成功！");
				}
			} else {
				if (0 >= consumeBonusService.save(consumeBonus)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("添加充值提成失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("添加充值提成成功！");
				}
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_consumeBonusController.error("保存充值提成信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除充值提成
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
				if (0 >= consumeBonusService.deleteConsumeBonus(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("删除充值提成失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("删除充值提成失败，请刷新页面后重试~");
				logger_consumeBonusController.warn("删除充值提成时，充值提成ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_consumeBonusController.error("删除充值提成出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

}