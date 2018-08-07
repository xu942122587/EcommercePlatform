package com.unitever.module.order.model;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.unitever.auth.user.model.User;
import com.unitever.module.customer.model.Customer;
import com.unitever.module.eticketuseRecord.model.EticketUseRecord;
import com.unitever.module.orderGoods.model.OrderGoods;
import com.unitever.module.orderSubremark.model.OrderSubremark;
import com.unitever.module.qrcode.model.Qrcode;
import com.unitever.module.store.model.Store;
import com.unitever.platform.core.dao.BaseModel;

/**
 *
 * <p>
 * 订单
 * </p>
 *
 */
public class Order extends BaseModel {

	/** Id */
	private String id;
	/** 会员 */
	private Customer customer;
	/** 门店 */
	private Store store;
	/** 收银员 */
	private User cashierUser;
	/** 导购 */
	private User guideUser;
	/** 订单 */
	private Order order;
	/** 订单号 */
	private String code;
	/** 类型（1：线上，2：线下，3：换购，4：预约，5：退货，6：换货 ,7:同码换货,8:赔偿） */
	private String type;
	/** 下单日期（线上），线下和换购：成交日期，预约：完成日期 */
	private Date payTime;
	/** 预约人 */
	private String reserveName;
	/** 预约电话 */
	private String reservePhone;
	/** 预约时间 */
	private Date reserveTime;
	/** 预约金额 */
	private String reserveMoney;
	/** 尾款（预约单会有） */
	private String lestMoney;
	/**
	 * 状态(1：未支付，2：未发货，3：已出库，4：已发货，5：待评价，6：已完成，7：放弃)（ps：放弃的状态在预约类的订单会出现，状态2、
	 * 3、4、5 只有线上出现其他状态都出现）
	 */
	private String state;
	/** 订单总金额 */
	private String sumMoney;
	/** 订单总数量 */
	private String sumNumber;
	/** 总支付金额 */
	private String payMoney;
	/** 订单优惠卷金额 */
	private String eticketMoney;
	/** 订单总优惠金额 */
	private String subMoney;
	/**
	 * 优惠级别（1：导购，2：主管，3：经理）
	 */
	private String subUserType;
	/** 款台号 */
	private String cashierCode;
	/** 支付方式（1：现金支付，2：银行pos刷卡支付，3：微信支付，4：支付宝支付，5：账户余额支付） */
	private String payType;
	/** 订单留言（仅线上订单有） */
	private String leaveMessage;
	/** 收货人（仅线上订单有） */
	private String receiverName;
	/** 收货地址（仅线上订单有） */
	private String receiverAddress;
	/** 收货人手机号（仅线上订单有） */
	private String receiverPhone;
	/** 线上订单支付总金额 */
	private String inLinePayMoney;
	/** 快递姓名（仅线上订单有） */
	private String expressName;
	/** 快递电话（仅线上订单有） */
	private String expressPhone;
	/**
	 * goodsOrder对应产品级活动子订单，storeOrder对应门店级活动子订单，
	 * tianheOrder对应天和级活动子订单，otherOrder代表无活动子订单产品， nullOrder 代表讲价优惠订单(不参与任何活动订单)
	 */
	private String proType;
	/**
	 * 订单优惠记录
	 */
	private List<OrderSubremark> orderSubremarkList;
	/** 第一次支付金额 */
	private String onePayMoney;
	/** 第一次支付方式 */
	private String onePayType;
	/** 第一次支付交易单号（微信或支付宝支付会有） */
	private String onePayCode;
	/** 订单首次支付未退款金额 */
	private String oneReturnMoney;
	/** 第二次支付金额 */
	private String twoPayMoney;
	/** 第二次支付方式 */
	private String twoPayType;
	/** 第二次支付交易单号（微信或支付宝支付会有） */
	private String twoPayCode;
	/** 第二次支付时间 */
	private String twoPayTime;
	/** 第二次支付收银员 */
	private User twoCashierUser;
	/** 第二次支付款台号 */
	private String twoCashierCode;
	/** 第二次支付未退款金额 */
	private String twoReturnMoney;
	/** 现金退款额度 */
	private String returnMoney;
	/** 微信支付退款额度 */
	private String returnWeChatPay;
	/** 支付宝支付退款额度 */
	private String returnAliPay;
	/** 银行卡退款额 */
	private String returnCard;
	/** 天和钱包退款额 */
	private String returnTianhe;
	/** 首次实收金额(现金和银行卡会放) */
	private String oneGetMoney;
	/** 第二次实收金额(现金和银行卡会放) */
	private String twoGetMoney;
	/** 备注 */
	private String remark;
	/** 批次编码 */
	private String batchCode;
	/** 邮费 */
	private String postage;
	/** 邮费 */
	private String logistics;
	/** 邮费 */
	private String logisticsCode;

	/** 是否隐藏 1:隐藏 2:显示 */
	private String isHide;

	/** 创建时间 */
	private Date createTime;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用

	/**
	 * 导购扫码的二维码ID
	 */
	private List<Qrcode> qrcodeList;
	/**
	 * 订单包含的商品信息
	 */
	private List<OrderGoods> orderGoodList;
	/**
	 * 订单包含的二级订单列表
	 */
	private List<Order> orderList;
	/**
	 * 订单包含的电子券列表
	 */
	private List<EticketUseRecord> eticketUseRecordList;

	/**
	 * 订单包含的二维码数量
	 */
	private String qrcodeCount;

	/** 订单状况名称 */
	private String stateValue;
	/** 订单状况1 未支付 */
	public static final String STATE_ONE = "1";
	/** 订单状况2 未发货 */
	public static final String STATE_TWO = "2";
	/** 订单状况3 已出库 */
	public static final String STATE_THREE = "3";
	/** 订单状况4 已发货 */
	public static final String STATE_FOUR = "4";
	/** 订单状况5 待评价 */
	public static final String STATE_FIVE = "5";
	/** 订单状况6 完成 */
	public static final String STATE_SIX = "6";
	/** 订单状况7 放弃 */
	public static final String STATE_SEVEN = "7";

	/** 订单类别名称 */
	private String typeValue;
	/** 订单类别1 线上 */
	public static final String TYPE_ONE = "1";
	/** 订单类别2 线下 */
	public static final String TYPE_TWO = "2";
	/** 订单类别3 换购 */
	public static final String TYPE_THREE = "3";
	/** 订单类别4 预约 */
	public static final String TYPE_FOUR = "4";
	/** 订单类别5 退货 */
	public static final String TYPE_FIVE = "5";
	/** 订单类别6 换货 */
	public static final String TYPE_SIX = "6";
	/** 订单类别7 同商品换货 */
	public static final String TYPE_SEVEN = "7";
	/** 订单类别8 赔偿 */
	public static final String TYPE_EIGHT = "8";

	/** one支付方式名称 */
	private String onePayTypeValue;
	/** two支付方式名称 */
	private String twoPayTypeValue;
	/** 支付方式名称 */
	private String payTypeValue;
	/** 支付方式1 现金支付 */
	public static final String PAYTYPE_ONE = "1";
	/** 支付方式2 银行pos刷卡支付 */
	public static final String PAYTYPE_TWO = "2";
	/** 支付方式3 微信支付 */
	public static final String PAYTYPE_THREE = "3";
	/** 支付方式4 支付宝支付 */
	public static final String PAYTYPE_FOUR = "4";
	/** 支付方式5 账户余额支付 */
	public static final String PAYTYPE_FIVE = "5";

	private String subUserTypeValue;
	/**
	 * 优惠级别：导购
	 */
	public static final String SUBUSERTYPE_ONE = "1";
	/**
	 * 优惠级别：主管
	 */
	public static final String SUBUSERTYPE_TWO = "2";
	/**
	 * 优惠级别：经理
	 */
	public static final String SUBUSERTYPE_THREE = "3";

	/** 是否隐藏 1:隐藏 2:显示 */
	private String isHideValue;
	/** 是否隐藏 1:隐藏 */
	public static final String ISHIDE_ONE = "1";
	/** 是否隐藏 2:显示 */
	public static final String ISHIDE_TWO = "2";

	public Order() {
		super();
	}

	public Order(String id) {
		super();
		this.id = id;
	}

	/**
	 * @param id
	 * @param customer
	 *            会员
	 * @param store
	 *            门店
	 * @param cashierUser
	 *            收银员
	 * @param guideUser
	 *            导购
	 * @param order
	 *            订单
	 * @param code
	 *            订单号
	 * @param type
	 *            类型（1：线上，2：线下，3：换购，4：预约，5：退货，6：换货 ,7:同码换货）
	 * @param payTime
	 *            下单日期
	 * @param reserveName
	 *            预约人
	 * @param reservePhone
	 *            预约电话
	 * @param reserveTime
	 *            预约时间
	 * @param reserveMoney
	 *            预约金额
	 * @param state
	 *            状态(1：未支付，2：未发货，3：已发货，4：已收货，5：待评价，6：已完成，7：放弃)
	 * @param sumMoney
	 *            订单总金额
	 * @param sumNumber
	 *            订单总数量
	 * @param subMoney
	 *            订单总优惠金额
	 * @param cashierCode
	 *            款台号
	 * @param payType
	 *            支付方式（1：现金支付，2：银行pos刷卡支付，3：微信支付，4：支付宝支付，5：账户余额支付）
	 * @param leaveMessage
	 *            订单留言（仅线上订单有）
	 * @param receiverName
	 *            收货人（仅线上订单有）
	 * @param receiverAddress
	 *            收货地址（仅线上订单有）
	 * @param receiverPhone
	 *            收货人手机号（仅线上订单有）
	 * @param createTime
	 *            创建时间
	 */
	public Order(String id, Customer customer, Store store, User cashierUser, User guideUser, Order order, String code,
			String type, Date payTime, String reserveName, String reservePhone, Date reserveTime, String reserveMoney,
			String state, String sumMoney, String sumNumber, String subMoney, String cashierCode, String payType,
			String leaveMessage, String receiverName, String receiverAddress, String receiverPhone, Date createTime) {
		super();
		this.id = id;
		this.customer = customer;
		this.store = store;
		this.cashierUser = cashierUser;
		this.guideUser = guideUser;
		this.order = order;
		this.code = code;
		this.type = type;
		this.payTime = payTime;
		this.reserveName = reserveName;
		this.reservePhone = reservePhone;
		this.reserveTime = reserveTime;
		this.reserveMoney = reserveMoney;
		this.state = state;
		this.sumMoney = sumMoney;
		this.sumNumber = sumNumber;
		this.subMoney = subMoney;
		this.cashierCode = cashierCode;
		this.payType = payType;
		this.leaveMessage = leaveMessage;
		this.receiverName = receiverName;
		this.receiverAddress = receiverAddress;
		this.receiverPhone = receiverPhone;
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
	 * @return the customer 会员
	 */
	public Customer getCustomer() {
		return customer;
	}

	/**
	 * @param customer
	 *            the customer (会员) to set
	 */
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	/**
	 * @return the store 门店
	 */
	public Store getStore() {
		return store;
	}

	/**
	 * @param store
	 *            the store (门店) to set
	 */
	public void setStore(Store store) {
		this.store = store;
	}

	/**
	 * @return the cashierUser 收银员
	 */
	public User getCashierUser() {
		return cashierUser;
	}

	/**
	 * @param cashierUser
	 *            the cashierUser (收银员) to set
	 */
	public void setCashierUser(User cashierUser) {
		this.cashierUser = cashierUser;
	}

	/**
	 * @return the guideUser 导购
	 */
	public User getGuideUser() {
		return guideUser;
	}

	/**
	 * @param guideUser
	 *            the guideUser (导购) to set
	 */
	public void setGuideUser(User guideUser) {
		this.guideUser = guideUser;
	}

	/**
	 * @return the order 订单
	 */
	public Order getOrder() {
		return order;
	}

	/**
	 * @param order
	 *            the order (订单) to set
	 */
	public void setOrder(Order order) {
		this.order = order;
	}

	/**
	 * @return the code 订单号
	 */
	public String getCode() {
		return code;
	}

	/**
	 * @param code
	 *            the code (订单号) to set
	 */
	public void setCode(String code) {
		this.code = code;
	}

	/**
	 * @return the type 类型（1：线上，2：线下，3：换购，4：预约，5：退货，6：换货 ,7:同码换货）
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type
	 *            the type类型（1：线上，2：线下，3：换购，4：预约，5：退货，6：换货 ,7:同码换货）to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return the payTime 下单日期
	 */
	public Date getPayTime() {
		return payTime;
	}

	/**
	 * @param payTime
	 *            the payTime (下单日期) to set
	 */
	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}

	/**
	 * @return the reserveName 预约人
	 */
	public String getReserveName() {
		return reserveName;
	}

	/**
	 * @param reserveName
	 *            the reserveName (预约人) to set
	 */
	public void setReserveName(String reserveName) {
		this.reserveName = reserveName;
	}

	/**
	 * @return the reservePhone 预约电话
	 */
	public String getReservePhone() {
		return reservePhone;
	}

	/**
	 * @param reservePhone
	 *            the reservePhone (预约电话) to set
	 */
	public void setReservePhone(String reservePhone) {
		this.reservePhone = reservePhone;
	}

	/**
	 * @return the reserveTime 预约时间
	 */
	public Date getReserveTime() {
		return reserveTime;
	}

	/**
	 * @param reserveTime
	 *            the reserveTime (预约时间) to set
	 */
	public void setReserveTime(Date reserveTime) {
		this.reserveTime = reserveTime;
	}

	/**
	 * @return the reserveMoney 预约金额
	 */
	public String getReserveMoney() {
		return reserveMoney;
	}

	/**
	 * @param reserveMoney
	 *            the reserveMoney (预约金额) to set
	 */
	public void setReserveMoney(String reserveMoney) {
		this.reserveMoney = reserveMoney;
	}

	/**
	 * @return the state 状态(1：未支付，2：未发货，3：已出库，4：已发货，5：待评价，6：已完成，7：放弃)
	 */
	public String getState() {
		return state;
	}

	/**
	 * @param state
	 *            the state 状态(1：未支付，2：未发货，3：已出库，4：已发货，5：待评价，6：已完成，7：放弃) to set
	 */
	public void setState(String state) {
		this.state = state;
	}

	/**
	 * @return the sumMoney 订单总金额
	 */
	public String getSumMoney() {
		return StringUtils.isNotBlank(sumMoney) ? sumMoney : "0.0";
	}

	/**
	 * @param sumMoney
	 *            the sumMoney (订单总金额) to set
	 */
	public void setSumMoney(String sumMoney) {
		this.sumMoney = sumMoney;
	}

	/**
	 * @return the sumNumber 订单总数量
	 */
	public String getSumNumber() {
		return StringUtils.isNotBlank(sumNumber) ? sumNumber : "0";
	}

	/**
	 * @param sumNumber
	 *            the sumNumber (订单总数量) to set
	 */
	public void setSumNumber(String sumNumber) {
		this.sumNumber = sumNumber;
	}

	/**
	 * @return the subMoney 订单总优惠金额
	 */
	public String getSubMoney() {
		return StringUtils.isNotBlank(subMoney) ? subMoney : "0.0";
	}

	/**
	 * @param subMoney
	 *            the subMoney (订单总优惠金额) to set
	 */
	public void setSubMoney(String subMoney) {
		this.subMoney = subMoney;
	}

	/**
	 * @return the cashierCode 款台号
	 */
	public String getCashierCode() {
		return cashierCode;
	}

	/**
	 * @param cashierCode
	 *            the cashierCode (款台号) to set
	 */
	public void setCashierCode(String cashierCode) {
		this.cashierCode = cashierCode;
	}

	/**
	 * @return the payType 支付方式（1：现金支付，2：银行pos刷卡支付，3：微信支付，4：支付宝支付，5：账户余额支付）
	 */
	public String getPayType() {
		return payType;
	}

	/**
	 * @param payType
	 *            the payType (支付方式（1：现金支付，2：银行pos刷卡支付，3：微信支付，4：支付宝支付，5：账户余额支付）)
	 *            to set
	 */
	public void setPayType(String payType) {
		this.payType = payType;
	}

	/**
	 * @return the leaveMessage 订单留言（仅线上订单有）
	 */
	public String getLeaveMessage() {
		return leaveMessage;
	}

	/**
	 * @param leaveMessage
	 *            the leaveMessage (订单留言（仅线上订单有）) to set
	 */
	public void setLeaveMessage(String leaveMessage) {
		this.leaveMessage = leaveMessage;
	}

	/**
	 * @return the receiverName 收货人（仅线上订单有）
	 */
	public String getReceiverName() {
		return receiverName;
	}

	/**
	 * @param receiverName
	 *            the receiverName (收货人（仅线上订单有）) to set
	 */
	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}

	/**
	 * @return the receiverAddress 收货地址（仅线上订单有）
	 */
	public String getReceiverAddress() {
		return receiverAddress;
	}

	/**
	 * @param receiverAddress
	 *            the receiverAddress (收货地址（仅线上订单有）) to set
	 */
	public void setReceiverAddress(String receiverAddress) {
		this.receiverAddress = receiverAddress;
	}

	/**
	 * @return the receiverPhone 收货人手机号（仅线上订单有）
	 */
	public String getReceiverPhone() {
		return receiverPhone;
	}

	/**
	 * @param receiverPhone
	 *            the receiverPhone (收货人手机号（仅线上订单有）) to set
	 */
	public void setReceiverPhone(String receiverPhone) {
		this.receiverPhone = receiverPhone;
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
	 * @return the typeValue
	 */
	public String getTypeValue() {
		if (TYPE_ONE.equals(type)) {
			return "线上";
		} else if (TYPE_TWO.equals(type)) {
			return "线下";
		} else if (TYPE_THREE.equals(type)) {
			return "换购";
		} else if (TYPE_FOUR.equals(type)) {
			return "预约";
		} else if (TYPE_FIVE.equals(type)) {
			return "退货";
		} else if (TYPE_SIX.equals(type)) {
			return "换货";
		} else if (TYPE_SEVEN.equals(type)) {
			return "同商品换货";
		} else if (TYPE_EIGHT.equals(type)) {
			return "赔偿";
		}
		return null;
	}

	/**
	 * @return the stateValue
	 */
	public String getStateValue() {
		if (STATE_ONE.equals(state)) {
			return "未支付";
		} else if (STATE_TWO.equals(state)) {
			return "未发货";
		} else if (STATE_THREE.equals(state)) {
			return "已出库";
		} else if (STATE_FOUR.equals(state)) {
			return "已发货";
		} else if (STATE_FIVE.equals(state)) {
			return "待评价";
		} else if (STATE_SIX.equals(state)) {
			return "完成";
		} else if (STATE_SEVEN.equals(state)) {
			return "放弃";
		}
		return null;
	}

	/**
	 * @return the payTypeValue
	 */
	public String getPayTypeValue() {
		if (PAYTYPE_ONE.equals(payType)) {
			return "现金";
		} else if (PAYTYPE_TWO.equals(payType)) {
			return "刷卡";
		} else if (PAYTYPE_THREE.equals(payType)) {
			return "微信";
		} else if (PAYTYPE_FOUR.equals(payType)) {
			return "支付宝";
		} else if (PAYTYPE_FIVE.equals(payType)) {
			return "余额";
		}
		return null;
	}

	/**
	 * @return the onePayTypeValue
	 */
	public String getOnePayTypeValue() {
		if (PAYTYPE_ONE.equals(onePayType)) {
			return "现金";
		} else if (PAYTYPE_TWO.equals(onePayType)) {
			return "刷卡";
		} else if (PAYTYPE_THREE.equals(onePayType)) {
			return "微信";
		} else if (PAYTYPE_FOUR.equals(onePayType)) {
			return "支付宝";
		} else if (PAYTYPE_FIVE.equals(onePayType)) {
			return "余额";
		}
		return null;
	}

	/**
	 * @return the twoPayTypeValue
	 */
	public String getTwoPayTypeValue() {
		if (PAYTYPE_ONE.equals(twoPayType)) {
			return "现金";
		} else if (PAYTYPE_TWO.equals(twoPayType)) {
			return "刷卡";
		} else if (PAYTYPE_THREE.equals(twoPayType)) {
			return "微信";
		} else if (PAYTYPE_FOUR.equals(twoPayType)) {
			return "支付宝";
		} else if (PAYTYPE_FIVE.equals(twoPayType)) {
			return "余额";
		}
		return null;
	}

	/**
	 * @return the payMoney 总支付金额
	 */
	public String getPayMoney() {
		return StringUtils.isNotBlank(payMoney) ? payMoney : "0.0";
	}

	/**
	 * @param payMoney
	 *            the payMoney（总支付金额 ） to set
	 */
	public void setPayMoney(String payMoney) {
		this.payMoney = payMoney;
	}

	/**
	 * @return the subUserType 优惠级别（1：导购，2：主管，3：经理）
	 */
	public String getSubUserType() {
		return subUserType;
	}

	/**
	 * @param subUserType
	 *            the subUserType（优惠级别（1：导购，2：主管，3：经理）） to set
	 */
	public void setSubUserType(String subUserType) {
		this.subUserType = subUserType;
	}

	/**
	 * @return the qrcodeList 导购扫码的二维码ID
	 */
	public List<Qrcode> getQrcodeList() {
		return qrcodeList;
	}

	/**
	 * @param qrcodeList
	 *            the qrcodeList（导购扫码的二维码ID） to set
	 */
	public void setQrcodeList(List<Qrcode> qrcodeList) {
		this.qrcodeList = qrcodeList;
	}

	/**
	 * @return the orderGoodList 订单包含的商品信息
	 */
	public List<OrderGoods> getOrderGoodList() {
		return orderGoodList;
	}

	/**
	 * @param orderGoodList
	 *            the orderGoodList（订单包含的商品信息） to set
	 */
	public void setOrderGoodList(List<OrderGoods> orderGoodList) {
		this.orderGoodList = orderGoodList;
	}

	/**
	 * @return the proType
	 */
	public String getProType() {
		return proType;
	}

	/**
	 * @param proType
	 *            the proType to set
	 */
	public void setProType(String proType) {
		this.proType = proType;
	}

	/**
	 * @return the orderList 订单包含的二级订单列表
	 */
	public List<Order> getOrderList() {
		return orderList;
	}

	/**
	 * @param orderList
	 *            the orderList（订单包含的二级订单列表） to set
	 */
	public void setOrderList(List<Order> orderList) {
		this.orderList = orderList;
	}

	/**
	 * @return the orderSubremarkList 订单优惠记录
	 */
	public List<OrderSubremark> getOrderSubremarkList() {
		return orderSubremarkList;
	}

	/**
	 * @param orderSubremarkList
	 *            the orderSubremarkList(订单优惠记录) to set
	 */
	public void setOrderSubremarkList(List<OrderSubremark> orderSubremarkList) {
		this.orderSubremarkList = orderSubremarkList;
	}

	/**
	 * @return the onePayType 第一次支付方式
	 */
	public String getOnePayType() {
		return onePayType;
	}

	/**
	 * @param onePayType
	 *            the onePayType(第一次支付方式) to set
	 */
	public void setOnePayType(String onePayType) {
		this.onePayType = onePayType;
	}

	/**
	 * @return the onePayCode 第一次支付交易单号（微信或支付宝支付会有）
	 */
	public String getOnePayCode() {
		return onePayCode;
	}

	/**
	 * @param onePayCode
	 *            the onePayCode(第一次支付交易单号（微信或支付宝支付会有）) to set
	 */
	public void setOnePayCode(String onePayCode) {
		this.onePayCode = onePayCode;
	}

	/**
	 * @return the twoPayType 第二次支付方式
	 */
	public String getTwoPayType() {
		return twoPayType;
	}

	/**
	 * @param twoPayType
	 *            the twoPayType(第二次支付方式) to set
	 */
	public void setTwoPayType(String twoPayType) {
		this.twoPayType = twoPayType;
	}

	/**
	 * @return the twoPayCode 第二次支付交易单号（微信或支付宝支付会有）
	 */
	public String getTwoPayCode() {
		return twoPayCode;
	}

	/**
	 * @param twoPayCode
	 *            the twoPayCode(第二次支付交易单号（微信或支付宝支付会有）) to set
	 */
	public void setTwoPayCode(String twoPayCode) {
		this.twoPayCode = twoPayCode;
	}

	/**
	 * @return the twoPayTime 第二次支付时间
	 */
	public String getTwoPayTime() {
		return twoPayTime;
	}

	/**
	 * @param twoPayTime
	 *            the twoPayTime（第二次支付时间 ） to set
	 */
	public void setTwoPayTime(String twoPayTime) {
		this.twoPayTime = twoPayTime;
	}

	/**
	 * @return the twoCashierUser 第二次支付收银员
	 */
	public User getTwoCashierUser() {
		return twoCashierUser;
	}

	/**
	 * @param twoCashierUser
	 *            the twoCashierUser（第二次支付收银员） to set
	 */
	public void setTwoCashierUser(User twoCashierUser) {
		this.twoCashierUser = twoCashierUser;
	}

	/**
	 * @return the twoCashierCode 第二次支付款台号
	 */
	public String getTwoCashierCode() {
		return twoCashierCode;
	}

	/**
	 * @param twoCashierCode
	 *            the twoCashierCode（第二次支付款台号） to set
	 */
	public void setTwoCashierCode(String twoCashierCode) {
		this.twoCashierCode = twoCashierCode;
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
	 * @return the lestMoney 尾款（预约单会有）
	 */
	public String getLestMoney() {
		return lestMoney;
	}

	/**
	 * @param lestMoney
	 *            the lestMoney(尾款（预约单会有）) to set
	 */
	public void setLestMoney(String lestMoney) {
		this.lestMoney = lestMoney;
	}

	/**
	 * @return the subUserTypeValue
	 */
	public String getSubUserTypeValue() {
		if (StringUtils.isBlank(subUserType)) {
			return null;
		}
		switch (subUserType) {
		case (SUBUSERTYPE_ONE):
			subUserTypeValue = "导购";
			break;
		case (SUBUSERTYPE_TWO):
			subUserTypeValue = "主管";
			break;
		case (SUBUSERTYPE_THREE):
			subUserTypeValue = "经理";
			break;
		default:
			subUserTypeValue = "未知";
			break;
		}
		return subUserTypeValue;
	}

	/**
	 * @return the qrcodeCount
	 */
	public String getQrcodeCount() {
		return qrcodeCount;
	}

	/**
	 * @param qrcodeCount
	 *            the qrcodeCount to set
	 */
	public void setQrcodeCount(String qrcodeCount) {
		this.qrcodeCount = qrcodeCount;
	}

	/**
	 * @return the oneReturnMoney 订单首次支付未退款金额
	 */
	public String getOneReturnMoney() {
		return oneReturnMoney;
	}

	/**
	 * @param oneReturnMoney
	 *            the oneReturnMoney(订单首次支付未退款金额) to set
	 */
	public void setOneReturnMoney(String oneReturnMoney) {
		this.oneReturnMoney = oneReturnMoney;
	}

	/**
	 * @return the onePayMoney 第一次支付金额
	 */
	public String getOnePayMoney() {
		return onePayMoney;
	}

	/**
	 * @param onePayMoney
	 *            the onePayMoney(第一次支付金额) to set
	 */
	public void setOnePayMoney(String onePayMoney) {
		this.onePayMoney = onePayMoney;
	}

	/**
	 * @return the twoPayMoney 第二次支付金额
	 */
	public String getTwoPayMoney() {
		return twoPayMoney;
	}

	/**
	 * @param twoPayMoney
	 *            the twoPayMoney(第二次支付金额) to set
	 */
	public void setTwoPayMoney(String twoPayMoney) {
		this.twoPayMoney = twoPayMoney;
	}

	/**
	 * @return the twoReturnMoney 第二次支付未退款金额
	 */
	public String getTwoReturnMoney() {
		return twoReturnMoney;
	}

	/**
	 * @param twoReturnMoney
	 *            the twoReturnMoney(第二次支付未退款金额) to set
	 */
	public void setTwoReturnMoney(String twoReturnMoney) {
		this.twoReturnMoney = twoReturnMoney;
	}

	/**
	 * @return the returnMoney 现金退款额度
	 */
	public String getReturnMoney() {
		return returnMoney;
	}

	/**
	 * @param returnMoney
	 *            the returnMoney(现金退款额度) to set
	 */
	public void setReturnMoney(String returnMoney) {
		this.returnMoney = returnMoney;
	}

	/**
	 * @return the returnWeChatPay 微信支付退款额度
	 */
	public String getReturnWeChatPay() {
		return returnWeChatPay;
	}

	/**
	 * @param returnWeChatPay
	 *            the returnWeChatPay(微信支付退款额度) to set
	 */
	public void setReturnWeChatPay(String returnWeChatPay) {
		this.returnWeChatPay = returnWeChatPay;
	}

	/**
	 * @return the returnAliPay 支付宝支付退款额度
	 */
	public String getReturnAliPay() {
		return returnAliPay;
	}

	/**
	 * @param returnAliPay
	 *            the returnAliPay(支付宝支付退款额度) to set
	 */
	public void setReturnAliPay(String returnAliPay) {
		this.returnAliPay = returnAliPay;
	}

	/**
	 * @return the returnCard 银行卡退款额
	 */
	public String getReturnCard() {
		return returnCard;
	}

	/**
	 * @param returnCard
	 *            the returnCard(银行卡退款额) to set
	 */
	public void setReturnCard(String returnCard) {
		this.returnCard = returnCard;
	}

	/**
	 * @return the returnTianhe 天和钱包退款额
	 */
	public String getReturnTianhe() {
		return returnTianhe;
	}

	/**
	 * @param returnTianhe
	 *            the returnTianhe(天和钱包退款额) to set
	 */
	public void setReturnTianhe(String returnTianhe) {
		this.returnTianhe = returnTianhe;
	}

	/**
	 * @return the eticketUseRecordList
	 */
	public List<EticketUseRecord> getEticketUseRecordList() {
		return eticketUseRecordList;
	}

	/**
	 * @param eticketUseRecordList
	 *            the eticketUseRecordList to set
	 */
	public void setEticketUseRecordList(List<EticketUseRecord> eticketUseRecordList) {
		this.eticketUseRecordList = eticketUseRecordList;
	}

	/**
	 * @return the expressName
	 */
	public String getExpressName() {
		return expressName;
	}

	/**
	 * @param expressName
	 *            the expressName to set
	 */
	public void setExpressName(String expressName) {
		this.expressName = expressName;
	}

	/**
	 * @return the expressPhone
	 */
	public String getExpressPhone() {
		return expressPhone;
	}

	/**
	 * @param expressPhone
	 *            the expressPhone to set
	 */
	public void setExpressPhone(String expressPhone) {
		this.expressPhone = expressPhone;
	}

	/**
	 * @return the inLinePayMoney
	 */
	public String getInLinePayMoney() {
		return inLinePayMoney;
	}

	/**
	 * @param inLinePayMoney
	 *            the inLinePayMoney to set
	 */
	public void setInLinePayMoney(String inLinePayMoney) {
		this.inLinePayMoney = inLinePayMoney;
	}

	/**
	 * @return the eticketMoney
	 */
	public String getEticketMoney() {
		return eticketMoney;
	}

	/**
	 * @param eticketMoney
	 *            the eticketMoney to set
	 */
	public void setEticketMoney(String eticketMoney) {
		this.eticketMoney = eticketMoney;
	}

	public static String getPayTypeValue(String payType_String) {
		if (PAYTYPE_ONE.equals(payType_String)) {
			return "现金";
		} else if (PAYTYPE_TWO.equals(payType_String)) {
			return "刷卡";
		} else if (PAYTYPE_THREE.equals(payType_String)) {
			return "微信";
		} else if (PAYTYPE_FOUR.equals(payType_String)) {
			return "支付宝";
		} else if (PAYTYPE_FIVE.equals(payType_String)) {
			return "余额";
		}
		return null;
	}

	/**
	 * @return the oneGetMoney 首次实收金额(现金和银行卡会放)
	 */
	public String getOneGetMoney() {
		return oneGetMoney;
	}

	/**
	 * @param oneGetMoney
	 *            the oneGetMoney（首次实收金额(现金和银行卡会放)） to set
	 */
	public void setOneGetMoney(String oneGetMoney) {
		this.oneGetMoney = oneGetMoney;
	}

	/**
	 * @return the twoGetMoney 第二次实收金额(现金和银行卡会放)
	 */
	public String getTwoGetMoney() {
		return twoGetMoney;
	}

	/**
	 * @param twoGetMoney
	 *            the twoGetMoney（第二次实收金额(现金和银行卡会放)） to set
	 */
	public void setTwoGetMoney(String twoGetMoney) {
		this.twoGetMoney = twoGetMoney;
	}

	/**
	 * @return the batchCode
	 */
	public String getBatchCode() {
		return batchCode;
	}

	/**
	 * @param batchCode
	 *            the batchCode to set
	 */
	public void setBatchCode(String batchCode) {
		this.batchCode = batchCode;
	}

	/**
	 * @return the postage
	 */
	public String getPostage() {
		return postage;
	}

	/**
	 * @param postage
	 *            the postage to set
	 */
	public void setPostage(String postage) {
		this.postage = postage;
	}

	/**
	 * @return the logistics
	 */
	public String getLogistics() {
		return logistics;
	}

	/**
	 * @param logistics
	 *            the logistics to set
	 */
	public void setLogistics(String logistics) {
		this.logistics = logistics;
	}

	/**
	 * @return the logisticsCode
	 */
	public String getLogisticsCode() {
		return logisticsCode;
	}

	/**
	 * @param logisticsCode
	 *            the logisticsCode to set
	 */
	public void setLogisticsCode(String logisticsCode) {
		this.logisticsCode = logisticsCode;
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
