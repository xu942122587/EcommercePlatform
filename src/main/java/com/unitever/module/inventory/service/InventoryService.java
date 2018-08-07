package com.unitever.module.inventory.service;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.inventory.dao.manual.InventoryDAO;
import com.unitever.module.inventory.model.Inventory;
import com.unitever.module.inventory.vo.InventoryVO;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

@Service
@Transactional
public class InventoryService {
	@Autowired
	private InventoryDAO inventoryDAO;

	/**
	 *
	 * <P>
	 * 根据Id获取库存信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param id
	 * @return inventory
	 */
	public Inventory getInventoryById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return inventoryDAO.get(id);
		}
		return null;
	}

	/**
	 *
	 * <P>
	 * 根据库存信息获取库存信息列表
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param inventory
	 * @return List<inventory>
	 */
	public List<Inventory> getInventoryByInventory(Inventory inventory) {
		return inventoryDAO.getInventoryByInventory(inventory);
	}

	/**
	 *
	 * <P>
	 * 依据主产品ID获取子产品的库存
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月13日
	 * @param id
	 * @return List<Inventory>
	 */
	public List<Inventory> getGoodsChildInventoryListByGoodsId(String id, String storageId) {
		return inventoryDAO.getGoodsChildInventoryListByGoodsId(id, storageId);
	}

	/**
	 *
	 * <P>
	 * 获取符合当前条件的库存信息数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param inventory
	 * @return int
	 */
	public int getCountByInventory(Inventory inventory) {
		return inventoryDAO.getCountByInventory(inventory);
	}

	/**
	 *
	 * <P>
	 * 获取库存信息分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param page
	 * @param inventory
	 * @return Page<inventory>
	 */
	public Page<InventoryVO> getPage(Page<InventoryVO> page, InventoryVO inventoryVO) {
		page.setTotalRecord(inventoryDAO.getCountByInventoryVO(inventoryVO));
		inventoryVO.setStartOfPage(page.getStartOfPage());
		inventoryVO.setPageSize(page.getPageSize());
		page.setResults(inventoryDAO.getInventoryVOList(inventoryVO));
		return page;
	}

	/**
	 *
	 * <P>
	 * 获取所有库存信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @return List<inventory>
	 */
	public List<Inventory> getAllInventory() {
		return inventoryDAO.getAll();
	}

	/**
	 *
	 * <P>
	 * 依据产品ID和库房Id获取库存记录条数
	 * </p>
	 * 
	 * @author 闫枫
	 * @date Jul 12, 2017
	 * @param goodsId
	 *            产品ID
	 * @param storageId
	 *            库房ID
	 * @return int 记录条数
	 */
	public int getInventoryCountByGoodsIdAndStorageId(String goodsId, String storageId) {
		if (StringUtils.isNotBlank(storageId) && StringUtils.isNotBlank(goodsId))
			return inventoryDAO.getInventoryCountByGoodsIdAndStorageId(goodsId, storageId);
		return 0;
	}

	/**
	 *
	 * <P>
	 * 依据产品ID和库房Id增加库存量、库存金额
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 12, 2017
	 * @param goodsId
	 *            产品Id
	 * @param storageId
	 *            库房ID
	 * @param number
	 *            更改数量
	 * @param money
	 *            更改金额，计算好后传入
	 * @return int
	 */
	public int getAddInventoryNumberByGoodsIdAndStorageId(String goodsId, String storageId, String number, String money) {
		if (StringUtils.isNotBlank(goodsId) && StringUtils.isNotBlank(storageId) && StringUtils.isNotBlank(number)
				&& StringUtils.isNotBlank(money))
			return inventoryDAO.getAddInventoryNumberByGoodsIdAndStorageId(goodsId, storageId, number, money);
		return 0;
	}

	/**
	 *
	 * <P>
	 * 依据产品ID和库房Id减少库存量、库存金额
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 12, 2017
	 * @param goodsId
	 *            产品Id
	 * @param storageId
	 *            库房ID
	 * @param number
	 *            更改数量
	 * @param money
	 *            更改金额，计算好后传入
	 * @return int
	 */
	public int getSubInventoryNumberByGoodsIdAndStorageId(String goodsId, String storageId, String number, String money) {
		if (StringUtils.isNotBlank(goodsId) && StringUtils.isNotBlank(storageId) && StringUtils.isNotBlank(number)
				&& StringUtils.isNotBlank(money))
			return inventoryDAO.getSubInventoryNumberByGoodsIdAndStorageId(goodsId, storageId, number, money);
		return 0;
	}

	/**
	 *
	 * <P>
	 * 保存库存记录
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 12, 2017
	 * @param inventory
	 * @return int
	 */
	public int save(Inventory inventory) {
		if (null != inventory) {
			inventory.setId(UUID.getUUID());
			return inventoryDAO.save(inventory);
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 获取所有库存记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月19日
	 * @return List<InventoryVO>
	 */
	public List<InventoryVO> getInventoryVOList(InventoryVO inventoryVO) {
		return inventoryDAO.getInventoryVOList(inventoryVO);
	}

	/**
	 *
	 * <P>
	 * 依据产品ID和仓库Id获取单商品的库存
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月22日
	 * @param goodsId
	 * @param storageId
	 * @return Inventory
	 */
	public Inventory getGoodsInventoryByGoodsIdAndStorageId(String goodsId, String storageId) {
		return inventoryDAO.getGoodsInventoryByGoodsIdAndStorageId(goodsId, storageId);
	}

	/**
	 *
	 * <P>
	 * 获取所有库存数量金额记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年10月14日
	 * @param inventoryVO
	 * @return InventoryVO
	 */
	public InventoryVO getSumInventoryVOList(InventoryVO inventoryVO) {
		return inventoryDAO.getSumInventoryVOList(inventoryVO);
	}
}