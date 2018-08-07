package com.unitever.module.weChat.model.pay;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "xml")
public class PayPackage {

	private String bank_type; // 银行通道类型

	private String body; // 商品描述

	private String attach; // 附加数据

	private String mch_id; // 商户号

	private String out_trade_no;// 商户订单号

	private String total_fee; // 订单价格

	private String fee_type; // 支付类型 1 人民币

	private String notify_url; // 返回地址

	private String spbill_create_ip; // 订单生成的客户端IP

	private String time_start; // 交易起始时间

	private String time_expire; // 交易结束时间

	private String transport_fee; // 物流费用

	private String product_fee; // 商品费用

	private String goods_tag; // 商品标记,优惠卷里可能用到

	private String input_charset; // default GBK , UTF-8

	private String trade_type; // 交易类型

	private String appid; // 公众账号ID

	private String device_info; // 设备号

	private String nonce_str; // 随机字符串,随机字符串，不长于32位。

	private String sign; // 签名

	private String detail; // 商品详情

	private String product_id; // 商品ID,trade_type=NATIVE，此参数必传。此id为二维码中包含的商品ID，商户自行定义。

	private String limit_pay; // 指定支付方式 , no_credit--指定不能使用信用卡支付

	private String openid; // trade_type=JSAPI，此参数必传，用户在商户appid下的唯一标识。

	private String sub_appid; // 子商户公众账号ID

	private String sub_mch_id; // 子商户号

	private String sub_openid; // 用户子标识

	public String getTrade_type() {
		return trade_type;
	}

	public void setTrade_type(String trade_type) {
		this.trade_type = trade_type;
	}

	public String getAppid() {
		return appid;
	}

	public void setAppid(String appid) {
		this.appid = appid;
	}

	public String getDevice_info() {
		return device_info;
	}

	public void setDevice_info(String device_info) {
		this.device_info = device_info;
	}

	public String getNonce_str() {
		return nonce_str;
	}

	public void setNonce_str(String nonce_str) {
		this.nonce_str = nonce_str;
	}

	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getProduct_id() {
		return product_id;
	}

	public void setProduct_id(String product_id) {
		this.product_id = product_id;
	}

	public String getLimit_pay() {
		return limit_pay;
	}

	public void setLimit_pay(String limit_pay) {
		this.limit_pay = limit_pay;
	}

	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public String getBank_type() {
		return bank_type;
	}

	public void setBank_type(String bank_type) {
		this.bank_type = bank_type;
	}

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}

	public String getAttach() {
		return attach;
	}

	public void setAttach(String attach) {
		this.attach = attach;
	}

	public String getMch_id() {
		return mch_id;
	}

	public void setMch_id(String mch_id) {
		this.mch_id = mch_id;
	}

	public String getOut_trade_no() {
		return out_trade_no;
	}

	public void setOut_trade_no(String outTradeNo) {
		out_trade_no = outTradeNo;
	}

	public String getTotal_fee() {
		return total_fee;
	}

	public void setTotal_fee(String totalFee) {
		total_fee = totalFee;
	}

	public String getFee_type() {
		return fee_type;
	}

	public void setFee_type(String feeType) {
		fee_type = feeType;
	}

	public String getNotify_url() {
		return notify_url;
	}

	public void setNotify_url(String notifyUrl) {
		notify_url = notifyUrl;
	}

	public String getSpbill_create_ip() {
		return spbill_create_ip;
	}

	public void setSpbill_create_ip(String spbillCreateIp) {
		spbill_create_ip = spbillCreateIp;
	}

	public String getTime_start() {
		return time_start;
	}

	public void setTime_start(String timeStart) {
		time_start = timeStart;
	}

	public String getTime_expire() {
		return time_expire;
	}

	public void setTime_expire(String timeExpire) {
		time_expire = timeExpire;
	}

	public String getTransport_fee() {
		return transport_fee;
	}

	public void setTransport_fee(String transportFee) {
		transport_fee = transportFee;
	}

	public String getProduct_fee() {
		return product_fee;
	}

	public void setProduct_fee(String productFee) {
		product_fee = productFee;
	}

	public String getGoods_tag() {
		return goods_tag;
	}

	public void setGoods_tag(String goodsTag) {
		goods_tag = goodsTag;
	}

	public String getInput_charset() {
		return input_charset;
	}

	public void setInput_charset(String inputCharset) {
		input_charset = inputCharset;
	}

	public String getSub_appid() {
		return sub_appid;
	}

	public void setSub_appid(String sub_appid) {
		this.sub_appid = sub_appid;
	}

	public String getSub_mch_id() {
		return sub_mch_id;
	}

	public void setSub_mch_id(String sub_mch_id) {
		this.sub_mch_id = sub_mch_id;
	}

	public String getSub_openid() {
		return sub_openid;
	}

	public void setSub_openid(String sub_openid) {
		this.sub_openid = sub_openid;
	}

}
