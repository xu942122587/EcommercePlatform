package com.unitever.module.promotionLadder.model;

import java.util.Date;

import com.unitever.module.goods.model.Goods;
import com.unitever.module.promotion.model.Promotion;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.promotionLadder.model->PromotionLadder.
 * java
 * </p>
 * <P>
 * 活动阶梯条件
 * </p>
 *
 * @author 闫枫
 * @date Aug 2, 2017
 */
public class PromotionLadder {

	/** Id */
	private String id;
	/**
	 * 所属促销活动
	 */
	private Promotion promotion;
	/**
	 * 阶梯起点金额或件数
	 */
	private String ladderStart;
	/**
	 * 减免金额或折扣比例
	 */
	private String promotionMoney;
	/**
	 * 产品换购价
	 */
	private String goodsPrice;
	/**
	 * 购买产品数量
	 */
	private String goodsNumberBuy;
	/**
	 * 赠送(换购)产品ID
	 */
	private Goods goods;
	/**
	 * 赠送产品数量
	 */
	private String goodsNumber;
	/** 是否删除（1：否，2：是） */
	private String isDelete;
	/** 创建时间 */
	private Date createTime;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用

	/**
	 * 是否删除--否
	 */
	public static final String ISDELETE_NO = "1";
	/**
	 * 是否删除--是
	 */
	public static final String ISDELETE_YES = "2";

	/**
	 * 
	 */
	public PromotionLadder() {
		super();
	}

	/**
	 * @param id
	 */
	public PromotionLadder(String id) {
		super();
		this.id = id;
	}

	/**
	 * @param id
	 * @param promotion
	 *            所属促销活动
	 * @param ladderStart
	 *            阶梯起点金额或件数
	 * @param promotionMoney
	 *            减免金额或折扣比例
	 * @param goods
	 *            赠送(换购)产品ID
	 * @param goodsPrice
	 *            赠送产品数量
	 * @param goodsNumber
	 *            赠送产品数量
	 * @param createTime
	 */
	public PromotionLadder(String id, Promotion promotion, String ladderStart, String promotionMoney, Goods goods,
			String goodsPrice, String goodsNumber, Date createTime) {
		super();
		this.id = id;
		this.promotion = promotion;
		this.ladderStart = ladderStart;
		this.promotionMoney = promotionMoney;
		this.goods = goods;
		this.goodsPrice = goodsPrice;
		this.goodsNumber = goodsNumber;
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
	 * @return the promotion 所属促销活动
	 */
	public Promotion getPromotion() {
		return promotion;
	}

	/**
	 * @param promotion
	 *            the promotion（所属促销活动） to set
	 */
	public void setPromotion(Promotion promotion) {
		this.promotion = promotion;
	}

	/**
	 * @return the ladderStart 阶梯起点金额或件数
	 */
	public String getLadderStart() {
		return ladderStart;
	}

	/**
	 * @param ladderStart
	 *            the ladderStart（阶梯起点金额或件数） to set
	 */
	public void setLadderStart(String ladderStart) {
		this.ladderStart = ladderStart;
	}

	/**
	 * @return the promotionMoney 减免金额或折扣比例
	 */
	public String getPromotionMoney() {
		return promotionMoney;
	}

	/**
	 * @param promotionMoney
	 *            the promotionMoney（减免金额或折扣比例） to set
	 */
	public void setPromotionMoney(String promotionMoney) {
		this.promotionMoney = promotionMoney;
	}

	/**
	 * @return the goods 赠送(换购)产品ID
	 */
	public Goods getGoods() {
		return goods;
	}

	/**
	 * @param goods
	 *            the goods(赠送(换购)产品ID) to set
	 */
	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	/**
	 * @return the goodsNumber 赠送产品数量
	 */
	public String getGoodsNumber() {
		return goodsNumber;
	}

	/**
	 * @param goodsNumber
	 *            the goodsNumber(赠送产品数量) to set
	 */
	public void setGoodsNumber(String goodsNumber) {
		this.goodsNumber = goodsNumber;
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

	/**
	 * @return the startDate
	 */
	public String getStartDate() {
		return startDate;
	}

	/**
	 * @param startDate
	 *            the startDate to set
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	/**
	 * @return the endDate
	 */
	public String getEndDate() {
		return endDate;
	}

	/**
	 * @param endDate
	 *            the endDate to set
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	/**
	 * @return the isDelete
	 */
	public String getIsDelete() {
		return isDelete;
	}

	/**
	 * @param isDelete
	 *            the isDelete to set
	 */
	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}

	/**
	 * @return the goodsPrice 产品换购价
	 */
	public String getGoodsPrice() {
		return goodsPrice;
	}

	/**
	 * @param goodsPrice
	 *            the goodsPrice(产品换购价) to set
	 */
	public void setGoodsPrice(String goodsPrice) {
		this.goodsPrice = goodsPrice;
	}

	/**
	 * @return the goodsNumberBuy 购买产品数量
	 */
	public String getGoodsNumberBuy() {
		return goodsNumberBuy;
	}

	/**
	 * @param goodsNumberBuy
	 *            the goodsNumberBuy(购买产品数量) to set
	 */
	public void setGoodsNumberBuy(String goodsNumberBuy) {
		this.goodsNumberBuy = goodsNumberBuy;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "PromotionLadder [id=" + id + ", promotion=" + promotion + ", ladderStart=" + ladderStart
				+ ", promotionMoney=" + promotionMoney + ", goods=" + goods + ", goodsNumber=" + goodsNumber
				+ ", createTime=" + createTime + ", ft=" + ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu
				+ ", startDate=" + startDate + ", endDate=" + endDate + "]";
	}

}
