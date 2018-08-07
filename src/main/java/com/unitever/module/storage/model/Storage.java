package com.unitever.module.storage.model;

import java.util.Date;

import com.unitever.module.store.model.Store;
import com.unitever.platform.core.dao.BaseModel;

/**
 * <p>
 * 库房
 * </p>
 *
 */
public class Storage extends BaseModel {

	/** Id */
	private String id;
	/** 名称 */
	private String name;
	/** 负责人 */
	private String chargeName;
	/** 负责人联系方式 */
	private String chargePhone;
	/** 仓库面积 */
	private String acreage;
	/** 门店 */
	private Store store;
	/** 状态（1：启用，2：停用） */
	private String state;
	/** 备注 */
	private String remark;
	/** 创建时间 */
	private Date createTime;
	/** 是否删除（1：否，2：是） */
	private String isDelete;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用

	private String stateValue;
	/**
	 * 状态：启用
	 */
	public static final String STATE_NO_STOP = "1";
	/**
	 * 状态：停用
	 */
	public static final String STATE_STOP = "2";

	/**
	 * 是否删除--否
	 */
	public static final String ISDELETE_NO = "1";
	/**
	 * 是否删除--是
	 */
	public static final String ISDELETE_YES = "2";

	public Storage() {
		super();
	}

	public Storage(String id) {
		super();
		this.id = id;
	}

	/**
	 * @param id
	 * @param name
	 *            名称
	 * @param chargeName
	 *            负责人
	 * @param chargePhone
	 *            负责人联系方式
	 * @param store
	 *            门店
	 * @param state
	 *            状态（1：启用，2：停用）
	 * @param remark
	 *            备注
	 * @param createTime
	 *            创建时间
	 * @param acreage
	 *            仓库面积
	 */
	public Storage(String id, String name, String chargeName, String chargePhone, Store store, String state,
			String remark, Date createTime, String acreage) {
		super();
		this.id = id;
		this.name = name;
		this.chargeName = chargeName;
		this.chargePhone = chargePhone;
		this.store = store;
		this.state = state;
		this.remark = remark;
		this.createTime = createTime;
		this.acreage = acreage;
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
	 * @return the name 名称
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name（名称） to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the chargeName 负责人
	 */
	public String getChargeName() {
		return chargeName;
	}

	/**
	 * @param chargeName
	 *            the chargeName（负责人） to set
	 */
	public void setChargeName(String chargeName) {
		this.chargeName = chargeName;
	}

	/**
	 * @return the chargePhone 负责人联系方式
	 */
	public String getChargePhone() {
		return chargePhone;
	}

	/**
	 * @param chargePhone
	 *            the chargePhone（负责人联系方式） to set
	 */
	public void setChargePhone(String chargePhone) {
		this.chargePhone = chargePhone;
	}

	/**
	 * @return the store 门店
	 */
	public Store getStore() {
		return store;
	}

	/**
	 * @param store
	 *            the store（门店） to set
	 */
	public void setStore(Store store) {
		this.store = store;
	}

	/**
	 * @return the state 状态（1：启用，2：停用）
	 */
	public String getState() {
		return state;
	}

	/**
	 * @param state
	 *            the state（状态（1：启用，2：停用）） to set
	 */
	public void setState(String state) {
		this.state = state;
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
	 * @return the createTime 创建时间
	 */
	public Date getCreateTime() {
		return createTime;
	}

	/**
	 * @param createTime
	 *            the createTime（创建时间） to set
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
	 * @return the stateValue
	 */
	public String getStateValue() {
		if (STATE_NO_STOP.equals(state)) {
			return "启用";
		} else if (STATE_STOP.equals(state)) {
			return "停用";
		}
		return "未知";
	}

	/**
	 * @return the isDelete 是否删除（1：否，2：是）
	 */
	public String getIsDelete() {
		return isDelete;
	}

	/**
	 * @param isDelete
	 *            the isDelete（是否删除（1：否，2：是）） to set
	 */
	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}

	/**
	 * @return the acreage 仓库面积
	 */
	public String getAcreage() {
		return acreage;
	}

	/**
	 * @param acreage
	 *            the acreage(仓库面积) to set
	 */
	public void setAcreage(String acreage) {
		this.acreage = acreage;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Storage [id=" + id + ", name=" + name + ", chargeName=" + chargeName + ", chargePhone=" + chargePhone
				+ ", store=" + store + ", state=" + state + ", remark=" + remark + ", createTime=" + createTime
				+ ", ft=" + ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu + ", startDate=" + startDate + ", endDate="
				+ endDate + "]";
	}

}
