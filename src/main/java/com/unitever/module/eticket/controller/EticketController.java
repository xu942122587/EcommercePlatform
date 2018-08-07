package com.unitever.module.eticket.controller;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.module.customer.service.CustomerService;
import com.unitever.module.eticket.model.Eticket;
import com.unitever.module.eticket.service.EticketService;
import com.unitever.module.eticketoutRecord.model.EticketOutRecord;
import com.unitever.module.eticketoutRecord.service.EticketOutRecordService;
import com.unitever.module.store.service.StoreService;
import com.unitever.module.weChat.service.WeChatService;
import com.unitever.module.weChat.util.WeChatUtil;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;
import com.unitever.platform.util.ThreadPoolUtil;

@Controller
@RequestMapping(value = "/eticket")
public class EticketController extends SpringController {

	private Logger logger_eticketController = LoggerFactory.getLogger("EticketController");

	@Autowired
	private EticketService eticketService;
	@Autowired
	private EticketOutRecordService eticketOutRecordService;
	@Autowired
	private StoreService storeService;
	@Autowired
	private CustomerService customerService;
	@Autowired
	private WeChatService weChatService;

	/**
	 * 
	 * <P>
	 * 跳转至电子券列表
	 * </p>
	 * 
	 * @author 闫枫
	 * @date Sep 7, 2017
	 * @param page
	 * @param eticket
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String goEticketList(@FormModel("page") Page<Eticket> page, @FormModel("model") Eticket eticket) {
		setAttribute("pageObj", eticketService.getPage(page, eticket));
		setAttribute("model", eticket);
		return "/module/eticket/jsp/eticket-list";
	}

	/**
	 *
	 * <P>
	 * 跳转添加更新电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Nov 19, 2016
	 * @param inputKind
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/goAddEticket")
	public String goAddEticket(@RequestParam(value = "id", required = false) String id) {
		setAttribute("storeList", storeService.getAllStore());
		if (StringUtils.isNotBlank(id)) {
			setAttribute("model", eticketService.getEticketById(id));
		}
		return "/module/eticket/jsp/eticket-add";
	}

	/**
	 *
	 * <P>
	 * 跳转查看电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Nov 19, 2016
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam(value = "id") String id) {
		setAttribute("model", eticketService.getEticketById(id));
		return "/module/eticket/jsp/eticket-view";
	}

	/**
	 *
	 * <P>
	 * 保存电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Nov 19, 2016
	 * @param goods
	 * @return
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel("model") Eticket eticket) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(eticket.getId())) {
				if (0 >= eticketService.updateEticket(eticket)) {
					ajaxJson.setMsg("修改电子券失败！");
					ajaxJson.setSuccess(false);
				} else {
					ajaxJson.setMsg("修改电子券成功！");
					ajaxJson.setSuccess(true);
				}
			} else {
				if (0 >= eticketService.saveEticket(eticket)) {
					ajaxJson.setMsg("电子券失败！");
					ajaxJson.setSuccess(false);
				} else {
					ajaxJson.setMsg("添加电子券成功！");
					ajaxJson.setSuccess(true);
				}
			}
		} catch (Error e) {
			ajaxJson.setMsg("电子券失败！");
			ajaxJson.setSuccess(false);
			logger_eticketController.error("保存电子券出错，具体错误如下：" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setMsg("电子券失败！");
			ajaxJson.setSuccess(false);
			logger_eticketController
					.error("保存电子券出错，具体错误如下：" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;

	}

	/**
	 *
	 * <P>
	 * 删除电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Nov 19, 2016
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/doDelete", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doDelete(String id) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (0 >= eticketService.deleteEticketById(id)) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("删除电子券失败");
			} else {
				ajaxJson.setSuccess(true);
				ajaxJson.setMsg("删除电子券成功");
			}
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~出错了。刷新页面重试吧");
			logger_eticketController.error("删除电子券出错，错误如下：" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~出错了。刷新页面重试吧");
			logger_eticketController
					.error("删除电子券出错，错误如下：" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 跳转手动发放电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Nov 21, 2016
	 * @return
	 */
	@RequestMapping(value = "/goManualOutEticket", method = RequestMethod.GET)
	public String goManualOutEticket() {
		setAttribute("eticketList", eticketService.getAllManualEticket());
		setAttribute("customerList", customerService.getAllNoBlankCustomer());
		return "/module/eticket/jsp/eticket-manualOut";
	}

	/**
	 *
	 * <P>
	 * 手动发放电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Nov 19, 2016
	 * @param eticketOutRecord
	 * @return
	 */
	@RequestMapping(value = "/doManualOutEticket", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doManualOutEticket(@FormModel("model") EticketOutRecord eticketOutRecord) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			eticketOutRecord.setState(EticketOutRecord.STATUS_NORMAL);
			if (0 >= eticketOutRecordService.saveEticketOutRecord(eticketOutRecord)) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("发放电子券失败");
			} else {
				ajaxJson.setSuccess(true);
				ajaxJson.setMsg("发放电子券成功");
				final String etickedOutId = eticketOutRecord.getId();
				ThreadPoolUtil.getPool().execute(new Runnable() {
					public void run() {
						try {
							WeChatUtil.getNewEticket(eticketOutRecordService.getEticketOutRecordById(etickedOutId),
									weChatService.getWeChatList().get(0));
						} catch (Exception e) {
							logger_eticketController.error("发送获得电子券模板消息--出错，错误如下："
									+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
						}
					}
				});
			}
		} catch (Error e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~出错了。刷新页面重试吧");
			logger_eticketController.error("手动发放电子券出错，错误如下：" + e.getMessage());
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~出错了。刷新页面重试吧");
			logger_eticketController
					.error("手动发放电子券出错，错误如下：" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}
}
