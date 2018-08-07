package com.unitever.module.eticketoutRecord.model;

import java.util.Date;

import com.unitever.module.customer.model.Customer;
import com.unitever.module.eticket.model.Eticket;
import com.unitever.platform.core.dao.BaseModel;
import com.unitever.platform.util.DateUtil;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.eticketoutRecord.model->EticketOutRecord
 * .java
 * </p>
 * <P>
 * 电子券发放记录
 * </p>
 *
 * @author 闫枫
 * @date Sep 7, 2017
 */
public class EticketOutRecord extends BaseModel {

	/** 发放记录ID */
	private String id;
	/** 发放日期 */
	private Date createDate;
	/** 发放的电子券 */
	private Eticket eticket;
	/** 客户 */
	private Customer customer;
	/** 使用状态 */
	private String state;
	/** 发放备注 */
	private String remark;
	/** 到期时间 年月日 */
	private Date endDate;
	/** 到期时间 年月日 */
	private String endDateValue;
	/** 编号 */
	private String code;

	/** 是否隐藏 1:隐藏 2:显示 */
	private String isHide;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate_select; // 查询用
	private String endDate_select; // 查询用

	private String createDateString;

	private String stateValue;
	/** 状态：未使用 */
	public static final String STATUS_NORMAL = "1";
	/** 状态：已使用 */
	public static final String STATUS_USED = "2";
	/** 状态：过期失效 */
	public static final String STATUS_FAIL = "3";
	/** 是否隐藏 1:隐藏 2:显示 */
	private String isHideValue;
	/** 是否隐藏 1:隐藏 */
	public static final String ISHIDE_ONE = "1";
	/** 是否隐藏 2:显示 */
	public static final String ISHIDE_TWO = "2";

	public EticketOutRecord() {
		super();
	}

	public EticketOutRecord(String id) {
		super();
		this.id = id;
	}

	public EticketOutRecord(String id, Date createDate, Eticket eticket, String state, String remark, String code,
			Customer customer) {
		super();
		this.id = id;
		this.createDate = createDate;
		this.eticket = eticket;
		this.state = state;
		this.remark = remark;
		this.code = code;
		this.customer = customer;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Eticket getEticket() {
		return eticket;
	}

	public void setEticket(Eticket eticket) {
		this.eticket = eticket;
	}

	/**
	 * @return the state
	 */
	public String getState() {
		return state;
	}

	/**
	 * @param state
	 *            the state to set
	 */
	public void setState(String state) {
		this.state = state;
	}

	public String getStateValue() {
		switch (state) {
		case STATUS_NORMAL:
			stateValue = "未使用";
			break;
		case STATUS_USED:
			stateValue = "已使用";
			break;
		case STATUS_FAIL:
			stateValue = "已失效";
			break;
		default:
			stateValue = "未知";
			break;
		}
		return stateValue;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
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
	 * @return the startDate_select
	 */
	public String getStartDate_select() {
		return startDate_select;
	}

	/**
	 * @param startDate_select
	 *            the startDate_select to set
	 */
	public void setStartDate_select(String startDate_select) {
		this.startDate_select = startDate_select;
	}

	/**
	 * @return the endDate_select
	 */
	public String getEndDate_select() {
		return endDate_select;
	}

	/**
	 * @param endDate_select
	 *            the endDate_select to set
	 */
	public void setEndDate_select(String endDate_select) {
		this.endDate_select = endDate_select;
	}

	/**
	 * @return the createDateString
	 */
	public String getCreateDateString() {
		return DateUtil.getDateString(createDate);
	}

	/**
	 * @return the endDateValue
	 */
	public String getEndDateValue() {
		String endDateValue = DateUtil.getDateString(endDate);
		return endDateValue;
	}

	/**
	 * @return the isHide
	 */
	public String getIsHide() {
		return isHide;
	}

	/**
	 * @param isHide
	 *            the isHide to set
	 */
	public void setIsHide(String isHide) {
		this.isHide = isHide;
	}

	/**
	 * @return the isHideValue
	 */
	public String getIsHideValue() {
		if (ISHIDE_ONE.equals(isHide)) {
			return "隐藏";
		} else if (ISHIDE_TWO.equals(isHide)) {
			return "显示";
		}
		return null;
	}

}
