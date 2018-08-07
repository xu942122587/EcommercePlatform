package com.unitever.module.storeProperty.model;

import java.util.Date;

import com.unitever.module.store.model.Store;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.storeProperty.model->StoreProperty.java
 * </p>
 * <P>
 * 门店固定资产
 * </p>
 *
 * @author 闫枫
 * @date Jun 29, 2017
 */
public class StoreProperty {

	/** Id */
	private String id;
	/** 所属门店 */
	private Store store;
	/** 固定财产名称 */
	private String name;
	/** 数量 */
	private String number;
	/** 备注 */
	private String remark;
	/** 创建时间 */
	private Date createTime;

	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用

	public StoreProperty() {
		super();
	}

	public StoreProperty(String id) {
		super();
		this.id = id;
	}

	/**
	 * @param id
	 * @param store
	 *            所属门店
	 * @param name
	 *            固定财产名称
	 * @param number
	 *            数量
	 * @param remark
	 *            备注
	 * @param createTime
	 */
	public StoreProperty(String id, Store store, String name, String number, String remark, Date createTime) {
		super();
		this.id = id;
		this.store = store;
		this.name = name;
		this.number = number;
		this.remark = remark;
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
	 * @return the store 所属门店
	 */
	public Store getStore() {
		return store;
	}

	/**
	 * @param store
	 *            the store(所属门店) to set
	 */
	public void setStore(Store store) {
		this.store = store;
	}

	/**
	 * @return the name 固定财产名称
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name(固定财产名称) to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the number 数量
	 */
	public String getNumber() {
		return number;
	}

	/**
	 * @param number
	 *            the number(数量) to set
	 */
	public void setNumber(String number) {
		this.number = number;
	}

	/**
	 * @return the remark 备注
	 */
	public String getRemark() {
		return remark;
	}

	/**
	 * @param remark
	 *            the remark（备注） to set
	 */
	public void setRemark(String remark) {
		this.remark = remark;
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

	@Override
	public String toString() {
		return "StoreProperty [id=" + id + ", store=" + store + ", name=" + name + ", number=" + number + ", remark="
				+ remark + ", createTime=" + createTime + ", ft=" + ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu
				+ "]";
	}

}
