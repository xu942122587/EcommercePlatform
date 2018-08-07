package com.unitever.module.registerBonus.model;

import java.util.Date;

import com.unitever.platform.core.dao.BaseModel;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.registerBonus.model->RegisterBonus.java
 * </p>
 * <P>
 * 注册奖励金
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月5日
 */
public class RegisterBonus extends BaseModel {
	/** Id */
	private String id;
	/**
	 * 提成档位
	 */
	private String startMoney;
	/**
	 * 备注
	 */
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
	 * 
	 */
	public RegisterBonus() {
		super();
	}

	/**
	 * @param id
	 */
	public RegisterBonus(String id) {
		super();
		this.id = id;
	}

	/**
	 * @param id
	 * @param startMoney
	 *            提成档位
	 * @param proportion
	 *            提成比例
	 * @param remark
	 *            备注
	 * @param createTime
	 *            创建时间
	 */
	public RegisterBonus(String id, String startMoney, String remark, Date createTime) {
		super();
		this.id = id;
		this.startMoney = startMoney;
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
	 * @return the startMoney 提成档位
	 */
	public String getStartMoney() {
		return startMoney;
	}

	/**
	 * @param startMoney
	 *            the startMoney（提成档位） to set
	 */
	public void setStartMoney(String startMoney) {
		this.startMoney = startMoney;
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "RegisterBonus [id=" + id + ", startMoney=" + startMoney + ", remark=" + remark + ", createTime="
				+ createTime + ", ft=" + ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu + "]";
	}

}
