package com.unitever.module.banner.model;

import java.util.Date;
import java.util.List;

import com.unitever.platform.core.dao.BaseModel;

/**
 *
 * 微信首页轮播 </p>
 *
 */
public class Banner extends BaseModel {

	/** Id */
	private String id;
	/** 创建时间 */
	private Date createTime;

	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用
	/**
	 * 图片 数据库获取
	 */
	private List<String> imgUrl;

	public Banner() {
		super();
	}

	public Banner(String id) {
		super();
		this.id = id;
	}

	public Banner(String id, Date createTime) {
		super();
		this.id = id;
		this.createTime = createTime;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Date getCreateTime() {
		return createTime;
	}

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

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	/**
	 * @return the imgUrl
	 */
	public List<String> getImgUrl() {
		return imgUrl;
	}

	/**
	 * @param imgUrl
	 *            the imgUrl to set
	 */
	public void setImgUrl(List<String> imgUrl) {
		this.imgUrl = imgUrl;
	}

	@Override
	public String toString() {
		return "Banner [id=" + id + ", createTime=" + createTime + ", ft=" + ft + ", lt=" + lt + ", fu=" + fu + ", lu="
				+ lu + "]";
	}

}
