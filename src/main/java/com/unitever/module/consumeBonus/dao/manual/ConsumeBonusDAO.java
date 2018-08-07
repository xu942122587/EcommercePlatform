package com.unitever.module.consumeBonus.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.consumeBonus.model.ConsumeBonus;
import com.unitever.platform.core.dao.BaseDAO;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.consumeBonus.dao.manual->ConsumeBonusDAO
 * .java
 * </p>
 * <P>
 * 充值提成比例
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月10日
 */
@Repository
public class ConsumeBonusDAO extends BaseDAO<ConsumeBonus, String> {

	/**
	 *
	 * <P>
	 * 根据金额获取提成档位
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月18日
	 * @param startMoney
	 * @return ConsumeBonus
	 */
	public ConsumeBonus getProportionByStartMoney(String startMoney) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("startMoney", startMoney);
		return this.get("getProportionByStartMoney", params);
	}

	/**
	 *
	 * <P>
	 * 依据导购提成比例对象获取list
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 1, 2017
	 * @param consumeBonus
	 * @return List<ConsumeBonus>
	 */
	public List<ConsumeBonus> getConsumeBonusByConsumeBonus(ConsumeBonus consumeBonus) {
		return this.getList("getConsumeBonusByConsumeBonus", consumeBonus);
	}

	/**
	 *
	 * <P>
	 * 依据导购提成比例对象获取统计数
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 1, 2017
	 * @param consumeBonus
	 * @return int
	 */
	public int getCountByConsumeBonus(ConsumeBonus consumeBonus) {
		return this.get("getCountByConsumeBonus", consumeBonus);
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
	public int batchInsert(List<ConsumeBonus> list) {
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
	public int batchUpdate(List<ConsumeBonus> list) {
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
	public int batchDelete(List<ConsumeBonus> list) {
		return this.batchDelete("delete", list);
	}

}
