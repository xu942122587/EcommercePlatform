package com.unitever.module.promotionGroup.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.promotionGroup.model.PromotionGroup;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class PromotionGroupDAO extends BaseDAO<PromotionGroup, String> {

	/**
	 *
	 * <P>
	 * 获取符合条件的活动组列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 2, 2017
	 * @param promotionGroup
	 * @return List<PromotionGroup>
	 */
	public List<PromotionGroup> getPromotionGroupByPromotionGroup(PromotionGroup promotionGroup) {
		return this.getList("getPromotionGroupByPromotionGroup", promotionGroup);
	}

	/**
	 *
	 * <P>
	 * 获取符合条件的活动组数量
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 2, 2017
	 * @param promotionGroup
	 * @return int
	 */
	public int getCountByPromotionGroup(PromotionGroup promotionGroup) {
		return this.get("getCountByPromotionGroup", promotionGroup);
	}

	/**
	 *
	 * <P>
	 * 检查活动组是否可保存
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 8, 2017
	 * @param promotionGroup
	 * @return int
	 */
	public int checkGroupIsNeedSave(PromotionGroup promotionGroup) {
		return this.get("checkGroupIsNeedSave", promotionGroup);
	}

	/**
	 *
	 * <P>
	 * 获取线上线下互斥的记录条数
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 8, 2017
	 * @param proStartDate
	 * @param proEndDate
	 * @param isOnline
	 * @return int
	 */
	public int getIsOnlineCount(PromotionGroup promotionGroup) {
		return this.get("getIsOnlineCount", promotionGroup);
	}

	/**
	 *
	 * <P>
	 * 获取支付方式互斥统计数
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 8, 2017
	 * @param promotionGroup
	 * @return int
	 */
	public int getPayTypeCount(PromotionGroup promotionGroup) {
		return this.get("getPayTypeCount", promotionGroup);
	}

	/**
	 *
	 * <P>
	 * 依据门店ID获取活动分组信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 10, 2017
	 * @param storeId
	 *            门店ID
	 * @param payType
	 *            支付方式
	 * @param isOnline
	 *            线上线下
	 * @return List<PromotionGroup>
	 */
	public List<PromotionGroup> getAllPromotionGroupByStoreId(String storeId, String payType, String isOnline) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("storeId", storeId);
		map.put("payType", payType);
		map.put("isOnline", isOnline);
		return this.getList("getAllPromotionGroupByStoreId", map);
	}

	/**
	 *
	 * <P>
	 * 依据商家店门店ID获取活动分组信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 10, 2017
	 * @param storeId
	 *            门店ID
	 * @param payType
	 *            支付方式
	 * @param isOnline
	 *            线上线下
	 * @return List<PromotionGroup>
	 */
	public List<PromotionGroup> getAllPromotionGroupByNoTianheStoreId(String storeId, String payType, String isOnline) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("storeId", storeId);
		map.put("payType", payType);
		map.put("isOnline", isOnline);
		return this.getList("getAllPromotionGroupByNoTianheStoreId", map);
	}

	/**
	 *
	 * <P>
	 * 获取叠加活动组
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 19, 2017
	 * @return List<PromotionGroup>
	 */
	public List<PromotionGroup> getNoScopeGroup() {
		return this.getList("getNoScopeGroup");
	}

	/**
	 *
	 * <P>
	 * 线下：依据门店ID获取活动分组信息中支付方式列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 19, 2017
	 * @return List<String>
	 */
	public String getProGroupPayTypesByStoreId(String storeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("storeId", storeId);
		return this.get("getProGroupPayTypesByStoreId", map);
	}

	/**
	 *
	 * <P>
	 * 线下：依据商家店门店ID获取活动分组信息中支付方式列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 19, 2017
	 * @return List<String>
	 */
	public String getProGroupPayTypesByNoTianheStoreId(String storeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("storeId", storeId);
		return this.get("getProGroupPayTypesByNoTianheStoreId", map);
	}
}
