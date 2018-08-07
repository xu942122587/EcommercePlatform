package com.unitever.module.orderGoods.vo;

import java.util.List;

import com.unitever.module.orderGoods.model.OrderGoods;

/**
 *
 * 订单商品Vo类 切割产品级订单使用
 *
 */
public class OrderGoodsVo {

	private List<OrderGoods> orderGoodsList;
	private String sumCount;
	private String sumMoney;

	/**
	 * @param orderGoodsList
	 * @param sumCount
	 * @param sumMoney
	 */
	public OrderGoodsVo(List<OrderGoods> orderGoodsList, String sumCount, String sumMoney) {
		super();
		this.orderGoodsList = orderGoodsList;
		this.sumCount = sumCount;
		this.sumMoney = sumMoney;
	}

	/**
	 * @return the orderGoodsList
	 */
	public List<OrderGoods> getOrderGoodsList() {
		return orderGoodsList;
	}

	/**
	 * @param orderGoodsList
	 *            the orderGoodsList to set
	 */
	public void setOrderGoodsList(List<OrderGoods> orderGoodsList) {
		this.orderGoodsList = orderGoodsList;
	}

	/**
	 * @return the sumCount
	 */
	public String getSumCount() {
		return sumCount;
	}

	/**
	 * @param sumCount
	 *            the sumCount to set
	 */
	public void setSumCount(String sumCount) {
		this.sumCount = sumCount;
	}

	/**
	 * @return the sumMoney
	 */
	public String getSumMoney() {
		return sumMoney;
	}

	/**
	 * @param sumMoney
	 *            the sumMoney to set
	 */
	public void setSumMoney(String sumMoney) {
		this.sumMoney = sumMoney;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "OrderGoodsVo [orderGoodsList=" + orderGoodsList + ", sumCount=" + sumCount + ", sumMoney=" + sumMoney
				+ "]";
	}

}
