package com.unitever.module.finance.service;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.order.dao.manual.OrderDAO;
import com.unitever.module.order.model.Order;
import com.unitever.module.procurement.dao.manual.ProcurementDAO;
import com.unitever.module.procurement.model.Procurement;
import com.unitever.module.rechargeRecord.dao.manual.RechargeRecordDAO;
import com.unitever.module.rechargeRecord.model.RechargeRecord;
import com.unitever.platform.core.dao.Page;

@Service
@Transactional
public class FinanceService {

	@Autowired
	private OrderDAO orderDAO;
	@Autowired
	private ProcurementDAO procurementDAO;
	@Autowired
	private RechargeRecordDAO rechargeRecordDAO;

	/**
	 *
	 * <P>
	 * 获取公告信息分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param page
	 * @param order
	 * @return Page<order>
	 */
	public Page<Order> getOrderPage(Page<Order> page, Order order) {
		if (StringUtils.isNotBlank(order.getEndDate())) {
			order.setEndDate(order.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(orderDAO.getCountOrderByPayType(order));
		order.setStartOfPage(page.getStartOfPage());
		order.setPageSize(page.getPageSize());
		page.setResults(orderDAO.getOrderByPayType(order));
		if (StringUtils.isNotBlank(order.getEndDate())) {
			order.setEndDate(order.getEndDate().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 获取公告信息分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param page
	 * @param order
	 * @return Page<order>
	 */
	public Page<RechargeRecord> getRechargeRecordPage(Page<RechargeRecord> page, RechargeRecord rechargeRecord) {
		if (StringUtils.isNotBlank(rechargeRecord.getEndDate())) {
			rechargeRecord.setEndDate(rechargeRecord.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(rechargeRecordDAO.getCountByRechargeRecord(rechargeRecord));
		rechargeRecord.setStartOfPage(page.getStartOfPage());
		rechargeRecord.setPageSize(page.getPageSize());
		page.setResults(rechargeRecordDAO.getRechargeRecordByPayType(rechargeRecord));
		if (StringUtils.isNotBlank(rechargeRecord.getEndDate())) {
			rechargeRecord.setEndDate(rechargeRecord.getEndDate().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 获取公告信息分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param page
	 * @param procurement
	 * @return Page<procurement>
	 */
	public Page<Procurement> getProcurementPage(Page<Procurement> page, Procurement procurement) {
		if (StringUtils.isNotBlank(procurement.getEndDate())) {
			procurement.setEndDate(procurement.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(procurementDAO.getCountByObject(procurement));
		procurement.setStartOfPage(page.getStartOfPage());
		procurement.setPageSize(page.getPageSize());
		page.setResults(procurementDAO.getProcurementByProcurement(procurement));
		if (StringUtils.isNotBlank(procurement.getEndDate())) {
			procurement.setEndDate(procurement.getEndDate().split(" ")[0]);
		}
		return page;
	}

}
