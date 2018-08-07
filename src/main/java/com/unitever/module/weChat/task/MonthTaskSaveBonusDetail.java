package com.unitever.module.weChat.task;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.unitever.module.bonusDetail.service.BonusDetailService;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.weChat.task->MonthTaskSaveBonusDetail.
 * java
 * </p>
 * <P>
 * 定时任务--保存上月销售提成记录
 * </p>
 *
 * @author 徐昊
 * @date 2017年9月18日
 */
@Component
public class MonthTaskSaveBonusDetail {

	@Autowired
	private BonusDetailService bonusDetailService;

	private Logger logger_monthTaskSaveBonusDetail = LoggerFactory.getLogger("MonthTaskSaveBonusDetail");

	/**
	 *
	 * <P>
	 * 每月1号00:04分执行定时任务
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月18日 void
	 */
	@Scheduled(cron = "0 04 00 1 * *")
	public void show() {
		this.logger_monthTaskSaveBonusDetail.info("task:::每月一号凌晨0点04分走一次--保存上月销售提成记录-定时任务务--Start");
		bonusDetailService.bonusDetailTask();
		this.logger_monthTaskSaveBonusDetail.info("task:::每月一号凌晨0点04分走一次--保存上月销售提成记录-定时任务务--End");
	}

}
