package com.unitever.module.procurementGoods.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.procurementGoods.model.ProcurementGoods;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class ProcurementGoodsDAO extends BaseDAO<ProcurementGoods, String> {

	/**
	 * 根据Object获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param Goods
	 * @return List<ProcurementGoods>
	 */
	public List<ProcurementGoods> getProcurementGoodsByProcurementGoods(ProcurementGoods procurementGoods) {
		return this.getList("getProcurementGoodsByProcurementGoods", procurementGoods);
	}

	/**
	 * 获取符合当前条件的ProcurementGoods数量
	 * 
	 * @author XiaoYu
	 * @date 2016年12月28日
	 * @param Goods
	 * @return int
	 */
	public int getCountByProcurementGoods(ProcurementGoods procurementGoods) {
		return this.get("getCountByProcurementGoods", procurementGoods);
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
	public int batchInsert(List<ProcurementGoods> list) {
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
	public int batchUpdate(List<ProcurementGoods> list) {
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
	public int batchDelete(List<ProcurementGoods> list) {
		return this.batchDelete("delete", list);
	}

	/**
	 *
	 * <P>
	 * 依据采购单ID获取采购单商品明细list
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 8, 2017
	 * @param procurementId
	 * @return Object
	 */
	public List<ProcurementGoods> getAllByProcurementId(String procurementId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("procurementId", procurementId);
		return this.getList("getProcurementGoodsListByProcurementId", map);
	}

	/**
	 *
	 * <P>
	 * 更改已打印数量
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 17, 2017
	 * @param id
	 * @param number
	 * @return int
	 */
	public int updatePrintNumber(String id, int number, String printUserId) {
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("number", number);
		map.put("printUserId", printUserId);
		return this.update("updatePrintNumber", map);
	}
}
