package com.unitever.module.postageBonus.controller;

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

import com.unitever.module.postageBonus.model.PostageBonus;
import com.unitever.module.postageBonus.service.PostageBonusService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.postageBonus.controller->
 * PostageBonusController. java
 * </p>
 * <P>
 * 充值返现比例
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月5日
 */
@Controller
@RequestMapping(value = "/postageBonus")
public class PostageBonusController extends SpringController {

	@Autowired
	private PostageBonusService postageBonusService;

	private Logger logger_postageBonusController = LoggerFactory.getLogger("PostageBonusController");

	/**
	 *
	 * <P>
	 * 跳转至邮费设置列表页面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param page
	 * @param postageBonus
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<PostageBonus> page, @FormModel("model") PostageBonus postageBonus) {
		setAttribute("pageObj", postageBonusService.getPage(page, postageBonus));
		setAttribute("model", postageBonus);
		return "module/postageBonus/postageBonus-list";
	}

	/**
	 *
	 * <P>
	 * 跳转至添加更新邮费设置
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/input", method = RequestMethod.GET)
	public String input() {
		List<PostageBonus> postageBonusList = postageBonusService.getPostageBonusByPostageBonus(new PostageBonus());
		if (null != postageBonusList && 0 < postageBonusList.size()) {
			setAttribute("model", postageBonusList.get(0));
		}
		return "module/postageBonus/postageBonus-input";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看邮费设置
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam(value = "id", required = false) String id) {
		setAttribute("model", postageBonusService.getPostageBonusById(id));
		return "module/postageBonus/postageBonus-view";
	}

	/**
	 *
	 * <P>
	 * 保存邮费设置信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param postageBonus
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") PostageBonus postageBonus) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(postageBonus.getId())) {
				if (0 >= postageBonusService.update(postageBonus)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("修改邮费设置失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("修改邮费设置成功！");
				}
			} else {
				if (0 >= postageBonusService.save(postageBonus)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("添加邮费设置失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("添加邮费设置成功！");
				}
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_postageBonusController.error("保存邮费设置信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除邮费设置
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
				if (0 >= postageBonusService.deletePostageBonus(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("删除邮费设置失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("删除邮费设置失败，请刷新页面后重试~");
				logger_postageBonusController.warn("删除邮费设置时，邮费设置ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_postageBonusController.error("删除邮费设置出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

}