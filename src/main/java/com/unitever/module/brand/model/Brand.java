package com.unitever.module.brand.model;

import java.util.Date;

import org.apache.commons.lang.StringUtils;

import com.unitever.auth.user.model.User;
import com.unitever.platform.core.dao.BaseModel;

/**
 * * 品牌 </p>
 *
 */
public class Brand extends BaseModel {

	/** Id */
	private String id;
	/** 品牌名称 */
	private String name;
	/** 官网网址 */
	private String brandHttpURI;
	/** 描述 */
	private String content;
	/** 备注 */
	private String remark;
	/** 是否删除（1：否，2：是） */
	private String isDelete;
	/** 创建时间 */
	private Date createTime;

	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用

	private String contentShow; // 描述显示部分
	private User fu_user; // 创建人

	/**
	 * 是否删除--否
	 */
	public static final String ISDELETE_NO = "1";
	/**
	 * 是否删除--是
	 */
	public static final String ISDELETE_YES = "2";

	public Brand() {
		super();
	}

	public Brand(String id) {
		super();
		this.id = id;
	}

	/**
	 * @param id
	 * @param name
	 *            品牌名称
	 * @param brandHttpURI
	 *            官网网址
	 * @param content
	 *            描述
	 * @param remark
	 *            备注
	 * @param createTime
	 */
	public Brand(String id, String name, String brandHttpURI, String content, String remark, Date createTime) {
		super();
		this.id = id;
		this.name = name;
		this.brandHttpURI = brandHttpURI;
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
	 * @return the name 品牌名称
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name(品牌名称) to set
	 */
	public void setName(String name) {
		this.name = name;
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
	 * @return the content 描述
	 */
	public String getContent() {
		return content;
	}

	/**
	 * @param content
	 *            the content(描述) to set
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
	 *            the remark(备注) to set
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
	 * @return the fu_user 创建人
	 */
	public User getFu_user() {
		return fu_user;
	}

	/**
	 * @param fu_user
	 *            the fu_user（创建人） to set
	 */
	public void setFu_user(User fu_user) {
		this.fu_user = fu_user;
	}

	/**
	 * @return the isDelete 是否删除（1：否，2：是）
	 */
	public String getIsDelete() {
		return isDelete;
	}

	/**
	 * @param isDelete
	 *            the isDelete（是否删除（1：否，2：是）） to set
	 */
	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}

	/**
	 * @return the contentShow
	 */
	public String getContentShow() {
		if (StringUtils.isNotBlank(content)) {
			if (30 <= content.length()) {
				return content.substring(0, 30) + "...";
			}
		}
		return content;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Brand [id=" + id + ", name=" + name + ", brandHttpURI=" + brandHttpURI + ", content=" + content
				+ ", remark=" + remark + ", createTime=" + createTime + ", ft=" + ft + ", lt=" + lt + ", fu=" + fu
				+ ", lu=" + lu + ", startDate=" + startDate + ", endDate=" + endDate + "]";
	}

}
