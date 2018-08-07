package com.unitever.module.evaluation.model;

import java.util.Date;
import java.util.List;

import com.unitever.module.customer.model.Customer;
import com.unitever.module.goods.model.Goods;
import com.unitever.platform.core.dao.BaseModel;

public class Evaluation extends BaseModel {

	private String id;
	private Goods goods;
	private Customer customer;
	private String content;
	private String imgName;
	private String ft;
	private String lt;
	private String fu;
	private String lu;
	private Date createTime;

	/**
	 * 图片 数据库获取
	 */
	private List<String> imgUrl;

	public Evaluation() {
		super();
	}

	public Evaluation(String id) {
		super();
		this.id = id;
	}

	public Evaluation(String id, Goods goods, Customer customer, String content, Date createTime) {
		super();
		this.id = id;
		this.goods = goods;
		this.customer = customer;
		this.content = content;
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
	 * @return the goods
	 */
	public Goods getGoods() {
		return goods;
	}

	/**
	 * @param goods
	 *            the goods to set
	 */
	public void setGoods(Goods goods) {
		this.goods = goods;
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
	 * @return the content
	 */
	public String getContent() {
		return content;
	}

	/**
	 * @param content
	 *            the content to set
	 */
	public void setContent(String content) {
		this.content = content;
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

	/**
	 * @return the imgName
	 */
	public String getImgName() {
		return imgName;
	}

	/**
	 * @param imgName
	 *            the imgName to set
	 */
	public void setImgName(String imgName) {
		this.imgName = imgName;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Evaluation [id=" + id + ", goods=" + goods + ", customer=" + customer + ", content=" + content
				+ ", ft=" + ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu + ", createTime=" + createTime + "]";
	}

}