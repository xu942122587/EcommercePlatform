package com.unitever.module.registerBonus.dao.manual;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.unitever.module.registerBonus.model.RegisterBonus;
import com.unitever.platform.core.dao.BaseDAO;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.registerBonus.dao.manual->
 * RegisterBonusDAO.java
 * </p>
 * <P>
 * 注册奖励
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月5日
 */
@Repository
public class RegisterBonusDAO extends BaseDAO<RegisterBonus, String> {

	/**
	 *
	 * <P>
	 * 注册奖励
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param registerBonus
	 * @return List<RegisterBonus>
	 */
	public List<RegisterBonus> getRegisterBonusByRegisterBonus(RegisterBonus registerBonus) {
		return this.getList("getRegisterBonusByRegisterBonus", registerBonus);
	}

	/**
	 *
	 * <P>
	 * 注册奖励
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param registerBonus
	 * @return int
	 */
	public int getCountByRegisterBonus(RegisterBonus registerBonus) {
		return this.get("getCountByRegisterBonus", registerBonus);
	}

	/**
	 *
	 * <P>
	 * 获取充值比例(第一条)
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 19, 2017
	 * @return RegisterBonus
	 */
	public RegisterBonus getFirstRegisterBonus() {
		return this.get("getFirstRegisterBonus", null);
	}

}
