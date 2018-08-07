package com.unitever.module.allocation.model;

import java.util.Date;
import java.util.List;

import com.unitever.auth.user.model.User;
import com.unitever.module.allocationQrcode.model.AllocationQrcode;
import com.unitever.module.storage.model.Storage;
import com.unitever.module.store.model.Store;
import com.unitever.platform.core.dao.BaseModel;

/**
 *
 * * 订单 </p>
 *
 */
public class Allocation extends BaseModel {

	/** Id */
	private String id;
	/** 调出仓库 */
	private Storage outStorage;
	/** 调入仓库 */
	private Storage inStorage;
	/** 所属门店 */
	private Store store;
	/** 调拨单号 */
	private String allocationCode;
	/** 调拨单状态 1.完成 2. 新建 */
	private String state;
	/** 是否删除（1：否，2：是） */
	private String isDelete;
	/** 备注 */
	private String remark;
	/** 创建时间 */
	private Date createTime;
	/** 创建人 */
	private User fu_user;

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

	/** 调拨单状态值 1.完成 2. 新建 */
	private String stateValue;
	/** 完成 */
	public static final String STATE_TURE = "1";
	/** 新建 */
	public static final String STATE_FALSE = "2";
	/**
	 * 调库二维码
	 */
	private List<AllocationQrcode> allocationQrcodeList;
	/**
	 * 调库二维码--新建
	 */
	private List<AllocationQrcode> allocationQrcodeListNew;
	/**
	 * 调库二维码--删除
	 */
	private List<Allocation> allocationQrcodeListDel;

	public Allocation() {
		super();
	}

	public Allocation(String id) {
		super();
		this.id = id;
	}

	public Allocation(String id, Storage outStorage, Storage inStorage, String allocationCode, String remark,
			Date createTime) {
		super();
		this.id = id;
		this.outStorage = outStorage;
		this.inStorage = inStorage;
		this.allocationCode = allocationCode;
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
	 * @return the outStorage 调出仓库
	 */
	public Storage getOutStorage() {
		return outStorage;
	}

	/**
	 * @param outStorage
	 *            the outStorage 调出仓库 to set
	 */
	public void setOutStorage(Storage outStorage) {
		this.outStorage = outStorage;
	}

	/**
	 * @return the inStorage 调入仓库
	 */
	public Storage getInStorage() {
		return inStorage;
	}

	/**
	 * @param inStorage
	 *            the inStorage 调入仓库 to set
	 */
	public void setInStorage(Storage inStorage) {
		this.inStorage = inStorage;
	}

	/**
	 * @return the remark
	 */
	public String getRemark() {
		return remark;
	}

	/**
	 * @param remark
	 *            the remark to set
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

	/**
	 * @return the allocationCode 调拨单号
	 */
	public String getAllocationCode() {
		return allocationCode;
	}

	/**
	 * @param allocationCode
	 *            the allocationCode 调拨单号 to set
	 */
	public void setAllocationCode(String allocationCode) {
		this.allocationCode = allocationCode;
	}

	/**
	 * @return the fu_user
	 */
	public User getFu_user() {
		return fu_user;
	}

	/**
	 * @param fu_user
	 *            the fu_user to set
	 */
	public void setFu_user(User fu_user) {
		this.fu_user = fu_user;
	}

	/**
	 * @return the allocationQrcodeList 调库二维码
	 */
	public List<AllocationQrcode> getAllocationQrcodeList() {
		return allocationQrcodeList;
	}

	/**
	 * @param allocationQrcodeList
	 *            the allocationQrcodeList 调库二维码 to set
	 */
	public void setAllocationQrcodeList(List<AllocationQrcode> allocationQrcodeList) {
		this.allocationQrcodeList = allocationQrcodeList;
	}

	/**
	 * @return the allocationQrcodeListNew 调库二维码--新建
	 */
	public List<AllocationQrcode> getAllocationQrcodeListNew() {
		return allocationQrcodeListNew;
	}

	/**
	 * @param allocationQrcodeListNew
	 *            the allocationQrcodeListNew 调库二维码--新建 to set
	 */
	public void setAllocationQrcodeListNew(List<AllocationQrcode> allocationQrcodeListNew) {
		this.allocationQrcodeListNew = allocationQrcodeListNew;
	}

	/**
	 * @return the allocationQrcodeListDel 调库二维码--删除
	 */
	public List<Allocation> getAllocationQrcodeListDel() {
		return allocationQrcodeListDel;
	}

	/**
	 * @param allocationQrcodeListDel
	 *            the allocationQrcodeListDel 调库二维码--删除 to set
	 */
	public void setAllocationQrcodeListDel(List<Allocation> allocationQrcodeListDel) {
		this.allocationQrcodeListDel = allocationQrcodeListDel;
	}

	/**
	 * @return the state 1.完成 2. 新建
	 */
	public String getState() {
		return state;
	}

	/**
	 * @param state
	 *            the state 1.完成 2. 新建 to set
	 */
	public void setState(String state) {
		this.state = state;
	}

	/**
	 * @return the stateValue
	 */
	public String getStateValue() {
		if (STATE_TURE.equals(state)) {
			return "完成";
		} else if (STATE_FALSE.equals(state)) {
			return "新建";
		}
		return null;
	}

	/**
	 * @return the store
	 */
	public Store getStore() {
		return store;
	}

	/**
	 * @param store
	 *            the store to set
	 */
	public void setStore(Store store) {
		this.store = store;
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Allocation [id=" + id + ", outStorage=" + outStorage + ", inStorage=" + inStorage + ", allocationCode="
				+ allocationCode + ", remark=" + remark + ", createTime=" + createTime + ", ft=" + ft + ", lt=" + lt
				+ ", fu=" + fu + ", lu=" + lu + "]";
	}

}
