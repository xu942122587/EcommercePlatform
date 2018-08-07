package com.unitever.module.consumeBonusDetail.controller;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.module.consumeBonusDetail.model.ConsumeBonusDetail;
import com.unitever.module.consumeBonusDetail.service.ConsumeBonusDetailService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.consumeBonusDetail.controller->
 * ConsumeBonusDetailController. java
 * </p>
 * <P>
 * 注册提成记录
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月5日
 */
@Controller
@RequestMapping(value = "/consumeBonusDetail")
public class ConsumeBonusDetailController extends SpringController {

	@Autowired
	private ConsumeBonusDetailService consumeBonusDetailService;

	private Logger logger_consumeBonusDetailController = LoggerFactory.getLogger("ConsumeBonusDetailController");

	/**
	 *
	 * <P>
	 * 跳转至注册推荐列表页面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param page
	 * @param consumeBonusDetail
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<ConsumeBonusDetail> page,
			@FormModel("model") ConsumeBonusDetail consumeBonusDetail) {
		setAttribute("pageObj", consumeBonusDetailService.getPage(page, consumeBonusDetail));
		setAttribute("model", consumeBonusDetail);
		return "module/consumeBonusDetail/consumeBonusDetail-list";
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
			setAttribute("model", consumeBonusDetailService.getConsumeBonusDetailById(id));
		}
		return "module/consumeBonusDetail/consumeBonusDetail-input";
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
		setAttribute("consumeBonusDetailList",
				consumeBonusDetailService.getConsumeBonusDetailByGuideUserId(guideUserId));
		return "module/consumeBonusDetail/consumeBonusDetail-view";
	}

	/**
	 *
	 * <P>
	 * 保存充值管理信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param consumeBonusDetail
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") ConsumeBonusDetail consumeBonusDetail) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(consumeBonusDetail.getId())) {
				ajaxJson.setMsg("修改充值管理成功！");
				if (0 >= consumeBonusDetailService.update(consumeBonusDetail)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("修改充值管理失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("修改充值管理成功！");
				}
			} else {
				if (0 >= consumeBonusDetailService.save(consumeBonusDetail)) {
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
			logger_consumeBonusDetailController.error("保存充值管理信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 发放提成操作
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param goodsId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/sendMoney", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson sendMoney(@RequestParam(value = "consumeBonusDetailId") String consumeBonusDetailId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(consumeBonusDetailId)) {
				ConsumeBonusDetail consumeBonusDetail = new ConsumeBonusDetail(consumeBonusDetailId);
				consumeBonusDetail.setIsPayMoney(ConsumeBonusDetail.ISPAYMONEY_TRUE);
				if (0 >= consumeBonusDetailService.update(consumeBonusDetail)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("发放提成失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("发放提成成功!");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("发放提成失败，请刷新页面后重试~");
				logger_consumeBonusDetailController.warn("发放提成时，商品ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_consumeBonusDetailController.error("发放提成出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}
}