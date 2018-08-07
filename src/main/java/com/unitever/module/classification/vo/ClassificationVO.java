package com.unitever.module.classification.vo;

import com.unitever.module.classification.model.Classification;

/**
 * 自定义属性
 * 
 * @author XiaoYu
 * @date 2017年4月24日
 */
public class ClassificationVO {

	/** 类别 */
	private Classification classification;
	/** 键名 */
	private String attrCode;
	/** 输入类型 */
	private String inputType;
	/** 是否必填 */
	private String isRequired;
	/** 备选项 */
	private String childAttr;
	/** 主属性 */
	private String Attr;
	
	private String inputTypeValue;
	/** 自由输入 */
	public static String INPUTTYPE_ONE = "1";
	/** 备选项 */
	public static String INPUTTYPE_TWO = "2";
	/** 手机类型 */
	public static String INPUTTYPE_THR = "3";
	/** 邮箱类型 */
	public static String INPUTTYPE_FOU = "4";
	/** 金额类型 */
	public static String INPUTTYPE_FIV = "5";
	
	private String isRequiredValue;
	/** 自由输入 */
	public static String ISREQUIRED_ONE = "1";
	/** 备选项 */
	public static String ISREQUIRED_TWO = "2";

	public ClassificationVO() {
		super();
	}

	public ClassificationVO(Classification classification, String attrCode,
			String inputType, String isRequired, String childAttr) {
		super();
		this.classification = classification;
		this.attrCode = attrCode;
		this.inputType = inputType;
		this.isRequired = isRequired;
		this.childAttr = childAttr;
	}

	/**
	 * @return the classification 类别
	 */
	public Classification getClassification() {
		return classification;
	}

	/**
	 * @param classification the classification 类别 to set
	 */
	public void setClassification(Classification classification) {
		this.classification = classification;
	}

	/**
	 * @return the attrCode 键名
	 */
	public String getAttrCode() {
		return attrCode;
	}

	/**
	 * @param attrCode the attrCode 键名 to set
	 */
	public void setAttrCode(String attrCode) {
		this.attrCode = attrCode;
	}

	/**
	 * @return the inputType 输入类型
	 */
	public String getInputType() {
		return inputType;
	}

	/**
	 * @param inputType the inputType 输入类型 to set
	 */
	public void setInputType(String inputType) {
		this.inputType = inputType;
	}

	/**
	 * @return the isRequired 是否必填
	 */
	public String getIsRequired() {
		return isRequired;
	}

	/**
	 * @param isRequired the isRequired 是否必填 to set
	 */
	public void setIsRequired(String isRequired) {
		this.isRequired = isRequired;
	}

	/**
	 * @return the childAttr 备选项
	 */
	public String getChildAttr() {
		return childAttr;
	}

	/**
	 * @param childAttr the childAttr 备选项 to set
	 */
	public void setChildAttr(String childAttr) {
		this.childAttr = childAttr;
	}

	/**
	 * @return the attr
	 */
	public String getAttr() {
		return Attr;
	}

	/**
	 * @param attr the attr to set
	 */
	public void setAttr(String attr) {
		Attr = attr;
	}

	/**
	 * @return the inputTypeValue
	 */
	public String getInputTypeValue() {
		if(INPUTTYPE_ONE.equals(inputType)){
			return "自由输入";
		}
		if(INPUTTYPE_TWO.equals(inputType)){
			return "备选项";
		}
		if(INPUTTYPE_THR.equals(inputType)){
			return "手机类型";
		}
		if(INPUTTYPE_FOU.equals(inputType)){
			return "邮箱类型";
		}
		if(INPUTTYPE_FIV.equals(inputType)){
			return "金额类型";
		}
		return null;
	}


	/**
	 * @return the isRequiredValue
	 */
	public String getIsRequiredValue() {
		if(ISREQUIRED_ONE.equals(isRequired)){
			return "必填";
		}
		if(ISREQUIRED_TWO.equals(isRequired)){
			return "非必填";
		}
		return isRequiredValue;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "ClassificationVO [classification=" + classification
				+ ", attrCode=" + attrCode + ", inputType=" + inputType
				+ ", isRequired=" + isRequired + ", childAttr=" + childAttr
				+ "]";
	}


}
