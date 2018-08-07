package com.unitever.module.consume.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.consume.model.Consume;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class ConsumeDAO extends BaseDAO<Consume, String> {

	/**
	 * 根据Object获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param Goods
	 * @return List<Consume>
	 */
	public List<Consume> getConsumeByConsume(Consume consume) {
		return this.getList("getConsumeByConsume", consume);
	}

	/**
	 * 获取符合当前条件的Consume数量
	 * 
	 * @author XiaoYu
	 * @date 2016年12月28日
	 * @param Goods
	 * @return int
	 */
	public int getCountByConsume(Consume consume) {
		return this.get("getCountByConsume", consume);
	}

	/**
	 *
	 * <P>
	 * 获取type为1,2的Consume数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月14日
	 * @param consume
	 * @return List<Consume>
	 */
	public List<Consume> getConsumeByConsumeForType(Consume consume) {
		return this.getList("getConsumeByConsumeForType", consume);
	}

	/**
	 *
	 * <P>
	 * 根据用户获取交易流水记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月2日
	 * @param customerId
	 * @return List<Consume>
	 */
	public List<Consume> getConsumeByCustomerId(String customerId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("customerId", customerId);
		return this.getList("getConsumeByCustomerId", params);
	}
}
