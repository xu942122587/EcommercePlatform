package com.unitever.module.allocationQrcode.model;

import java.util.Date;

import com.unitever.module.allocation.model.Allocation;
import com.unitever.module.goods.model.Goods;
import com.unitever.module.qrcode.model.Qrcode;
import com.unitever.platform.core.dao.BaseModel;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.allocationQrcode.model->AllocationQrcode
 * .java
 * </p>
 * <P>
 * 调拨库存二维码
 * </p>
 *
 * @author 徐昊
 * @date 2017年7月15日
 */
public class AllocationQrcode extends BaseModel {
	/** Id */
	private String id;
	/** 数量统计 */
	private String qrcodeCount;
	/** 调拨单 */
	private Allocation allocation;
	/** 调拨商品 */
	private Goods goods;
	/** 商品二维码 */
	private Qrcode qrcode;
	/** 调出仓库库存 */
	private Integer outStorageCount;
	/** 调入仓库库存 */
	private Integer inStorageCount;
	/** 创建时间 */
	private Date createTime;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用

	public AllocationQrcode() {
		super();
	}

	public AllocationQrcode(String id) {
		super();
		this.id = id;
	}

	public AllocationQrcode(String id, Allocation allocation, Goods goods, Qrcode qrcode, Date createTime) {
		super();
		this.id = id;
		this.allocation = allocation;
		this.goods = goods;
		this.qrcode = qrcode;
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
	 * @return the allocation 调拨单
	 */
	public Allocation getAllocation() {
		return allocation;
	}

	/**
	 * @param allocation
	 *            the allocation 调拨单 to set
	 */
	public void setAllocation(Allocation allocation) {
		this.allocation = allocation;
	}

	/**
	 * @return the goods 调拨商品
	 */
	public Goods getGoods() {
		return goods;
	}

	/**
	 * @param goods
	 *            the goods 调拨商品 to set
	 */
	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	/**
	 * @return the qrcode 商品二维码
	 */
	public Qrcode getQrcode() {
		return qrcode;
	}

	/**
	 * @param qrcode
	 *            the qrcode 商品二维码 to set
	 */
	public void setQrcode(Qrcode qrcode) {
		this.qrcode = qrcode;
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
	 * @return the outStorageCount
	 */
	public Integer getOutStorageCount() {
		return outStorageCount;
	}

	/**
	 * @param outStorageCount
	 *            the outStorageCount to set
	 */
	public void setOutStorageCount(Integer outStorageCount) {
		this.outStorageCount = outStorageCount;
	}

	/**
	 * @return the inStorageCount
	 */
	public Integer getInStorageCount() {
		return inStorageCount;
	}

	/**
	 * @param inStorageCount
	 *            the inStorageCount to set
	 */
	public void setInStorageCount(Integer inStorageCount) {
		this.inStorageCount = inStorageCount;
	}

	/**
	 * @return the qrcodeCount
	 */
	public String getQrcodeCount() {
		return qrcodeCount;
	}

	/**
	 * @param qrcodeCount
	 *            the qrcodeCount to set
	 */
	public void setQrcodeCount(String qrcodeCount) {
		this.qrcodeCount = qrcodeCount;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "AllocationQrcode [id=" + id + ", allocation=" + allocation + ", goods=" + goods + ", qrcode=" + qrcode
				+ ", createTime=" + createTime + ", ft=" + ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu + "]";
	}

}
