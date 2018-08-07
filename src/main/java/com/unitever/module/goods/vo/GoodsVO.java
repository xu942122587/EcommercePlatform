package com.unitever.module.goods.vo;

import com.unitever.module.goods.model.Goods;


public class GoodsVO {

	/** 商品 */
	private Goods goods;
	/** 键名 */
	private String attrCode;
	/** 属性名 */
	private String attr;
	/** 属性值 */
	private String attrValue;

	public GoodsVO() {
		super();
	}

	public GoodsVO(String attrCode, String attr, String attrValue) {
		super();
		this.attrCode = attrCode;
		this.attr = attr;
		this.attrValue = attrValue;
	}

	/**
	 * @return the attrCode
	 */
	public String getAttrCode() {
		return attrCode;
	}

	/**
	 * @param attrCode the attrCode to set
	 */
	public void setAttrCode(String attrCode) {
		this.attrCode = attrCode;
	}

	/**
	 * @return the goods
	 */
	public Goods getGoods() {
		return goods;
	}

	/**
	 * @param goods the goods to set
	 */
	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	/**
	 * @return the attr
	 */
	public String getAttr() {
		return attr;
	}

	/**
	 * @param attr the attr to set
	 */
	public void setAttr(String attr) {
		this.attr = attr;
	}

	/**
	 * @return the attrValue
	 */
	public String getAttrValue() {
		return attrValue;
	}

	/**
	 * @param attrValue the attrValue to set
	 */
	public void setAttrValue(String attrValue) {
		this.attrValue = attrValue;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "GoodsVO [attrCode=" + attrCode + ", attr=" + attr
				+ ", attrValue=" + attrValue + "]";
	}


}
