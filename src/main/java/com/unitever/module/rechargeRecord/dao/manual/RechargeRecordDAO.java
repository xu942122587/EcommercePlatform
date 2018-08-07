package com.unitever.module.rechargeRecord.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.rechargeRecord.model.RechargeRecord;
import com.unitever.platform.core.dao.BaseDAO;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.rechargeRecord.dao.manual->
 * RechargeRecordDAO.java
 * </p>
 * <P>
 * 注册奖励
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月5日
 */
@Repository
public class RechargeRecordDAO extends BaseDAO<RechargeRecord, String> {

	/**
	 *
	 * <P>
	 * 充值金额统计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月2日
	 * @param startDate
	 * @param endDate
	 * @return String
	 */
	public String getRechargeSumMoney(String startDate, String endDate) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		return this.get("getRechargeSumMoney", map);
	}

	/**
	 *
	 * <P>
	 * 充值返现金额统计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月2日
	 * @param startDate
	 * @param endDate
	 * @return String
	 */
	public String getRechargeBackCashSumMoney(String startDate, String endDate) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		return this.get("getRechargeBackCashSumMoney", map);
	}

	/**
	 *
	 * <P>
	 * 根据导购获取上月的充值总金额
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param rechargeRecord
	 * @return List<RechargeRecord>
	 */
	public String getRechargeRecordByGuideUserInLastMonth(String guideUserId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("guideUserId", guideUserId);
		return this.get("getRechargeRecordByGuideUserInLastMonth", map);
	}

	/**
	 *
	 * <P>
	 * 注册奖励
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param rechargeRecord
	 * @return List<RechargeRecord>
	 */
	public List<RechargeRecord> getRechargeRecordByRechargeRecord(RechargeRecord rechargeRecord) {
		return this.getList("getRechargeRecordByRechargeRecord", rechargeRecord);
	}

	/**
	 *
	 * <P>
	 * 根据支付方式获取充值记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param rechargeRecord
	 * @return List<RechargeRecord>
	 */
	public List<RechargeRecord> getRechargeRecordByPayType(RechargeRecord rechargeRecord) {
		return this.getList("getRechargeRecordByPayType", rechargeRecord);
	}

	/**
	 *
	 * <P>
	 * 注册奖励
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param rechargeRecord
	 * @return int
	 */
	public int getCountByRechargeRecord(RechargeRecord rechargeRecord) {
		return this.get("getCountByRechargeRecord", rechargeRecord);
	}

	/**
	 *
	 * <P>
	 * 充值完成更新
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param rechargeRecord
	 * @return int
	 */
	public int updatePay(RechargeRecord rechargeRecord) {
		return this.update("updatePay", rechargeRecord);
	}

	/**
	 *
	 * <P>
	 * 交接班-充值记录统计
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 17, 2017
	 * @param cashierUser_id
	 *            收银ID
	 * @param start_time
	 * @return Map<String,Map<String,Object>>
	 */
	public Map<String, Map<String, Object>> getRechargeCountMap(String cashierUser_id, String start_time,
			String end_time) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("cashierUser_id", cashierUser_id);
		map.put("start_time", start_time);
		map.put("end_time", end_time);
		return this.getSqlSession().selectMap("getRechargeCountMap", map, "payType");
	}
}
