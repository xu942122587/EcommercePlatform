package com.unitever.module.procurement.model;

import java.util.Date;
import java.util.List;

import com.unitever.auth.user.model.User;
import com.unitever.module.procurementGoods.model.ProcurementGoods;
import com.unitever.module.store.model.Store;
import com.unitever.module.vende.model.Vende;
import com.unitever.platform.core.dao.BaseModel;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.procurement.model->Procurement.java
 * </p>
 * <P>
 * 采购订单（退货单）实体
 * </p>
 *
 * @author 闫枫
 * @date Jul 6, 2017
 */
public class Procurement extends BaseModel {

	/** Id */
	private String id;
	/** 类型(1：采购订单，2：采购退货单) */
	private String type;
	/** 供应商 */
	private Vende vende;
	/** 采购单号 */
	private String procurementCode;
	/** 件数总计 */
	private String count;
	/** 金额总计 */
	private String sumMoney;
	/** 实到件数总计 */
	private String buyCount;
	/** 实到金额总计 */
	private String buySumMoney;
	/** 状态(1：待审核，2：同意采购，3：待退货，4：完成，5：未通过，6：采购到货, 7:退货单未完成) */
	private String state;
	/** 审核人 */
	private User user;
	/** 门店 */
	private Store store;
	/** 采购、退货日期 */
	private Date procurementDate;
	/** 是否删除（1：否，2：是） */
	private String isDelete;
	/** 备注 */
	private String remark;
	/** 审核不通过原因 */
	private String checkRemark;
	/** 发货类型 */
	private String shipType;
	/** 创建时间 */
	private Date createTime;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用
	private String fu_string; // 创建人

	/**
	 * 采购（采购退货）产品
	 */
	private List<ProcurementGoods> procurementGoodsList;
	/**
	 * 采购（采购退货）产品--新建
	 */
	private List<ProcurementGoods> procurementGoodsListNew;
	/**
	 * 采购（采购退货）产品--删除
	 */
	private List<ProcurementGoods> procurementGoodsListDel;

	/**
	 * 是否删除--否
	 */
	public static final String ISDELETE_NO = "1";
	/**
	 * 是否删除--是
	 */
	public static final String ISDELETE_YES = "2";

	private String stateValue;
	/**
	 * 状态:待审核
	 */
	public static final String STATE_ONE = "1";
	/**
	 * 状态:同意采购
	 */
	public static final String STATE_TWO = "2";
	/**
	 * 状态:待退货
	 */
	public static final String STATE_THREE = "3";
	/**
	 * 状态:完成
	 */
	public static final String STATE_FOUR = "4";
	/**
	 * 状态:未通过
	 */
	public static final String STATE_FIVE = "5";
	/**
	 * 状态:采购到货
	 */
	public static final String STATE_SIX = "6";
	/**
	 * 状态:采购退货未完成
	 */
	public static final String STATE_SEVEN = "7";

	/**
	 * 类型的value值，部分
	 */
	private String type_value_lest;
	/**
	 * 类型：采购订单
	 */
	public static final String TYPE_ONE = "1";
	/**
	 * 类型：采购退货单
	 */
	public static final String TYPE_TWO = "2";

	public Procurement() {
		super();
	}

	public Procurement(String id) {
		super();
		this.id = id;
	}

	/**
	 * @param id
	 * @param type
	 *            类型(1：采购订单，2：采购退货单)
	 * @param vende
	 *            供应商
	 * @param procurementCode
	 *            采购单号
	 * @param count
	 *            件数总计
	 * @param sumMoney
	 *            金额总计
	 * @param state
	 *            状态(1：待审核，2：未入库，3：已退货，4：完成)
	 * @param user
	 *            审核人
	 * @param procurementDate
	 *            采购、退货日期
	 * @param isDelete
	 *            是否删除（1：否，2：是）
	 * @param remark
	 *            备注
	 * @param createTime
	 * @param store
	 *            门店
	 */
	public Procurement(String id, String type, Vende vende, String procurementCode, String count, String sumMoney,
			String state, User user, Date procurementDate, String isDelete, String remark, Date createTime, Store store) {
		super();
		this.id = id;
		this.type = type;
		this.vende = vende;
		this.procurementCode = procurementCode;
		this.count = count;
		this.sumMoney = sumMoney;
		this.state = state;
		this.user = user;
		this.procurementDate = procurementDate;
		this.isDelete = isDelete;
		this.remark = remark;
		this.createTime = createTime;
		this.store = store;
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
	 * @return the type 类型(1：采购订单，2：采购退货单)
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type
	 *            the type(类型(1：采购订单，2：采购退货单)) to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return the vende 供应商
	 */
	public Vende getVende() {
		return vende;
	}

	/**
	 * @param vende
	 *            the vende(供应商) to set
	 */
	public void setVende(Vende vende) {
		this.vende = vende;
	}

	/**
	 * @return the procurementCode 采购单号
	 */
	public String getProcurementCode() {
		return procurementCode;
	}

	/**
	 * @param procurementCode
	 *            the procurementCode(采购单号) to set
	 */
	public void setProcurementCode(String procurementCode) {
		this.procurementCode = procurementCode;
	}

	/**
	 * @return the count 件数总计
	 */
	public String getCount() {
		return count;
	}

	/**
	 * @param count
	 *            the count(件数总计) to set
	 */
	public void setCount(String count) {
		this.count = count;
	}

	/**
	 * @return the sumMoney 金额总计
	 */
	public String getSumMoney() {
		return sumMoney;
	}

	/**
	 * @param sumMoney
	 *            the sumMoney(金额总计) to set
	 */
	public void setSumMoney(String sumMoney) {
		this.sumMoney = sumMoney;
	}

	/**
	 * @return the state 状态(1：待审核，2：未入库，3：已退货，4：完成)
	 */
	public String getState() {
		return state;
	}

	/**
	 * @param state
	 *            the state(状态(1：待审核，2：未入库，3：已退货，4：完成)) to set
	 */
	public void setState(String state) {
		this.state = state;
	}

	/**
	 * @return the user 审核人
	 */
	public User getUser() {
		return user;
	}

	/**
	 * @param user
	 *            the user(审核人) to set
	 */
	public void setUser(User user) {
		this.user = user;
	}

	/**
	 * @return the procurementDate 采购、退货日期
	 */
	public Date getProcurementDate() {
		return procurementDate;
	}

	/**
	 * @param procurementDate
	 *            the procurementDate(采购、退货日期) to set
	 */
	public void setProcurementDate(Date procurementDate) {
		this.procurementDate = procurementDate;
	}

	/**
	 * @return the isDelete 是否删除（1：否，2：是）
	 */
	public String getIsDelete() {
		return isDelete;
	}

	/**
	 * @param isDelete
	 *            the isDelete(是否删除（1：否，2：是）) to set
	 */
	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}

	/**
	 * @return the remark 备注
	 */
	public String getRemark() {
		return remark;
	}

	/**
	 * @param remark
	 *            the remark(备注) to set
	 */
	public void setRemark(String remark) {
		this.remark = remark;
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
	 * @return the stateValue
	 */
	public String getStateValue() {
		if (STATE_ONE.equals(state)) {
			return "待审核";
		} else if (STATE_TWO.equals(state)) {
			return "同意采购";
		} else if (STATE_THREE.equals(state)) {
			return "同意退货";
		} else if (STATE_FOUR.equals(state)) {
			return "完成";
		} else if (STATE_FIVE.equals(state)) {
			return "未通过";
		} else if (STATE_SIX.equals(state)) {
			return "采购到货";
		} else if (STATE_SEVEN.equals(state)) {
			return "退货单未完成";
		}
		return "未知~";
	}

	/**
	 * @return the store 门店
	 */
	public Store getStore() {
		return store;
	}

	/**
	 * @param store
	 *            the store（门店） to set
	 */
	public void setStore(Store store) {
		this.store = store;
	}

	/**
	 * @return the procurementGoodsList 采购（采购退货）产品
	 */
	public List<ProcurementGoods> getProcurementGoodsList() {
		return procurementGoodsList;
	}

	/**
	 * @param procurementGoodsList
	 *            the procurementGoodsList（采购（采购退货）产品） to set
	 */
	public void setProcurementGoodsList(List<ProcurementGoods> procurementGoodsList) {
		this.procurementGoodsList = procurementGoodsList;
	}

	/**
	 * @return the type_value_lest
	 */
	public String getType_value_lest() {
		if (TYPE_ONE.equals(type)) {
			return "采购";
		} else if (TYPE_TWO.equals(type)) {
			return "退货";
		}
		return "未知~";
	}

	/**
	 * @return the procurementGoodsListNew 采购（采购退货）产品--新建
	 */
	public List<ProcurementGoods> getProcurementGoodsListNew() {
		return procurementGoodsListNew;
	}

	/**
	 * @param procurementGoodsListNew
	 *            the procurementGoodsListNew（采购（采购退货）产品--新建） to set
	 */
	public void setProcurementGoodsListNew(List<ProcurementGoods> procurementGoodsListNew) {
		this.procurementGoodsListNew = procurementGoodsListNew;
	}

	/**
	 * @return the procurementGoodsListDel 采购（采购退货）产品--删除
	 */
	public List<ProcurementGoods> getProcurementGoodsListDel() {
		return procurementGoodsListDel;
	}

	/**
	 * @param procurementGoodsListDel
	 *            the procurementGoodsListDel（采购（采购退货）产品--删除） to set
	 */
	public void setProcurementGoodsListDel(List<ProcurementGoods> procurementGoodsListDel) {
		this.procurementGoodsListDel = procurementGoodsListDel;
	}

	/**
	 * @return the checkRemark 审核不通过原因
	 */
	public String getCheckRemark() {
		return checkRemark;
	}

	/**
	 * @param checkRemark
	 *            the checkRemark（审核不通过原因） to set
	 */
	public void setCheckRemark(String checkRemark) {
		this.checkRemark = checkRemark;
	}

	/**
	 * @return the buyCount 实到件数总计
	 */
	public String getBuyCount() {
		return buyCount;
	}

	/**
	 * @param buyCount
	 *            the buyCount（实到件数总计） to set
	 */
	public void setBuyCount(String buyCount) {
		this.buyCount = buyCount;
	}

	/**
	 * @return the buySumMoney 实到金额总计
	 */
	public String getBuySumMoney() {
		return buySumMoney;
	}

	/**
	 * @param buySumMoney
	 *            the buySumMoney（实到金额总计） to set
	 */
	public void setBuySumMoney(String buySumMoney) {
		this.buySumMoney = buySumMoney;
	}

	/**
	 * @return the shipType
	 */
	public String getShipType() {
		return shipType;
	}

	/**
	 * @param shipType
	 *            the shipType to set
	 */
	public void setShipType(String shipType) {
		this.shipType = shipType;
	}

	/**
	 * @return the fu_string
	 */
	public String getFu_string() {
		return fu_string;
	}

	/**
	 * @param fu_string
	 *            the fu_string to set
	 */
	public void setFu_string(String fu_string) {
		this.fu_string = fu_string;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Procurement [id=" + id + ", type=" + type + ", vende=" + vende + ", procurementCode=" + procurementCode
				+ ", count=" + count + ", sumMoney=" + sumMoney + ", state=" + state + ", user=" + user
				+ ", procurementDate=" + procurementDate + ", isDelete=" + isDelete + ", remark=" + remark
				+ ", createTime=" + createTime + ", ft=" + ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu
				+ ", startDate=" + startDate + ", endDate=" + endDate + "]";
	}

}
