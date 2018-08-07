package com.unitever.module.storeBonusDetail.controller;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.module.storeBonusDetail.model.StoreBonusDetail;
import com.unitever.module.storeBonusDetail.service.StoreBonusDetilService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.storeBonusDetil.controller->
 * StoreBonusDetailController. java
 * </p>
 * <P>
 * 商家店服务费记录
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月5日
 */
@Controller
@RequestMapping(value = "/storeBonusDetil")
public class StoreBonusDetailController extends SpringController {

	@Autowired
	private StoreBonusDetilService storeBonusDetilService;

	private Logger logger_storeBonusDetilController = LoggerFactory.getLogger("StoreBonusDetailController");

	/**
	 *
	 * <P>
	 * 跳转至注册推荐列表页面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param page
	 * @param storeBonusDetil
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<StoreBonusDetail> page,
			@FormModel("model") StoreBonusDetail storeBonusDetil) {
		setAttribute("pageObj", storeBonusDetilService.getPage(page, storeBonusDetil));
		setAttribute("model", storeBonusDetil);
		return "module/storeBonusDetil/storeBonusDetil-list";
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
			setAttribute("model", storeBonusDetilService.getStoreBonusDetailById(id));
		}
		return "module/storeBonusDetil/storeBonusDetil-input";
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
	public String view(@RequestParam(value = "storeId") String storeId) {
		setAttribute("storeBonusDetilList", storeBonusDetilService.getStoreBonusDetailByStoreId(storeId));
		return "module/storeBonusDetil/storeBonusDetil-view";
	}

	/**
	 *
	 * <P>
	 * 保存服务费信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param storeBonusDetil
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") StoreBonusDetail storeBonusDetil) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(storeBonusDetil.getId())) {
				ajaxJson.setMsg("修改服务费成功！");
				if (0 >= storeBonusDetilService.update(storeBonusDetil)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("修改服务费失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("修改服务费成功！");
				}
			} else {
				if (0 >= storeBonusDetilService.save(storeBonusDetil)) {
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
			logger_storeBonusDetilController.error("保存服务费信息出错，具体错误如下：\r\n"
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
	public AjaxJson sendMoney(@RequestParam(value = "storeBonusDetilId") String storeBonusDetilId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(storeBonusDetilId)) {
				StoreBonusDetail storeBonusDetil = new StoreBonusDetail(storeBonusDetilId);
				storeBonusDetil.setIsPayMoney(StoreBonusDetail.ISPAYMONEY_TRUE);
				if (0 >= storeBonusDetilService.update(storeBonusDetil)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("发放提成失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("发放提成成功!");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("发放提成失败，请刷新页面后重试~");
				logger_storeBonusDetilController.warn("发放提成时，商品ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_storeBonusDetilController.error("发放提成出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}
}