package com.unitever.module.postageBonus.model;

import java.util.Date;

import com.unitever.platform.core.dao.BaseModel;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.consumeBonus.model->ConsumeBonus.java
 * </p>
 * <P>
 * 充值提成比例
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月10日
 */
public class PostageBonus extends BaseModel {
	/** Id */
	private String id;
	/**
	 * 提成档位
	 */
	private String startMoney;
	/**
	 * 提成比例
	 */
	private String proportion;
	/** 创建时间 */
	private Date createTime;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	/**
	 * 
	 */
	public PostageBonus() {
		super();
	}

	/**
	 * @param id
	 */
	public PostageBonus(String id) {
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
	public PostageBonus(String id, String startMoney, String proportion, Date createTime) {
		super();
		this.id = id;
		this.startMoney = startMoney;
		this.proportion = proportion;
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
	 * @return the proportion 提成比例
	 */
	public String getProportion() {
		return proportion;
	}

	/**
	 * @param proportion
	 *            the proportion（提成比例） to set
	 */
	public void setProportion(String proportion) {
		this.proportion = proportion;
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "PostageBonus [id=" + id + ", startMoney=" + startMoney + ", proportion=" + proportion + ", createTime="
				+ createTime + ", ft=" + ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu + "]";
	}

}
