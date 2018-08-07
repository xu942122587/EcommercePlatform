package com.unitever.module.classification.model;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

/**
 * 分类
 * 
 * @author XiaoYu
 * @date 2017年4月24日
 */
public class Classification {

	private String id;
	/** 分类名称 */
	private String name;
	/** 分类描述 */
	private String description;
	/** 分类顺序 */
	private String seq;
	/** 是否可见 */
	private String isVisible;
	/** 状态 */
	private String state;
	/** 是否有商品 */
	private Integer isHaveGoods;
	/** 分类级别 */
	private String level;
	/** 父分类 */
	private Classification parentClassification;
	/** 子分类 */
	private List<Classification> childrenClassifications = new ArrayList<Classification>();
	/**
	 * 自定义属性(使用json方式定义产品自定义属性，eg: {'price','价格'}，key为产品属性json的对应key，value为属性名称)
	 */
	private String otherAttrJson;
	/** 备注 */
	private String remark;

	private String isVisibleValue;
	/** 可见 */
	public static final String VALUE_ISVISIBLE_TRUE = "1";
	/** 隐藏 */
	public static final String VALUE_ISVISIBLE_FALSE = "2";

	/** 正常 */
	public static final String VALUE_STATE_NORMAL = "1";
	/** 删除 */
	public static final String VALUE_STATE_DELETE = "2";

	public Classification() {
		super();
	}

	public Classification(String id) {
		super();
		this.id = id;
	}

	public Classification(String id, String name, String description, String seq, String isVisible, String state,
			String level, Classification parentClassification, List<Classification> childrenClassifications,
			String otherAttrJson, String remark) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.seq = seq;
		this.isVisible = isVisible;
		this.state = state;
		this.level = level;
		this.parentClassification = parentClassification;
		this.childrenClassifications = childrenClassifications;
		this.otherAttrJson = otherAttrJson;
		this.remark = remark;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public Classification getParentClassification() {
		return parentClassification;
	}

	public void setParentClassification(Classification parentClassification) {
		this.parentClassification = parentClassification;
	}

	public List<Classification> getChildrenClassifications() {
		return childrenClassifications;
	}

	public void setChildrenClassifications(List<Classification> childrenClassifications) {
		this.childrenClassifications = childrenClassifications;
	}

	public String getIsVisible() {
		return isVisible;
	}

	public void setIsVisible(String isVisible) {
		this.isVisible = isVisible;
	}

	public String getIsVisibleValue() {
		if (VALUE_ISVISIBLE_TRUE.equals(isVisible)) {
			return "可见";
		} else if (VALUE_ISVISIBLE_FALSE.equals(isVisible)) {
			return "隐藏";
		}
		return null;
	}

	public void setIsVisibleValue(String isVisibleValue) {
		this.isVisibleValue = isVisibleValue;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	/**
	 * @return the otherAttrJson
	 */
	public String getOtherAttrJson() {
		return otherAttrJson;
	}

	/**
	 * @param otherAttrJson
	 *            the otherAttrJson to set
	 */
	public void setOtherAttrJson(String otherAttrJson) {
		this.otherAttrJson = otherAttrJson;
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
	 * @return the isHaveGoods
	 */
	public Integer getIsHaveGoods() {
		return isHaveGoods;
	}

	/**
	 * @param isHaveGoods the isHaveGoods to set
	 */
	public void setIsHaveGoods(Integer isHaveGoods) {
		this.isHaveGoods = isHaveGoods;
	}

	@Override
	public String toString() {
		String id = "";
		if (null != parentClassification && StringUtils.isNotBlank(parentClassification.getId())) {
			id = parentClassification.getId();
		}
		return "Classification [id=" + id + ", name=" + name + ", description=" + description + ", seq=" + seq
				+ ", level=" + level + ", isVisible=" + isVisibleValue + ", state=" + state + ", parentClassification="
				+ id + ", childrenClassifications=" + childrenClassifications.size() + "]";
	}

}
