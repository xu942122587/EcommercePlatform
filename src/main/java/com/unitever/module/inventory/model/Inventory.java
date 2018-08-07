package com.unitever.module.inventory.model;

import java.util.Date;

import com.unitever.module.goods.model.Goods;
import com.unitever.module.storage.model.Storage;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.inventory.model->Inventory.java
 * </p>
 * <P>
 * 库存
 * </p>
 *
 * @author 徐昊
 * @date 2017年7月12日
 */
public class Inventory {

	/** Id */
	private String id;
	/** 商品 */
	private Goods goods;
	/** 仓库 */
	private Storage storage;
	/** 当前库存 */
	private String count;
	/** 库存金额 */
	private String money;
	/** 上限预警值 */
	private String warningUpValue;
	/** 下限预警值 */
	private String warningDownValue;
	/** 创建时间 */
	private Date createTime;

	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用

	private String upCount; // 查询用
	private String downCount; // 查询用

	public Inventory() {
		super();
	}

	public Inventory(String id) {
		super();
		this.id = id;
	}

	public Inventory(String id, Goods goods, String count, String money, Storage storage, Date createTime) {
		super();
		this.id = id;
		this.goods = goods;
		this.count = count;
		this.money = money;
		this.storage = storage;
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
	 * @return the goods
	 */
	public Goods getGoods() {
		return goods;
	}

	/**
	 * @param goods
	 *            the goods to set
	 */
	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	/**
	 * @return the storage
	 */
	public Storage getStorage() {
		return storage;
	}

	/**
	 * @param storage
	 *            the storage to set
	 */
	public void setStorage(Storage storage) {
		this.storage = storage;
	}

	/**
	 * @return the count
	 */
	public String getCount() {
		return count;
	}

	/**
	 * @param count
	 *            the count to set
	 */
	public void setCount(String count) {
		this.count = count;
	}

	/**
	 * @return the money
	 */
	public String getMoney() {
		return money;
	}

	/**
	 * @param money
	 *            the money to set
	 */
	public void setMoney(String money) {
		this.money = money;
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
	 * @return the upCount
	 */
	public String getUpCount() {
		return upCount;
	}

	/**
	 * @param upCount
	 *            the upCount to set
	 */
	public void setUpCount(String upCount) {
		this.upCount = upCount;
	}

	/**
	 * @return the downCount
	 */
	public String getDownCount() {
		return downCount;
	}

	/**
	 * @param downCount
	 *            the downCount to set
	 */
	public void setDownCount(String downCount) {
		this.downCount = downCount;
	}

	/**
	 * @return the warningUpValue
	 */
	public String getWarningUpValue() {
		if (Integer.valueOf(goods.getWarningUp()) <= Integer.valueOf(count)) {
			return "1";
		} else {
			return "2";
		}
	}

	/**
	 * @return the warningDownValue
	 */
	public String getWarningDownValue() {
		if (Integer.valueOf(goods.getWarningDown()) >= Integer.valueOf(count)) {
			return "1";
		} else {
			return "2";
		}
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Inventory [id=" + id + ", goods=" + goods + ", storage=" + storage + ", count=" + count + ", money="
				+ money + ", createTime=" + createTime + ", ft=" + ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu
				+ "]";
	}

}
