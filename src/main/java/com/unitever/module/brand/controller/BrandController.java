package com.unitever.module.brand.controller;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.module.brand.model.Brand;
import com.unitever.module.brand.service.BrandService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.brand.controller->BrandController.java
 * </p>
 * <P>
 * 品牌信息controller
 * </p>
 *
 * @author 闫枫
 * @date Jun 30, 2017
 */
@Controller
@RequestMapping(value = "/brand")
public class BrandController extends SpringController {

	@Autowired
	private BrandService brandService;

	private Logger logger_brandController = LoggerFactory.getLogger("BrandController");

	/**
	 *
	 * <P>
	 * 跳转至品牌信息列表页面
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param page
	 * @param brand
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<Brand> page, @FormModel("model") Brand brand) {
		setAttribute("pageObj", brandService.getPage(page, brand));
		setAttribute("model", brand);
		return "module/brand/brand-list";
	}

	/**
	 *
	 * <P>
	 * 跳转至添加更新品牌信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/input", method = RequestMethod.GET)
	public String input(@RequestParam(value = "id", required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			setAttribute("model", brandService.getBrandById(id));
		}
		return "module/brand/brand-input";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看品牌信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam(value = "id") String id) {
		setAttribute("model", brandService.getBrandById(id));
		return "module/brand/brand-view";
	}

	/**
	 *
	 * <P>
	 * 保存品牌信息信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param brand
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") Brand brand) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(brand.getId())) {
				ajaxJson.setMsg("修改品牌信息成功！");
				if (0 >= brandService.update(brand)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("修改品牌信息失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("修改品牌信息成功！");
				}
			} else {
				if (0 >= brandService.save(brand)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("添加品牌信息失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("添加品牌信息成功！");
				}
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_brandController.error(
					"保存品牌信息信息出错，具体错误如下：\r\n" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除品牌信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return int
	 */
	@RequestMapping(value = "/doDelete", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doDelete(@RequestParam(value = "id") String id) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(id)) {
				if (0 >= brandService.deleteBrand(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("删除品牌信息失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("删除品牌信息失败，请刷新页面后重试~");
				logger_brandController.warn("删除品牌信息时，品牌信息ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_brandController.error(
					"删除品牌信息出错，具体错误如下：\r\n" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}
}