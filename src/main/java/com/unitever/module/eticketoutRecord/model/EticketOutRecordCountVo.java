package com.unitever.module.eticketoutRecord.model;

import com.unitever.module.eticket.model.Eticket;
import com.unitever.module.goods.model.Goods;
import com.unitever.module.store.model.Store;

/**
 *
 * <P>
 * platform-channel->com.unitever.module.eticketoutRecord.model->
 * EticketOutRecordCountVo.java
 * </p>
 * <P>
 * 电子券发放记录统计用Vo
 * </p>
 *
 * @author 闫枫
 * @date Nov 21, 2016
 */
public class EticketOutRecordCountVo {
	private Goods goods;
	private Store store;
	private Eticket eticket;

	private String outEticketCount;// 发放总张数
	private String outEticketMoneyCount;// 发放总金额

	public EticketOutRecordCountVo() {
		super();
	}

	public EticketOutRecordCountVo(Goods goods, Store store, Eticket eticket, String outEticketCount,
			String outEticketMoneyCount) {
		super();
		this.goods = goods;
		this.store = store;
		this.eticket = eticket;
		this.outEticketCount = outEticketCount;
		this.outEticketMoneyCount = outEticketMoneyCount;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public Store getStore() {
		return store;
	}

	public void setStore(Store store) {
		this.store = store;
	}

	public Eticket getEticket() {
		return eticket;
	}

	public void setEticket(Eticket eticket) {
		this.eticket = eticket;
	}

	public String getOutEticketCount() {
		return outEticketCount;
	}

	public void setOutEticketCount(String outEticketCount) {
		this.outEticketCount = outEticketCount;
	}

	public String getOutEticketMoneyCount() {
		return outEticketMoneyCount;
	}

	public void setOutEticketMoneyCount(String outEticketMoneyCount) {
		this.outEticketMoneyCount = outEticketMoneyCount;
	}

}
