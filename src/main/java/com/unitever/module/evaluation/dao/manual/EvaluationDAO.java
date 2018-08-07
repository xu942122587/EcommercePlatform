package com.unitever.module.evaluation.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.evaluation.model.Evaluation;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class EvaluationDAO extends BaseDAO<Evaluation, String> {

	/**
	 * 根据Evaluation获取List
	 * 
	 * @author XiaoYu
	 * @date 2017年1月13日
	 * @param evaluation
	 * @return List<Evaluation>
	 */
	public List<Evaluation> getEvaluationListWithEvaluation(Evaluation evaluation) {
		return this.getList("getEvaluationListWithEvaluation", evaluation);
	}

	/**
	 * 根据goodsId获取List
	 * 
	 * @author XiaoYu
	 * @date 2017年1月13日
	 * @param goodsId
	 * @return List<Evaluation>
	 */
	public List<Evaluation> getEvaluationListByGoodsId(String goodsId) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("goodsId", goodsId);
		return this.getList("getEvaluationListByGoodsId", params);
	}
}
