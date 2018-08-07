package com.unitever.module.weChat.task;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.unitever.module.consumeBonusDetail.service.ConsumeBonusDetailService;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.weChat.task->
 * MonthTaskSaveConsumeBonusDetail.java
 * </p>
 * <P>
 * 定时任务--保存上月充值提成记录
 * </p>
 *
 * @author 徐昊
 * @date 2017年9月18日
 */
@Component
public class MonthTaskSaveConsumeBonusDetail {

	@Autowired
	private ConsumeBonusDetailService consumeBonusDetailService;

	private Logger logger_monthTaskSaveConsumeBonusDetail = LoggerFactory.getLogger("MonthTaskSaveConsumeBonusDetail");

	/**
	 *
	 * <P>
	 * 每月1号00:02分执行定时任务
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月18日 void
	 */
	@Scheduled(cron = "0 02 00 1 * *")
	public void show() {
		this.logger_monthTaskSaveConsumeBonusDetail.info("task:::每月一号凌晨0点02分走一次--保存上月充值提成记录-定时任务务--Start");
		consumeBonusDetailService.consumeBonusDetailTask();
		this.logger_monthTaskSaveConsumeBonusDetail.info("task:::每月一号凌晨0点02分走一次--保存上月充值提成记录-定时任务务--End");
	}

}
