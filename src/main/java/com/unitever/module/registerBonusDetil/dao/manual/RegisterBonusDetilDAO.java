package com.unitever.module.registerBonusDetil.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.registerBonusDetil.model.RegisterBonusDetil;
import com.unitever.platform.core.dao.BaseDAO;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.registerBonusDetil.dao.manual->
 * RegisterBonusDetilDAO.java
 * </p>
 * <P>
 * 注册奖励
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月5日
 */
@Repository
public class RegisterBonusDetilDAO extends BaseDAO<RegisterBonusDetil, String> {

	/**
	 *
	 * <P>
	 * 注册奖励
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param registerBonusDetil
	 * @return List<RegisterBonusDetil>
	 */
	public List<RegisterBonusDetil> getRegisterBonusDetilByRegisterBonusDetil(RegisterBonusDetil registerBonusDetil) {
		return this.getList("getRegisterBonusDetilByRegisterBonusDetil", registerBonusDetil);
	}

	/**
	 *
	 * <P>
	 * 注册奖励
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param registerBonusDetil
	 * @return int
	 */
	public int getCountByRegisterBonusDetil(RegisterBonusDetil registerBonusDetil) {
		return this.get("getCountByRegisterBonusDetil", registerBonusDetil);
	}

	/**
	 *
	 * <P>
	 * 根据用户分组获取注册提成记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param registerBonusDetil
	 * @return List<RegisterBonusDetil>
	 */
	public List<RegisterBonusDetil> getRegisterBonusDetilGroupByGuideUser(RegisterBonusDetil registerBonusDetil) {
		return this.getList("getRegisterBonusDetilGroupByGuideUser", registerBonusDetil);
	}

	/**
	 *
	 * <P>
	 * 根据用户分组获取注册提成记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param registerBonusDetil
	 * @return List<RegisterBonusDetil>
	 */
	public List<RegisterBonusDetil> getRegisterBonusDetilByGuideUserId(String guideUserId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("guideUserId", guideUserId);
		return this.getList("getRegisterBonusDetilByGuideUserId", map);
	}

	/**
	 *
	 * <P>
	 * 推荐注册奖励金
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月6日
	 * @param startDate
	 * @param endDate
	 * @return String
	 */
	public String getRegisterBonusDetailSumMoney(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.get("getRegisterBonusDetailSumMoney", map);
	}

	/**
	 *
	 * <P>
	 * 推荐注册人数
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月6日
	 * @param startDate
	 * @param endDate
	 * @return String
	 */
	public String getRegisterBonusDetailSumCount(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.get("getRegisterBonusDetailSumCount", map);
	}
}
