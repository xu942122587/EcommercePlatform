package com.unitever.module.storeProperty.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.storeProperty.model.StoreProperty;
import com.unitever.platform.core.dao.BaseDAO;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.storeProperty.dao.manual->
 * StorePropertyDAO.java
 * </p>
 * <P>
 * 门店固定资产Dao
 * </p>
 *
 * @author 闫枫
 * @date Jun 29, 2017
 */
@Repository
public class StorePropertyDAO extends BaseDAO<StoreProperty, String> {
	/**
	 *
	 * <P>
	 * 依据门店固定资产对象获取门店固定资产List
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param storeProperty
	 * @return List<StoreProperty>
	 */
	public List<StoreProperty> getStorePropertyByStoreProperty(StoreProperty storeProperty) {
		return this.getList("getStorePropertyByStoreProperty", storeProperty);
	}

	/**
	 *
	 * <P>
	 * 依据门店固定资产对象获取门店固定资产统计数
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param storeProperty
	 * @return int
	 */
	public int getCountByStoreProperty(StoreProperty storeProperty) {
		return this.get("getCountByStoreProperty", storeProperty);
	}

	/**
	 *
	 * <P>
	 * 依据门店ID获取门店固定资产list
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param storeId
	 * @return List<StoreProperty>
	 */
	public List<StoreProperty> getAllByStoreId(String storeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("storeId", storeId);
		return this.getList("getAllByStoreId", map);
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
	public int batchInsert(List<StoreProperty> list) {
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
	public int batchUpdate(List<StoreProperty> list) {
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
	public int batchDelete(List<StoreProperty> list) {
		return this.batchUpdate("delete", list);
	}

}
