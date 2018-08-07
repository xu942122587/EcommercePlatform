package com.unitever.module.banner.controller;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.module.banner.model.Banner;
import com.unitever.module.banner.service.BannerService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.banner.controller->BannerController.java
 * </p>
 * <P>
 * 微信首页轮播controller
 * </p>
 *
 * @author 闫枫
 * @date Jul 1, 2017
 */
@Controller
@RequestMapping(value = "/banner")
public class BannerController extends SpringController {

	@Autowired
	private BannerService bannerService;

	private Logger logger_bannerController = LoggerFactory.getLogger("BannerController");

	/**
	 *
	 * <P>
	 * 跳转至上传更新微信首页轮播
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/input", method = RequestMethod.GET)
	public String input() {
		if (0 < bannerService.getCountByBanner(new Banner())) {
			setAttribute("model", bannerService.getBannerFirst());
		}
		return "module/banner/banner-input";
	}

	/**
	 *
	 * <P>
	 * 保存微信首页轮播信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param banner
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") Banner banner) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(banner.getId())) {
				if (0 >= bannerService.update(banner)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("上传微信首页轮播失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("上传微信首页轮播成功！");
				}
			} else {
				if (0 >= bannerService.save(banner)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("上传微信首页轮播失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("上传微信首页轮播成功！");
				}
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_bannerController.error("上传微信首页轮播信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

}