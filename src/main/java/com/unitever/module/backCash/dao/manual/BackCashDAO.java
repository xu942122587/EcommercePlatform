package com.unitever.module.backCash.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.backCash.model.BackCash;
import com.unitever.platform.core.dao.BaseDAO;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.backCash.dao.manual->BackCashDAO.java
 * </p>
 * <P>
 * 充值返现比例
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月5日
 */
@Repository
public class BackCashDAO extends BaseDAO<BackCash, String> {

	/**
	 *
	 * <P>
	 * 充值返现比例
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param backCash
	 * @return List<BackCash>
	 */
	public List<BackCash> getBackCashByBackCash(BackCash backCash) {
		return this.getList("getBackCashByBackCash", backCash);
	}

	/**
	 *
	 * <P>
	 * 根据金额获取阶梯
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月9日
	 * @param money
	 * @return BackCash
	 */
	public BackCash getBackCashByMoney(String money) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("money", money);
		return this.get("getBackCashByMoney", map);
	}

	/**
	 *
	 * <P>
	 * 充值返现比例
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param backCash
	 * @return int
	 */
	public int getCountByBackCash(BackCash backCash) {
		return this.get("getCountByBackCash", backCash);
	}

}
