package com.unitever.module.promotionLadder.dao.manual;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.unitever.module.promotionLadder.model.PromotionLadder;
import com.unitever.platform.core.dao.BaseDAO;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.promotionLadder.dao.manual->
 * PromotionLadderDAO.java
 * </p>
 * <P>
 * 活动阶梯条件Dao
 * </p>
 *
 * @author 闫枫
 * @date Jun 29, 2017
 */
@Repository
public class PromotionLadderDAO extends BaseDAO<PromotionLadder, String> {
	/**
	 *
	 * <P>
	 * 依据活动阶梯条件对象获取活动阶梯条件List
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param promotionLadder
	 * @return List<PromotionLadder>
	 */
	public List<PromotionLadder> getPromotionLadderByPromotionLadder(PromotionLadder promotionLadder) {
		return this.getList("getPromotionLadderByPromotionLadder", promotionLadder);
	}

	/**
	 *
	 * <P>
	 * 依据活动阶梯条件对象获取活动阶梯条件统计数
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param promotionLadder
	 * @return int
	 */
	public int getCountByPromotionLadder(PromotionLadder promotionLadder) {
		return this.get("getCountByPromotionLadder", promotionLadder);
	}

	/**
	 *
	 * <P>
	 * 批量保存
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param list
	 * @return int
	 */
	public int batchInsert(List<PromotionLadder> list) {
		return this.batchInsert("save", list);
	}

	/**
	 *
	 * <P>
	 * 批量更新
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param list
	 * @return int
	 */
	public int batchUpdate(List<PromotionLadder> list) {
		return this.batchUpdate("update", list);
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
	public int batchDelete(List<PromotionLadder> list) {
		return this.batchUpdate("delete", list);
	}
}
