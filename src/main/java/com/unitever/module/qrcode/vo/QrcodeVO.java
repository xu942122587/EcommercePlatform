package com.unitever.module.qrcode.vo;

public class QrcodeVO {

	/** 二维码Id */
	private String id;
	/** 调拨记录Id */
	private String allocationQrcodeId;
	/** 采购退货Id */
	private String procurementQrcodeId;
	/** 商品名 */
	private String goodsName;
	/** 商品编码 */
	private String goodsCode;
	/** 商品Id */
	private String goodsId;
	/** 商品Id */
	private String parentGoodsId;
	/** 商品售价 */
	private String goodsSalePrice;
	/**
	 * 产品自定义属性
	 */
	private String other_attr_value;
	/** 所在仓库 */
	private String storageName;
	/** 批次号 */
	private String qrcodeBatch;
	/** 产品进货价 */
	private String procurementPrice;
	/**
	 * 流向(产品的每一次位置的改变都追加进来。eg：供货商-->门店1-->顾客1-->门店1-->大库-->门店1-->顾客2-->门店1-->
	 * 供货商)
	 */
	private String logistics;

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
	 * 优惠金额
	 */
	private String subMoney;

	public QrcodeVO() {
		super();
	}

	/**
	 * @return the qrcode
	 */

	public QrcodeVO(String id, String goodsName, String goodsCode, String goodsId, String other_attr_value,
			String storageName, String qrcodeBatch, String procurementPrice) {
		super();
		this.id = id;
		this.goodsName = goodsName;
		this.goodsCode = goodsCode;
		this.goodsId = goodsId;
		this.other_attr_value = other_attr_value;
		this.storageName = storageName;
		this.qrcodeBatch = qrcodeBatch;
		this.procurementPrice = procurementPrice;
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
	 * @return the goodsName
	 */
	public String getGoodsName() {
		return goodsName;
	}

	/**
	 * @param goodsName
	 *            the goodsName to set
	 */
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	/**
	 * @return the goodsCode
	 */
	public String getGoodsCode() {
		return goodsCode;
	}

	/**
	 * @param goodsCode
	 *            the goodsCode to set
	 */
	public void setGoodsCode(String goodsCode) {
		this.goodsCode = goodsCode;
	}

	/**
	 * @return the goodsId
	 */
	public String getGoodsId() {
		return goodsId;
	}

	/**
	 * @param goodsId
	 *            the goodsId to set
	 */
	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}

	/**
	 * @return the other_attr_value
	 */
	public String getOther_attr_value() {
		return other_attr_value;
	}

	/**
	 * @param other_attr_value
	 *            the other_attr_value to set
	 */
	public void setOther_attr_value(String other_attr_value) {
		this.other_attr_value = other_attr_value;
	}

	/**
	 * @return the storageName
	 */
	public String getStorageName() {
		return storageName;
	}

	/**
	 * @param storageName
	 *            the storageName to set
	 */
	public void setStorageName(String storageName) {
		this.storageName = storageName;
	}

	/**
	 * @return the qrcodeBatch
	 */
	public String getQrcodeBatch() {
		return qrcodeBatch;
	}

	/**
	 * @param qrcodeBatch
	 *            the qrcodeBatch to set
	 */
	public void setQrcodeBatch(String qrcodeBatch) {
		this.qrcodeBatch = qrcodeBatch;
	}

	/**
	 * @return the procurementPrice
	 */
	public String getProcurementPrice() {
		return procurementPrice;
	}

	/**
	 * @param procurementPrice
	 *            the procurementPrice to set
	 */
	public void setProcurementPrice(String procurementPrice) {
		this.procurementPrice = procurementPrice;
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
	 * @return the allocationQrcodeId
	 */
	public String getAllocationQrcodeId() {
		return allocationQrcodeId;
	}

	/**
	 * @param allocationQrcodeId
	 *            the allocationQrcodeId to set
	 */
	public void setAllocationQrcodeId(String allocationQrcodeId) {
		this.allocationQrcodeId = allocationQrcodeId;
	}

	/**
	 * @return the procurementQrcodeId
	 */
	public String getProcurementQrcodeId() {
		return procurementQrcodeId;
	}

	/**
	 * @param procurementQrcodeId
	 *            the procurementQrcodeId to set
	 */
	public void setProcurementQrcodeId(String procurementQrcodeId) {
		this.procurementQrcodeId = procurementQrcodeId;
	}

	/**
	 * @return the goodsSalePrice
	 */
	public String getGoodsSalePrice() {
		return goodsSalePrice;
	}

	/**
	 * @param goodsSalePrice
	 *            the goodsSalePrice to set
	 */
	public void setGoodsSalePrice(String goodsSalePrice) {
		this.goodsSalePrice = goodsSalePrice;
	}

	/**
	 * @return the isJoin
	 */
	public String getIsJoin() {
		return isJoin;
	}

	/**
	 * @param isJoin
	 *            the isJoin to set
	 */
	public void setIsJoin(String isJoin) {
		this.isJoin = isJoin;
	}

	/**
	 * @return the strikePrice
	 */
	public String getStrikePrice() {
		return strikePrice;
	}

	/**
	 * @param strikePrice
	 *            the strikePrice to set
	 */
	public void setStrikePrice(String strikePrice) {
		this.strikePrice = strikePrice;
	}

	/**
	 * @return the isOutGoods
	 */
	public String getIsOutGoods() {
		return isOutGoods;
	}

	/**
	 * @param isOutGoods
	 *            the isOutGoods to set
	 */
	public void setIsOutGoods(String isOutGoods) {
		this.isOutGoods = isOutGoods;
	}

	/**
	 * @return the subMoney
	 */
	public String getSubMoney() {
		return subMoney;
	}

	/**
	 * @param subMoney
	 *            the subMoney to set
	 */
	public void setSubMoney(String subMoney) {
		this.subMoney = subMoney;
	}

	/**
	 * @return the parentGoodsId
	 */
	public String getParentGoodsId() {
		return parentGoodsId;
	}

	/**
	 * @param parentGoodsId
	 *            the parentGoodsId to set
	 */
	public void setParentGoodsId(String parentGoodsId) {
		this.parentGoodsId = parentGoodsId;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "QrcodeVO [id=" + id + ", allocationQrcodeId=" + allocationQrcodeId + ", procurementQrcodeId="
				+ procurementQrcodeId + ", goodsName=" + goodsName + ", goodsCode=" + goodsCode + ", goodsId="
				+ goodsId + ", other_attr_value=" + other_attr_value + ", storageName=" + storageName
				+ ", qrcodeBatch=" + qrcodeBatch + ", procurementPrice=" + procurementPrice + ", logistics="
				+ logistics + "]";
	}

}
