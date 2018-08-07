package com.unitever.module.registerBonusDetil.model;

import java.util.Date;

import com.unitever.auth.user.model.User;
import com.unitever.platform.core.dao.BaseModel;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.registerBonusDetil.model->
 * RegisterBonusDetil.java
 * </p>
 * <P>
 * 注册奖励金记录
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月9日
 */
public class RegisterBonusDetil extends BaseModel {
	/** Id */
	private String id;
	/** 用户 */
	private User guideUser;
	/** 提成金额 */
	private String sumMoney;
	/** 总提成金额 */
	private String money;
	/** 月份 */
	private String month;
	/** 数量 */
	private String count;
	/** 总数量 */
	private String sumCount;
	/** 是否发放(1:是,2:否) */
	private String isPayMoney;
	/** 创建时间 */
	private Date createTime;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用

	private String isPayMoneyValue;
	/** 是否发放(1:是) */
	public static String ISPAYMONEY_TRUE = "1";
	/** 是否发放(2:否) */
	public static String ISPAYMONEY_FALSE = "2";

	/**
	 * 
	 */
	public RegisterBonusDetil() {
		super();
	}

	/**
	 * @param id
	 */
	public RegisterBonusDetil(String id) {
		super();
		this.id = id;
	}

	public RegisterBonusDetil(String id, User guideUser, String money, String month, String count, String isPayMoney,
			Date createTime) {
		super();
		this.id = id;
		this.guideUser = guideUser;
		this.money = money;
		this.month = month;
		this.count = count;
		this.isPayMoney = isPayMoney;
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
	 * @return the month
	 */
	public String getMonth() {
		return month;
	}

	/**
	 * @param month
	 *            the month to set
	 */
	public void setMonth(String month) {
		this.month = month;
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
	 * @return the isPayMoney 是否发放(1:是,2:否)
	 */
	public String getIsPayMoney() {
		return isPayMoney;
	}

	/**
	 * @param isPayMoney
	 *            the isPayMoney 是否发放(1:是,2:否) to set
	 */
	public void setIsPayMoney(String isPayMoney) {
		this.isPayMoney = isPayMoney;
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
	 * @return the sumMoney
	 */
	public String getSumMoney() {
		return sumMoney;
	}

	/**
	 * @param sumMoney
	 *            the sumMoney to set
	 */
	public void setSumMoney(String sumMoney) {
		this.sumMoney = sumMoney;
	}

	/**
	 * @return the sumCount
	 */
	public String getSumCount() {
		return sumCount;
	}

	/**
	 * @param sumCount
	 *            the sumCount to set
	 */
	public void setSumCount(String sumCount) {
		this.sumCount = sumCount;
	}

	/**
	 * @return the isPayMoneyValue
	 */
	public String getIsPayMoneyValue() {
		if (ISPAYMONEY_TRUE.equals(isPayMoney)) {
			return "是";
		} else if (ISPAYMONEY_FALSE.equals(isPayMoney)) {
			return "否";
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
		return "RegisterBonusDetil [id=" + id + ", guideUser=" + guideUser + ", money=" + money + ", month=" + month
				+ ", count=" + count + ", isPayMoney=" + isPayMoney + ", createTime=" + createTime + ", ft=" + ft
				+ ", lt=" + lt + ", fu=" + fu + ", lu=" + lu + "]";
	}

}
