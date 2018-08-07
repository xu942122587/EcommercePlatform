package com.unitever.module.promotion.model;

import java.util.Date;
import java.util.List;

import com.unitever.module.promotionGroup.model.PromotionGroup;
import com.unitever.module.promotionLadder.model.PromotionLadder;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.promotion.model->Promotion.java
 * </p>
 * <P>
 * 促销活动
 * </p>
 *
 * @author 闫枫
 * @date Aug 2, 2017
 */
public class Promotion {

	/** Id */
	private String id;

	/**
	 * 所属活动分组
	 */
	private PromotionGroup promotionGroup;
	/**
	 * 活动类型( 1：满折，2：满减，3：满反，4：特价促销，5：前二件折扣，
	 * 6：前三件折扣，7：满送促销，8：买赠促销，9：加钱换购，10：第二件折扣，11：单品折扣 ）
	 */
	private String type;
	/**
	 * 产品Id或者门店ID，针对天和的本字段为空
	 */
	private String ownerId;
	/**
	 * 优先级
	 */
	private String sorting;
	/**
	 * 其他条件预留字段1
	 */
	private String otherPro1;
	/**
	 * 其他条件预留字段2
	 */
	private String otherPro2;
	/**
	 * 其他条件预留字段3
	 */
	private String otherPro3;
	/**
	 * 其他条件预留字段4
	 */
	private String otherPro4;
	/**
	 * 其他条件预留字段5
	 */
	private String otherPro5;
	/**
	 * 其他条件预留字段6
	 */
	private String otherPro6;
	/**
	 * 其他条件预留字段7
	 */
	private String otherPro7;
	/**
	 * 其他条件预留字段8
	 */
	private String otherPro8;
	/**
	 * 其他条件预留字段9
	 */
	private String otherPro9;
	/**
	 * 其他条件预留字段10
	 */
	private String otherPro10;
	/**
	 * 其他条件预留字段11
	 */
	private String otherPro11;
	/**
	 * 其他条件预留字段12
	 */
	private String otherPro12;
	/**
	 * 其他条件预留字段13
	 */
	private String otherPro13;
	/**
	 * 其他条件预留字段14
	 */
	private String otherPro14;
	/**
	 * 其他条件预留字段15
	 */
	private String otherPro15;
	/** 是否删除（1：否，2：是） */
	private String isDelete;
	/** 创建时间 */
	private Date createTime;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用

	/**
	 * 活动价格阶梯--已有
	 */
	private List<PromotionLadder> promotionLadderList;
	/**
	 * 活动价格阶梯--新建
	 */
	private List<PromotionLadder> promotionLadderListNew;
	/**
	 * 活动价格阶梯--删除
	 */
	private List<PromotionLadder> promotionLadderListDel;

	private String typeValue;
	/**
	 * 活动类型：满折
	 */
	public static final String TYPE_1 = "1";
	/**
	 * 活动类型：满减
	 */
	public static final String TYPE_2 = "2";
	/**
	 * 活动类型：满反
	 */
	public static final String TYPE_3 = "3";
	/**
	 * 活动类型：特价促销
	 */
	public static final String TYPE_4 = "4";
	/**
	 * 活动类型：前二件折扣
	 */
	public static final String TYPE_5 = "5";
	/**
	 * 活动类型：前三件折扣
	 */
	public static final String TYPE_6 = "6";
	/**
	 * 活动类型：满送促销
	 */
	public static final String TYPE_7 = "7";
	/**
	 * 活动类型：买赠促销
	 */
	public static final String TYPE_8 = "8";
	/**
	 * 活动类型：加钱换购
	 */
	public static final String TYPE_9 = "9";
	/**
	 * 活动类型：第二件折扣
	 */
	public static final String TYPE_10 = "10";
	/**
	 * 活动类型：单品折扣
	 */
	public static final String TYPE_11 = "11";

	/**
	 * 是否删除--否
	 */
	public static final String ISDELETE_NO = "1";
	/**
	 * 是否删除--是
	 */
	public static final String ISDELETE_YES = "2";

	public Promotion() {
		super();
	}

	public Promotion(String id) {
		super();
		this.id = id;
	}

	/**
	 * @param id
	 * @param promotionGroup
	 * @param type
	 * @param createTime
	 */
	public Promotion(String id, PromotionGroup promotionGroup, String type, Date createTime) {
		super();
		this.id = id;
		this.promotionGroup = promotionGroup;
		this.type = type;
		this.createTime = createTime;
	}

	/**
	 * @param id
	 * @param promotionGroup
	 * @param type
	 * @param ownerId
	 * @param otherPro1
	 * @param otherPro2
	 * @param otherPro3
	 * @param otherPro4
	 * @param otherPro5
	 * @param createTime
	 */
	public Promotion(String id, PromotionGroup promotionGroup, String type, String ownerId, String otherPro1,
			String otherPro2, String otherPro3, String otherPro4, String otherPro5, Date createTime) {
		super();
		this.id = id;
		this.promotionGroup = promotionGroup;
		this.type = type;
		this.ownerId = ownerId;
		this.otherPro1 = otherPro1;
		this.otherPro2 = otherPro2;
		this.otherPro3 = otherPro3;
		this.otherPro4 = otherPro4;
		this.otherPro5 = otherPro5;
		this.createTime = createTime;
	}

	/**
	 * @param id
	 * @param promotionGroup
	 * @param type
	 * @param ownerId
	 * @param otherPro1
	 * @param otherPro2
	 * @param otherPro3
	 * @param otherPro4
	 * @param otherPro5
	 * @param otherPro6
	 * @param otherPro7
	 * @param otherPro8
	 * @param otherPro9
	 * @param otherPro10
	 * @param createTime
	 */
	public Promotion(String id, PromotionGroup promotionGroup, String type, String ownerId, String otherPro1,
			String otherPro2, String otherPro3, String otherPro4, String otherPro5, String otherPro6, String otherPro7,
			String otherPro8, String otherPro9, String otherPro10, Date createTime) {
		super();
		this.id = id;
		this.promotionGroup = promotionGroup;
		this.type = type;
		this.ownerId = ownerId;
		this.otherPro1 = otherPro1;
		this.otherPro2 = otherPro2;
		this.otherPro3 = otherPro3;
		this.otherPro4 = otherPro4;
		this.otherPro5 = otherPro5;
		this.otherPro6 = otherPro6;
		this.otherPro7 = otherPro7;
		this.otherPro8 = otherPro8;
		this.otherPro9 = otherPro9;
		this.otherPro10 = otherPro10;
		this.createTime = createTime;
	}

	/**
	 * @param id
	 * @param promotionGroup
	 * @param type
	 * @param ownerId
	 * @param otherPro1
	 * @param otherPro2
	 * @param otherPro3
	 * @param otherPro4
	 * @param otherPro5
	 * @param otherPro6
	 * @param otherPro7
	 * @param otherPro8
	 * @param otherPro9
	 * @param otherPro10
	 * @param otherPro11
	 * @param otherPro12
	 * @param otherPro13
	 * @param otherPro14
	 * @param otherPro15
	 * @param createTime
	 */
	public Promotion(String id, PromotionGroup promotionGroup, String type, String ownerId, String otherPro1,
			String otherPro2, String otherPro3, String otherPro4, String otherPro5, String otherPro6, String otherPro7,
			String otherPro8, String otherPro9, String otherPro10, String otherPro11, String otherPro12,
			String otherPro13, String otherPro14, String otherPro15, Date createTime) {
		super();
		this.id = id;
		this.promotionGroup = promotionGroup;
		this.type = type;
		this.ownerId = ownerId;
		this.otherPro1 = otherPro1;
		this.otherPro2 = otherPro2;
		this.otherPro3 = otherPro3;
		this.otherPro4 = otherPro4;
		this.otherPro5 = otherPro5;
		this.otherPro6 = otherPro6;
		this.otherPro7 = otherPro7;
		this.otherPro8 = otherPro8;
		this.otherPro9 = otherPro9;
		this.otherPro10 = otherPro10;
		this.otherPro11 = otherPro11;
		this.otherPro12 = otherPro12;
		this.otherPro13 = otherPro13;
		this.otherPro14 = otherPro14;
		this.otherPro15 = otherPro15;
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
	 * @return the promotionGroup 所属活动分组
	 */
	public PromotionGroup getPromotionGroup() {
		return promotionGroup;
	}

	/**
	 * @param promotionGroup
	 *            the promotionGroup(所属活动分组) to set
	 */
	public void setPromotionGroup(PromotionGroup promotionGroup) {
		this.promotionGroup = promotionGroup;
	}

	/**
	 * @return the type 活动类型
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type
	 *            the type(活动类型) to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return the ownerId 产品Id或者门店ID，针对天和的本字段为空
	 */
	public String getOwnerId() {
		return ownerId;
	}

	/**
	 * @param ownerId
	 *            the ownerId(产品Id或者门店ID，针对天和的本字段为空) to set
	 */
	public void setOwnerId(String ownerId) {
		this.ownerId = ownerId;
	}

	/**
	 * @return the otherPro1 其他条件预留字段1
	 */
	public String getOtherPro1() {
		return otherPro1;
	}

	/**
	 * @param otherPro1
	 *            the otherPro1(其他条件预留字段1) to set
	 */
	public void setOtherPro1(String otherPro1) {
		this.otherPro1 = otherPro1;
	}

	/**
	 * @return the otherPro2 其他条件预留字段2
	 */
	public String getOtherPro2() {
		return otherPro2;
	}

	/**
	 * @param otherPro2
	 *            the otherPro2(其他条件预留字段2) to set
	 */
	public void setOtherPro2(String otherPro2) {
		this.otherPro2 = otherPro2;
	}

	/**
	 * @return the otherPro3 其他条件预留字段3
	 */
	public String getOtherPro3() {
		return otherPro3;
	}

	/**
	 * @param otherPro3
	 *            the otherPro3(其他条件预留字段3) to set
	 */
	public void setOtherPro3(String otherPro3) {
		this.otherPro3 = otherPro3;
	}

	/**
	 * @return the otherPro4 其他条件预留字段4
	 */
	public String getOtherPro4() {
		return otherPro4;
	}

	/**
	 * @param otherPro4
	 *            the otherPro4(其他条件预留字段4) to set
	 */
	public void setOtherPro4(String otherPro4) {
		this.otherPro4 = otherPro4;
	}

	/**
	 * @return the otherPro5 其他条件预留字段5
	 */
	public String getOtherPro5() {
		return otherPro5;
	}

	/**
	 * @param otherPro5
	 *            the otherPro5(其他条件预留字段5) to set
	 */
	public void setOtherPro5(String otherPro5) {
		this.otherPro5 = otherPro5;
	}

	/**
	 * @return the otherPro6 其他条件预留字段6
	 */
	public String getOtherPro6() {
		return otherPro6;
	}

	/**
	 * @param otherPro6
	 *            the otherPro6(其他条件预留字段6) to set
	 */
	public void setOtherPro6(String otherPro6) {
		this.otherPro6 = otherPro6;
	}

	/**
	 * @return the otherPro7 其他条件预留字段7
	 */
	public String getOtherPro7() {
		return otherPro7;
	}

	/**
	 * @param otherPro7
	 *            the otherPro7(其他条件预留字段7) to set
	 */
	public void setOtherPro7(String otherPro7) {
		this.otherPro7 = otherPro7;
	}

	/**
	 * @return the otherPro8 其他条件预留字段8
	 */
	public String getOtherPro8() {
		return otherPro8;
	}

	/**
	 * @param otherPro8
	 *            the otherPro8(其他条件预留字段8) to set
	 */
	public void setOtherPro8(String otherPro8) {
		this.otherPro8 = otherPro8;
	}

	/**
	 * @return the otherPro9 其他条件预留字段9
	 */
	public String getOtherPro9() {
		return otherPro9;
	}

	/**
	 * @param otherPro9
	 *            the otherPro9(其他条件预留字段9) to set
	 */
	public void setOtherPro9(String otherPro9) {
		this.otherPro9 = otherPro9;
	}

	/**
	 * @return the otherPro10 其他条件预留字段10
	 */
	public String getOtherPro10() {
		return otherPro10;
	}

	/**
	 * @param otherPro10
	 *            the otherPro10(其他条件预留字段10) to set
	 */
	public void setOtherPro10(String otherPro10) {
		this.otherPro10 = otherPro10;
	}

	/**
	 * @return the otherPro11 其他条件预留字段11
	 */
	public String getOtherPro11() {
		return otherPro11;
	}

	/**
	 * @param otherPro11
	 *            the otherPro11(其他条件预留字段11) to set
	 */
	public void setOtherPro11(String otherPro11) {
		this.otherPro11 = otherPro11;
	}

	/**
	 * @return the otherPro12 其他条件预留字段12
	 */
	public String getOtherPro12() {
		return otherPro12;
	}

	/**
	 * @param otherPro12
	 *            the otherPro12(其他条件预留字段12) to set
	 */
	public void setOtherPro12(String otherPro12) {
		this.otherPro12 = otherPro12;
	}

	/**
	 * @return the otherPro13 其他条件预留字段13
	 */
	public String getOtherPro13() {
		return otherPro13;
	}

	/**
	 * @param otherPro13
	 *            the otherPro13(其他条件预留字段13) to set
	 */
	public void setOtherPro13(String otherPro13) {
		this.otherPro13 = otherPro13;
	}

	/**
	 * @return the otherPro14 其他条件预留字段14
	 */
	public String getOtherPro14() {
		return otherPro14;
	}

	/**
	 * @param otherPro14
	 *            the otherPro14(其他条件预留字段14) to set
	 */
	public void setOtherPro14(String otherPro14) {
		this.otherPro14 = otherPro14;
	}

	/**
	 * @return the otherPro15 其他条件预留字段15
	 */
	public String getOtherPro15() {
		return otherPro15;
	}

	/**
	 * @param otherPro15
	 *            the otherPro15（ 其他条件预留字段15） to set
	 */
	public void setOtherPro15(String otherPro15) {
		this.otherPro15 = otherPro15;
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
		switch (type) {
		case TYPE_1:
			typeValue = "满折";
			break;
		case TYPE_2:
			typeValue = "满减";
			break;
		case TYPE_3:
			typeValue = "满返";
			break;
		case TYPE_4:
			typeValue = "特价促销";
			break;
		case TYPE_5:
			typeValue = "前二件折扣";
			break;
		case TYPE_6:
			typeValue = "前三件折扣";
			break;
		case TYPE_7:
			typeValue = "满送促销";
			break;
		case TYPE_8:
			typeValue = "买赠促销";
			break;
		case TYPE_9:
			typeValue = "加钱换购";
			break;
		case TYPE_10:
			typeValue = "第二件折扣";
			break;
		case TYPE_11:
			typeValue = "单品折扣";
			break;
		default:
			typeValue = "未知";
			break;
		}
		return typeValue;
	}

	/**
	 * @return the sorting 优先级
	 */
	public String getSorting() {
		return sorting;
	}

	/**
	 * @param sorting
	 *            the sorting（优先级） to set
	 */
	public void setSorting(String sorting) {
		this.sorting = sorting;
	}

	/**
	 * @return the promotionLadderList 活动价格阶梯
	 */
	public List<PromotionLadder> getPromotionLadderList() {
		return promotionLadderList;
	}

	/**
	 * @param promotionLadderList
	 *            the promotionLadderList(活动价格阶梯) to set
	 */
	public void setPromotionLadderList(List<PromotionLadder> promotionLadderList) {
		this.promotionLadderList = promotionLadderList;
	}

	/**
	 * @return the isDelete
	 */
	public String getIsDelete() {
		return isDelete;
	}

	/**
	 * @param isDelete
	 *            the isDelete to set
	 */
	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}

	/**
	 * @return the promotionLadderListNew 活动价格阶梯--新建
	 */
	public List<PromotionLadder> getPromotionLadderListNew() {
		return promotionLadderListNew;
	}

	/**
	 * @param promotionLadderListNew
	 *            the promotionLadderListNew(活动价格阶梯--新建) to set
	 */
	public void setPromotionLadderListNew(List<PromotionLadder> promotionLadderListNew) {
		this.promotionLadderListNew = promotionLadderListNew;
	}

	/**
	 * @return the promotionLadderListDel 活动价格阶梯--删除
	 */
	public List<PromotionLadder> getPromotionLadderListDel() {
		return promotionLadderListDel;
	}

	/**
	 * @param promotionLadderListDel
	 *            the promotionLadderListDel(活动价格阶梯--删除) to set
	 */
	public void setPromotionLadderListDel(List<PromotionLadder> promotionLadderListDel) {
		this.promotionLadderListDel = promotionLadderListDel;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Promotion [id=" + id + ", promotionGroup=" + promotionGroup + ", type=" + type + ", ownerId=" + ownerId
				+ ", otherPro1=" + otherPro1 + ", otherPro2=" + otherPro2 + ", otherPro3=" + otherPro3 + ", otherPro4="
				+ otherPro4 + ", otherPro5=" + otherPro5 + ", otherPro6=" + otherPro6 + ", otherPro7=" + otherPro7
				+ ", otherPro8=" + otherPro8 + ", otherPro9=" + otherPro9 + ", otherPro10=" + otherPro10
				+ ", otherPro11=" + otherPro11 + ", otherPro12=" + otherPro12 + ", otherPro13=" + otherPro13
				+ ", otherPro14=" + otherPro14 + ", otherPro15=" + otherPro15 + ", createTime=" + createTime + ", ft="
				+ ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu + ", startDate=" + startDate + ", endDate=" + endDate
				+ ", typeValue=" + typeValue + "]";
	}

}
