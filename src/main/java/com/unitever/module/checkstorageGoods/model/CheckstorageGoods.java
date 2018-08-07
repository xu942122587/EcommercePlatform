package com.unitever.module.checkstorageGoods.model;

import java.util.Date;

import com.unitever.module.checkstorage.model.Checkstorage;
import com.unitever.module.goods.model.Goods;
import com.unitever.platform.core.dao.BaseModel;

/**
 *
 * * 盘点明细 </p>
 *
 */
public class CheckstorageGoods extends BaseModel {

	/** Id */
	private String id;
	/** 会员 */
	private Checkstorage checkstorage;
	/** 商品 */
	private Goods goods;
	/** 盘点数量 */
	private String checkNumber;
	/** 盘点前数量 */
	private String inventoryNumber;
	/** 盈亏数量 */
	private String profitNumber;
	/** 盈亏金额 */
	private String profitMoney;
	/** 盘点状态 */
	private String state;
	/** 创建时间 */
	private Date createTime;

	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用

	/** 盘点状态值 */
	private String stateValue;
	/** 完成 */
	public static final String STATE_ONE = "1";
	/** 新建 */
	public static final String STATE_TWO = "2";

	public CheckstorageGoods() {
		super();
	}

	public CheckstorageGoods(String id) {
		super();
		this.id = id;
	}

	public CheckstorageGoods(String id, Checkstorage checkstorage, Goods goods, String checkNumber,
			String inventoryNumber, String profitNumber, String profitMoney, Date createTime) {
		super();
		this.id = id;
		this.checkstorage = checkstorage;
		this.goods = goods;
		this.checkNumber = checkNumber;
		this.inventoryNumber = inventoryNumber;
		this.profitNumber = profitNumber;
		this.profitMoney = profitMoney;
		this.createTime = createTime;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	/**
	 * @return the checkstorage
	 */
	public Checkstorage getCheckstorage() {
		return checkstorage;
	}

	/**
	 * @param checkstorage
	 *            the checkstorage to set
	 */
	public void setCheckstorage(Checkstorage checkstorage) {
		this.checkstorage = checkstorage;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public String getCheckNumber() {
		return checkNumber;
	}

	public void setCheckNumber(String checkNumber) {
		this.checkNumber = checkNumber;
	}

	public String getInventoryNumber() {
		return inventoryNumber;
	}

	public void setInventoryNumber(String inventoryNumber) {
		this.inventoryNumber = inventoryNumber;
	}

	public String getProfitNumber() {
		return profitNumber;
	}

	public void setProfitNumber(String profitNumber) {
		this.profitNumber = profitNumber;
	}

	public String getProfitMoney() {
		return profitMoney;
	}

	public void setProfitMoney(String profitMoney) {
		this.profitMoney = profitMoney;
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
	 * @return the stateValue
	 */
	public String getStateValue() {
		if (STATE_ONE.equals(state)) {
			return "完成";
		} else if (STATE_TWO.equals(state)) {
			return "新建";
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "CheckstorageGoods [id=" + id + ", checkstorage=" + checkstorage + ", goods=" + goods + ", checkNumber="
				+ checkNumber + ", inventoryNumber=" + inventoryNumber + ", profitNumber=" + profitNumber
				+ ", profitMoney=" + profitMoney + ", createTime=" + createTime + ", ft=" + ft + ", lt=" + lt + ", fu="
				+ fu + ", lu=" + lu + "]";
	}

}
