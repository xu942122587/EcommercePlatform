package com.unitever.module.bonusDetail.controller;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.module.bonusDetail.model.BonusDetail;
import com.unitever.module.bonusDetail.service.BonusDetailService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.bonusDetail.controller->
 * BonusDetailController. java
 * </p>
 * <P>
 * 注册提成记录
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月5日
 */
@Controller
@RequestMapping(value = "/bonusDetail")
public class BonusDetailController extends SpringController {

	@Autowired
	private BonusDetailService bonusDetailService;

	private Logger logger_bonusDetailController = LoggerFactory.getLogger("BonusDetailController");

	/**
	 *
	 * <P>
	 * 跳转至注册推荐列表页面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param page
	 * @param bonusDetail
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<BonusDetail> page, @FormModel("model") BonusDetail bonusDetail) {
		setAttribute("pageObj", bonusDetailService.getPage(page, bonusDetail));
		setAttribute("model", bonusDetail);
		return "module/bonusDetail/bonusDetail-list";
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
			setAttribute("model", bonusDetailService.getBonusDetailById(id));
		}
		return "module/bonusDetail/bonusDetail-input";
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
		setAttribute("bonusDetailList", bonusDetailService.getBonusDetailByGuideUserId(guideUserId));
		return "module/bonusDetail/bonusDetail-view";
	}

	/**
	 *
	 * <P>
	 * 保存充值管理信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param bonusDetail
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") BonusDetail bonusDetail) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(bonusDetail.getId())) {
				ajaxJson.setMsg("修改充值管理成功！");
				if (0 >= bonusDetailService.update(bonusDetail)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("修改充值管理失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("修改充值管理成功！");
				}
			} else {
				if (0 >= bonusDetailService.save(bonusDetail)) {
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
			logger_bonusDetailController.error("保存充值管理信息出错，具体错误如下：\r\n"
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
	public AjaxJson sendMoney(@RequestParam(value = "bonusDetailId") String bonusDetailId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(bonusDetailId)) {
				BonusDetail bonusDetail = new BonusDetail(bonusDetailId);
				bonusDetail.setIsPayMoney(BonusDetail.ISPAYMONEY_TRUE);
				if (0 >= bonusDetailService.update(bonusDetail)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("发放提成失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("发放提成成功!");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("发放提成失败，请刷新页面后重试~");
				logger_bonusDetailController.warn("发放提成时，商品ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_bonusDetailController.error("发放提成出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}
}