package com.unitever.module.storeBonus.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.storeBonus.dao.manual.StoreBonusDAO;
import com.unitever.module.storeBonus.model.StoreBonus;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.storeBonus.service->
 * StoreBonusService.java
 * </p>
 * <P>
 * 充值返现比例
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月5日
 */
@Service
@Transactional
public class StoreBonusService {

	@Autowired
	private StoreBonusDAO storeBonusDAO;

	/**
	 *
	 * <P>
	 * 保存新信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param storeBonus
	 * @return int
	 */
	public int save(StoreBonus storeBonus) {
		if (storeBonus != null) {
			storeBonus.setId(UUID.getUUID());
			storeBonus.setCreateTime(new Date());
			int i = storeBonusDAO.save(storeBonus);
			if (0 < i) {
				return i;
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 更新数据
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param storeBonus
	 * @return int
	 */
	public int update(StoreBonus storeBonus) {
		if (null != storeBonus) {
			if (StringUtils.isNotBlank(storeBonus.getId())) {
				int i = storeBonusDAO.update(storeBonus);
				if (0 < i) {
					return i;
				}
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 根据Id获取
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return StoreBonus
	 */
	public StoreBonus getStoreBonusById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return storeBonusDAO.get(id);
		}
		return null;
	}

	/**
	 *
	 * <P>
	 * 根据Object获取
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param storeBonus
	 * @return List<StoreBonus>
	 */
	public List<StoreBonus> getStoreBonusByStoreBonus(StoreBonus storeBonus) {
		return storeBonusDAO.getStoreBonusByStoreBonus(storeBonus);
	}

	/**
	 *
	 * <P>
	 * 获取符合当前条件的StoreBonus数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param storeBonus
	 * @return int
	 */
	public int getCountByStoreBonus(StoreBonus storeBonus) {
		return storeBonusDAO.getCountByStoreBonus(storeBonus);
	}

	/**
	 *
	 * <P>
	 * 获取所有提成比例
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @return List<StoreBonus>
	 */
	public List<StoreBonus> getAll() {
		return storeBonusDAO.getAll();
	}

	/**
	 *
	 * <P>
	 * 获取余额流水记录分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param page
	 * @param storeBonus
	 * @return Page<StoreBonus>
	 */
	public Page<StoreBonus> getPage(Page<StoreBonus> page, StoreBonus storeBonus) {
		page.setTotalRecord(storeBonusDAO.getCountByObject(storeBonus));
		storeBonus.setStartOfPage(page.getStartOfPage());
		storeBonus.setPageSize(page.getPageSize());
		page.setResults(storeBonusDAO.getStoreBonusByStoreBonus(storeBonus));
		return page;
	}

	/**
	 *
	 * <P>
	 * 删除余额流水记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param id
	 * @return int
	 */
	public int deleteStoreBonus(String id) {
		if (StringUtils.isNotBlank(id)) {
			return storeBonusDAO.delete(id);
		}
		return 0;
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
		return storeBonusDAO.getProportionByStartMoney(startMoney);
	}

}
