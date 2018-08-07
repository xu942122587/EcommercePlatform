package com.unitever.module.customer.model;

import java.util.Date;

import com.unitever.auth.user.model.User;
import com.unitever.module.employee.model.Employee;
import com.unitever.platform.core.dao.BaseModel;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.customer.model->Customer.java
 * </p>
 * <P>
 * * 客户
 * </p>
 *
 * @author 闫枫
 * @date Jun 27, 2017
 */
/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.customer.model->Customer.java
 * </p>
 * <P>
 * TODO
 * </p>
 *
 * @author 闫枫
 * @date Sep 20, 2017
 */
public class Customer extends BaseModel {

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
	/** 导购推荐提成 */
	private String registerBonusMoney;
	/** 导购推荐数总 */
	private String sumGuideUser;
	/** 导购推荐提成总 */
	private String sumRegisterBonusMoney;
	/** 是否拉黑（1：否，2：是） */
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
	/** 天和钱包支付动态密码 */
	private String payCode;
	/** 天和钱包支付动态密码生成时间 */
	private Date payCodeCreateTime;

	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用
	/** 拉黑 */
	public static final String ISBLANK_TRUE = "2";
	/** 不拉黑 */
	public static final String ISBLANK_FALSE = "1";

	public Customer() {
		super();
	}

	public Customer(String id) {
		super();
		this.id = id;
	}

	public Customer(String id, String name, Date birthday, String phone, String loginPassword, String money,
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

	/**
	 * @return the sumGuideUser
	 */
	public String getSumGuideUser() {
		return sumGuideUser;
	}

	/**
	 * @param sumGuideUser
	 *            the sumGuideUser to set
	 */
	public void setSumGuideUser(String sumGuideUser) {
		this.sumGuideUser = sumGuideUser;
	}

	/**
	 * @return the sumRegisterBonusMoney
	 */
	public String getSumRegisterBonusMoney() {
		return sumRegisterBonusMoney;
	}

	/**
	 * @param sumRegisterBonusMoney
	 *            the sumRegisterBonusMoney to set
	 */
	public void setSumRegisterBonusMoney(String sumRegisterBonusMoney) {
		this.sumRegisterBonusMoney = sumRegisterBonusMoney;
	}

	/**
	 * @return the registerBonusMoney
	 */
	public String getRegisterBonusMoney() {
		return registerBonusMoney;
	}

	/**
	 * @param registerBonusMoney
	 *            the registerBonusMoney to set
	 */
	public void setRegisterBonusMoney(String registerBonusMoney) {
		this.registerBonusMoney = registerBonusMoney;
	}

	/**
	 * @return the payCode 天和钱包支付动态密码
	 */
	public String getPayCode() {
		return payCode;
	}

	/**
	 * @param payCode
	 *            the payCode（ 天和钱包支付动态密码 ） to set
	 */
	public void setPayCode(String payCode) {
		this.payCode = payCode;
	}

	/**
	 * @return the payCodeCreateTime 天和钱包支付动态密码生成时间
	 */
	public Date getPayCodeCreateTime() {
		return payCodeCreateTime;
	}

	/**
	 * @param payCodeCreateTime
	 *            the payCodeCreateTime（天和钱包支付动态密码生成时间） to set
	 */
	public void setPayCodeCreateTime(Date payCodeCreateTime) {
		this.payCodeCreateTime = payCodeCreateTime;
	}

}
