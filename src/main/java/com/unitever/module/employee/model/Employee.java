package com.unitever.module.employee.model;

import java.util.Date;

import com.unitever.platform.core.dao.BaseModel;

/**
 *
 * <P>
 * platform-daikuan->com.unitever.module.employee.model->Employee.java
 * </p>
 * <P>
 * 微信用户信息
 * </p>
 *
 * @author 闫枫
 * @date Dec 22, 2016
 */
public class Employee extends BaseModel {
	private String id;
	private String name;
	private String headimgurl;
	private String openid;
	/** 客服状态 1:开始2:结束 */
	private String kefuState;
	/** 客服开始时间 */
	private Date kefuStartDate;
	private Date createTime;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	/**
	 * 客服开始
	 */
	public static final String kefuState_one = "1";
	/**
	 * 客服结束
	 */
	public static final String kefuState_two = "2";

	public Employee() {
		super();
	}

	public Employee(String id) {
		super();
		this.id = id;
	}

	public Employee(String id, String name, String headimgurl, String openid, Date createTime, String ft, String lt,
			String fu, String lu) {
		super();
		this.id = id;
		this.name = name;
		this.headimgurl = headimgurl;
		this.openid = openid;
		this.createTime = createTime;
		this.ft = ft;
		this.lt = lt;
		this.fu = fu;
		this.lu = lu;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getHeadimgurl() {
		return headimgurl;
	}

	public void setHeadimgurl(String headimgurl) {
		this.headimgurl = headimgurl;
	}

	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
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

	/**
	 * @return the kefuState
	 */
	public String getKefuState() {
		return kefuState;
	}

	/**
	 * @param kefuState
	 *            the kefuState to set
	 */
	public void setKefuState(String kefuState) {
		this.kefuState = kefuState;
	}

	/**
	 * @return the kefuStartDate
	 */
	public Date getKefuStartDate() {
		return kefuStartDate;
	}

	/**
	 * @param kefuStartDate
	 *            the kefuStartDate to set
	 */
	public void setKefuStartDate(Date kefuStartDate) {
		this.kefuStartDate = kefuStartDate;
	}
}
