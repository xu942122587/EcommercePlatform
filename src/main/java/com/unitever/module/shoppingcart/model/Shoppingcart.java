package com.unitever.module.shoppingcart.model;

import java.util.Date;

import com.unitever.module.customer.model.Customer;
import com.unitever.module.goods.model.Goods;
import com.unitever.module.store.model.Store;

/**
 *
 * * 购物车
 * </p>
 *
 */
public class Shoppingcart {


	/** Id */
	private String id;
	/** 商品 */
	private Goods goods;
	/** 用户 */
	private Customer customer;
	/** 数量 */
	private String count;
	/** 创建时间 */
	private Date createTime;

	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用

	public Shoppingcart() {
		super();
	}

	public Shoppingcart(String id) {
		super();
		this.id = id;
	}

	public Shoppingcart(String id, Goods goods, Customer customer,
			String count, Date createTime) {
		super();
		this.id = id;
		this.goods = goods;
		this.customer = customer;
		this.count = count;
		this.createTime = createTime;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
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

	@Override
	public String toString() {
		return "Shoppingcart [id=" + id + ", goods=" + goods + ", customer="
				+ customer + ", count=" + count + ", createTime=" + createTime
				+ ", ft=" + ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu
				+ "]";
	}


}
