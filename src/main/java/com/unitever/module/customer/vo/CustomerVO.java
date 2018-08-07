package com.unitever.module.customer.vo;

import java.util.Date;

import com.unitever.auth.user.model.User;
import com.unitever.module.employee.model.Employee;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.customer.vo->CustomerVO.java
 * </p>
 * <P>
 * 客户
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月9日
 */
public class CustomerVO {

	/** Id */
	private String id;
	/** 姓名 */
	private String name;
	/** 生日 */
	private Date birthday;
	/** 手机号 */
	private String phone;
	/** 登陆密码 */
	private String loginPassword;
	/** 钱包余额 */
	private String money;
	/** 支付密码 */
	private String payPassword;
	/** 拉黑 */
	private String isBlank;
	/** 微信用户 */
	private Employee employee;
	/** 导购编号 */
	private User guideUser;
	/** 图片 */
	private String headImgurl;
	/** 创建时间 */
	private Date createTime;
	/** 线上购买量 */
	private String upSumNumber;
	/** 线上消费额 */
	private String upPayMoney;
	/** 线下购买量 */
	private String downSumNumber;
	/** 线下消费额 */
	private String downPayMoney;

	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用

	public CustomerVO() {
		super();
	}

	public CustomerVO(String id) {
		super();
		this.id = id;
	}

	public CustomerVO(String id, String name, Date birthday, String phone, String loginPassword, String money,
			String payPassword, String isBlank, Employee employee, String headImgurl, Date createTime) {
		super();
		this.id = id;
		this.name = name;
		this.birthday = birthday;
		this.phone = phone;
		this.loginPassword = loginPassword;
		this.money = money;
		this.payPassword = payPassword;
		this.isBlank = isBlank;
		this.employee = employee;
		this.headImgurl = headImgurl;
		this.createTime = createTime;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getLoginPassword() {
		return loginPassword;
	}

	public void setLoginPassword(String loginPassword) {
		this.loginPassword = loginPassword;
	}

	public String getMoney() {
		return money;
	}

	public void setMoney(String money) {
		this.money = money;
	}

	public String getPayPassword() {
		return payPassword;
	}

	public void setPayPassword(String payPassword) {
		this.payPassword = payPassword;
	}

	public String getIsBlank() {
		return isBlank;
	}

	public void setIsBlank(String isBlank) {
		this.isBlank = isBlank;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
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

	public String getHeadImgurl() {
		return headImgurl;
	}

	public void setHeadImgurl(String headImgurl) {
		this.headImgurl = headImgurl;
	}

	/**
	 * @return the guideUser
	 */
	public User getGuideUser() {
		return guideUser;
	}

	/**
	 * @param guideUser
	 *            the guideUser to set
	 */
	public void setGuideUser(User guideUser) {
		this.guideUser = guideUser;
	}

	/**
	 * @return the upSumNumber
	 */
	public String getUpSumNumber() {
		return upSumNumber;
	}

	/**
	 * @param upSumNumber
	 *            the upSumNumber to set
	 */
	public void setUpSumNumber(String upSumNumber) {
		this.upSumNumber = upSumNumber;
	}

	/**
	 * @return the upPayMoney
	 */
	public String getUpPayMoney() {
		return upPayMoney;
	}

	/**
	 * @param upPayMoney
	 *            the upPayMoney to set
	 */
	public void setUpPayMoney(String upPayMoney) {
		this.upPayMoney = upPayMoney;
	}

	/**
	 * @return the downSumNumber
	 */
	public String getDownSumNumber() {
		return downSumNumber;
	}

	/**
	 * @param downSumNumber
	 *            the downSumNumber to set
	 */
	public void setDownSumNumber(String downSumNumber) {
		this.downSumNumber = downSumNumber;
	}

	/**
	 * @return the downPayMoney
	 */
	public String getDownPayMoney() {
		return downPayMoney;
	}

	/**
	 * @param downPayMoney
	 *            the downPayMoney to set
	 */
	public void setDownPayMoney(String downPayMoney) {
		this.downPayMoney = downPayMoney;
	}

	@Override
	public String toString() {
		return "Customer [id=" + id + ", name=" + name + ", birthday=" + birthday + ", phone=" + phone
				+ ", loginPassword=" + loginPassword + ", money=" + money + ", payPassword=" + payPassword
				+ ", isBlank=" + isBlank + ", employee=" + employee + ", headImgurl=" + headImgurl + ", createTime="
				+ createTime + ", ft=" + ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu + "]";
	}

}
