package com.unitever.module.classification.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.classification.model.Classification;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class ClassificationDAO extends BaseDAO<Classification, String> {

	public List<Classification> getChildrenClassificationList(String id) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		return this.getList("getChildrenClassificationList", params);
	}

	/**
	 *
	 * <P>
	 * 根据门店Id获取主类
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月26日
	 * @param storeId
	 * @return List<Classification>
	 */
	public List<Classification> getParentClassByStoreId(String storeId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("storeId", storeId);
		return this.getList("getParentClassByStoreId", params);
	}

	/**
	 *
	 * <P>
	 * 根据门店Id获取子类
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月26日
	 * @param storeId
	 * @return List<Classification>
	 */
	public List<Classification> getChildClassByStoreId(String storeId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("storeId", storeId);
		return this.getList("getChildClassByStoreId", params);
	}

	/**
	 *
	 * <P>
	 * 根据门店Id获取3级
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月26日
	 * @param storeId
	 * @return List<Classification>
	 */
	public List<Classification> getThreeClassByStoreId(String storeId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("storeId", storeId);
		return this.getList("getThreeClassByStoreId", params);
	}

	public Classification getClassificationWithName(String name) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("name", name);
		List<Classification> classificationList = this.getList("getClassificationWithName", name);
		return classificationList.size() > 0 ? classificationList.get(0) : null;
	}

	public List<Classification> getClassificationByClassification(Classification classification) {
		return this.getList("getClassificationByClassification", classification);
	}

	public List<Classification> getParentClassificationList() {
		return this.getList("getParentClassificationList");
	}

	public List<Classification> getClassificationListForAttr() {
		return this.getList("getClassificationListForAttr");
	}

}