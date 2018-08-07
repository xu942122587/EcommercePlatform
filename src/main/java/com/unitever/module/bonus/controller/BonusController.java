package com.unitever.module.bonus.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.module.bonus.model.BonusVo;
import com.unitever.module.bonus.service.BonusService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.bonus.controller->BonusController.java
 * </p>
 * <P>
 * 导购提成比例controller
 * </p>
 *
 * @author 闫枫
 * @date Jul 1, 2017
 */
@Controller
@RequestMapping(value = "/bonus")
public class BonusController extends SpringController {

	@Autowired
	private BonusService bonusService;

	private Logger logger_bonusController = LoggerFactory.getLogger("BonusController");

	/**
	 *
	 * <P>
	 * 跳转至上传更新导购提成比例
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/input", method = RequestMethod.GET)
	public String input() {
		setAttribute("bonusList", bonusService.getAll());
		return "module/bonus/bonus-input";
	}

	/**
	 *
	 * <P>
	 * 保存导购提成比例信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param bonus
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") BonusVo bonusVo) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			bonusService.saveBonusWithBonusVo(bonusVo);
			ajaxJson.setSuccess(true);
			ajaxJson.setMsg("保存导购提成比例信息成功！");
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_bonusController.error("保存导购提成比例信息信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

}