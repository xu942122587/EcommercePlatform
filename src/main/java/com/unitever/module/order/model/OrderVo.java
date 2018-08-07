package com.unitever.module.order.model;

import java.util.List;

import com.unitever.module.customer.model.Customer;

public class OrderVo {

	private String batchCode;
	private Customer customer;
	private List<Order> orderList;
	private String state;
	private String type;

	/** 订单状况名称 */
	private String stateValue;
	/** 订单状况1 未支付 */
	public static final String STATE_ONE = "1";
	/** 订单状况2 未发货 */
	public static final String STATE_TWO = "2";
	/** 订单状况3 已出库 */
	public static final String STATE_THREE = "3";
	/** 订单状况4 已发货 */
	public static final String STATE_FOUR = "4";
	/** 订单状况5 待评价 */
	public static final String STATE_FIVE = "5";
	/** 订单状况6 完成 */
	public static final String STATE_SIX = "6";
	/** 订单状况7 放弃 */
	public static final String STATE_SEVEN = "7";

	/** 订单类别名称 */
	private String typeValue;
	/** 订单类别1 线上 */
	public static final String TYPE_ONE = "1";
	/** 订单类别2 线下 */
	public static final String TYPE_TWO = "2";
	/** 订单类别3 换购 */
	public static final String TYPE_THREE = "3";
	/** 订单类别4 预约 */
	public static final String TYPE_FOUR = "4";
	/** 订单类别5 退货 */
	public static final String TYPE_FIVE = "5";
	/** 订单类别6 换货 */
	public static final String TYPE_SIX = "6";
	/** 订单类别7 同商品换货 */
	public static final String TYPE_SEVEN = "7";
	/** 订单类别8 赔偿 */
	public static final String TYPE_EIGHT = "8";

	/**
	 * @return the state
	 */
	public String getState() {
		return state;
	}

	/**
	 * @param state
	 *            the state to set
	 */
	public void setState(String state) {
		this.state = state;
	}

	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type
	 *            the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return the customer
	 */
	public Customer getCustomer() {
		return customer;
	}

	/**
	 * @param customer
	 *            the customer to set
	 */
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	/**
	 * @return the batchCode
	 */
	public String getBatchCode() {
		return batchCode;
	}

	/**
	 * @param batchCode
	 *            the batchCode to set
	 */
	public void setBatchCode(String batchCode) {
		this.batchCode = batchCode;
	}

	/**
	 * @return the orderList
	 */
	public List<Order> getOrderList() {
		return orderList;
	}

	/**
	 * @param orderList
	 *            the orderList to set
	 */
	public void setOrderList(List<Order> orderList) {
		this.orderList = orderList;
	}

	/**
	 * @return the typeValue
	 */
	public String getTypeValue() {
		if (TYPE_ONE.equals(type)) {
			return "线上";
		} else if (TYPE_TWO.equals(type)) {
			return "线下";
		} else if (TYPE_THREE.equals(type)) {
			return "换购";
		} else if (TYPE_FOUR.equals(type)) {
			return "预约";
		} else if (TYPE_FIVE.equals(type)) {
			return "退货";
		} else if (TYPE_SIX.equals(type)) {
			return "换货";
		} else if (TYPE_SEVEN.equals(type)) {
			return "同商品换货";
		} else if (TYPE_EIGHT.equals(type)) {
			return "赔偿";
		}
		return null;
	}

	/**
	 * @return the stateValue
	 */
	public String getStateValue() {
		if (STATE_ONE.equals(state)) {
			return "未支付";
		} else if (STATE_TWO.equals(state)) {
			return "未发货";
		} else if (STATE_THREE.equals(state)) {
			return "已出库";
		} else if (STATE_FOUR.equals(state)) {
			return "已发货";
		} else if (STATE_FIVE.equals(state)) {
			return "待评价";
		} else if (STATE_SIX.equals(state)) {
			return "完成";
		} else if (STATE_SEVEN.equals(state)) {
			return "放弃";
		}
		return null;
	}
}
