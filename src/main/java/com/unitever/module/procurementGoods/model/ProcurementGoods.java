package com.unitever.module.procurementGoods.model;

import java.util.Date;

import org.apache.commons.lang.StringUtils;

import com.unitever.module.goods.model.Goods;
import com.unitever.module.procurement.model.Procurement;
import com.unitever.platform.util.DoubleUtil;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.procurementGoods.model->ProcurementGoods
 * .java
 * </p>
 * <P>
 * 采购（退货）产品
 * </p>
 *
 * @author 闫枫
 * @date Jul 7, 2017
 */
public class ProcurementGoods {
	/** Id */
	private String id;
	/** 采购单 */
	private Procurement procurement;
	/** 商品 */
	private Goods goods;
	/** 采购申请数量 */
	private String count;
	/** 采购到货数量 */
	private String buyCount;
	/** 采购单价 */
	private String buyPrice;
	/** 采购总价 */
	private String buySumMoney;
	/** 采购折扣 */
	private String buyAgio;
	/** 销售单价 */
	private String salseMoney;
	/** 销售折扣 */
	private String salseAgio;
	/** 产品吊牌价 */
	private String goodsPrice;
	/** 已打印数量 */
	private String printCount;
	/** 是否打印(1：未打印，2：已打印) */
	private String isPrint;
	/** 是否入库（1：未入库，2：已入库 ps：写到这里的时候再考虑和二维码的关联） */
	private String isRecord;
	/** 印刷人ID列表字符串 */
	private String printUserID_string;
	/** 创建时间 */
	private Date createTime;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用
	/** 印刷人ID列表对应的名字字符串 */
	private String printUser_String;

	/** 是否可以继续打印 */
	private String isNeedPrint;

	public ProcurementGoods() {
		super();
	}

	public ProcurementGoods(String id) {
		super();
		this.id = id;
	}

	public ProcurementGoods(String id, Procurement procurement, Goods goods, String count, String buyPrice,
			String isPrint, String isRecord, Date createTime) {
		super();
		this.id = id;
		this.procurement = procurement;
		this.goods = goods;
		this.count = count;
		this.buyPrice = buyPrice;
		this.isPrint = isPrint;
		this.isRecord = isRecord;
		this.createTime = createTime;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Procurement getProcurement() {
		return procurement;
	}

	public void setProcurement(Procurement procurement) {
		this.procurement = procurement;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	/**
	 * @return the buyPrice 采购单价
	 */
	public String getBuyPrice() {
		return buyPrice;
	}

	/**
	 * @param buyPrice
	 *            the buyPrice(采购单价) to set
	 */
	public void setBuyPrice(String buyPrice) {
		this.buyPrice = buyPrice;
	}

	/**
	 * @return the buyAgio
	 */
	public String getBuyAgio() {
		return buyAgio;
	}

	/**
	 * @param buyAgio
	 *            the buyAgio to set
	 */
	public void setBuyAgio(String buyAgio) {
		this.buyAgio = buyAgio;
	}

	/**
	 * @return the salseMoney 销售单价
	 */
	public String getSalseMoney() {
		return salseMoney;
	}

	/**
	 * @param salseMoney
	 *            the salseMoney(销售单价 ) to set
	 */
	public void setSalseMoney(String salseMoney) {
		this.salseMoney = salseMoney;
	}

	/**
	 * @return the salseAgio
	 */
	public String getSalseAgio() {
		return salseAgio;
	}

	/**
	 * @param salseAgio
	 *            the salseAgio to set
	 */
	public void setSalseAgio(String salseAgio) {
		this.salseAgio = salseAgio;
	}

	/**
	 * @return the goodsPrice 产品吊牌价
	 */
	public String getGoodsPrice() {
		return goodsPrice;
	}

	/**
	 * @param goodsPrice
	 *            the goodsPrice(产品吊牌价) to set
	 */
	public void setGoodsPrice(String goodsPrice) {
		this.goodsPrice = goodsPrice;
	}

	public String getIsPrint() {
		return isPrint;
	}

	public void setIsPrint(String isPrint) {
		this.isPrint = isPrint;
	}

	public String getIsRecord() {
		return isRecord;
	}

	public void setIsRecord(String isRecord) {
		this.isRecord = isRecord;
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
	 * @return the buyCount 采购到货数量
	 */
	public String getBuyCount() {
		return buyCount;
	}

	/**
	 * @param buyCount
	 *            the buyCount（采购到货数量） to set
	 */
	public void setBuyCount(String buyCount) {
		this.buyCount = buyCount;
	}

	/**
	 * @return the printCount 已打印数量
	 */
	public String getPrintCount() {
		return printCount;
	}

	/**
	 * @param printCount
	 *            the printCount（已打印数量） to set
	 */
	public void setPrintCount(String printCount) {
		this.printCount = printCount;
	}

	/**
	 * @return the printUserID_string 印刷人ID列表字符串
	 */
	public String getPrintUserID_string() {
		return printUserID_string;
	}

	/**
	 * @param printUserID_string
	 *            the printUserID_string to（印刷人ID列表字符串） set
	 */
	public void setPrintUserID_string(String printUserID_string) {
		this.printUserID_string = printUserID_string;
	}

	/**
	 * @return the printUser_String 印刷人ID列表对应的名字字符串
	 */
	public String getPrintUser_String() {
		return printUser_String;
	}

	/**
	 * @param printUser_String
	 *            the printUser_String（印刷人ID列表对应的名字字符串） to set
	 */
	public void setPrintUser_String(String printUser_String) {
		this.printUser_String = printUser_String;
	}

	/**
	 * @return the isNeedPrint 是否可以继续打印
	 */
	public String getIsNeedPrint() {
		if (StringUtils.isBlank(printCount)) {
			return "yes";
		} else if (Integer.parseInt(printCount) < Integer.parseInt(buyCount)) {
			return "yes";
		}
		return "no";
	}

	/**
	 * @return the buySumMoney
	 */
	public String getBuySumMoney() {
		if (Procurement.STATE_FOUR.equals(procurement.getState())
				|| Procurement.STATE_SIX.equals(procurement.getState())) {
			if (StringUtils.isNotBlank(buyCount) && StringUtils.isNotBlank(buyPrice)) {
				return DoubleUtil.mul(buyCount, buyPrice, 2).toString();
			} else {
				return "0";
			}
		} else {
			if (StringUtils.isNotBlank(count) && StringUtils.isNotBlank(buyPrice)) {
				return DoubleUtil.mul(count, buyPrice, 2).toString();
			} else {
				return "0";
			}
		}

	}

	@Override
	public String toString() {
		return "ProcurementGoods [id=" + id + ", procurement=" + procurement + ", goods=" + goods + ", count=" + count
				+ ", buyPrice=" + buyPrice + ", isPrint=" + isPrint + ", isRecord=" + isRecord + ", createTime="
				+ createTime + ", ft=" + ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu + "]";
	}

}
