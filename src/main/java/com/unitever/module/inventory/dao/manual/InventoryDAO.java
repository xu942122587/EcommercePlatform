package com.unitever.module.inventory.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.inventory.model.Inventory;
import com.unitever.module.inventory.vo.InventoryVO;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class InventoryDAO extends BaseDAO<Inventory, String> {

	/**
	 * 根据Object获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param Goods
	 * @return List<Inventory>
	 */
	public List<Inventory> getInventoryByInventory(Inventory inventory) {
		return this.getList("getInventoryByInventory", inventory);
	}

	/**
	 *
	 * <P>
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年1月29日
	 * @param inventoryVO
	 * @return int
	 */
	public int getCountByInventoryVO(InventoryVO inventoryVO) {
		return this.get("getCountByInventoryVO", inventoryVO);
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
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("storageId", storageId);
		return this.getList("getGoodsChildInventoryListByGoodsId", map);
	}

	/**
	 * 获取符合当前条件的Inventory数量
	 * 
	 * @author XiaoYu
	 * @date 2016年12月28日
	 * @param Goods
	 * @return int
	 */
	public int getCountByInventory(Inventory inventory) {
		return this.get("getCountByInventory", inventory);
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
	 * @param storageId
	 * @return int
	 */
	public int getInventoryCountByGoodsIdAndStorageId(String goodsId, String storageId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("goodsId", goodsId);
		map.put("storageId", storageId);
		return this.get("getInventoryCountByGoodsIdAndStorageId", map);
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
	 * @param storageId
	 * @return int
	 */
	public int getAddInventoryNumberByGoodsIdAndStorageId(String goodsId, String storageId, String number, String money) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("goodsId", goodsId);
		map.put("storageId", storageId);
		map.put("number", number);
		map.put("money", money);
		return this.update("getAddInventoryNumberByGoodsIdAndStorageId", map);
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
	 * @param storageId
	 * @return int
	 */
	public int getSubInventoryNumberByGoodsIdAndStorageId(String goodsId, String storageId, String number, String money) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("goodsId", goodsId);
		map.put("storageId", storageId);
		map.put("number", number);
		map.put("money", money);
		return this.update("getSubInventoryNumberByGoodsIdAndStorageId", map);
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
		return this.getList("getInventoryVOList", inventoryVO);
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
		return this.get("getSumInventoryVOList", inventoryVO);
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
		Map<String, String> map = new HashMap<String, String>();
		map.put("goodsId", goodsId);
		map.put("storageId", storageId);
		return this.get("getGoodsInventoryByGoodsIdAndStorageId", map);
	}

	/**
	 *
	 * <P>
	 * 单仓库库存总量及总金额统计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月5日
	 * @return Map<String,Map<String,Object>>
	 */
	public Map<String, Map<String, Object>> getSumMoneyAndCountByStorage() {
		return this.getSqlSession().selectMap("getSumMoneyAndCountByStorage", null, "storageId");
	}
}
