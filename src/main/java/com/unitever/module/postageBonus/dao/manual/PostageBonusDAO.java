package com.unitever.module.postageBonus.dao.manual;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.unitever.module.postageBonus.model.PostageBonus;
import com.unitever.platform.core.dao.BaseDAO;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.postageBonus.dao.manual->PostageBonusDAO
 * .java
 * </p>
 * <P>
 * 充值提成比例
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月10日
 */
@Repository
public class PostageBonusDAO extends BaseDAO<PostageBonus, String> {

	/**
	 *
	 * <P>
	 * 依据导购提成比例对象获取list
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 1, 2017
	 * @param postageBonus
	 * @return List<PostageBonus>
	 */
	public List<PostageBonus> getPostageBonusByPostageBonus(PostageBonus postageBonus) {
		return this.getList("getPostageBonusByPostageBonus", postageBonus);
	}

	/**
	 *
	 * <P>
	 * 依据导购提成比例对象获取统计数
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 1, 2017
	 * @param postageBonus
	 * @return int
	 */
	public int getCountByPostageBonus(PostageBonus postageBonus) {
		return this.get("getCountByPostageBonus", postageBonus);
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
	public int batchInsert(List<PostageBonus> list) {
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
	public int batchUpdate(List<PostageBonus> list) {
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
	public int batchDelete(List<PostageBonus> list) {
		return this.batchDelete("delete", list);
	}

}
