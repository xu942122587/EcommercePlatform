package com.unitever.module.checkstorage.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.checkstorage.dao.manual.CheckstorageDAO;
import com.unitever.module.checkstorage.model.Checkstorage;
import com.unitever.module.checkstorageGoods.dao.manual.CheckstorageGoodsDAO;
import com.unitever.module.checkstorageGoods.model.CheckstorageGoods;
import com.unitever.module.checkstorageGoods.service.CheckstorageGoodsService;
import com.unitever.module.inventory.service.InventoryService;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.OrderCodeID;
import com.unitever.platform.util.UUID;

@Service
@Transactional
public class CheckstorageService {

	@Autowired
	private CheckstorageDAO checkstorageDAO;
	@Autowired
	private CheckstorageGoodsDAO checkstorageGoodsDAO;
	@Autowired
	private CheckstorageGoodsService checkstorageGoodsService;
	@Autowired
	private InventoryService inventoryService;

	/**
	 *
	 * <P>
	 * 保存新库存盘点
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param checkstorage
	 * @return int
	 */
	public String save(Checkstorage checkstorage) {
		if (checkstorage != null) {
			checkstorage.setId(UUID.getUUID());
			checkstorage.setState(Checkstorage.STATE_TWO);
			checkstorage.setCode(OrderCodeID.nextCode());
			checkstorage.setCreateTime(new Date());
			checkstorageDAO.save(checkstorage);
			return checkstorage.getId();
		}
		return null;
	}

	/**
	 *
	 * <P>
	 * 更新库存盘点
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param checkstorage
	 * @return int
	 */
	public int update(Checkstorage checkstorage) {
		if (null != checkstorage) {
			if (StringUtils.isNotBlank(checkstorage.getId())) {
				int i = checkstorageDAO.update(checkstorage);
				return i;
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 根据Id获取库存盘点
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param id
	 * @return checkstorage
	 */
	public Checkstorage getCheckstorageById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return checkstorageDAO.get(id);
		}
		return null;
	}

	/**
	 *
	 * <P>
	 * 根据库存盘点获取库存盘点列表
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param checkstorage
	 * @return List<checkstorage>
	 */
	public List<Checkstorage> getCheckstorageByCheckstorage(Checkstorage checkstorage) {
		return checkstorageDAO.getCheckstorageByCheckstorage(checkstorage);
	}

	/**
	 *
	 * <P>
	 * 获取符合当前条件的库存盘点数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param checkstorage
	 * @return int
	 */
	public int getCountBycheckstorage(Checkstorage checkstorage) {
		return checkstorageDAO.getCountByObject(checkstorage);
	}

	/**
	 *
	 * <P>
	 * 获取库存盘点分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param page
	 * @param checkstorage
	 * @return Page<checkstorage>
	 */
	public Page<Checkstorage> getPage(Page<Checkstorage> page, Checkstorage checkstorage) {
		if (StringUtils.isNotBlank(checkstorage.getEndDate())) {
			checkstorage.setEndDate(checkstorage.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(checkstorageDAO.getCountByObject(checkstorage));
		checkstorage.setStartOfPage(page.getStartOfPage());
		checkstorage.setPageSize(page.getPageSize());
		page.setResults(checkstorageDAO.getCheckstorageByCheckstorage(checkstorage));
		if (StringUtils.isNotBlank(checkstorage.getEndDate())) {
			checkstorage.setEndDate(checkstorage.getEndDate().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 删除库存盘点
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param id
	 * @return int
	 */
	public int deleteCheckstorage(String id) {
		if (StringUtils.isNotBlank(id)) {
			return checkstorageDAO.delete(id);
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 获取所有库存盘点
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @return List<checkstorage>
	 */
	public List<Checkstorage> getAllCheckstorage() {
		return checkstorageDAO.getAll();
	}

	/**
	 *
	 * <P>
	 * 盘库对比
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param checkstorage
	 * @return int
	 */
	public int doCheckstorage(String checkstorageGoodsId, String checkstorage_checkNumber) {
		if (StringUtils.isNotBlank(checkstorageGoodsId) && StringUtils.isNotBlank(checkstorage_checkNumber)) {
			CheckstorageGoods checkstorageGoods = checkstorageGoodsService
					.getCheckstorageGoodsById(checkstorageGoodsId);
			checkstorageGoods.setCheckNumber(checkstorage_checkNumber);
			checkstorageGoods.setInventoryNumber(inventoryService.getGoodsInventoryByGoodsIdAndStorageId(
					checkstorageGoods.getGoods().getId(), checkstorageGoods.getCheckstorage().getStorage().getId())
					.getCount());
			checkstorageGoods
					.setProfitNumber(String.valueOf((Integer.parseInt(checkstorageGoods.getCheckNumber()) - Integer
							.parseInt(checkstorageGoods.getInventoryNumber()))));
			checkstorageGoods.setState(CheckstorageGoods.STATE_ONE);
			int i = checkstorageGoodsDAO.update(checkstorageGoods);
			return i;
		}
		return 0;
	}
}
