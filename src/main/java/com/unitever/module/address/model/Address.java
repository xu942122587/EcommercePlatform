package com.unitever.module.address.model;

import java.util.Date;

import com.unitever.module.customer.model.Customer;
import com.unitever.platform.core.dao.BaseModel;

public class Address extends BaseModel {

	/** Id */
	private String id;
	/** 会员 */
	private Customer customer;
	/** 详细地址 */
	private String content;
	/** 是否默认(1：是，2：否) */
	private String isDefault;
	/** 是否删除（1：否，2：是） */
	private String isDelete;
	/** 收货电话 */
	private String phone;
	/** 收货人 */
	private String receiver;
	/** 创建时间 */
	private Date createTime;

	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用

	/** 是否默认(1：是，2：否) */
	private String isDefaultValue;
	/** 是否默认(1：是) */
	public static String ISDEFAULT_TRUE = "1";
	/** 是否默认(2：否) */
	public static String ISDEFAULT_FALSE = "2";

	/** 是否删除(2：是) */
	public static String ISDELETE_TRUE = "2";
	/** 是否删除(1：否) */
	public static String ISDELETE_FALSE = "1";

	public Address() {
		super();
	}

	public Address(String id) {
		super();
		this.id = id;
	}

	public Address(String id, Customer customer, String content, String isDefault, String phone, String receiver,
			Date createTime) {
		super();
		this.id = id;
		this.customer = customer;
		this.content = content;
		this.isDefault = isDefault;
		this.phone = phone;
		this.receiver = receiver;
		this.createTime = createTime;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getIsDefault() {
		return isDefault;
	}

	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
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
	 * @return the isDefaultValue 是否默认(1：是，2：否)
	 */
	public String getIsDefaultValue() {
		if (ISDEFAULT_TRUE.equals(isDefault)) {
			return "是";
		} else if (ISDEFAULT_FALSE.equals(isDefault)) {
			return "否";
		}
		return null;
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

	@Override
	public String toString() {
		return "Address [id=" + id + ", customer=" + customer + ", content=" + content + ", isDefault=" + isDefault
				+ ", phone=" + phone + ", receiver=" + receiver + ", createTime=" + createTime + ", ft=" + ft + ", lt="
				+ lt + ", fu=" + fu + ", lu=" + lu + "]";
	}

}
