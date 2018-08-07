package com.unitever.module.orderGoods.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.orderGoods.model.OrderGoods;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class OrderGoodsDAO extends BaseDAO<OrderGoods, String> {

	/**
	 * 根据Object获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param Goods
	 * @return List<OrderGoods>
	 */
	public List<OrderGoods> getOrderGoodsByOrderGoods(OrderGoods orderGoods) {
		return this.getList("getOrderGoodsByOrderGoods", orderGoods);
	}

	/**
	 *
	 * <P>
	 * 根据orderId获取OrderGoods集合
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月17日
	 * @param orderId
	 * @return List<OrderGoods>
	 */
	public List<OrderGoods> getAllByOrderId(String orderId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("orderId", orderId);
		return this.getList("getAllByOrderId", map);
	}

	/**
	 *
	 * <P>
	 * 根据主订单Id获取OrderGoods集合
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月17日
	 * @param orderId
	 * @return List<OrderGoods>
	 */
	public List<OrderGoods> getAllByParentOrderId(String orderId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("orderId", orderId);
		return this.getList("getAllByParentOrderId", map);
	}

	/**
	 * 获取符合当前条件的OrderGoods数量
	 * 
	 * @author XiaoYu
	 * @date 2016年12月28日
	 * @param Goods
	 * @return int
	 */
	public int getCountByOrderGoods(OrderGoods orderGoods) {
		return this.get("getCountByOrderGoods", orderGoods);
	}

	/**
	 *
	 * <P>
	 * 根据qrcodeId获取卖出OrderGoodsList(根据时间倒叙,取0拿最新一次)
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月18日
	 * @param qrcodeId
	 * @return List<OrderGoods>
	 */
	public List<OrderGoods> getOrderGoodsByQrcodeId(String qrcodeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("qrcodeId", qrcodeId);
		return this.getList("getOrderGoodsByQrcodeId", map);
	}
}
