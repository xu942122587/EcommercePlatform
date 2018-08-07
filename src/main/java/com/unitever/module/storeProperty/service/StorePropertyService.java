package com.unitever.module.storeProperty.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.store.model.Store;
import com.unitever.module.storeProperty.dao.manual.StorePropertyDAO;
import com.unitever.module.storeProperty.model.StoreProperty;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.storeProperty.service->CustomerService.
 * java
 * </p>
 * <P>
 * 门店固定资产Services
 * </p>
 *
 * @author 闫枫
 * @date Jun 29, 2017
 */
@Service
@Transactional
public class StorePropertyService {

	@Autowired
	private StorePropertyDAO storePropertyDAO;

	/**
	 * 保存新信息
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param storeProperty
	 *            void
	 */
	public int save(StoreProperty storeProperty) {
		if (storeProperty != null) {
			storeProperty.setId(UUID.getUUID());
			storeProperty.setCreateTime(new Date());
			int i = storePropertyDAO.save(storeProperty);
			return i;
		}
		return 0;
	}

	/**
	 * 更新数据
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param storeProperty
	 * @return int
	 */
	public int update(StoreProperty storeProperty) {
		if (null != storeProperty) {
			if (StringUtils.isNotBlank(storeProperty.getId())) {
				int i = storePropertyDAO.update(storeProperty);
				return i;
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
	 * @return StoreProperty
	 */
	public StoreProperty getStorePropertyById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return storePropertyDAO.get(id);
		}
		return null;
	}

	/**
	 * 根据Object获取
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param storeProperty
	 * @return List<StoreProperty>
	 */
	public List<StoreProperty> getStorePropertyByStoreProperty(StoreProperty storeProperty) {
		return storePropertyDAO.getStorePropertyByStoreProperty(storeProperty);
	}

	/**
	 * 获取符合当前条件的StoreProperty数量
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param storeProperty
	 * @return int
	 */
	public int getCountByStoreProperty(StoreProperty storeProperty) {
		return storePropertyDAO.getCountByStoreProperty(storeProperty);
	}

	/**
	 *
	 * <P>
	 * 获取storeProperty分页对象
	 * </p>
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param page
	 * @param storeProperty
	 * @return Page<StoreProperty>
	 */
	public Page<StoreProperty> getPage(Page<StoreProperty> page, StoreProperty storeProperty) {
		if (StringUtils.isNotBlank(storeProperty.getEndDate())) {
			storeProperty.setEndDate(storeProperty.getEndDate() + " 23:59:59");
		}
		List<StoreProperty> storePropertyhandList = storePropertyDAO.getStorePropertyByStoreProperty(storeProperty);
		if (StringUtils.isNotBlank(storeProperty.getEndDate())) {
			storeProperty.setEndDate(storeProperty.getEndDate().split(" ")[0]);
		}
		page.setTotalRecord(storePropertyhandList.size());
		if (storePropertyhandList.size() >= (page.getStartOfPage() + page.getPageSize())) {
			page.setResults(
					storePropertyhandList.subList(page.getStartOfPage(), page.getStartOfPage() + page.getPageSize()));
		} else {
			page.setResults(storePropertyhandList.subList(page.getStartOfPage(), storePropertyhandList.size()));
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 依据门店ID获取门店固定资产list
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @return List<StoreProperty>
	 */
	public List<StoreProperty> getAllByStoreId(String storeId) {
		return StringUtils.isNotBlank(storeId) ? storePropertyDAO.getAllByStoreId(storeId) : null;
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
	 *            待保存的list
	 * @param storeId
	 *            门店ID，新建的门店必须传入，其他情况可传入null
	 * @return int
	 */
	public int batchInsert(List<StoreProperty> list, String storeId) {
		if (null != list) {
			if (!list.isEmpty()) {
				List<StoreProperty> list_to_save = new ArrayList<StoreProperty>();
				for (StoreProperty storeProperty : list) {
					System.err.println(storeProperty);
					if (StringUtils.isNotBlank(storeProperty.getName())
							&& StringUtils.isNotBlank(storeProperty.getNumber())) {
						if (null == storeProperty.getStore() || StringUtils.isBlank(storeProperty.getStore().getId())) {
							if (StringUtils.isNotBlank(storeId)) {
								storeProperty.setStore(new Store(storeId));
							}
						}
						list_to_save.add(storeProperty);
					}
				}
				list.clear();
				return storePropertyDAO.batchInsert(list_to_save);
			}
		}
		return 0;
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
		if (null != list) {
			if (!list.isEmpty()) {
				return storePropertyDAO.batchUpdate(list);
			}
		}
		return 0;
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
		if (null != list) {
			if (!list.isEmpty()) {
				return storePropertyDAO.batchDelete(list);
			}
		}
		return 0;
	}
}
