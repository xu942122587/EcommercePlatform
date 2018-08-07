package com.unitever.module.notice.controller;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.module.notice.model.Notice;
import com.unitever.module.notice.service.NoticeService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

@Controller
@RequestMapping(value = "/notice")
public class NoticeController extends SpringController {

	@Autowired
	private NoticeService noticeService;

	private Logger logger_noticeController = LoggerFactory.getLogger("NoticeController");

	/**
	 *
	 * <P>
	 * 跳转至公告信息列表页面
	 * </p>
	 *
	 * @date Jun 29, 2017
	 * @param page
	 * @param notice
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<Notice> page, @FormModel("model") Notice notice) {
		setAttribute("pageObj", noticeService.getPage(page, notice));
		setAttribute("model", notice);
		return "module/notice/notice-list";
	}

	/**
	 *
	 * <P>
	 * 跳转至添加更新公告信息
	 * </p>
	 *
	 * @date Jun 29, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/input", method = RequestMethod.GET)
	public String input(@RequestParam(value = "id", required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			setAttribute("model", noticeService.getNoticeById(id));
		}
		return "module/notice/notice-input";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看公告信息
	 * </p>
	 *
	 * @date Jun 29, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam(value = "id") String id,
			@RequestParam(value = "isIndex", required = false) String isIndex) {
		setAttribute("model", noticeService.getNoticeById(id));
		setAttribute("isIndex", isIndex);
		return "module/notice/notice-view";
	}

	/**
	 *
	 * <P>
	 * 保存公告信息信息
	 * </p>
	 *
	 * @date Jun 29, 2017
	 * @param notice
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") Notice notice) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(notice.getId())) {
				ajaxJson.setMsg("修改公告信息成功！");
				if (0 >= noticeService.update(notice)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("修改公告信息失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("修改公告信息成功！");
				}
			} else {
				if (0 >= noticeService.save(notice)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("添加公告信息失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("添加公告信息成功！");
				}
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_noticeController.error(
					"保存公告信息信息出错，具体错误如下：\r\n" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除公告信息
	 * </p>
	 *
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
				if (0 >= noticeService.deleteNotice(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("删除公告信息失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("删除公告信息失败，请刷新页面后重试~");
				logger_noticeController.warn("删除公告信息时，公告信息ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_noticeController.error(
					"删除公告信息出错，具体错误如下：\r\n" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}
}