package com.unitever.module.eticketuseRecord.model;

import java.util.Date;

import com.unitever.module.eticketoutRecord.model.EticketOutRecord;
import com.unitever.module.order.model.Order;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.eticketuseRecord.model->EticketUseRecord
 * .java
 * </p>
 * <P>
 * 电子券使用记录
 * </p>
 *
 * @author 闫枫
 * @date Sep 7, 2017
 */
public class EticketUseRecord {

	/** 使用记录id */
	private String id;
	/** 使用订单 */
	private Order order;
	/** 使用的电子券 */
	private EticketOutRecord eticketOutRecord;
	/** 使用时间 */
	private Date createTime;
	private String ft;
	private String lt;
	private String fu;
	private String lu;

	public EticketUseRecord() {
		super();
	}

	public EticketUseRecord(String id) {
		super();
		this.id = id;
	}

	public EticketUseRecord(String id, Date createTime, Order order, EticketOutRecord eticketOutRecord) {
		super();
		this.id = id;
		this.createTime = createTime;
		this.order = order;
		this.eticketOutRecord = eticketOutRecord;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Date getCreateDate() {
		return createTime;
	}

	public void setCreateDate(Date createDate) {
		this.createTime = createDate;
	}

	/**
	 *
	 * <P>
	 * 使用电子券的订单（otherOrder）
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 7, 2017
	 * @return Order
	 */
	public Order getOrder() {
		return order;
	}

	/**
	 *
	 * <P>
	 * 使用电子券的订单（otherOrder）
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 7, 2017
	 * @param order
	 *            void
	 */
	public void setOrder(Order order) {
		this.order = order;
	}

	/**
	 *
	 * <P>
	 * 使用的电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 7, 2017
	 * @return EticketOutRecord
	 */
	public EticketOutRecord getEticketOutRecord() {
		return eticketOutRecord;
	}

	/**
	 *
	 * <P>
	 * 使用的电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 7, 2017
	 * @param eticketOutRecord
	 *            void
	 */
	public void setEticketOutRecord(EticketOutRecord eticketOutRecord) {
		this.eticketOutRecord = eticketOutRecord;
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

}
