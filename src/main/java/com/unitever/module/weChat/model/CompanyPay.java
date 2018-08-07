package com.unitever.module.weChat.model;

import java.io.Serializable;
import java.util.Date;

public class CompanyPay implements Serializable {

	private static final long serialVersionUID = 1L;
	private Long companyPay;
	private Date addTime;
	private Integer amount;
	private String billNo;
	private String openid;
	private String remark;
	private Integer reuslt;

	public Long getCompanyPay() {
		return companyPay;
	}

	public void setCompanyPay(Long companyPay) {
		this.companyPay = companyPay;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amountl) {
		this.amount = amountl;
	}

	public String getBillNo() {
		return billNo;
	}

	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}

	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getReuslt() {
		return reuslt;
	}

	public void setReuslt(Integer reuslt) {
		this.reuslt = reuslt;
	}

}
