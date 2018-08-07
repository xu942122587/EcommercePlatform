package com.unitever.module.weChat.model;

public class WeChat {
	private String id;
	private String wechatnum;
	private String name;
	private String accesstoken;
	private String jsapiticket;
	private String expirestime;
	private String fatherAppid;
	private String appid;
	private String appsecret;
	private String fatherMchid;
	private String mchid;
	private String apisecret;
	private String fatherApisecret;
	private String domainName;
	private String tel;
	private String qrcodeUrl;
	private String wishing;
	private String actName;
	private String actRemark;
	private String actKey;
	private String mchidOrdinary;
	private String desc;
	private String prizeMaxCount;

	/**
	 * 支付宝支付应用私钥
	 */
	private String aliPayPrivateKey;
	/**
	 * 支付宝appid
	 */
	private String aliAppid;
	/**
	 * 支付宝公钥
	 */
	private String aliPublicKey;
	/**
	 * 支付宝接口调用网关
	 */
	private String aliHttpURL;

	public WeChat() {
		super();
	}

	public WeChat(String id) {
		super();
		this.id = id;
	}

	public String getFatherAppid() {
		return fatherAppid;
	}

	public void setFatherAppid(String fatherAppid) {
		this.fatherAppid = fatherAppid;
	}

	public String getFatherMchid() {
		return fatherMchid;
	}

	public void setFatherMchid(String fatherMchid) {
		this.fatherMchid = fatherMchid;
	}

	public String getActName() {
		return actName;
	}

	public void setActName(String actName) {
		this.actName = actName;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getWechatnum() {
		return wechatnum;
	}

	public void setWechatnum(String wechatnum) {
		this.wechatnum = wechatnum;
	}

	public String getAccesstoken() {
		return accesstoken;
	}

	public void setAccesstoken(String accesstoken) {
		this.accesstoken = accesstoken;
	}

	public String getJsapiticket() {
		return jsapiticket;
	}

	public void setJsapiticket(String jsapiticket) {
		this.jsapiticket = jsapiticket;
	}

	public String getExpirestime() {
		return expirestime;
	}

	public void setExpirestime(String expirestime) {
		this.expirestime = expirestime;
	}

	public String getAppid() {
		return appid;
	}

	public void setAppid(String appid) {
		this.appid = appid;
	}

	public String getAppsecret() {
		return appsecret;
	}

	public void setAppsecret(String appsecret) {
		this.appsecret = appsecret;
	}

	public String getMchid() {
		return mchid;
	}

	public void setMchid(String mchid) {
		this.mchid = mchid;
	}

	public String getApisecret() {
		return apisecret;
	}

	public void setApisecret(String apisecret) {
		this.apisecret = apisecret;
	}

	public String getDomainName() {
		return domainName;
	}

	public void setDomainName(String domainName) {
		this.domainName = domainName;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getQrcodeUrl() {
		return qrcodeUrl;
	}

	public void setQrcodeUrl(String qrcodeUrl) {
		this.qrcodeUrl = qrcodeUrl;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getWishing() {
		return wishing;
	}

	public void setWishing(String wishing) {
		this.wishing = wishing;
	}

	public String getActRemark() {
		return actRemark;
	}

	public void setActRemark(String actRemark) {
		this.actRemark = actRemark;
	}

	public String getActKey() {
		return actKey;
	}

	public void setActKey(String actKey) {
		this.actKey = actKey;
	}

	public String getMchidOrdinary() {
		return mchidOrdinary;
	}

	public void setMchidOrdinary(String mchidOrdinary) {
		this.mchidOrdinary = mchidOrdinary;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getPrizeMaxCount() {
		return prizeMaxCount;
	}

	public void setPrizeMaxCount(String prizeMaxCount) {
		this.prizeMaxCount = prizeMaxCount;
	}

	public String getFatherApisecret() {
		return fatherApisecret;
	}

	public void setFatherApisecret(String fatherApisecret) {
		this.fatherApisecret = fatherApisecret;
	}

	/**
	 * @return the aliPayPrivateKey 支付宝支付应用私钥
	 */
	public String getAliPayPrivateKey() {
		return aliPayPrivateKey;
	}

	/**
	 * @param aliPayPrivateKey
	 *            the aliPayPrivateKey（支付宝支付应用私钥） to set
	 */
	public void setAliPayPrivateKey(String aliPayPrivateKey) {
		this.aliPayPrivateKey = aliPayPrivateKey;
	}

	/**
	 * @return the aliAppid 支付宝appid
	 */
	public String getAliAppid() {
		return aliAppid;
	}

	/**
	 * @param aliAppid
	 *            the aliAppid（支付宝appid） to set
	 */
	public void setAliAppid(String aliAppid) {
		this.aliAppid = aliAppid;
	}

	/**
	 * @return the aliPublicKey 支付宝公钥
	 */
	public String getAliPublicKey() {
		return aliPublicKey;
	}

	/**
	 * @param aliPublicKey
	 *            the aliPublicKey（支付宝公钥） to set
	 */
	public void setAliPublicKey(String aliPublicKey) {
		this.aliPublicKey = aliPublicKey;
	}

	/**
	 * @return the aliHttpURL 支付宝接口调用网关
	 */
	public String getAliHttpURL() {
		return aliHttpURL;
	}

	/**
	 * @param aliHttpURL
	 *            the aliHttpURL（支付宝接口调用网关） to set
	 */
	public void setAliHttpURL(String aliHttpURL) {
		this.aliHttpURL = aliHttpURL;
	}

}
