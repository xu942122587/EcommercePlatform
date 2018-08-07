package com.unitever.module.orderAfterSale.model;

import java.util.Date;
import java.util.List;

import com.unitever.auth.user.model.User;
import com.unitever.module.orderGoodsQrcode.model.OrderGoodsQrcode;
import com.unitever.platform.core.dao.BaseModel;

/**
 *
 * <p>
 * 订单
 * </p>
 *
 */
public class OrderAfterSale extends BaseModel {

	/** Id */
	private String id;
	/** 售后商品 */
	private OrderGoodsQrcode orderGoodsQrcode;
	/** 主管 */
	private User user;
	/** 售后退款金 */
	private String sendMoney;
	/** 售后备注 */
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

	/**
	 * 图片 数据库获取
	 */
	private List<String> imgUrl;

	private String isDeleteValue;
	/**
	 * 是否删除--否
	 */
	public static final String ISDELETE_NO = "1";
	/**
	 * 是否删除--是
	 */
	public static final String ISDELETE_YES = "2";

	public OrderAfterSale() {
		super();
	}

	public OrderAfterSale(String id) {
		super();
		this.id = id;
	}

	public OrderAfterSale(String id, OrderGoodsQrcode orderGoodsQrcode, User user, String sendMoney, String remark,
			String isDelete, Date createTime) {
		super();
		this.id = id;
		this.orderGoodsQrcode = orderGoodsQrcode;
		this.user = user;
		this.sendMoney = sendMoney;
		this.remark = remark;
		this.isDelete = isDelete;
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
	 * @return the orderGoodsQrcode
	 */
	public OrderGoodsQrcode getOrderGoodsQrcode() {
		return orderGoodsQrcode;
	}

	/**
	 * @param orderGoodsQrcode
	 *            the orderGoodsQrcode to set
	 */
	public void setOrderGoodsQrcode(OrderGoodsQrcode orderGoodsQrcode) {
		this.orderGoodsQrcode = orderGoodsQrcode;
	}

	/**
	 * @return the user
	 */
	public User getUser() {
		return user;
	}

	/**
	 * @param user
	 *            the user to set
	 */
	public void setUser(User user) {
		this.user = user;
	}

	/**
	 * @return the sendMoney
	 */
	public String getSendMoney() {
		return sendMoney;
	}

	/**
	 * @param sendMoney
	 *            the sendMoney to set
	 */
	public void setSendMoney(String sendMoney) {
		this.sendMoney = sendMoney;
	}

	/**
	 * @return the remark
	 */
	public String getRemark() {
		return remark;
	}

	/**
	 * @param remark
	 *            the remark to set
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}

	/**
	 * @return the isDelete
	 */
	public String getIsDelete() {
		return isDelete;
	}

	/**
	 * @param isDelete
	 *            the isDelete to set
	 */
	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
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
	 * @return the isDeleteValue
	 */
	public String getIsDeleteValue() {
		if (ISDELETE_NO.equals(isDelete)) {
			return "否";
		}
		if (ISDELETE_YES.equals(isDelete)) {
			return "是";
		}
		return null;
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "OrderAfterSale [id=" + id + ", orderGoodsQrcode=" + orderGoodsQrcode + ", user=" + user
				+ ", sendMoney=" + sendMoney + ", remark=" + remark + ", isDelete=" + isDelete + ", createTime="
				+ createTime + ", ft=" + ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu + "]";
	}

}
