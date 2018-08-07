package com.unitever.module.consume.model;

import java.util.Date;

import com.unitever.auth.user.model.User;
import com.unitever.module.customer.model.Customer;
import com.unitever.platform.core.dao.BaseModel;

/**
 *
 * * 客户钱包余额流水记录 </p>
 *
 */
public class Consume extends BaseModel {

	/** Id */
	private String id;
	/** 会员 */
	private Customer customer;
	/** 导购 */
	private User guideUser;
	/** 流水单号(有订单用订单) */
	private String consumeCode;
	/** 类型（1：充值， 2：充值 (线下)，3：充值返现 4：消费返现 5：消费(线上) 6：消费(线下) 7:退款） */
	private String type;
	/** 金额 */
	private String money;
	/** 返现备注 */
	private String remark;
	/** 创建时间 */
	private Date createTime;

	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用

	private String typeValue;
	/** 1：充值(线上) */
	public static String TYPE_ONE_UP = "1";
	/** 2：充值 (线下) */
	public static String TYPE_ONE_DOWN = "2";
	/** 3：返现(充值) */
	public static String TYPE_TWO_IN = "3";
	/** 4：返现(消费) */
	public static String TYPE_TWO_OUT = "4";
	/** 5：消费(线上) */
	public static String TYPE_THREE_UP = "5";
	/** 6：消费(线下) */
	public static String TYPE_THREE_DOWN = "6";
	/** 7：退款 */
	public static String TYPE_RETURN_MONEY = "7";

	public Consume() {
		super();
	}

	public Consume(String id) {
		super();
		this.id = id;
	}

	public Consume(String id, Customer customer, User guideUser, String consumeCode, String type, String money,
			String remark, Date createTime) {
		super();
		this.id = id;
		this.customer = customer;
		this.guideUser = guideUser;
		this.consumeCode = consumeCode;
		this.type = type;
		this.money = money;
		this.remark = remark;
		this.createTime = createTime;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public User getGuideUser() {
		return guideUser;
	}

	public void setGuideUser(User guideUser) {
		this.guideUser = guideUser;
	}

	/**
	 *
	 * <P>
	 * 类型（1：充值， 2：充值 (线下)，3：返现 4：消费(线上) 5：消费(线下)
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月2日
	 * @return String
	 */
	public String getType() {
		return type;
	}

	/**
	 *
	 * <P>
	 * 类型（1：充值， 2：充值 (线下)，3：返现 4：消费(线上) 5：消费(线下)
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月2日
	 * @param type
	 *            void
	 */
	public void setType(String type) {
		this.type = type;
	}

	public String getMoney() {
		return money;
	}

	public void setMoney(String money) {
		this.money = money;
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
	 * @return the typeValue 1：充值， 2：充值 (线下)，3：充值返现 4：消费返现 5：消费(线上) 6：消费(线下)
	 */
	public String getTypeValue() {
		if (TYPE_ONE_UP.equals(type)) {
			return "线上充值";
		} else if (TYPE_ONE_DOWN.equals(type)) {
			return "线下充值";
		} else if (TYPE_TWO_IN.equals(type)) {
			return "充值返现";
		} else if (TYPE_TWO_OUT.equals(type)) {
			return "消费返现";
		} else if (TYPE_THREE_UP.equals(type)) {
			return "线上消费";
		} else if (TYPE_THREE_DOWN.equals(type)) {
			return "线下消费";
		} else if (TYPE_RETURN_MONEY.equals(type)) {
			return "退款";
		}
		return null;
	}

	/**
	 * @return the consumeCode
	 */
	public String getConsumeCode() {
		return consumeCode;
	}

	/**
	 * @param consumeCode
	 *            the consumeCode to set
	 */
	public void setConsumeCode(String consumeCode) {
		this.consumeCode = consumeCode;
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

	@Override
	public String toString() {
		return "Consume [id=" + id + ", customer=" + customer + ", guideUser=" + guideUser + ", type=" + type
				+ ", money=" + money + ", createTime=" + createTime + ", ft=" + ft + ", lt=" + lt + ", fu=" + fu
				+ ", lu=" + lu + "]";
	}

}
