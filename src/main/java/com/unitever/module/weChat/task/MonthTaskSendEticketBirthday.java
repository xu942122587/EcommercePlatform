package com.unitever.module.weChat.task;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.unitever.module.eticketoutRecord.service.EticketOutRecordService;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.weChat.task->
 * MonthTaskSendEticketBirthday.java
 * </p>
 * <P>
 * 定时任务--发送生日电子券
 * </p>
 *
 * @author 闫枫
 * @date Sep 7, 2017
 */
@Component
public class MonthTaskSendEticketBirthday {

	@Autowired
	private EticketOutRecordService eticketOutRecordService;

	private Logger logger_onthTaskSendEticketBirthday = LoggerFactory.getLogger("MonthTaskSendEticketBirthday");

	/**
	 *
	 * <P>
	 * 每月1号00:01分执行定时任务
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jan 3, 2017 void
	 */
	@Scheduled(cron = "0 01 00 1 * *")
	public void show() {
		this.logger_onthTaskSendEticketBirthday.info("task:::每月一号凌晨0点01分走一次--发送生日当月电子券-定时任务务--Start");
		eticketOutRecordService.sendAllCustomerEticketBirthday();
		this.logger_onthTaskSendEticketBirthday.info("task:::每月一号凌晨0点01分走一次--发送生日当月电子券-定时任务务--End");
	}

}
