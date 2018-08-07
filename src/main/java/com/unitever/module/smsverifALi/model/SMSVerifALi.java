package com.unitever.module.smsverifALi.model;

import java.util.Date;

/**
 *
 * <P>
 * platform-zslw->com.unitever.module.smsverifALi.model->SMSVerifALi.java
 * </p>
 * <P>
 * 阿里短信验证
 * </p>
 *
 * @author 徐昊
 * @date 2018年1月8日
 */
public class SMSVerifALi {

	/* ID */
	public String id;
	/* 手机号 */
	public String phone;
	/* 验证码 */
	public String code;
	/* 创建时间 */
	public Date createTime;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	/** 短信签名(阿里云短信测试专用) */
	public static final String SIGNNAME_ONE = "阿里云短信测试专用";
	/** 短信签名(待申请签名) */
	public static final String SIGNNAME_TWO = "有活有人";
	/** 短信模板ID(登录确认验证码) */
	public static final String TEMPLATECODE_ONE = "SMS_120115961";
	/** 短信模板ID(用户注册验证码) */
	public static final String TEMPLATECODE_TWO = "SMS_120130916";

	public SMSVerifALi() {
		super();
	}

	public SMSVerifALi(String id) {
		super();
		this.id = id;
	}

	public SMSVerifALi(String id, String phone, String code, Date createTime) {
		super();
		this.id = id;
		this.phone = phone;
		this.code = code;
		this.createTime = createTime;
	}

	public SMSVerifALi(String id, String phone, String code, Date createTime, String ft, String lt, String fu, String lu) {
		super();
		this.id = id;
		this.phone = phone;
		this.code = code;
		this.createTime = createTime;
		this.ft = ft;
		this.lt = lt;
		this.fu = fu;
		this.lu = lu;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
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

	@Override
	public String toString() {
		return "SMSVerif [id=" + id + ", phone=" + phone + ", code=" + code + ", createTime=" + createTime + ", ft="
				+ ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu + "]";
	}

}
