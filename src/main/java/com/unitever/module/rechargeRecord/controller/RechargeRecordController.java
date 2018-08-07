package com.unitever.module.rechargeRecord.controller;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.module.rechargeRecord.model.RechargeRecord;
import com.unitever.module.rechargeRecord.service.RechargeRecordService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.rechargeRecord.controller->
 * RechargeRecordController. java
 * </p>
 * <P>
 * 注册提成记录
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月5日
 */
@Controller
@RequestMapping(value = "/rechargeRecord")
public class RechargeRecordController extends SpringController {

	@Autowired
	private RechargeRecordService rechargeRecordService;

	private Logger logger_rechargeRecordController = LoggerFactory.getLogger("RechargeRecordController");

	/**
	 *
	 * <P>
	 * 跳转至注册推荐列表页面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param page
	 * @param rechargeRecord
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<RechargeRecord> page, @FormModel("model") RechargeRecord rechargeRecord) {
		setAttribute("pageObj", rechargeRecordService.getPage(page, rechargeRecord));
		setAttribute("model", rechargeRecord);
		return "module/rechargeRecord/rechargeRecord-list";
	}

	/**
	 *
	 * <P>
	 * 跳转至添加更新充值管理
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
			setAttribute("model", rechargeRecordService.getRechargeRecordById(id));
		}
		return "module/rechargeRecord/rechargeRecord-input";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看注册提成详情
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam(value = "guideUserId") String guideUserId) {
		return "module/rechargeRecord/rechargeRecord-view";
	}

	/**
	 *
	 * <P>
	 * 保存充值管理信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param rechargeRecord
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") RechargeRecord rechargeRecord) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(rechargeRecord.getId())) {
				ajaxJson.setMsg("修改充值管理成功！");
				if (0 >= rechargeRecordService.update(rechargeRecord)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("修改充值管理失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("修改充值管理成功！");
				}
			} else {
				if (0 >= rechargeRecordService.save(rechargeRecord)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("添加充值管理失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("添加充值管理成功！");
				}
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_rechargeRecordController.error("保存充值管理信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

}