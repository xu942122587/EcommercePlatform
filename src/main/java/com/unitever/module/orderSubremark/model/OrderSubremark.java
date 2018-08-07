package com.unitever.module.orderSubremark.model;

import java.util.Date;

import org.apache.commons.lang.StringUtils;

import com.unitever.module.order.model.Order;
import com.unitever.module.orderGoods.model.OrderGoods;
import com.unitever.module.promotion.model.Promotion;
import com.unitever.module.promotionLadder.model.PromotionLadder;
import com.unitever.platform.core.dao.BaseModel;

/**
 *
 * * 订单减免记录 </p>
 *
 */
public class OrderSubremark extends BaseModel {

	/** Id */
	private String id;
	/** 所属订单 */
	private Order order;
	/** 订单商品ID(针对商品的活动才放值） */
	private OrderGoods orderGoods;
	/** 活动阶梯ID(满足那哪个阶梯使用哪个阶梯优惠） */
	private PromotionLadder promotionLadder;
	/** 活动ID，无阶梯活动的使用本字段 */
	private Promotion promotion;
	/** 优惠是否发放(1：未发放，2：已发放） */
	private String isSendLadder;
	/** 待补交金额 */
	private String salesMoney;
	/** 订单减免备注 */
	private String remark;
	/** 赠品发放记录 */
	private String putOutGoodsQrcodeString;
	/** 创建时间 */
	private Date createTime;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用

	private String isSendLadderVlaue;
	/**
	 * 优惠是否发放:未发放
	 */
	public static final String ISSENDLADDER_NO = "1";
	/**
	 * 优惠是否发放:已发放
	 */
	public static final String ISSENDLADDER_YES = "2";

	public OrderSubremark() {
		super();
	}

	public OrderSubremark(String id) {
		super();
		this.id = id;
	}

	/**
	 * <p>
	 * 产品级有优惠级别--构造方法
	 * </p>
	 * 
	 * @param id
	 * @param orderGoods
	 * @param promotionLadder
	 * @param isSendLadder
	 * @param createTime
	 */
	public OrderSubremark(String id, OrderGoods orderGoods, PromotionLadder promotionLadder, String isSendLadder,
			Date createTime) {
		super();
		this.id = id;
		this.orderGoods = orderGoods;
		this.promotionLadder = promotionLadder;
		this.isSendLadder = isSendLadder;
		this.createTime = createTime;
	}

	/**
	 * *
	 * <p>
	 * 产品级没有优惠级别--构造方法
	 * </p>
	 * 
	 * @param id
	 * @param orderGoods
	 * @param promotion
	 * @param isSendLadder
	 * @param createTime
	 */
	public OrderSubremark(String id, OrderGoods orderGoods, Promotion promotion, String isSendLadder, Date createTime) {
		super();
		this.id = id;
		this.orderGoods = orderGoods;
		this.promotion = promotion;
		this.isSendLadder = isSendLadder;
		this.createTime = createTime;
	}

	/**
	 * <p>
	 * 订单级有优惠级别--构造方法
	 * </p>
	 * 
	 * @param id
	 * @param order
	 * @param promotionLadder
	 * @param isSendLadder
	 * @param createTime
	 */
	public OrderSubremark(String id, Order order, PromotionLadder promotionLadder, String isSendLadder, Date createTime) {
		super();
		this.id = id;
		this.order = order;
		this.promotionLadder = promotionLadder;
		this.isSendLadder = isSendLadder;
		this.createTime = createTime;
	}

	/**
	 * <p>
	 * 订单级，没有有优惠级别--构造方法
	 * </p>
	 * 
	 * @param id
	 * @param order
	 * @param promotion
	 * @param isSendLadder
	 * @param createTime
	 */
	public OrderSubremark(String id, Order order, Promotion promotion, String isSendLadder, Date createTime) {
		super();
		this.id = id;
		this.order = order;
		this.promotion = promotion;
		this.isSendLadder = isSendLadder;
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

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
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
	 * @return the orderGoods 订单商品ID(针对商品的活动才放值）
	 */
	public OrderGoods getOrderGoods() {
		return orderGoods;
	}

	/**
	 * @param orderGoods
	 *            the orderGoods 订单商品ID(针对商品的活动才放值） to set
	 */
	public void setOrderGoods(OrderGoods orderGoods) {
		this.orderGoods = orderGoods;
	}

	/**
	 * @return the promotionLadder 活动阶梯ID(满足那哪个阶梯使用哪个阶梯优惠）
	 */
	public PromotionLadder getPromotionLadder() {
		return promotionLadder;
	}

	/**
	 * @param promotionLadder
	 *            the promotionLadder 活动阶梯ID(满足那哪个阶梯使用哪个阶梯优惠） to set
	 */
	public void setPromotionLadder(PromotionLadder promotionLadder) {
		this.promotionLadder = promotionLadder;
	}

	/**
	 * @return the promotion 活动ID，无阶梯活动的使用本字段
	 */
	public Promotion getPromotion() {
		return promotion;
	}

	/**
	 * @param promotion
	 *            the promotion(活动ID，无阶梯活动的使用本字段) to set
	 */
	public void setPromotion(Promotion promotion) {
		this.promotion = promotion;
	}

	/**
	 * @return the isSendLadder 优惠是否发放(1：未发放，2：已发放）
	 */
	public String getIsSendLadder() {
		return isSendLadder;
	}

	/**
	 * @param isSendLadder
	 *            the isSendLadder(优惠是否发放(1：未发放，2：已发放）) to set
	 */
	public void setIsSendLadder(String isSendLadder) {
		this.isSendLadder = isSendLadder;
	}

	/**
	 * @return the isSendLadderVlaue
	 */
	public String getIsSendLadderVlaue() {
		switch (isSendLadder) {
		case ISSENDLADDER_NO:
			isSendLadderVlaue = "未发放";
			break;
		case ISSENDLADDER_YES:
			isSendLadderVlaue = "已发放";
			break;
		default:
			isSendLadderVlaue = "未知";
			break;
		}
		return isSendLadderVlaue;
	}

	/**
	 * @param isSendLadderVlaue
	 *            the isSendLadderVlaue to set
	 */
	public void setIsSendLadderVlaue(String isSendLadderVlaue) {
		this.isSendLadderVlaue = isSendLadderVlaue;
	}

	/**
	 * @return the salesMoney 待补交金额
	 */
	public String getSalesMoney() {
		return StringUtils.isNotBlank(salesMoney) ? salesMoney : "0.0";
	}

	/**
	 * @param salesMoney
	 *            the salesMoney(待补交金额) to set
	 */
	public void setSalesMoney(String salesMoney) {
		this.salesMoney = salesMoney;
	}

	/**
	 * @return the putOutGoodsQrcodeString 赠品发放记录
	 */
	public String getPutOutGoodsQrcodeString() {
		return putOutGoodsQrcodeString;
	}

	/**
	 * @param putOutGoodsQrcodeString
	 *            the putOutGoodsQrcodeString（赠品发放记录） to set
	 */
	public void setPutOutGoodsQrcodeString(String putOutGoodsQrcodeString) {
		this.putOutGoodsQrcodeString = putOutGoodsQrcodeString;
	}
}
