package com.unitever.module.client.model;

import java.util.Date;

import com.unitever.auth.user.model.User;
import com.unitever.module.goods.model.Goods;
import com.unitever.module.qrcode.model.Qrcode;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.client.model->ClientShoppingcart.java
 * </p>
 * <P>
 * 客户端收银员购物车，用于缓冲扫描录入的商品，方便订单提交
 * </p>
 *
 * @author 闫枫
 * @date Jul 22, 2017
 */
public class ClientShoppingcart {

	/** Id */
	private String id;
	/** 收银员 */
	private User user;
	/** 商品 */
	private Goods goods;
	/** 二维码 */
	private Qrcode qrcode;
	/** 类型（1：卖出，2：退回。ps:卖出在卖出、换货单出现，退回在退货单和换货单中出现） */
	private String type;
	/** 数量 */
	private String count;
	/** 商品售价，由导购开具（默认放置产品售价） */
	private String salesPrice;
	/** 创建时间 */
	private Date createTime;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	/**
	 * 类型：卖出
	 */
	public static final String TYPE_ONE = "1";
	/**
	 * 类型：退回
	 */
	public static final String TYPE_TWO = "2";

	/**
	 * 
	 */
	public ClientShoppingcart() {
		super();
	}

	/**
	 * @param id
	 */
	public ClientShoppingcart(String id) {
		super();
		this.id = id;
	}

	/**
	 * @param id
	 * @param user
	 *            收银员
	 * @param goods
	 *            商品
	 * @param type
	 *            类型（1：卖出，2：退回。ps:卖出在卖出、换货单出现，退回在退货单和换货单中出现）
	 * @param count
	 *            数量
	 * @param salesPrice
	 *            商品售价，由导购开具（默认放置产品售价
	 * @param createTime
	 *            创建时间
	 * @param qrcode
	 *            二维码
	 */
	public ClientShoppingcart(String id, User user, Goods goods, String type, String count, String salesPrice,
			Date createTime, Qrcode qrcode) {
		super();
		this.id = id;
		this.user = user;
		this.goods = goods;
		this.type = type;
		this.count = count;
		this.salesPrice = salesPrice;
		this.createTime = createTime;
		this.qrcode = qrcode;
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
	 * @return the user 收银员
	 */
	public User getUser() {
		return user;
	}

	/**
	 * @param user
	 *            the user（收银员） to set
	 */
	public void setUser(User user) {
		this.user = user;
	}

	/**
	 * @return the goods 商品
	 */
	public Goods getGoods() {
		return goods;
	}

	/**
	 * @param goods
	 *            the goods(商品) to set
	 */
	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	/**
	 * @return the type 类型（1：卖出，2：退回。ps:卖出在卖出、换货单出现，退回在退货单和换货单中出现）
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type
	 *            the type(类型（1：卖出，2：退回。ps:卖出在卖出、换货单出现，退回在退货单和换货单中出现）) to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return the count 数量
	 */
	public String getCount() {
		return count;
	}

	/**
	 * @param count
	 *            the count(数量) to set
	 */
	public void setCount(String count) {
		this.count = count;
	}

	/**
	 * @return the salesPrice 商品售价，由导购开具（默认放置产品售价
	 */
	public String getSalesPrice() {
		return salesPrice;
	}

	/**
	 * @param salesPrice
	 *            the salesPrice(商品售价，由导购开具（默认放置产品售价) to set
	 */
	public void setSalesPrice(String salesPrice) {
		this.salesPrice = salesPrice;
	}

	/**
	 * @return the createTime 创建时间
	 */
	public Date getCreateTime() {
		return createTime;
	}

	/**
	 * @param createTime
	 *            the createTime(创建时间) to set
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
	 * @return the qrcode 二维码
	 */
	public Qrcode getQrcode() {
		return qrcode;
	}

	/**
	 * @param qrcode
	 *            the qrcode（二维码） to set
	 */
	public void setQrcode(Qrcode qrcode) {
		this.qrcode = qrcode;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "ClientShoppingcart [id=" + id + ", user=" + user + ", goods=" + goods + ", type=" + type + ", count="
				+ count + ", salesPrice=" + salesPrice + ", createTime=" + createTime + ", ft=" + ft + ", lt=" + lt
				+ ", fu=" + fu + ", lu=" + lu + "]";
	}
}
