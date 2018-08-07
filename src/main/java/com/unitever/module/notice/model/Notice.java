package com.unitever.module.notice.model;

import java.util.Date;

import com.unitever.auth.user.model.User;
import com.unitever.platform.core.dao.BaseModel;

/**
 *
 * * 公告
 * </p>
 *
 */
/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.notice.model->Notice.java
 * </p>
 * <P>
 * TODO
 * </p>
 *
 * @author 徐昊
 * @date 2017年7月5日
 */
public class Notice extends BaseModel {

	/** Id */
	private String id;
	/** 标题 */
	private String title;
	/** 内容 */
	private String content;
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

	public Notice() {
		super();
	}

	public Notice(String id) {
		super();
		this.id = id;
	}

	/**
	 * @param id
	 * @param title
	 *            标题
	 * @param content
	 *            内容
	 * @param remark
	 *            备注
	 * @param createTime
	 *            创建时间
	 */
	public Notice(String id, String title, String content, String remark, Date createTime) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
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
	 * @return the title 标题
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * @param title
	 *            the title 标题 to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * @return the content 内容
	 */
	public String getContent() {
		return content;
	}

	/**
	 * @param content
	 *            the 内容 content to set
	 */
	public void setContent(String content) {
		this.content = content;
	}

	/**
	 * @return the remark 备注
	 */
	public String getRemark() {
		return remark;
	}

	/**
	 * @param remark
	 *            the 备注 remark to set
	 */
	public void setRemark(String remark) {
		this.remark = remark;
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Notice [id=" + id + ", title=" + title + ", content=" + content + ", remark=" + remark
				+ ", createTime=" + createTime + ", ft=" + ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu + "]";
	}

}
