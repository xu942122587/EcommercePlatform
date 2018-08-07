package com.unitever.module.storeBonusDetail.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.storeBonusDetail.model.StoreBonusDetail;
import com.unitever.platform.core.dao.BaseDAO;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.storeBonusDetail.dao.manual->
 * StoreBonusDetailDAO.java
 * </p>
 * <P>
 * 商家店服务费记录
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月5日
 */
@Repository
public class StoreBonusDetailDAO extends BaseDAO<StoreBonusDetail, String> {

	/**
	 *
	 * <P>
	 * 注册奖励
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param storeBonusDetail
	 * @return List<StoreBonusDetail>
	 */
	public List<StoreBonusDetail> getStoreBonusDetailByStoreBonusDetail(StoreBonusDetail storeBonusDetail) {
		return this.getList("getStoreBonusDetailByStoreBonusDetail", storeBonusDetail);
	}

	/**
	 *
	 * <P>
	 * 注册奖励
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param storeBonusDetail
	 * @return int
	 */
	public int getCountByStoreBonusDetail(StoreBonusDetail storeBonusDetail) {
		return this.get("getCountByStoreBonusDetail", storeBonusDetail);
	}

	/**
	 *
	 * <P>
	 * 根据商家店分组获取销售服务费记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param storeBonusDetail
	 * @return List<StoreBonusDetail>
	 */
	public List<StoreBonusDetail> getStoreBonusDetailGroupByStore(StoreBonusDetail storeBonusDetail) {
		return this.getList("getStoreBonusDetailGroupByStore", storeBonusDetail);
	}

	/**
	 *
	 * <P>
	 * 根据StoreId获取服务费记录详情
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param storeBonusDetail
	 * @return List<StoreBonusDetail>
	 */
	public List<StoreBonusDetail> getStoreBonusDetailByStoreId(String storeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("storeId", storeId);
		return this.getList("getStoreBonusDetailByStoreId", map);
	}

	/**
	 *
	 * <P>
	 * 商家店销售额统计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月6日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return String
	 */
	public String getStoreBonusDetailTargetMoneySumMoney(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.get("getStoreBonusDetailTargetMoneySumMoney", map);
	}

	/**
	 *
	 * <P>
	 * 商家店服务费统计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月6日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return String
	 */
	public String getStoreBonusDetailSumMoney(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.get("getStoreBonusDetailSumMoney", map);
	}

	/**
	 *
	 * <P>
	 * 商家店业绩排行
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月6日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return Map<String,Map<String,Object>>
	 */
	public Map<String, Map<String, Object>> getGroupByStoreBonusDetailStoreMap(String startDate, String endDate) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		return this.getSqlSession().selectMap("getGroupByStoreBonusDetailStoreMap", map, "storeCode");
	}

	/**
	 *
	 * <P>
	 * 商家店业绩排行
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年5月9日
	 * @param startDate
	 * @param endDate
	 * @return List<String>
	 */
	public List<String> getGroupByStoreBonusDetailStoreList(String startDate, String endDate) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		return this.getList("getGroupByStoreBonusDetailStoreList", map);
	}
}
