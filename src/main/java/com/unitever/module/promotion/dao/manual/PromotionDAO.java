package com.unitever.module.promotion.dao.manual;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.unitever.module.promotion.model.Promotion;
import com.unitever.platform.core.dao.BaseDAO;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.promotion.dao.manual-> PromotionDAO.java
 * </p>
 * <P>
 * 促销活动Dao
 * </p>
 *
 * @author 闫枫
 * @date Jun 29, 2017
 */
@Repository
public class PromotionDAO extends BaseDAO<Promotion, String> {
	/**
	 *
	 * <P>
	 * 依据促销活动对象获取促销活动List
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param promotion
	 * @return List<Promotion>
	 */
	public List<Promotion> getPromotionByPromotion(Promotion promotion) {
		return this.getList("getPromotionByPromotion", promotion);
	}

	/**
	 *
	 * <P>
	 * 依据促销活动对象获取促销活动统计数
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param promotion
	 * @return int
	 */
	public int getCountByPromotion(Promotion promotion) {
		return this.get("getCountByPromotion", promotion);
	}

	/**
	 *
	 * <P>
	 * 批量删除
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param list
	 * @return int
	 */
	public int batchDelete(List<Promotion> list) {
		return this.batchUpdate("delete", list);
	}
}
