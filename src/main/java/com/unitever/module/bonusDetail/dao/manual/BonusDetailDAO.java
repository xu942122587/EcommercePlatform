package com.unitever.module.bonusDetail.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.bonusDetail.model.BonusDetail;
import com.unitever.platform.core.dao.BaseDAO;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.bonusDetail.dao.manual->
 * BonusDetailDAO.java
 * </p>
 * <P>
 * 注册奖励
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月5日
 */
@Repository
public class BonusDetailDAO extends BaseDAO<BonusDetail, String> {

	/**
	 *
	 * <P>
	 * 注册奖励
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param bonusDetail
	 * @return List<BonusDetail>
	 */
	public List<BonusDetail> getBonusDetailByBonusDetail(BonusDetail bonusDetail) {
		return this.getList("getBonusDetailByBonusDetail", bonusDetail);
	}

	/**
	 *
	 * <P>
	 * 注册奖励
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param bonusDetail
	 * @return int
	 */
	public int getCountByBonusDetail(BonusDetail bonusDetail) {
		return this.get("getCountByBonusDetail", bonusDetail);
	}

	/**
	 *
	 * <P>
	 * 根据用户分组获取充值提成记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param bonusDetail
	 * @return List<BonusDetail>
	 */
	public List<BonusDetail> getBonusDetailGroupByGuideUser(BonusDetail bonusDetail) {
		return this.getList("getBonusDetailGroupByGuideUser", bonusDetail);
	}

	/**
	 *
	 * <P>
	 * 根据GuideUserId获取提成记录详情
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param bonusDetail
	 * @return List<BonusDetail>
	 */
	public List<BonusDetail> getBonusDetailByGuideUserId(String guideUserId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("guideUserId", guideUserId);
		return this.getList("getBonusDetailByGuideUserId", map);
	}

	/**
	 *
	 * <P>
	 * 导购销售总额
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月6日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return String
	 */
	public String getBonusDetailSumTargetMoney(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.get("getBonusDetailSumTargetMoney", map);
	}

	/**
	 *
	 * <P>
	 * 导购提成
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月6日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return String
	 */
	public String getBonusDetailSumMoney(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.get("getBonusDetailSumMoney", map);
	}

	/**
	 *
	 * <P>
	 * 导购销售排行
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月6日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return Map<String,Map<String,Object>>
	 */
	public Map<String, Map<String, Object>> getSumMoneyUserMap(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.getSqlSession().selectMap("getSumMoneyUserMap", map, "userName");
	}

	/**
	 *
	 * <P>
	 * 导购销售排行
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年5月9日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return List<String>
	 */
	public List<String> getSumMoneyUserList(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.getList("getSumMoneyUserList", map);
	}
}
