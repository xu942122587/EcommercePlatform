package com.unitever.module.store.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.store.model.Store;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class StoreDAO extends BaseDAO<Store, String> {

	/**
	 * 根据Object获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param Store
	 * @return List<Store>
	 */
	public List<Store> getStoreByStore(Store store) {
		return this.getList("getStoreByStore", store);
	}

	/**
	 * 获取符合当前条件的Store数量
	 * 
	 * @author XiaoYu
	 * @date 2016年12月28日
	 * @param Store
	 * @return int
	 */
	public int getCountByStore(Store store) {
		return this.get("getCountByStore", store);
	}

	/**
	 *
	 * <P>
	 * 门店停业
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 30, 2017
	 * @param id
	 * @return int
	 */
	public int storeStop(String id) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		return this.update("storeStop", map);
	}

	/**
	 *
	 * <P>
	 * 门店营业
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 30, 2017
	 * @param id
	 * @return int
	 */
	public int storeStart(String id) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		return this.update("storeStart", map);
	}

	/**
	 *
	 * <P>
	 * 获取所有营业门店
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @return List<Store>
	 */
	public List<Store> getAllStartStore() {
		return this.getList("getAllStartStore");
	}

	/**
	 *
	 * <P>
	 * 获取所有商家店
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @return List<Store>
	 */
	public List<Store> getAllNoTianheStore() {
		return this.getList("getAllNoTianheStore");
	}

	/**
	 *
	 * <P>
	 * 根据用户购物车获取其商品所属门店
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月28日
	 * @param customerId
	 * @return List<Store>
	 */
	public List<Store> getStoreByCustomerId(String customerId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("customerId", customerId);
		return this.getList("getStoreByCustomerId", map);
	}

	/**
	 *
	 * <P>
	 * 获取所有直营店和小商品店
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 8, 2017
	 * @return List<Store>
	 */
	public List<Store> getAllTianheStore() {
		return this.getList("getAllTianheStore");
	}

	/**
	 *
	 * <P>
	 * 依据门店code获取门店
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 12, 2017
	 * @param storeCode
	 * @return Object
	 */
	public Store getStoreByStoreCode(String storeCode) {
		Map<String, String> map = new HashMap<>();
		map.put("storeCode", storeCode);
		return this.get("getStoreByStoreCode", map);
	}
}
