package com.unitever.module.consumeBonusDetail.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.consumeBonusDetail.model.ConsumeBonusDetail;
import com.unitever.platform.core.dao.BaseDAO;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.consumeBonusDetail.dao.manual->
 * ConsumeBonusDetailDAO.java
 * </p>
 * <P>
 * 注册奖励
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月5日
 */
@Repository
public class ConsumeBonusDetailDAO extends BaseDAO<ConsumeBonusDetail, String> {

	/**
	 *
	 * <P>
	 * 注册奖励
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param consumeBonusDetail
	 * @return List<ConsumeBonusDetail>
	 */
	public List<ConsumeBonusDetail> getConsumeBonusDetailByConsumeBonusDetail(ConsumeBonusDetail consumeBonusDetail) {
		return this.getList("getConsumeBonusDetailByConsumeBonusDetail", consumeBonusDetail);
	}

	/**
	 *
	 * <P>
	 * 注册奖励
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param consumeBonusDetail
	 * @return int
	 */
	public int getCountByConsumeBonusDetail(ConsumeBonusDetail consumeBonusDetail) {
		return this.get("getCountByConsumeBonusDetail", consumeBonusDetail);
	}

	/**
	 *
	 * <P>
	 * 根据用户分组获取充值提成记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param consumeBonusDetail
	 * @return List<ConsumeBonusDetail>
	 */
	public List<ConsumeBonusDetail> getConsumeBonusDetailGroupByGuideUser(ConsumeBonusDetail consumeBonusDetail) {
		return this.getList("getConsumeBonusDetailGroupByGuideUser", consumeBonusDetail);
	}

	/**
	 *
	 * <P>
	 * 根据GuideUserId获取提成记录详情
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param consumeBonusDetail
	 * @return List<ConsumeBonusDetail>
	 */
	public List<ConsumeBonusDetail> getConsumeBonusDetailByGuideUserId(String guideUserId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("guideUserId", guideUserId);
		return this.getList("getConsumeBonusDetailByGuideUserId", params);
	}

	/**
	 *
	 * <P>
	 * 充值总额
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月6日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return String
	 */
	public String getConsumeBonusDetailSumTargetMoney(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.get("getConsumeBonusDetailSumTargetMoney", map);
	}

	/**
	 *
	 * <P>
	 * 充值提成
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月6日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return String
	 */
	public String getConsumeBonusDetailSumMoney(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.get("getConsumeBonusDetailSumMoney", map);
	}
}
