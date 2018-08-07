package com.unitever.module.procurement.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.procurement.model.Procurement;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class ProcurementDAO extends BaseDAO<Procurement, String> {

	/**
	 * 根据Object获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param Qrcode
	 * @return List<Procurement>
	 */
	public List<Procurement> getProcurementByProcurement(Procurement procurement) {
		return this.getList("getProcurementByProcurement", procurement);
	}

	/**
	 * 获取符合当前条件的Procurement数量
	 * 
	 * @author XiaoYu
	 * @date 2016年12月28日
	 * @param Qrcode
	 * @return int
	 */
	public int getCountByProcurement(Procurement procurement) {
		return this.get("getCountByProcurement", procurement);
	}

	/**
	 *
	 * <P>
	 * 依据订单Code获取采购单
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 13, 2017
	 * @param proCode
	 * @return List<Procurement>
	 */
	public Procurement getProcurementByProCode(String proCode) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("proCode", proCode);
		return this.get("getProcurementByProCode", map);
	}

	/**
	 *
	 * <P>
	 * 门店采购统计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月5日
	 * @param startDate
	 * @param endDate
	 * @return Map<String,Map<String,Object>>
	 */
	public Map<String, Map<String, Object>> getOneTypeSumMoneyAndCountMap(String startDate, String endDate) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		return this.getSqlSession().selectMap("getOneTypeSumMoneyAndCountMap", map, "storeId");
	}

	/**
	 *
	 * <P>
	 * 门店采购退货统计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月5日
	 * @param startDate
	 * @param endDate
	 * @return Map<String,Map<String,Object>>
	 */
	public Map<String, Map<String, Object>> getTwoTypeSumMoneyAndCountMap(String startDate, String endDate) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		return this.getSqlSession().selectMap("getTwoTypeSumMoneyAndCountMap", map, "storeId");
	}
}
