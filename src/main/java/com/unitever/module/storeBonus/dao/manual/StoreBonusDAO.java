package com.unitever.module.storeBonus.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.storeBonus.model.StoreBonus;
import com.unitever.platform.core.dao.BaseDAO;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.storeBonus.dao.manual->StoreBonusDAO
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
public class StoreBonusDAO extends BaseDAO<StoreBonus, String> {

	/**
	 *
	 * <P>
	 * 依据导购提成比例对象获取list
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 1, 2017
	 * @param storeBonus
	 * @return List<StoreBonus>
	 */
	public List<StoreBonus> getStoreBonusByStoreBonus(StoreBonus storeBonus) {
		return this.getList("getStoreBonusByStoreBonus", storeBonus);
	}

	/**
	 *
	 * <P>
	 * 依据导购提成比例对象获取统计数
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 1, 2017
	 * @param storeBonus
	 * @return int
	 */
	public int getCountByStoreBonus(StoreBonus storeBonus) {
		return this.get("getCountByStoreBonus", storeBonus);
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
	public int batchInsert(List<StoreBonus> list) {
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
	public int batchUpdate(List<StoreBonus> list) {
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
	public int batchDelete(List<StoreBonus> list) {
		return this.batchDelete("delete", list);
	}

	/**
	 *
	 * <P>
	 * 根据金额获取提成档位
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月19日
	 * @param startMoney
	 * @return StoreBonus
	 */
	public StoreBonus getProportionByStartMoney(String startMoney) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startMoney", startMoney);
		return this.get("getProportionByStartMoney", map);
	}

}
