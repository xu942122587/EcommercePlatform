package com.unitever.module.statistics.controller;

import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.unitever.module.statistics.service.StatisticsService;
import com.unitever.module.store.model.Store;
import com.unitever.module.store.service.StoreService;
import com.unitever.platform.core.external.UserUtil;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.DateUtil;

@Controller
@RequestMapping(value = "/statistics")
public class StatisticsController extends SpringController {

	@Autowired
	private StatisticsService statisticsService;
	@Autowired
	private StoreService storeService;

	private Logger logger_statisticsController = LoggerFactory.getLogger("StatisticsController");

	/**
	 *
	 * <P>
	 * 营收统计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月1日
	 * @param selectDay
	 * @param selectMonth
	 * @param selectYear
	 * @param storeId
	 * @param startDate
	 * @param endDate
	 * @return String
	 */
	@RequestMapping(value = "/saleList")
	public String saleList(@RequestParam(value = "selectDay", required = false) boolean selectDay,
			@RequestParam(value = "selectMonth", required = false) boolean selectMonth,
			@RequestParam(value = "selectYear", required = false) boolean selectYear,
			@RequestParam(value = "storeId", required = false) String storeId,
			@RequestParam(value = "startDate", required = false) String startDate,
			@RequestParam(value = "endDate", required = false) String endDate) {
		Store store = new Store();
		if (StringUtils.isNotBlank(storeId)) {
			store = storeService.getStoreById(storeId);
		} else {
			if (null != UserUtil.getCurrUser().getStore()
					&& StringUtils.isNotBlank(UserUtil.getCurrUser().getStore().getId())) {
				store = UserUtil.getCurrUser().getStore();
			}
		}
		if (selectDay) {
			startDate = DateUtil.getCurrDateString("yyyy-MM-dd", new Date());
			endDate = DateUtil.getCurrDateString("yyyy-MM-dd", new Date()) + " 23:59:59";
			setAttribute("statisticsMap", statisticsService.getSaleStatisticsByDate(startDate, endDate, store));
			setAttribute("startDate", startDate);
			endDate = endDate.split(" ")[0];
			setAttribute("endDate", endDate);
		} else if (selectMonth) {
			startDate = DateUtil.getCurrDateString("yyyy-MM", new Date()) + "-01";
			endDate = DateUtil.getCurrDateString("yyyy-MM", new Date()) + "-31 23:59:59";
			setAttribute("statisticsMap", statisticsService.getSaleStatisticsByDate(startDate, endDate, store));
			setAttribute("startDate", startDate);
			endDate = endDate.split(" ")[0];
			setAttribute("endDate", endDate);
		} else if (selectYear) {
			startDate = DateUtil.getCurrDateString("yyyy", new Date()) + "-01-01";
			endDate = DateUtil.getCurrDateString("yyyy", new Date()) + "-12-31 23:59:59";
			setAttribute("statisticsMap", statisticsService.getSaleStatisticsByDate(startDate, endDate, store));
			setAttribute("startDate", startDate);
			endDate = endDate.split(" ")[0];
			setAttribute("endDate", endDate);
		} else {
			endDate = DateUtil.getCurrDateString("yyyy-MM-dd", new Date()) + " 23:59:59";
			setAttribute("statisticsMap", statisticsService.getSaleStatisticsByDate(startDate, endDate, store));
			setAttribute("startDate", startDate);
			endDate = endDate.split(" ")[0];
			setAttribute("endDate", endDate);
		}
		if (null != store && StringUtils.isNotBlank(store.getId())) {
			setAttribute("selectStore", store);
		}
		setAttribute("storeList", storeService.getAllStore());
		return "module/statistics/statistics-saleList";
	}

	/**
	 *
	 * <P>
	 * 销量统计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月1日
	 * @param selectDay
	 * @param selectMonth
	 * @param selectYear
	 * @param storeId
	 * @param startDate
	 * @param endDate
	 * @return String
	 */
	@RequestMapping(value = "/amountList")
	public String amountList(@RequestParam(value = "selectDay", required = false) boolean selectDay,
			@RequestParam(value = "selectMonth", required = false) boolean selectMonth,
			@RequestParam(value = "selectYear", required = false) boolean selectYear,
			@RequestParam(value = "storeId", required = false) String storeId,
			@RequestParam(value = "startDate", required = false) String startDate,
			@RequestParam(value = "endDate", required = false) String endDate) {
		Store store = new Store();
		if (StringUtils.isNotBlank(storeId)) {
			store = storeService.getStoreById(storeId);
		} else {
			if (null != UserUtil.getCurrUser().getStore()
					&& StringUtils.isNotBlank(UserUtil.getCurrUser().getStore().getId())) {
				store = UserUtil.getCurrUser().getStore();
			}
		}
		if (selectDay) {
			startDate = DateUtil.getCurrDateString("yyyy-MM-dd", new Date());
			endDate = DateUtil.getCurrDateString("yyyy-MM-dd", new Date()) + " 23:59:59";
			setAttribute("statisticsMap", statisticsService.getAmountStatisticsByDate(startDate, endDate, store));
			setAttribute("startDate", startDate);
			endDate = endDate.split(" ")[0];
			setAttribute("endDate", endDate);
		} else if (selectMonth) {
			startDate = DateUtil.getCurrDateString("yyyy-MM", new Date()) + "-01";
			endDate = DateUtil.getCurrDateString("yyyy-MM", new Date()) + "-31 23:59:59";
			setAttribute("statisticsMap", statisticsService.getAmountStatisticsByDate(startDate, endDate, store));
			setAttribute("startDate", startDate);
			endDate = endDate.split(" ")[0];
			setAttribute("endDate", endDate);
		} else if (selectYear) {
			startDate = DateUtil.getCurrDateString("yyyy", new Date()) + "-01-01";
			endDate = DateUtil.getCurrDateString("yyyy", new Date()) + "-12-31 23:59:59";
			setAttribute("statisticsMap", statisticsService.getAmountStatisticsByDate(startDate, endDate, store));
			setAttribute("startDate", startDate);
			endDate = endDate.split(" ")[0];
			setAttribute("endDate", endDate);
		} else {
			endDate = endDate + " 23:59:59";
			setAttribute("statisticsMap", statisticsService.getAmountStatisticsByDate(startDate, endDate, store));
			setAttribute("startDate", startDate);
			endDate = endDate.split(" ")[0];
			setAttribute("endDate", endDate);
		}
		if (null != store && StringUtils.isNotBlank(store.getId())) {
			setAttribute("selectStore", store);
		}
		setAttribute("storeList", storeService.getAllStore());
		return "module/statistics/statistics-amountList";
	}

	/**
	 *
	 * <P>
	 * 业绩统计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月1日
	 * @param selectDay
	 * @param selectMonth
	 * @param selectYear
	 * @param storeId
	 * @param startDate
	 * @param endDate
	 * @return String
	 */
	@RequestMapping(value = "/achievementList")
	public String achievementList(@RequestParam(value = "selectDay", required = false) boolean selectDay,
			@RequestParam(value = "selectMonth", required = false) boolean selectMonth,
			@RequestParam(value = "selectYear", required = false) boolean selectYear,
			@RequestParam(value = "storeId", required = false) String storeId,
			@RequestParam(value = "startDate", required = false) String startDate,
			@RequestParam(value = "endDate", required = false) String endDate) {
		Store store = new Store();
		if (StringUtils.isNotBlank(storeId)) {
			store = storeService.getStoreById(storeId);
		} else {
			if (null != UserUtil.getCurrUser().getStore()
					&& StringUtils.isNotBlank(UserUtil.getCurrUser().getStore().getId())) {
				store = UserUtil.getCurrUser().getStore();
			}
		}
		if (selectMonth) {
			startDate = DateUtil.getCurrDateString("yyyy-MM", DateUtil.getLastMonthFirstDay(new Date()));
			endDate = DateUtil.getCurrDateString("yyyy-MM", DateUtil.getLastMonthFirstDay(new Date())) + "-31 23:59:59";
			setAttribute("statisticsMap", statisticsService.getAchievementStatisticsByDate(startDate, endDate, store));
			startDate = startDate.split("-")[0] + "-" + startDate.split("-")[1];
			setAttribute("startDate", startDate);
			endDate = endDate.split("-")[0] + "-" + endDate.split("-")[1];
			setAttribute("endDate", endDate);
		} else if (selectYear) {
			startDate = DateUtil.getCurrDateString("yyyy", DateUtil.getLastYearFirstDay(new Date())) + "-01";
			endDate = DateUtil.getCurrDateString("yyyy", DateUtil.getLastYearFirstDay(new Date())) + "-12-31 23:59:59";
			setAttribute("statisticsMap", statisticsService.getAchievementStatisticsByDate(startDate, endDate, store));
			startDate = startDate.split("-")[0] + "-" + startDate.split("-")[1];
			setAttribute("startDate", startDate);
			endDate = endDate.split("-")[0] + "-" + endDate.split("-")[1];
			setAttribute("endDate", endDate);
		} else {
			endDate = endDate + "-31 23:59:59";
			setAttribute("statisticsMap", statisticsService.getAchievementStatisticsByDate(startDate, endDate, store));
			setAttribute("startDate", startDate);
			endDate = endDate.split("-")[0] + "-" + endDate.split("-")[1];
			setAttribute("endDate", endDate);
		}
		if (null != store && StringUtils.isNotBlank(store.getId())) {
			setAttribute("selectStore", store);
		}
		setAttribute("storeList", storeService.getAllStore());
		return "module/statistics/statistics-achievementList";
	}
}