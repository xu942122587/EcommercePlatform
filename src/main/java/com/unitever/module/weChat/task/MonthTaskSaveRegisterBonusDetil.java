package com.unitever.module.weChat.task;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.unitever.module.registerBonusDetil.service.RegisterBonusDetilService;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.weChat.task->
 * MonthTaskSaveRegisterBonusDetil.java
 * </p>
 * <P>
 * 定时任务--保存上月注册提成记录
 * </p>
 *
 * @author 徐昊
 * @date 2017年9月18日
 */
@Component
public class MonthTaskSaveRegisterBonusDetil {

	@Autowired
	private RegisterBonusDetilService registerBonusDetilService;

	private Logger logger_monthTaskSaveRegisterBonusDetil = LoggerFactory.getLogger("MonthTaskSaveRegisterBonusDetil");

	/**
	 *
	 * <P>
	 * 每月1号00:03分执行定时任务
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月18日 void
	 */
	@Scheduled(cron = "0 03 00 1 * *")
	public void show() {
		this.logger_monthTaskSaveRegisterBonusDetil.info("task:::每月一号凌晨0点03分走一次--保存上月注册提成记录-定时任务务--Start");
		registerBonusDetilService.registerBonusDetilTask();
		this.logger_monthTaskSaveRegisterBonusDetil.info("task:::每月一号凌晨0点03分走一次--保存上月注册提成记录-定时任务务--End");
	}

}
