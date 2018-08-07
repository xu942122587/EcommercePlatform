package com.unitever.module.cashierUserLoginAndLogout.model;

import java.util.Date;

import com.unitever.auth.user.model.User;
import com.unitever.platform.core.dao.BaseModel;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.cashierUserLoginAndLogout.model->
 * CashierUserLoginAndLogout.java
 * </p>
 * <P>
 * 收银交接班信息
 * </p>
 *
 * @author 闫枫
 * @date Sep 18, 2017
 */
public class CashierUserLoginAndLogout extends BaseModel {

	/** Id */
	private String id;
	/** 收银员 */
	private User cashierUser;
	/** 款台号 */
	private String cashierCode;
	/** 登录时间 */
	private Date loginTime;
	/** 退出时间 */
	private Date logoutTime;
	/** 状态：1：未交班，2：未结算，3：完成 */
	private String state;
	/** 创建时间 */
	private Date createTime;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用
	private String cashierUserCode; // 查询用(收银工号)

	private String stateValue;
	/**
	 * 状态：未交班
	 */
	public static final String STATE_ONE = "1";
	/**
	 * 状态：未结算
	 */
	public static final String STATE_TWO = "2";
	/**
	 * 状态：完成
	 */
	public static final String STATE_THREE = "3";

	/**
	 * 
	 */
	public CashierUserLoginAndLogout() {
		super();
	}

	/**
	 * @param id
	 */
	public CashierUserLoginAndLogout(String id) {
		super();
		this.id = id;
	}

	/**
	 * @param id
	 * @param cashierUser
	 *            收银员
	 * @param cashierCode
	 *            款台号
	 * @param loginTime
	 *            登录时间
	 * @param logoutTime
	 *            退出时间
	 * @param state
	 *            状态：1：未交班，2：未结算，3：完成
	 * @param createTime
	 *            创建时间
	 */
	public CashierUserLoginAndLogout(String id, User cashierUser, String cashierCode, Date loginTime, Date logoutTime,
			String state, Date createTime) {
		super();
		this.id = id;
		this.cashierUser = cashierUser;
		this.cashierCode = cashierCode;
		this.loginTime = loginTime;
		this.logoutTime = logoutTime;
		this.state = state;
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
	 * @return the cashierUser 收银员
	 */
	public User getCashierUser() {
		return cashierUser;
	}

	/**
	 * @param cashierUser
	 *            the cashierUser（ 收银员） to set
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

	/**
	 * @return the loginTime 登录时间
	 */
	public Date getLoginTime() {
		return loginTime;
	}

	/**
	 * @param loginTime
	 *            the loginTime（登录时间） to set
	 */
	public void setLoginTime(Date loginTime) {
		this.loginTime = loginTime;
	}

	/**
	 * @return the logoutTime 退出时间
	 */
	public Date getLogoutTime() {
		return logoutTime;
	}

	/**
	 * @param logoutTime
	 *            the logoutTime（退出时间） to set
	 */
	public void setLogoutTime(Date logoutTime) {
		this.logoutTime = logoutTime;
	}

	/**
	 * @return the state (状态：1：未交班，2：未结算，3：完成)
	 */
	public String getState() {
		return state;
	}

	/**
	 * @param state
	 *            the state(状态：1：未交班，2：未结算，3：完成) to set
	 */
	public void setState(String state) {
		this.state = state;
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
	 * @return the cashierUserCode 收银工号（查询用）
	 */
	public String getCashierUserCode() {
		return cashierUserCode;
	}

	/**
	 * @param cashierUserCode
	 *            the cashierUserCode（收银工号（查询用）） to set
	 */
	public void setCashierUserCode(String cashierUserCode) {
		this.cashierUserCode = cashierUserCode;
	}

}
