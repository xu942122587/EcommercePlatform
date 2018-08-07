package com.unitever.module.orderAfterSale.dao.manual;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.unitever.module.orderAfterSale.model.OrderAfterSale;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class OrderAfterSaleDAO extends BaseDAO<OrderAfterSale, String> {

	/**
	 *
	 * 根据OrderAfterSale获取
	 *
	 * @author 徐昊
	 * @date 2017年6月29日
	 * @param order
	 * @return List<OrderAfterSale>
	 */
	public List<OrderAfterSale> getOrderAfterSaleByOrderAfterSale(OrderAfterSale orderAfterSale) {
		return this.getList("getOrderAfterSaleByOrderAfterSale", orderAfterSale);
	}

	/**
	 *
	 * 获取符合当前条件的OrderAfterSale数量
	 *
	 * @author 徐昊
	 * @date 2017年6月29日
	 * @param order
	 * @return int
	 */
	public int getCountByOrderAfterSale(OrderAfterSale orderAfterSale) {
		return this.get("getCountByOrderAfterSale", orderAfterSale);
	}

}
