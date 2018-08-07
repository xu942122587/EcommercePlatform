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
 * platform-tianhe->com.unitever.module.weChat.task->DayTaskRecyleEticket.java
 * </p>
 * <P>
 * 定时任务--天(定期回收电子券)
 * </p>
 *
 * @author 闫枫
 * @date Sep 7, 2017
 */
@Component
public class DayTaskRecyleEticket {
	private Logger logger_dayTaskRecyleEticket = LoggerFactory.getLogger("DayTaskRecyleEticket");
	/**
	 * 定时计算。每天凌晨 00:00:01 执行一次
	 */
	@Autowired
	private EticketOutRecordService eticketOutRecordService;

	@Scheduled(cron = "01 00 00 ? * *")
	public void show() {
		logger_dayTaskRecyleEticket.info("每天凌晨0点回收电子券定时任务开始》》》》");
		eticketOutRecordService.recycleEticketTask();
		logger_dayTaskRecyleEticket.info("每天凌晨0点回收电子券定时任务结束《《《《");
	}

}
