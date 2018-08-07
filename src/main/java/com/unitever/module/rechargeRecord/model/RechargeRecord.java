package com.unitever.module.rechargeRecord.model;

import java.util.Date;

import com.unitever.auth.user.model.User;
import com.unitever.module.customer.model.Customer;
import com.unitever.platform.core.dao.BaseModel;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.registerBonusDetil.model->
 * RegisterBonusDetil.java
 * </p>
 * <P>
 * 充值记录
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月9日
 */
public class RechargeRecord extends BaseModel {
	/** Id */
	private String id;
	/** 导购 */
	private User guideUser;
	/** 收银 */
	private User cashierUser;
	/** 客户 */
	private Customer customer;
	/** 状态 */
	private String state;
	/** 款台号 */
	private String cashierCode;
	/** 充值金额 */
	private String money;
	/** 返现金额 */
	private String backCash;
	/** 支付方式（1：现金支付，2：银行pos刷卡支付，3：微信支付，4：支付宝支付） */
	private String payType;
	/** 支付单号(微信/支付宝) */
	private String payCode;
	/** 支付时间 */
	private Date payTime;
	/** 创建时间 */
	private Date createTime;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用

	/** 支付方式名称 */
	private String payTypeValue;
	/** 支付方式1 现金支付 */
	public static final String PAYTYPE_ONE = "1";
	/** 支付方式2 银行pos刷卡支付 */
	public static final String PAYTYPE_TWO = "2";
	/** 支付方式3 微信支付 */
	public static final String PAYTYPE_THREE = "3";
	/** 支付方式4 支付宝支付 */
	public static final String PAYTYPE_FOUR = "4";

	/** 状态 */
	private String stateValue;
	/** 状态1 完成 */
	public static final String STATE_ONE = "1";
	/** 状态1 未支付 */
	public static final String STATE_TWO = "2";

	/**
	 * 
	 */
	public RechargeRecord() {
		super();
	}

	/**
	 * @param id
	 */
	public RechargeRecord(String id) {
		super();
		this.id = id;
	}

	public RechargeRecord(String id, User guideUser, Customer customer, String state, String money, String backCash,
			String payType, String payCode, Date payTime, Date createTime) {
		super();
		this.id = id;
		this.guideUser = guideUser;
		this.customer = customer;
		this.state = state;
		this.money = money;
		this.backCash = backCash;
		this.payType = payType;
		this.payCode = payCode;
		this.payTime = payTime;
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
	 * @return the guideUser
	 */
	public User getGuideUser() {
		return guideUser;
	}

	/**
	 * @param guideUser
	 *            the guideUser to set
	 */
	public void setGuideUser(User guideUser) {
		this.guideUser = guideUser;
	}

	/**
	 * @return the customer
	 */
	public Customer getCustomer() {
		return customer;
	}

	/**
	 * @param customer
	 *            the customer to set
	 */
	public void setCustomer(Customer customer) {
		this.customer = customer;
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
	 * @return the backCash
	 */
	public String getBackCash() {
		return backCash;
	}

	/**
	 * @param backCash
	 *            the backCash to set
	 */
	public void setBackCash(String backCash) {
		this.backCash = backCash;
	}

	/**
	 * @return the payType
	 */
	public String getPayType() {
		return payType;
	}

	/**
	 * @param payType
	 *            the payType to set
	 */
	public void setPayType(String payType) {
		this.payType = payType;
	}

	/**
	 * @return the payCode
	 */
	public String getPayCode() {
		return payCode;
	}

	/**
	 * @param payCode
	 *            the payCode to set
	 */
	public void setPayCode(String payCode) {
		this.payCode = payCode;
	}

	/**
	 * @return the payTime
	 */
	public Date getPayTime() {
		return payTime;
	}

	/**
	 * @param payTime
	 *            the payTime to set
	 */
	public void setPayTime(Date payTime) {
		this.payTime = payTime;
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
	 * @return the payTypeValue
	 */
	public String getPayTypeValue() {
		if (PAYTYPE_ONE.equals(payType)) {
			return "现金";
		} else if (PAYTYPE_TWO.equals(payType)) {
			return "刷卡";
		} else if (PAYTYPE_THREE.equals(payType)) {
			return "微信";
		} else if (PAYTYPE_FOUR.equals(payType)) {
			return "支付宝";
		}
		return null;
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
		return stateValue;
	}

	/**
	 * @return the cashierUser 收银
	 */
	public User getCashierUser() {
		return cashierUser;
	}

	/**
	 * @param cashierUser
	 *            the cashierUser（收银） to set
	 */
	public void setCashierUser(User cashierUser) {
		this.cashierUser = cashierUser;
	}

	/**
	 * @return the cashierCode 款台号
	 */
	public String getCashierCode() {
		return cashierCode;
	}

	/**
	 * @param cashierCode
	 *            the cashierCode（款台号） to set
	 */
	public void setCashierCode(String cashierCode) {
		this.cashierCode = cashierCode;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "RechargeRecord [id=" + id + ", guideUser=" + guideUser + ", customer=" + customer + ", money=" + money
				+ ", backCash=" + backCash + ", payType=" + payType + ", payCode=" + payCode + ", payTime=" + payTime
				+ ", createTime=" + createTime + ", ft=" + ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu
				+ ", payTypeValue=" + payTypeValue + "]";
	}

}
