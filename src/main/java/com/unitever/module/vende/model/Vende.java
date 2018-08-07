package com.unitever.module.vende.model;

import java.util.Date;

import org.apache.commons.lang.StringUtils;

import com.unitever.platform.core.dao.BaseModel;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.vende.model->Vende.java
 * </p>
 * <P>
 * 供应商
 * </p>
 *
 * @author 闫枫
 * @date Jul 3, 2017
 */
public class Vende extends BaseModel {

	/** Id */
	private String id;
	/** 名称 */
	private String name;
	/** 负责人 */
	private String chargeName;
	/** 联系方式 */
	private String chargePhone;
	/** 厂家地址 */
	private String address;
	/** 开户行 */
	private String bankName;
	/** 银行账户 */
	private String bankCardNum;
	/** 官网网址 */
	private String brandHttpURI;
	/** 邮箱 */
	private String email;
	/** 是否删除（1：否，2：是） */
	private String isDelete;
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

	/**
	 * 是否删除--否
	 */
	public static final String ISDELETE_NO = "1";
	/**
	 * 是否删除--是
	 */
	public static final String ISDELETE_YES = "2";

	/**
	 * 用于页面显示的地址
	 */
	private String address_show;
	/**
	 * 按“-”切割好的地址数组
	 */
	private String[] addressArray;

	public Vende() {
		super();
	}

	public Vende(String id) {
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
	 *            联系方式
	 * @param address
	 *            厂家地址
	 * @param bankName
	 *            开户行
	 * @param bankCardNum
	 *            银行账户
	 * @param brandHttpURI
	 *            官网网址
	 * @param isDelete
	 *            是否删除（1：否，2：是）
	 * @param remark
	 *            备注
	 * @param createTime
	 *            创建时间
	 * @param email
	 *            邮箱
	 */
	public Vende(String id, String name, String chargeName, String chargePhone, String address, String bankName,
			String bankCardNum, String brandHttpURI, String isDelete, String remark, Date createTime, String email) {
		super();
		this.id = id;
		this.name = name;
		this.chargeName = chargeName;
		this.chargePhone = chargePhone;
		this.address = address;
		this.bankName = bankName;
		this.bankCardNum = bankCardNum;
		this.brandHttpURI = brandHttpURI;
		this.isDelete = isDelete;
		this.remark = remark;
		this.createTime = createTime;
		this.email = email;
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
	 *            the name(名称) to set
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
	 *            the chargeName(负责人) to set
	 */
	public void setChargeName(String chargeName) {
		this.chargeName = chargeName;
	}

	/**
	 * @return the chargePhone 联系方式
	 */
	public String getChargePhone() {
		return chargePhone;
	}

	/**
	 * @param chargePhone
	 *            the chargePhone(联系方式) to set
	 */
	public void setChargePhone(String chargePhone) {
		this.chargePhone = chargePhone;
	}

	/**
	 * @return the address 厂家地址
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * @param address
	 *            the address(厂家地址) to set
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * @return the bankName 开户行
	 */
	public String getBankName() {
		return bankName;
	}

	/**
	 * @param bankName
	 *            the bankName(开户行) to set
	 */
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	/**
	 * @return the bankCardNum 银行账户
	 */
	public String getBankCardNum() {
		return bankCardNum;
	}

	/**
	 * @param bankCardNum
	 *            the bankCardNum(银行账户) to set
	 */
	public void setBankCardNum(String bankCardNum) {
		this.bankCardNum = bankCardNum;
	}

	/**
	 * @return the brandHttpURI 官网网址
	 */
	public String getBrandHttpURI() {
		return brandHttpURI;
	}

	/**
	 * @param brandHttpURI
	 *            the brandHttpURI(官网网址) to set
	 */
	public void setBrandHttpURI(String brandHttpURI) {
		this.brandHttpURI = brandHttpURI;
	}

	/**
	 * @return the remark 备注
	 */
	public String getRemark() {
		return remark;
	}

	/**
	 * @param remark
	 *            the remark(备注) to set
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
	 *            the createTime(创建时间) to set
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
	 * @return the isDelete 是否删除（1：否，2：是）
	 */
	public String getIsDelete() {
		return isDelete;
	}

	/**
	 * @param isDelete
	 *            the isDelete(是否删除（1：否，2：是）) to set
	 */
	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}

	/**
	 * @return the address_show 用于页面显示的地址
	 */
	public String getAddress_show() {
		String[] address_array_get = this.getAddressArray();
		return null != address_array_get ? address_array_get[address_array_get.length - 1] : "未知地点~";
	}

	/**
	 * @return the addressArray 按“-”切割好的地址数组 eg: "010011-010012-010013-某地区" 切割后
	 *         ["010011","010012", "010013","某地区"]
	 */
	public String[] getAddressArray() {
		return (StringUtils.isNotBlank(address) && 0 <= address.indexOf("-")) ? address.split("-") : null;
	}

	/**
	 * @return the email 邮箱
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * @param email
	 *            the email（邮箱） to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Vende [id=" + id + ", name=" + name + ", chargeName=" + chargeName + ", chargePhone=" + chargePhone
				+ ", address=" + address + ", bankName=" + bankName + ", bankCardNum=" + bankCardNum
				+ ", brandHttpURI=" + brandHttpURI + ", remark=" + remark + ", createTime=" + createTime + ", ft=" + ft
				+ ", lt=" + lt + ", fu=" + fu + ", lu=" + lu + "]";
	}

}
