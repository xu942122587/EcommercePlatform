package com.unitever.module.consume.controller;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.module.consume.model.Consume;
import com.unitever.module.consume.service.ConsumeService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.consume.controller->ConsumeController.
 * java
 * </p>
 * <P>
 * 充值记录
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月4日
 */
@Controller
@RequestMapping(value = "/consume")
public class ConsumeController extends SpringController {

	@Autowired
	private ConsumeService consumeService;

	private Logger logger_consumeController = LoggerFactory.getLogger("ConsumeController");

	/**
	 *
	 * <P>
	 * 跳转至充值管理列表页面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param page
	 * @param consume
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<Consume> page, @FormModel("model") Consume consume) {
		setAttribute("pageObj", consumeService.getPage(page, consume));
		setAttribute("model", consume);
		return "module/consume/consume-list";
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
			setAttribute("model", consumeService.getConsumeById(id));
		}
		return "module/consume/consume-input";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看充值管理
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam(value = "id", required = false) String id) {
		setAttribute("model", consumeService.getConsumeById(id));
		return "module/consume/consume-view";
	}

	/**
	 *
	 * <P>
	 * 保存充值管理信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param consume
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") Consume consume) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(consume.getId())) {
				ajaxJson.setMsg("修改充值管理成功！");
				if (0 >= consumeService.update(consume)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("修改充值管理失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("修改充值管理成功！");
				}
			} else {
				if (0 >= consumeService.save(consume)) {
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
			logger_consumeController.error("保存充值管理信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除充值管理
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
				if (0 >= consumeService.deleteConsume(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("删除充值管理失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("删除充值管理失败，请刷新页面后重试~");
				logger_consumeController.warn("删除充值管理时，充值管理ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_consumeController.error("删除充值管理出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}
}