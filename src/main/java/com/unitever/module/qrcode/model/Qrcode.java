package com.unitever.module.qrcode.model;

import java.util.Date;

import com.unitever.module.goods.model.Goods;
import com.unitever.module.procurement.model.Procurement;
import com.unitever.module.storage.model.Storage;
import com.unitever.platform.core.dao.BaseModel;

/**
 *
 * * 二维码 </p>
 *
 */
public class Qrcode extends BaseModel {

	/** Id */
	private String id;
	/** 商品 */
	private Goods goods;
	/** 所在仓库 */
	private Storage storage;
	/** 批次号 */
	private String qrcodeBatch;
	/** 产品进货价 */
	private String procurementPrice;
	/** 产品进货数量 */
	private String procurementBuyCount;
	/** 状态(1：正常，2：卖出，3：退还厂家 ps： 只有正常的才可补印 4.锁定 ) */
	private String state;
	/**
	 * 流向(产品的每一次位置的改变都追加进来。eg：供货商-->门店1-->顾客1-->门店1-->大库-->门店1-->顾客2-->门店1-->
	 * 供货商)
	 */
	private String logistics;
	/** 采购单 */
	private Procurement procurement;
	/** 创建时间 */
	private Date createTime;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	/**
	 * 是否参与活动
	 */
	private String isJoin;
	/**
	 * 成交价
	 */
	private String strikePrice;
	/**
	 * 是否退货（yes:退回，其他：卖出）
	 */
	private String isOutGoods;

	/**
	 * 印刷数量
	 */
	private String printCount;

	private String startDate; // 查询用
	private String endDate; // 查询用
	private String storeId; // 查询用--门店ID

	private String stateValue;
	/**
	 * 状态：正常
	 */
	public static final String STATE_ONE = "1";
	/**
	 * 状态：卖出
	 */
	public static final String STATE_TWO = "2";
	/**
	 * 状态：退还厂家
	 */
	public static final String STATE_THREE = "3";
	/**
	 * 状态：锁定
	 */
	public static final String STATE_FOUR = "4";

	public Qrcode() {
		super();
	}

	public Qrcode(String id) {
		super();
		this.id = id;
	}

	/**
	 * @param id
	 * @param goods
	 *            产品
	 * @param qrcodeBatch
	 *            二维码批次号
	 * @param procurementPrice
	 *            进货价
	 * @param procurementBuyCount
	 *            到货数量
	 * @param state
	 *            状态
	 * @param logistics
	 *            流向
	 * @param procurement
	 *            采购单
	 * @param createTime
	 */
	public Qrcode(String id, Goods goods, String qrcodeBatch, String procurementPrice, String procurementBuyCount,
			String state, String logistics, Procurement procurement, Date createTime) {
		super();
		this.id = id;
		this.goods = goods;
		this.qrcodeBatch = qrcodeBatch;
		this.procurementPrice = procurementPrice;
		this.procurementBuyCount = procurementBuyCount;
		this.state = state;
		this.logistics = logistics;
		this.procurement = procurement;
		this.createTime = createTime;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public String getQrcodeBatch() {
		return qrcodeBatch;
	}

	public void setQrcodeBatch(String qrcodeBatch) {
		this.qrcodeBatch = qrcodeBatch;
	}

	/**
	 *
	 * 产品进货价
	 */
	public String getProcurementPrice() {
		return procurementPrice;
	}

	public void setProcurementPrice(String procurementPrice) {
		this.procurementPrice = procurementPrice;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getLogistics() {
		return logistics;
	}

	/**
	 *
	 * <P>
	 * 流向--设置
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 5, 2017
	 * @param logistics
	 *            void
	 */
	public void setLogistics(String logistics) {
		this.logistics = logistics;
	}

	public Procurement getProcurement() {
		return procurement;
	}

	public void setProcurement(Procurement procurement) {
		this.procurement = procurement;
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

	/**
	 * @return the stateValue
	 */
	public String getStateValue() {
		if (STATE_ONE.equals(state)) {
			return "正常";
		} else if (STATE_TWO.equals(state)) {
			return "卖出";
		} else if (STATE_THREE.equals(state)) {
			return "退还厂家";
		} else if (STATE_FOUR.equals(state)) {
			return "锁定";
		}
		return "未知~";
	}

	/**
	 * @return the storage 所在仓库
	 */
	public Storage getStorage() {
		return storage;
	}

	/**
	 * @param storage
	 *            the storage（所在仓库） to set
	 */
	public void setStorage(Storage storage) {
		this.storage = storage;
	}

	/**
	 * @return the storeId 查询用--门店ID
	 */
	public String getStoreId() {
		return storeId;
	}

	/**
	 * @param storeId
	 *            the storeId（查询用--门店ID） to set
	 */
	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}

	/**
	 * @return the procurementBuyCount 产品进货数量
	 */
	public String getProcurementBuyCount() {
		return procurementBuyCount;
	}

	/**
	 * @param procurementBuyCount
	 *            the procurementBuyCount（产品进货数量） to set
	 */
	public void setProcurementBuyCount(String procurementBuyCount) {
		this.procurementBuyCount = procurementBuyCount;
	}

	/**
	 * @return the printCount 印刷数量
	 */
	public String getPrintCount() {
		return printCount;
	}

	/**
	 * @param printCount
	 *            the printCount(印刷数量) to set
	 */
	public void setPrintCount(String printCount) {
		this.printCount = printCount;
	}

	/**
	 * @return the isJoin 是否参与活动
	 */
	public String getIsJoin() {
		return isJoin;
	}

	/**
	 * @param isJoin
	 *            the isJoin（是否参与活动） to set
	 */
	public void setIsJoin(String isJoin) {
		this.isJoin = isJoin;
	}

	/**
	 * @return the strikePrice 成交价
	 */
	public String getStrikePrice() {
		return strikePrice;
	}

	/**
	 * @param strikePrice
	 *            the strikePrice（成交价） to set
	 */
	public void setStrikePrice(String strikePrice) {
		this.strikePrice = strikePrice;
	}

	/**
	 * @return the isOutGoods 是否退货（yes:退回，其他：卖出）
	 */
	public String getIsOutGoods() {
		return isOutGoods;
	}

	/**
	 * @param isOutGoods
	 *            the isOutGoods（是否退货（yes:退回，其他：卖出）） to set
	 */
	public void setIsOutGoods(String isOutGoods) {
		this.isOutGoods = isOutGoods;
	}

	@Override
	public String toString() {
		return "Qrcode [id=" + id + ", goods=" + goods + ", qrcodeBatch=" + qrcodeBatch + ", procurementPrice="
				+ procurementPrice + ", state=" + state + ", logistics=" + logistics + ", createTime=" + createTime
				+ ", ft=" + ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu + "]";
	}

}
