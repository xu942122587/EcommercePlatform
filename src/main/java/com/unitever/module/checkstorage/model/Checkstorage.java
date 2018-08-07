package com.unitever.module.checkstorage.model;

import java.util.Date;
import java.util.List;

import com.unitever.auth.user.model.User;
import com.unitever.module.checkstorageGoods.model.CheckstorageGoods;
import com.unitever.module.storage.model.Storage;
import com.unitever.module.store.model.Store;
import com.unitever.platform.core.dao.BaseModel;

/**
 *
 * * 库存盘点 </p>
 *
 */
public class Checkstorage extends BaseModel {

	/** Id */
	private String id;
	/** 门店 */
	private Store store;
	/** 仓库 */
	private Storage storage;
	/** 盘点单号（ps:16位长订单号生成模式） */
	private String code;
	/** 盘点日期 */
	private Date checkDate;
	/** 状态（1：未提交，2：已提交，3：朕已阅） */
	private String state;
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

	/** 状态（1：完成，2：新建，3：已审批） */
	private String stateValue;
	/** 完成 */
	public static final String STATE_ONE = "1";
	/** 新建 */
	public static final String STATE_TWO = "2";
	/** 已审批 */
	public static final String STATE_THREE = "3";

	/**
	 * 盘点单中的商品
	 */
	private List<CheckstorageGoods> checkstorageGoodsList;

	public Checkstorage() {
		super();
	}

	public Checkstorage(String id) {
		super();
		this.id = id;
	}

	public Checkstorage(String id, Store store, Storage storage, String code, Date checkDate, String state,
			String remark, Date createTime) {
		super();
		this.id = id;
		this.store = store;
		this.storage = storage;
		this.code = code;
		this.checkDate = checkDate;
		this.state = state;
		this.remark = remark;
		this.createTime = createTime;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Store getStore() {
		return store;
	}

	public void setStore(Store store) {
		this.store = store;
	}

	public Storage getStorage() {
		return storage;
	}

	public void setStorage(Storage storage) {
		this.storage = storage;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Date getCheckDate() {
		return checkDate;
	}

	public void setCheckDate(Date checkDate) {
		this.checkDate = checkDate;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
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
	 * @return the stateValue
	 */
	public String getStateValue() {
		if (STATE_ONE.equals(state)) {
			return "完成";
		} else if (STATE_TWO.equals(state)) {
			return "新建";
		} else if (STATE_THREE.equals(state)) {
			return "已审批";
		}
		return null;
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
	 * @return the checkstorageGoodsList
	 */
	public List<CheckstorageGoods> getCheckstorageGoodsList() {
		return checkstorageGoodsList;
	}

	/**
	 * @param checkstorageGoodsList
	 *            the checkstorageGoodsList to set
	 */
	public void setCheckstorageGoodsList(List<CheckstorageGoods> checkstorageGoodsList) {
		this.checkstorageGoodsList = checkstorageGoodsList;
	}

	@Override
	public String toString() {
		return "Checkstorage [id=" + id + ", store=" + store + ", storage=" + storage + ", code=" + code
				+ ", checkDate=" + checkDate + ", state=" + state + ", remark=" + remark + ", createTime=" + createTime
				+ ", ft=" + ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu + "]";
	}

}
