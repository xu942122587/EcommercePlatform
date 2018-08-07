package com.unitever.module.weChat.task;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.unitever.module.order.service.OrderService;

/**
 *
 * <P>
 * platform-daikuan->com.unitever.module.weChat.task->DayTaskRefund.java
 * </p>
 * <P>
 * 定时任务（天）
 * </p>
 *
 * @author 闫枫
 * @date Jun 27, 2017
 */
@Component
public class DayTaskRefund {

	@Autowired
	private OrderService orderService;

	private Logger logger = LoggerFactory.getLogger("DayTask");

	/**
	 *
	 * <P>
	 * 每天00:01分执行定时任务
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jan 3, 2017 void
	 */
	@Scheduled(cron = "0 01 00 * * *")
	public void show() {
		this.logger.info("task:::每天00:01走一次--未支付订单放弃--定时任务--Start");
		orderService.giveUpOrder();
		this.logger.info("task:::每天00:01走一次--未支付订单放弃--定时任务--End");
	}

}
