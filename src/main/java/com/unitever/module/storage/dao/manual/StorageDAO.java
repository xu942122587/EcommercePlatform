package com.unitever.module.storage.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.storage.model.Storage;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class StorageDAO extends BaseDAO<Storage, String> {

	/**
	 * 根据Object获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param Goods
	 * @return List<Storage>
	 */
	public List<Storage> getStorageByStorage(Storage storage) {
		return this.getList("getStorageByStorage", storage);
	}

	/**
	 * 获取符合当前条件的Storage数量
	 * 
	 * @author XiaoYu
	 * @date 2016年12月28日
	 * @param Goods
	 * @return int
	 */
	public int getCountByStorage(Storage storage) {
		return this.get("getCountByStorage", storage);
	}

	/**
	 *
	 * <P>
	 * 仓库停用
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 30, 2017
	 * @param id
	 * @return int
	 */
	public int storageStop(String id) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		return this.update("storageStop", map);
	}

	/**
	 *
	 * <P>
	 * 仓库启用
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 30, 2017
	 * @param id
	 * @return int
	 */
	public int storageStart(String id) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		return this.update("storageStart", map);
	}

	/**
	 *
	 * <P>
	 * 依据门店ID获取所属门店可用仓库列表（和该门店关联的仓库以及公共库）
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 13, 2017
	 * @param storeId
	 * @return List<Storage>
	 */
	public List<Storage> getAllStoreStorageList(String storeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("storeId", storeId);
		return this.getList("getAllStoreStorageList", map);
	}
}
