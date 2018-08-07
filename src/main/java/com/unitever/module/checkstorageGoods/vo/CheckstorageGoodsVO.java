package com.unitever.module.checkstorageGoods.vo;

public class CheckstorageGoodsVO {

	/** 盘库明细Id */
	private String id;
	/** 盘库单Id */
	private String checkstorageId;
	/** 商品名 */
	private String goodsName;
	/** 商品名 */
	private String storeName;
	/** 商品名 */
	private String storageName;
	/** 商品编码 */
	private String goodsCode;
	/** 盘点数量 */
	private String checkNumber;
	/** 商品Id */
	private String goodsId;
	/** 盘点前数量 */
	private String inventoryNumber;
	/** 盈亏数量 */
	private String profitNumber;
	/**
	 * 产品自定义属性
	 */
	private String other_attr_value;
	/** 盘点状态值 */
	private String state;
	/** 盘点状态值 */
	private String stateValue;

	public CheckstorageGoodsVO() {
		super();
	}

	public CheckstorageGoodsVO(String id) {
		super();
		this.id = id;
	}

	public CheckstorageGoodsVO(String id, String checkstorageId,
			String goodsName, String storeName, String storageName,
			String goodsCode, String goodsId, String other_attr_value) {
		super();
		this.id = id;
		this.checkstorageId = checkstorageId;
		this.goodsName = goodsName;
		this.storeName = storeName;
		this.storageName = storageName;
		this.goodsCode = goodsCode;
		this.goodsId = goodsId;
		this.other_attr_value = other_attr_value;
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
	 * @return the checkstorageId
	 */
	public String getCheckstorageId() {
		return checkstorageId;
	}

	/**
	 * @param checkstorageId
	 *            the checkstorageId to set
	 */
	public void setCheckstorageId(String checkstorageId) {
		this.checkstorageId = checkstorageId;
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
	 * @return the storeName
	 */
	public String getStoreName() {
		return storeName;
	}

	/**
	 * @param storeName
	 *            the storeName to set
	 */
	public void setStoreName(String storeName) {
		this.storeName = storeName;
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
	 * @return the checkNumber
	 */
	public String getCheckNumber() {
		return checkNumber;
	}

	/**
	 * @param checkNumber
	 *            the checkNumber to set
	 */
	public void setCheckNumber(String checkNumber) {
		this.checkNumber = checkNumber;
	}

	/**
	 * @return the stateValue
	 */
	public String getStateValue() {
		return stateValue;
	}

	/**
	 * @param stateValue
	 *            the stateValue to set
	 */
	public void setStateValue(String stateValue) {
		this.stateValue = stateValue;
	}

	/**
	 * @return the state
	 */
	public String getState() {
		return state;
	}

	/**
	 * @param state
	 *            the state to set
	 */
	public void setState(String state) {
		this.state = state;
	}

	/**
	 * @return the inventoryNumber
	 */
	public String getInventoryNumber() {
		return inventoryNumber;
	}

	/**
	 * @param inventoryNumber
	 *            the inventoryNumber to set
	 */
	public void setInventoryNumber(String inventoryNumber) {
		this.inventoryNumber = inventoryNumber;
	}

	/**
	 * @return the profitNumber
	 */
	public String getProfitNumber() {
		return profitNumber;
	}

	/**
	 * @param profitNumber
	 *            the profitNumber to set
	 */
	public void setProfitNumber(String profitNumber) {
		this.profitNumber = profitNumber;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "CheckstorageGoodsVO [id=" + id + ", checkstorageId="
				+ checkstorageId + ", goodsName=" + goodsName + ", storeName="
				+ storeName + ", storageName=" + storageName + ", goodsCode="
				+ goodsCode + ", goodsId=" + goodsId + ", other_attr_value="
				+ other_attr_value + "]";
	}

}
