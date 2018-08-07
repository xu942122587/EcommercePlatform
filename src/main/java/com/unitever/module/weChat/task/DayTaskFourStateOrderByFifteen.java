package com.unitever.module.weChat.task;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.unitever.module.order.service.OrderService;

@Component
public class DayTaskFourStateOrderByFifteen {
	private Logger logger_dayTaskFourStateOrderByFifteen = LoggerFactory.getLogger("DayTaskFourStateOrderByFifteen");
	/**
	 * 定时计算。每天凌晨 00:05:01 执行一次
	 */
	@Autowired
	private OrderService orderService;

	@Scheduled(cron = "01 05 00 ? * *")
	public void show() {
		logger_dayTaskFourStateOrderByFifteen.info("每天凌晨0点5分15天自动收货定时任务开始》》》》");
		orderService.FourStateOrderByFifteenTask();
		logger_dayTaskFourStateOrderByFifteen.info("每天凌晨0点5分15天自动收货定时任务结束《《《《");
	}

}
