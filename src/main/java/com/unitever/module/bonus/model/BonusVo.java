package com.unitever.module.bonus.model;

import java.util.List;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.bonus.model->BonusVo.java
 * </p>
 * <P>
 * 导购提成比例Vo对象
 * </p>
 *
 * @author 闫枫
 * @date Jul 1, 2017
 */
public class BonusVo {

	/**
	 * 已有的list更新--导购提成比例
	 */
	private List<Bonus> bonuOldList;
	/**
	 * 新建的list--导购提成比例
	 */
	private List<Bonus> bonuNewList;
	/**
	 * 要删除的list--导购提成比例
	 */
	private List<Bonus> bonuDeleteList;

	/**
	 * @return the bonuOldList 已有的list更新--导购提成比例
	 */
	public List<Bonus> getBonuOldList() {
		return bonuOldList;
	}

	/**
	 * @param bonuOldList
	 *            the bonuOldList（已有的list更新--导购提成比例） to set
	 */
	public void setBonuOldList(List<Bonus> bonuOldList) {
		this.bonuOldList = bonuOldList;
	}

	/**
	 * @return the bonuNewList 新建的list--导购提成比例
	 */
	public List<Bonus> getBonuNewList() {
		return bonuNewList;
	}

	/**
	 * @param bonuNewList
	 *            the bonuNewList（新建的list--导购提成比例） to set
	 */
	public void setBonuNewList(List<Bonus> bonuNewList) {
		this.bonuNewList = bonuNewList;
	}

	/**
	 * @return the bonuDeleteList 新建的list--导购提成比例
	 */
	public List<Bonus> getBonuDeleteList() {
		return bonuDeleteList;
	}

	/**
	 * @param bonuDeleteList
	 *            the bonuDeleteList（新建的list--导购提成比例） to set
	 */
	public void setBonuDeleteList(List<Bonus> bonuDeleteList) {
		this.bonuDeleteList = bonuDeleteList;
	}

}
