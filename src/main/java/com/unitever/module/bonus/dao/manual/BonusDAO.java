package com.unitever.module.bonus.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.bonus.model.Bonus;
import com.unitever.platform.core.dao.BaseDAO;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.bonus.dao.manual->BonusDAO.java
 * </p>
 * <P>
 * 导购提成比例
 * </p>
 *
 * @author 闫枫
 * @date Jul 1, 2017
 */
@Repository
public class BonusDAO extends BaseDAO<Bonus, String> {

	/**
	 *
	 * <P>
	 * 根据金额获取提成档位
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月18日
	 * @param startMoney
	 * @return Bonus
	 */
	public Bonus getProportionByStartMoney(String startMoney) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startMoney", startMoney);
		return this.get("getProportionByStartMoney", map);
	}

	/**
	 *
	 * <P>
	 * 依据导购提成比例对象获取list
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 1, 2017
	 * @param bonus
	 * @return List<Bonus>
	 */
	public List<Bonus> getBonusByBonus(Bonus bonus) {
		return this.getList("getBonusByBonus", bonus);
	}

	/**
	 *
	 * <P>
	 * 依据导购提成比例对象获取统计数
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 1, 2017
	 * @param bonus
	 * @return int
	 */
	public int getCountByBonus(Bonus bonus) {
		return this.get("getCountByBonus", bonus);
	}

	/**
	 *
	 * <P>
	 * 批量保存
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param list
	 * @return int
	 */
	public int batchInsert(List<Bonus> list) {
		return this.batchInsert("save", list);
	}

	/**
	 *
	 * <P>
	 * 批量更新
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param list
	 * @return int
	 */
	public int batchUpdate(List<Bonus> list) {
		return this.batchUpdate("update", list);
	}

	/**
	 *
	 * <P>
	 * 批量删除
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param list
	 * @return int
	 */
	public int batchDelete(List<Bonus> list) {
		return this.batchDelete("delete", list);
	}

}
