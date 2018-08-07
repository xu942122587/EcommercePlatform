package com.unitever.module.orderGoodsQrcode.model;

import java.util.Date;

import com.unitever.module.orderGoods.model.OrderGoods;
import com.unitever.module.qrcode.model.Qrcode;

public class OrderGoodsQrcode {

	/** Id */
	private String id;
	/** orderGoods对象 */
	private OrderGoods orderGoods;
	/** 二维码 */
	private Qrcode qrcode;
	/** 是否参与活动（1：参与，2：不参与） */
	private String isJoin;
	/** 创建时间 */
	private Date createTime;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	/**
	 * 是否参与活动:参与
	 */
	public static final String ISJOIN_YES = "1";
	/**
	 * 是否参与活动:不参与
	 */
	public static final String ISJOIN_NO = "2";

	/**
	 * 
	 */
	public OrderGoodsQrcode() {
		super();
	}

	/**
	 * @param id
	 */
	public OrderGoodsQrcode(String id) {
		super();
		this.id = id;
	}

	/**
	 * @param id
	 * @param orderGoods
	 * @param qrcode
	 * @param isJoin
	 *            是否参与活动（1：参与，2：不参与）
	 * @param createTime
	 */
	public OrderGoodsQrcode(String id, OrderGoods orderGoods, Qrcode qrcode, String isJoin, Date createTime) {
		super();
		this.id = id;
		this.orderGoods = orderGoods;
		this.qrcode = qrcode;
		this.isJoin = isJoin;
		this.createTime = createTime;
	}

	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}

	/**
	 * @param id
	 *            the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * @return the orderGoods
	 */
	public OrderGoods getOrderGoods() {
		return orderGoods;
	}

	/**
	 * @param orderGoods
	 *            the orderGoods to set
	 */
	public void setOrderGoods(OrderGoods orderGoods) {
		this.orderGoods = orderGoods;
	}

	/**
	 * @return the qrcode
	 */
	public Qrcode getQrcode() {
		return qrcode;
	}

	/**
	 * @param qrcode
	 *            the qrcode to set
	 */
	public void setQrcode(Qrcode qrcode) {
		this.qrcode = qrcode;
	}

	/**
	 * @return the isJoin 是否参与活动（1：参与，2：不参与）
	 */
	public String getIsJoin() {
		return isJoin;
	}

	/**
	 * @param isJoin
	 *            the isJoin（是否参与活动（1：参与，2：不参与）） to set
	 */
	public void setIsJoin(String isJoin) {
		this.isJoin = isJoin;
	}

	/**
	 * @return the createTime
	 */
	public Date getCreateTime() {
		return createTime;
	}

	/**
	 * @param createTime
	 *            the createTime to set
	 */
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	/**
	 * @return the ft
	 */
	public String getFt() {
		return ft;
	}

	/**
	 * @param ft
	 *            the ft to set
	 */
	public void setFt(String ft) {
		this.ft = ft;
	}

	/**
	 * @return the lt
	 */
	public String getLt() {
		return lt;
	}

	/**
	 * @param lt
	 *            the lt to set
	 */
	public void setLt(String lt) {
		this.lt = lt;
	}

	/**
	 * @return the fu
	 */
	public String getFu() {
		return fu;
	}

	/**
	 * @param fu
	 *            the fu to set
	 */
	public void setFu(String fu) {
		this.fu = fu;
	}

	/**
	 * @return the lu
	 */
	public String getLu() {
		return lu;
	}

	/**
	 * @param lu
	 *            the lu to set
	 */
	public void setLu(String lu) {
		this.lu = lu;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "OrderGoodsQrcoede [id=" + id + ", orderGoods=" + orderGoods + ", qrcode=" + qrcode + ", isJoin="
				+ isJoin + ", createTime=" + createTime + ", ft=" + ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu
				+ "]";
	}

}
