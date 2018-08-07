package com.unitever.module.storage.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.storage.dao.manual.StorageDAO;
import com.unitever.module.storage.model.Storage;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.storage.service->StorageService.java
 * </p>
 * <P>
 * 仓库Services
 * </p>
 *
 * @author 闫枫
 * @date Jul 3, 2017
 */
@Service
@Transactional
public class StorageService {

	@Autowired
	private StorageDAO storageDAO;

	/**
	 * 保存新信息
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param storage
	 *            void
	 */
	public int save(Storage storage) {
		if (storage != null) {
			storage.setId(UUID.getUUID());
			storage.setCreateTime(new Date());
			storage.setState(Storage.STATE_NO_STOP);
			storage.setIsDelete(Storage.ISDELETE_NO);
			if (null != storage.getStore()) {
				if (StringUtils.isBlank(storage.getStore().getId())) {
					storage.setStore(null);
				}
			}
			int i = storageDAO.save(storage);
			if (0 < i) {
				return i;
			}
		}
		return 0;
	}

	/**
	 * 更新数据
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param storage
	 * @return int
	 */
	public int update(Storage storage) {
		if (null != storage) {
			if (StringUtils.isNotBlank(storage.getId())) {
				if (null != storage.getStore()) {
					if (StringUtils.isBlank(storage.getStore().getId())) {
						storage.setStore(null);
					}
				}
				int i = storageDAO.update(storage);
				if (0 < i) {
					return i;
				}
			}
		}
		return 0;
	}

	/**
	 * 根据Id获取
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return Storage
	 */
	public Storage getStorageById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return storageDAO.get(id);
		}
		return null;
	}

	/**
	 * 根据Object获取
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param storage
	 * @return List<Storage>
	 */
	public List<Storage> getStorageByStorage(Storage storage) {
		return storageDAO.getStorageByStorage(storage);
	}

	/**
	 * 获取符合当前条件的Storage数量
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param storage
	 * @return int
	 */
	public int getCountByStorage(Storage storage) {
		return storageDAO.getCountByStorage(storage);
	}

	/**
	 *
	 * <P>
	 * 获取所有仓库
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 1, 2017
	 * @return Object
	 */
	public List<Storage> getAll() {
		return storageDAO.getAll();
	}

	/**
	 *
	 * <P>
	 * 获取storage分页对象
	 * </p>
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param page
	 * @param storage
	 * @return Page<Storage>
	 */
	public Page<Storage> getPage(Page<Storage> page, Storage storage) {
		if (StringUtils.isNotBlank(storage.getEndDate())) {
			storage.setEndDate(storage.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(storageDAO.getCountByObject(storage));
		storage.setStartOfPage(page.getStartOfPage());
		storage.setPageSize(page.getPageSize());
		page.setResults(storageDAO.getStorageByStorage(storage));
		if (StringUtils.isNotBlank(storage.getEndDate())) {
			storage.setEndDate(storage.getEndDate().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 删除仓库--假删除
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return int
	 */
	public int deleteStorage(String id) {
		if (StringUtils.isNotBlank(id)) {
			Storage storage = new Storage(id);
			storage.setIsDelete(Storage.ISDELETE_YES);
			return storageDAO.update(storage);
		}
		return 0;
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
		return storageDAO.storageStop(id);
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
		return storageDAO.storageStart(id);
	}

	/**
	 *
	 * <P>
	 * 依据门店ID获取所属门店可用仓库列表（和该门店关联的仓库以及公共库）
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 13, 2017
	 * @param id
	 * @return Object
	 */
	public List<Storage> getAllStoreStorageList(String storeId) {
		return storageDAO.getAllStoreStorageList(storeId);
	}

}
