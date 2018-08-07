package com.unitever.module.orderGoods.model;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.unitever.module.goods.model.Goods;
import com.unitever.module.order.model.Order;
import com.unitever.module.orderGoodsQrcode.model.OrderGoodsQrcode;
import com.unitever.module.orderSubremark.model.OrderSubremark;
import com.unitever.platform.util.DoubleUtil;

/**
 *
 * * 订单
 * </p>
 *
 */
public class OrderGoods implements Comparable<OrderGoods> {

	/** Id */
	private String id;
	/** 菜单 */
	private Order order;
	/** 商品 */
	private Goods goods;
	/** 数量 */
	private String count;
	/** 单价 */
	private String price;
	/** 减免金额 */
	private String subMoney;
	/** 类型 （1：卖出，2：退货） */
	private String type;
	/** 订单减免记录 */
	private OrderSubremark orderSubremark;
	/** 创建时间 */
	private Date createTime;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用

	/** 减免记录ID */
	private String OSM_ID;

	/**
	 * 单件减免金额
	 */
	private String subMoneyOne;
	/**
	 * 单件最终成交价
	 */
	private String salesPrice;

	/**
	 * 订单商品对应的qrcode列表
	 */
	private List<OrderGoodsQrcode> oGQList;
	/** 是否参与活动（1：参与，2：不参与） */
	private String isJoin;
	/**
	 * 是否参与活动:参与
	 */
	public static final String ISJOIN_YES = "1";
	/**
	 * 是否参与活动:不参与
	 */
	public static final String ISJOIN_NO = "2";

	/** 类型：卖出 */
	public static final String TYPE_OUT = "1";
	/** 类型：退货（消费者） */
	public static final String TYPE_RETURN_TIANHE = "2";

	public OrderGoods() {
		super();
	}

	public OrderGoods(String id) {
		super();
		this.id = id;
	}

	public OrderGoods(String id, Order order, Goods goods, String count, String price, String subMoney, String type,
			Date createTime) {
		super();
		this.id = id;
		this.order = order;
		this.goods = goods;
		this.count = count;
		this.price = price;
		this.subMoney = subMoney;
		this.type = type;
		this.createTime = createTime;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getSubMoney() {
		return subMoney;
	}

	public void setSubMoney(String subMoney) {
		this.subMoney = subMoney;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getFt() {
		return ft;
	}

	public void setFt(String ft) {
		this.ft = ft;
	}

	public String getLt() {
		return lt;
	}

	public void setLt(String lt) {
		this.lt = lt;
	}

	public String getFu() {
		return fu;
	}

	public void setFu(String fu) {
		this.fu = fu;
	}

	public String getLu() {
		return lu;
	}

	public void setLu(String lu) {
		this.lu = lu;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	/**
	 * @return the oGQList 订单商品对应的qrcode列表
	 */
	public List<OrderGoodsQrcode> getoGQList() {
		return oGQList;
	}

	/**
	 * @param oGQList
	 *            the oGQList（订单商品对应的qrcode列表） to set
	 */
	public void setoGQList(List<OrderGoodsQrcode> oGQList) {
		this.oGQList = oGQList;
	}

	/**
	 * @return the orderSubremark 订单减免记录
	 */
	public OrderSubremark getOrderSubremark() {
		return orderSubremark;
	}

	/**
	 * @param orderSubremark
	 *            the orderSubremark(订单减免记录) to set
	 */
	public void setOrderSubremark(OrderSubremark orderSubremark) {
		this.orderSubremark = orderSubremark;
	}

	@Override
	public String toString() {
		return "OrderGoods [id=" + id + ", order=" + order + ", goods=" + goods + ", count=" + count + ", price="
				+ price + ", subMoney=" + subMoney + ", type=" + type + ", createTime=" + createTime + ", ft=" + ft
				+ ", lt=" + lt + ", fu=" + fu + ", lu=" + lu + "]";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Comparable#compareTo(java.lang.Object)
	 */
	public int compareTo(OrderGoods orderGoods) {
		return new BigDecimal(orderGoods.getPrice()).compareTo(new BigDecimal(this.price));
	}

	/**
	 * @return the isJoin 是否参与活动（1：参与，2：不参与）
	 */
	public String getIsJoin() {
		return isJoin;
	}

	/**
	 * @param isJoin
	 *            the isJoin(是否参与活动（1：参与，2：不参与）) to set
	 */
	public void setIsJoin(String isJoin) {
		this.isJoin = isJoin;
	}

	/**
	 * @return the subMoneyOne 单件减免金额
	 */
	public String getSubMoneyOne() {
		return DoubleUtil.div(StringUtils.isBlank(this.getSubMoney()) ? "0.0" : this.getSubMoney(), this.getCount(), 2)
				.toString();
	}

	/**
	 * @return the salesPrice 单件最终成交价
	 */
	public String getSalesPrice() {
		return DoubleUtil.sub(this.getPrice(), this.getSubMoneyOne(), 2).toString();
	}

	/**
	 * @return the oSM_ID 减免记录ID
	 */
	public String getOSM_ID() {
		return OSM_ID;
	}

	/**
	 * @param oSM_ID
	 *            the oSM_ID(减免记录ID) to set
	 */
	public void setOSM_ID(String oSM_ID) {
		this.OSM_ID = oSM_ID;
	}
}
