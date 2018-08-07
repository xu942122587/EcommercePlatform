package com.unitever.module.eticket.model;

import java.util.Date;

import org.apache.commons.lang.StringUtils;

import com.unitever.module.store.model.Store;
import com.unitever.platform.core.dao.BaseModel;

/**
 * 电子券
 * 
 * @author XiaoYu 2016年11月16日
 */
public class Eticket extends BaseModel {

	/** 电子券id */
	private String id;
	/** 电子券名称 */
	private String name;
	/** 有效期 */
	private String dateLimit;
	/** 价值 */
	private String price;
	/** 发放时的触发门店 */
	private Store outStore;
	/** 使用时的触发门店 */
	private Store useStore;
	/** 发放阀值 */
	private String outLimit;
	/** 使用阀值 */
	private String useLimit;
	/** 类型（1：专用，2：通用） */
	private String type;
	/** 发放类型(1：手动发放，2：自动发放-交易，3：自动发放-微信注册，4：自动发放-微信充值，5：自动发放-生日当月) */
	private String outType;
	/** 是否删除（1：否，2：是） */
	private String isDelete;
	/** 停止发放时间 */
	private Date stopSendTime;
	/** 创建时间 */
	private Date createTime;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	/** 停止发放时间--接收参数 */
	private String stopSendTimeString;

	private String typeValue;
	/** 类型：专用 */
	public static final String TYPE_ONE = "1";
	/** 类型：通用 */
	public static final String TYPE_TWO = "2";

	private String outTypeValue;
	/** 自动发放（交易） */
	public static final String OUT_TYPE_AUTO_BUY = "2";
	/** 自动发放（充值） */
	public static final String OUT_TYPE_AUTO_RECHARGE = "4";
	/** 自动发放（生日卷） */
	public static final String OUT_TYPE_AUTO_BIRTHDAY = "5";
	/** 自动发放--注册 */
	public static final String OUT_TYPE_AUTO_REGISTER = "3";
	/** 手动发放 */
	public static final String OUT_TYPE_MANUAL = "1";

	/**
	 * 是否删除--否
	 */
	public static final String ISDELETE_NO = "1";
	/**
	 * 是否删除--是
	 */
	public static final String ISDELETE_YES = "2";

	public Eticket() {
		super();
	}

	public Eticket(String id) {
		super();
		this.id = id;
	}

	/**
	 * @param id
	 * @param name
	 *            电子券名称
	 * @param dateLimit
	 *            有效期
	 * @param price
	 *            价值
	 * @param outStore
	 *            发放时的触发门店
	 * @param useStore
	 *            使用时的触发门店
	 * @param outLimit
	 *            发放阀值
	 * @param useLimit
	 *            使用阀值
	 * @param type
	 *            发放方式
	 * @param isDelete
	 *            是否删除（1：否，2：是）
	 * @param createTime
	 *            创建时间
	 */
	public Eticket(String id, String name, String dateLimit, String price, Store outStore, Store useStore,
			String outLimit, String useLimit, String type, String isDelete, Date createTime) {
		super();
		this.id = id;
		this.name = name;
		this.createTime = createTime;
		this.dateLimit = dateLimit;
		this.price = price;
		this.outStore = outStore;
		this.useStore = useStore;
		this.outLimit = outLimit;
		this.useLimit = useLimit;
		this.type = type;
		this.isDelete = isDelete;
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
	 * @return the name 电子券名称
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name（电子券名称） to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the dateLimit 有效期
	 */
	public String getDateLimit() {
		return dateLimit;
	}

	/**
	 * @param dateLimit
	 *            the dateLimit（有效期） to set
	 */
	public void setDateLimit(String dateLimit) {
		this.dateLimit = dateLimit;
	}

	/**
	 * @return the price 价值
	 */
	public String getPrice() {
		return price;
	}

	/**
	 * @param price
	 *            the price（价值） to set
	 */
	public void setPrice(String price) {
		this.price = price;
	}

	/**
	 * @return the outStore 发放时的触发门店
	 */
	public Store getOutStore() {
		return outStore;
	}

	/**
	 * @param outStore
	 *            the outStore（发放时的触发门店） to set
	 */
	public void setOutStore(Store outStore) {
		this.outStore = outStore;
	}

	/**
	 * @return the useStore 使用时的触发门店
	 */
	public Store getUseStore() {
		return useStore;
	}

	/**
	 * @param useStore
	 *            the useStore（使用时的触发门店） to set
	 */
	public void setUseStore(Store useStore) {
		this.useStore = useStore;
	}

	/**
	 * @return the outLimit 发放阀值
	 */
	public String getOutLimit() {
		return outLimit;
	}

	/**
	 * @param outLimit
	 *            the outLimit（发放阀值） to set
	 */
	public void setOutLimit(String outLimit) {
		this.outLimit = outLimit;
	}

	/**
	 * @return the useLimit 使用阀值
	 */
	public String getUseLimit() {
		return useLimit;
	}

	/**
	 * @param useLimit
	 *            the useLimit（使用阀值） to set
	 */
	public void setUseLimit(String useLimit) {
		this.useLimit = useLimit;
	}

	/**
	 * @return the type 发放方式
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type
	 *            the type（发放方式） to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return the isDelete 是否删除（1：否，2：是）
	 */
	public String getIsDelete() {
		return isDelete;
	}

	/**
	 * @param isDelete
	 *            the isDelete（是否删除（1：否，2：是）） to set
	 */
	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}

	/**
	 * @return the createTime 创建时间
	 */
	public Date getCreateTime() {
		return createTime;
	}

	/**
	 * @param createTime
	 *            the createTime（创建时间） to set
	 */
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	/**
	 * @return the outTypeValue
	 */
	public String getTypeValue() {
		switch (type) {
		case TYPE_ONE:
			typeValue = "专用";
			break;
		case TYPE_TWO:
			typeValue = "通用";
			break;
		default:
			typeValue = "未知";
			break;
		}
		return typeValue;
	}

	/**
	 * @return the outTypeValue(发放方式)
	 */
	public String getOutTypeValue() {
		if (StringUtils.isBlank(outType)) {
			outTypeValue = "未知";
		} else {
			switch (outType) {
			case OUT_TYPE_AUTO_BUY:
				outTypeValue = "自动发放（交易）";
				break;
			case OUT_TYPE_AUTO_RECHARGE:
				outTypeValue = "自动发放（充值）";
				break;
			case OUT_TYPE_AUTO_BIRTHDAY:
				outTypeValue = "自动发放（生日）";
				break;
			case OUT_TYPE_AUTO_REGISTER:
				outTypeValue = "自动发放（注册）";
				break;
			case OUT_TYPE_MANUAL:
				outTypeValue = "手动发放";
				break;
			default:
				outTypeValue = "未知";
				break;
			}
		}
		return outTypeValue;
	}

	/**
	 * @return the outType
	 */
	public String getOutType() {
		return outType;
	}

	/**
	 * @param outType
	 *            the outType to set
	 */
	public void setOutType(String outType) {
		this.outType = outType;
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
	 * @return the stopSendTime
	 */
	public Date getStopSendTime() {
		return stopSendTime;
	}

	/**
	 * @param stopSendTime
	 *            the stopSendTime to set
	 */
	public void setStopSendTime(Date stopSendTime) {
		this.stopSendTime = stopSendTime;
	}

	/**
	 * @return the stopSendTimeString
	 */
	public String getStopSendTimeString() {
		return stopSendTimeString;
	}

	/**
	 * @param stopSendTimeString
	 *            the stopSendTimeString to set
	 */
	public void setStopSendTimeString(String stopSendTimeString) {
		this.stopSendTimeString = stopSendTimeString;
	}

}
