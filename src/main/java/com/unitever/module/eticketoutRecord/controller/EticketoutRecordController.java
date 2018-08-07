package com.unitever.module.eticketoutRecord.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.unitever.module.eticketoutRecord.model.EticketOutRecord;
import com.unitever.module.eticketoutRecord.service.EticketOutRecordService;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;

@Controller
@RequestMapping(value = "/eticketoutRecord")
public class EticketoutRecordController extends SpringController {

	@Autowired
	private EticketOutRecordService eticketOutRecordService;

	/**
	 *
	 * <P>
	 * 跳转发放的电子券明细--页面
	 * </p>
	 *
	 * @author 闫枫
	 * @date Nov 21, 2016
	 * @param page
	 * @param storeId
	 * @return
	 */
	@RequestMapping(value = "/getListEticketOut")
	public String getListEticketOutByStore(@FormModel("page") Page<EticketOutRecord> page,
			@FormModel("model") EticketOutRecord eticketOutRecord) {
		setAttribute("model", eticketOutRecord);
		setAttribute("pageObj", eticketOutRecordService.getPage(page, eticketOutRecord));
		return "/module/eticket/jsp/eticket-listEticketOut";
	}

	/**
	 *
	 * <P>
	 * 查看电子券发放详情
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 7, 2017
	 * @param page
	 * @param eticketOutRecord
	 * @return String
	 */
	@RequestMapping(value = "/view")
	public String view(@RequestParam(value = "id") String eticketOutRecordId) {
		setAttribute("model", eticketOutRecordService.getEticketOutRecordById(eticketOutRecordId));
		return "/module/eticket/jsp/eticket-out-view";
	}
}
