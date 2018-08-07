package com.unitever.module.promotionGroup.model;

import java.util.Date;
import java.util.List;

import com.unitever.module.promotion.model.Promotion;
import com.unitever.module.promotionLadder.model.PromotionLadder;
import com.unitever.platform.core.dao.BaseModel;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.promotionGroup.model->PromotionGroup.
 * java
 * </p>
 * <P>
 * 活动组
 * </p>
 *
 * @author 闫枫
 * @date Aug 2, 2017
 */
public class PromotionGroup extends BaseModel {

	/** Id */
	private String id;
	/**
	 * 活动开始时间
	 */
	private Date proStartDate;
	/**
	 * 活动结束时间
	 */
	private Date proEndDate;
	/**
	 * 针对范围：（1：产品，2：门店，3：天和全场，4：不限制（叠加类））
	 */
	private String scope;
	/**
	 * 是否线上（1：线上，2：线下，3：全部）
	 */
	private String isOline;
	/**
	 * 支付方式（6：不限制，1：现金，2：刷卡，3：微信，4：支付宝，5：天和会员余额）
	 */
	private String payType;
	/**
	 * 产品Id或者门店ID，针对天和的本字段为空
	 */
	private String ownerId;
	/** 是否删除（1：否，2：是） */
	private String isDelete;
	/** 备注 */
	private String remark;
	/** 创建时间 */
	private Date createTime;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用

	private String[] ownerIdArray;// ownerId 的数组，查询用

	/**
	 * 活动开始时间--字符串类型用于新建和更新时，接收页面数据并保存
	 */
	private String proStartDateString;
	/**
	 * 活动结束时间--字符串类型用于新建和更新时，接收页面数据并保存
	 */
	private String proEndDateString;

	/**
	 * 促销活动--已有
	 */
	private List<Promotion> promotionList;
	/**
	 * 促销活动--新建
	 */
	private List<Promotion> promotionListNew;
	/**
	 * 促销活动--删除
	 */
	private List<Promotion> promotionListDel;
	/**
	 * 促销活动--档位--删除
	 */
	private List<PromotionLadder> promotionLadderListDel;

	private String scopeValue;
	/**
	 * 针对范围：产品
	 */
	public static final String SCOPE_GOODS = "1";
	/**
	 * 针对范围：门店
	 */
	public static final String SCOPE_STORE = "2";
	/**
	 * 针对范围：天和全场
	 */
	public static final String SCOPE_ALL = "3";
	/**
	 * 针对范围：叠加
	 */
	public static final String SCOPE_NOSET = "4";

	private String isOlineValue;
	/**
	 * 是否线上：线上
	 */
	public static final String ISONLINE_YES = "1";
	/**
	 * 是否线上：线下
	 */
	public static final String ISONLINE_NO = "2";
	/**
	 * 是否线上：不限制
	 */
	public static final String ISONLINE_ALL = "3";

	private String payTypeValue;
	/**
	 * 支付方式：不限制
	 */
	public static final String PAYTYPE_ALL = "6";
	/**
	 * 支付方式：现金支付
	 */
	public static final String PAYTYPE_MONEY = "1";
	/**
	 * 支付方式：银行卡pos支付
	 */
	public static final String PAYTYPE_POS = "2";
	/**
	 * 支付方式：微信支付
	 */
	public static final String PAYTYPE_WECHAT = "3";
	/**
	 * 支付方式：支付宝支付
	 */
	public static final String PAYTYPE_ALIPAY = "4";
	/**
	 * 支付方式：天和钱包支付
	 */
	public static final String PAYTYPE_TIANHE = "5";

	/**
	 * 是否删除--否
	 */
	public static final String ISDELETE_NO = "1";
	/**
	 * 是否删除--是
	 */
	public static final String ISDELETE_YES = "2";

	/**
	 * 
	 */
	public PromotionGroup() {
		super();
	}

	/**
	 * @param id
	 */
	public PromotionGroup(String id) {
		super();
		this.id = id;
	}

	/**
	 * @param id
	 * @param proStartDate
	 *            活动开始时间
	 * @param proEndDate
	 *            活动结束时间
	 * @param scope
	 *            针对范围：（1：产品，2：门店，3：天和全场）
	 * @param isOline
	 *            是否线上（1：线上，2：线下，3：全部）
	 * @param payType
	 *            支付方式（1：不限制，2：现金，3：刷卡，4：微信，5：支付宝，6：天和会员余额）
	 * @param isDelete
	 *            是否删除（1：否，2：是）
	 * @param createTime
	 *            创建时间
	 */
	public PromotionGroup(String id, Date proStartDate, Date proEndDate, String scope, String isOline, String payType,
			String isDelete, Date createTime) {
		super();
		this.id = id;
		this.proStartDate = proStartDate;
		this.proEndDate = proEndDate;
		this.scope = scope;
		this.isOline = isOline;
		this.payType = payType;
		this.isDelete = isDelete;
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
	 * @return the proStartDate 活动开始时间
	 */
	public Date getProStartDate() {
		return proStartDate;
	}

	/**
	 * @param proStartDate
	 *            the proStartDate(活动开始时间) to set
	 */
	public void setProStartDate(Date proStartDate) {
		this.proStartDate = proStartDate;
	}

	/**
	 * @return the proEndDate (活动结束时间)
	 */
	public Date getProEndDate() {
		return proEndDate;
	}

	/**
	 * @param proEndDate
	 *            the proEndDate(活动结束时间) to set
	 */
	public void setProEndDate(Date proEndDate) {
		this.proEndDate = proEndDate;
	}

	/**
	 * @return the scope 针对范围：（1：产品，2：门店，3：天和全场）
	 */
	public String getScope() {
		return scope;
	}

	/**
	 * @param scope
	 *            the scope(针对范围：（1：产品，2：门店，3：天和全场）) to set
	 */
	public void setScope(String scope) {
		this.scope = scope;
	}

	/**
	 * @return the isOline 是否线上（1：线上，2：线下，3：全部）
	 */
	public String getIsOline() {
		return isOline;
	}

	/**
	 * @param isOline
	 *            the isOline(是否线上（1：线上，2：线下，3：全部）) to set
	 */
	public void setIsOline(String isOline) {
		this.isOline = isOline;
	}

	/**
	 * @return the payType 支付方式（1：不限制，2：现金，3：刷卡，4：微信，5：支付宝，6：天和会员余额）
	 */
	public String getPayType() {
		return payType;
	}

	/**
	 * @param payType
	 *            the payType（支付方式（1：不限制，2：现金，3：刷卡，4：微信，5：支付宝，6：天和会员余额）） to set
	 */
	public void setPayType(String payType) {
		this.payType = payType;
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
	 * @return the scopeValue (针对范围VALUE用于前台显示)
	 */
	public String getScopeValue() {
		if (SCOPE_GOODS.equals(scope)) {
			return "产品";
		} else if (SCOPE_STORE.equals(scope)) {
			return "门店";
		} else if (SCOPE_ALL.equals(scope)) {
			return "天和全场";
		} else if (SCOPE_NOSET.equals(scope)) {
			return "叠加活动";
		}
		return scopeValue;
	}

	/**
	 * @return the isOlineValue (是否线上VALUE用于前台显示)
	 */
	public String getIsOlineValue() {
		if (ISONLINE_YES.equals(isOline)) {
			return "线上";
		} else if (ISONLINE_NO.equals(isOline)) {
			return "线下";
		} else if (ISONLINE_ALL.equals(isOline)) {
			return "不限制";
		}
		return isOlineValue;
	}

	/**
	 * @return the payTypeValue (支付方式VALUE用于前台显示)
	 */
	public String getPayTypeValue() {
		switch (payType) {
		case PAYTYPE_ALL:
			payTypeValue = "不限制";
			break;
		case PAYTYPE_MONEY:
			payTypeValue = "现金支付";
			break;
		case PAYTYPE_POS:
			payTypeValue = "银行卡pos支付";
			break;
		case PAYTYPE_WECHAT:
			payTypeValue = "微信支付";
			break;
		case PAYTYPE_ALIPAY:
			payTypeValue = "支付宝支付";
			break;
		case PAYTYPE_TIANHE:
			payTypeValue = "天和钱包支付";
			break;
		default:
			payTypeValue = "不限制";
			break;
		}
		return payTypeValue;
	}

	/**
	 * @return the remark 备注
	 */
	public String getRemark() {
		return remark;
	}

	/**
	 * @param remark
	 *            the remark（备注） to set
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}

	/**
	 * @return the promotionList 促销活动--已有
	 */
	public List<Promotion> getPromotionList() {
		return promotionList;
	}

	/**
	 * @param promotionList
	 *            the promotionList（促销活动--已有） to set
	 */
	public void setPromotionList(List<Promotion> promotionList) {
		this.promotionList = promotionList;
	}

	/**
	 * @return the promotionListNew 促销活动--新建
	 */
	public List<Promotion> getPromotionListNew() {
		return promotionListNew;
	}

	/**
	 * @param promotionListNew
	 *            the promotionListNew（促销活动--新建） to set
	 */
	public void setPromotionListNew(List<Promotion> promotionListNew) {
		this.promotionListNew = promotionListNew;
	}

	/**
	 * @return the promotionListDel 促销活动--删除
	 */
	public List<Promotion> getPromotionListDel() {
		return promotionListDel;
	}

	/**
	 * @param promotionListDel
	 *            the promotionListDel（促销活动--删除） to set
	 */
	public void setPromotionListDel(List<Promotion> promotionListDel) {
		this.promotionListDel = promotionListDel;
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
	 * @return the promotionLadderListDel 促销活动--档位--删除
	 */
	public List<PromotionLadder> getPromotionLadderListDel() {
		return promotionLadderListDel;
	}

	/**
	 * @param promotionLadderListDel
	 *            the promotionLadderListDel（促销活动--档位--删除） to set
	 */
	public void setPromotionLadderListDel(List<PromotionLadder> promotionLadderListDel) {
		this.promotionLadderListDel = promotionLadderListDel;
	}

	/**
	 * @return the proStartDateString 活动开始时间--字符串类型用于新建和更新时，接收页面数据并保存
	 */
	public String getProStartDateString() {
		return proStartDateString;
	}

	/**
	 * @param proStartDateString
	 *            the proStartDateString（活动开始时间--字符串类型用于新建和更新时，接收页面数据并保存） to set
	 */
	public void setProStartDateString(String proStartDateString) {
		this.proStartDateString = proStartDateString;
	}

	/**
	 * @return the proEndDateString 活动结束时间--字符串类型用于新建和更新时，接收页面数据并保存
	 */
	public String getProEndDateString() {
		return proEndDateString;
	}

	/**
	 * @param proEndDateString
	 *            the proEndDateString（活动结束时间--字符串类型用于新建和更新时，接收页面数据并保存） to set
	 */
	public void setProEndDateString(String proEndDateString) {
		this.proEndDateString = proEndDateString;
	}

	/**
	 * @return the ownerIdArray
	 */
	public String[] getOwnerIdArray() {
		return ownerId.split(",");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "PromotionGroup [id=" + id + ", proStartDate=" + proStartDate + ", proEndDate=" + proEndDate
				+ ", scope=" + scope + ", isOline=" + isOline + ", payType=" + payType + ", isDelete=" + isDelete
				+ ", createTime=" + createTime + ", ft=" + ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu
				+ ", startDate=" + startDate + ", endDate=" + endDate + ", scopeValue=" + scopeValue
				+ ", isOlineValue=" + isOlineValue + ", payTypeValue=" + payTypeValue + "]";
	}

}
