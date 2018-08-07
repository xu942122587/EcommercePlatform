package com.unitever.module.weChat.vo;

import java.util.List;

import com.unitever.module.goods.model.Goods;

public class GoodsPageVo {

	private int pageNo;
	private int totalRecord;// 总记录数
	private List<Goods> goodsList;// 对应的当前页记录
	private String isHave;

	public List<Goods> getGoodsList() {
		return goodsList;
	}

	public void setGoodsList(List<Goods> goodsList) {
		this.goodsList = goodsList;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}

	public String getIsHave() {
		return isHave;
	}

	public void setIsHave(String isHave) {
		this.isHave = isHave;
	}

}
