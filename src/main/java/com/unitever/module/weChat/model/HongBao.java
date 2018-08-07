package com.unitever.module.weChat.model;

import java.io.Serializable;
import java.util.Date;

public class HongBao implements Serializable {
	private static final long serialVersionUID = 1L;
	private Long hongBaoId;
	private Date addTime; // 红包发送时间
	private Integer amount; // 金额 单位分
	private String billNo; // 订单号
	private String openid; // 用户
	private String remark; // 微信返回的内容
	private Integer result; // 发送结果

	public Long getHongBaoId() {
		return hongBaoId;
	}

	public void setHongBaoId(Long hongBaoId) {
		this.hongBaoId = hongBaoId;
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

	public void setAmount(Integer amount) {
		this.amount = amount;
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

	public Integer getResult() {
		return result;
	}

	public void setResult(Integer result) {
		this.result = result;
	}

}