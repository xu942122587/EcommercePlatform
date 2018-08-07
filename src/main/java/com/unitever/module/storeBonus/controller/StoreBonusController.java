package com.unitever.module.storeBonus.controller;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.module.storeBonus.model.StoreBonus;
import com.unitever.module.storeBonus.service.StoreBonusService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.storeBonus.controller->
 * StoreBonusController. java
 * </p>
 * <P>
 * 充值返现比例
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月5日
 */
@Controller
@RequestMapping(value = "/storeBonus")
public class StoreBonusController extends SpringController {

	@Autowired
	private StoreBonusService storeBonusService;

	private Logger logger_storeBonusController = LoggerFactory.getLogger("StoreBonusController");

	/**
	 *
	 * <P>
	 * 跳转至服务费列表页面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param page
	 * @param storeBonus
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<StoreBonus> page, @FormModel("model") StoreBonus storeBonus) {
		setAttribute("pageObj", storeBonusService.getPage(page, storeBonus));
		setAttribute("model", storeBonus);
		return "module/storeBonus/storeBonus-list";
	}

	/**
	 *
	 * <P>
	 * 跳转至添加更新服务费
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
			setAttribute("model", storeBonusService.getStoreBonusById(id));
		}
		return "module/storeBonus/storeBonus-input";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看服务费
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam(value = "id", required = false) String id) {
		setAttribute("model", storeBonusService.getStoreBonusById(id));
		return "module/storeBonus/storeBonus-view";
	}

	/**
	 *
	 * <P>
	 * 保存服务费信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param storeBonus
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") StoreBonus storeBonus) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(storeBonus.getId())) {
				if (0 >= storeBonusService.update(storeBonus)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("修改服务费失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("修改服务费成功！");
				}
			} else {
				if (0 >= storeBonusService.save(storeBonus)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("添加服务费失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("添加服务费成功！");
				}
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_storeBonusController.error("保存服务费信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除服务费
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
				if (0 >= storeBonusService.deleteStoreBonus(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("删除服务费失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("删除服务费失败，请刷新页面后重试~");
				logger_storeBonusController.warn("删除服务费时，服务费ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_storeBonusController.error("删除服务费出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

}