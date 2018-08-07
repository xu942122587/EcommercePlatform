package com.unitever.module.procurementQrcode.model;

import java.util.Date;

import com.unitever.module.procurement.model.Procurement;
import com.unitever.module.qrcode.model.Qrcode;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.procurementQrcode.model->
 * ProcurementQrcode.java
 * </p>
 * <P>
 * 采购退货
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月11日
 */
public class ProcurementQrcode {
	/** Id */
	private String id;
	/** 采购退货单 */
	private Procurement procurement;
	/** 商品二维码 */
	private Qrcode qrcode;
	/** 创建时间 */
	private Date createTime;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用

	public ProcurementQrcode() {
		super();
	}

	public ProcurementQrcode(String id) {
		super();
		this.id = id;
	}

	public ProcurementQrcode(String id, Procurement procurement, Qrcode qrcode, Date createTime) {
		super();
		this.id = id;
		this.procurement = procurement;
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
	 * @return the procurement
	 */
	public Procurement getProcurement() {
		return procurement;
	}

	/**
	 * @param procurement
	 *            the procurement to set
	 */
	public void setProcurement(Procurement procurement) {
		this.procurement = procurement;
	}

	/**
	 * @return the qrcode
	 */
	public Qrcode getQrcode() {
		return qrcode;
	}

	/**
	 * @param qrcode
	 *            the qrcode to set
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "ProcurementQrcode [id=" + id + ", procurement=" + procurement + ", qrcode=" + qrcode + ", createTime="
				+ createTime + ", ft=" + ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu + "]";
	}

}
