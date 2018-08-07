package com.unitever.module.record.model;

import java.util.Date;

import com.unitever.module.qrcode.model.Qrcode;
import com.unitever.module.storage.model.Storage;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.record.model->Record.java
 * </p>
 * <P>
 * 入库记录
 * </p>
 *
 * @author 闫枫
 * @date Jul 12, 2017
 */
public class Record {

	/** Id */
	private String id;
	/** 二维码 */
	private Qrcode qrcode;
	/** 仓库ID */
	private Storage storage;
	/** 创建时间 */
	private Date createTime;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用

	public Record() {
		super();
	}

	public Record(String id) {
		super();
		this.id = id;
	}

	public Record(String id, Qrcode qrcode, Storage storage, Date createTime) {
		super();
		this.id = id;
		this.qrcode = qrcode;
		this.storage = storage;
		this.createTime = createTime;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public Storage getStorage() {
		return storage;
	}

	public void setStorage(Storage storage) {
		this.storage = storage;
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

	@Override
	public String toString() {
		return "Record [id=" + id + ", qrcode=" + qrcode + ", storage=" + storage + ", createTime=" + createTime
				+ ", ft=" + ft + ", lt=" + lt + ", fu=" + fu + ", lu=" + lu + "]";
	}

}
