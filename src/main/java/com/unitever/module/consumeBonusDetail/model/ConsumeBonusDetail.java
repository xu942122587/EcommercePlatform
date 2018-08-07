package com.unitever.module.consumeBonusDetail.model;

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
public class ConsumeBonusDetail extends BaseModel {
	/** Id */
	private String id;
	/** 用户 */
	private User guideUser;
	/** 提成金额 */
	private String targetMoney;
	/** 总提成金额 */
	private String sumTargetMoney;
	/** 总提成金额 */
	private String sumMoney;
	/** 提成金额 */
	private String money;
	/** 月份 */
	private String month;
	/** 是否发放(1:是,2:否) */
	private String isPayMoney;
	/** 创建时间 */
	private Date createTime;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String isPayMoneyValue;
	/** 是否发放(1:是) */
	public static String ISPAYMONEY_TRUE = "1";
	/** 是否发放(2:否) */
	public static String ISPAYMONEY_FALSE = "2";

	/**
	 * 
	 */
	public ConsumeBonusDetail() {
		super();
	}

	/**
	 * @param id
	 */
	public ConsumeBonusDetail(String id) {
		super();
		this.id = id;
	}

	public ConsumeBonusDetail(String id, User guideUser, String targetMoney, String money, String month,
			String isPayMoney, Date createTime) {
		super();
		this.id = id;
		this.guideUser = guideUser;
		this.targetMoney = targetMoney;
		this.money = money;
		this.month = month;
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

	/**
	 * @return the targetMoney
	 */
	public String getTargetMoney() {
		return targetMoney;
	}

	/**
	 * @param targetMoney
	 *            the targetMoney to set
	 */
	public void setTargetMoney(String targetMoney) {
		this.targetMoney = targetMoney;
	}

	/**
	 * @return the sumTargetMoney
	 */
	public String getSumTargetMoney() {
		return sumTargetMoney;
	}

	/**
	 * @param sumTargetMoney
	 *            the sumTargetMoney to set
	 */
	public void setSumTargetMoney(String sumTargetMoney) {
		this.sumTargetMoney = sumTargetMoney;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "ConsumeBonusDetail [id=" + id + ", guideUser=" + guideUser + ", sumMoney=" + sumMoney + ", money="
				+ money + ", month=" + month + ", isPayMoney=" + isPayMoney + ", createTime=" + createTime + ", ft="
				+ ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu + "]";
	}

}
