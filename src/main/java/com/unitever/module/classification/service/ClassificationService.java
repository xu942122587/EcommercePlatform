package com.unitever.module.classification.service;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;
import net.sf.json.util.PropertyFilter;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.classification.dao.manual.ClassificationDAO;
import com.unitever.module.classification.model.Classification;
import com.unitever.module.classification.model.ClassificationTree;
import com.unitever.module.classification.vo.ClassificationVO;
import com.unitever.module.goods.service.GoodsService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

/**
 * 
 * @author XiaoYu
 * @date 2017年4月24日
 */
@Transactional
@Service
public class ClassificationService {

	@Autowired
	private ClassificationDAO classificationDAO;
	@Autowired
	private GoodsService goodsService;

	Logger logger_classificationService = LoggerFactory.getLogger(this.getClass().getName());

	/**
	 * 保存
	 * 
	 * @author XiaoYu
	 * @date 2017年4月24日
	 * @param model
	 *            void
	 */
	public int save(Classification model) {
		if (null != model) {
			model.setId(UUID.getUUID());
			model.setIsVisible(Classification.VALUE_ISVISIBLE_TRUE);
			model.setState(Classification.VALUE_STATE_NORMAL);
			return classificationDAO.save(model);
		} else {
			logger_classificationService.error("保存失败 传入null");
		}
		return 0;
	}

	/**
	 * 更新
	 * 
	 * @author XiaoYu
	 * @date 2017年5月2日
	 * @param model
	 * @return int
	 */
	public int update(Classification model) {
		if (null != model) {
			if (StringUtils.isNotBlank(model.getId())) {
				return classificationDAO.update(model);
			}
		}
		logger_classificationService.error("更新 null");
		return 0;
	}

	/**
	 * 根据Id获取
	 * 
	 * @author XiaoYu
	 * @date 2017年5月2日
	 * @param id
	 * @return Classification
	 */
	public Classification getClassificationById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return classificationDAO.get(id);
		}
		logger_classificationService.error("获取失败 传入null");
		return null;
	}

	/**
	 *
	 * <P>
	 * 获取有自定义属性的类别
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月4日
	 * @return List<Classification>
	 */
	public List<Classification> getClassificationListForAttr() {
		return classificationDAO.getClassificationListForAttr();
	}

	/**
	 * 获取一级分类
	 * 
	 * @author XiaoYu
	 * @date 2017年4月24日
	 * @return List<Classification>
	 */
	public List<Classification> getParentClassificationList() {
		return classificationDAO.getParentClassificationList();
	}

	/**
	 * 根据父分类id获取子分类
	 * 
	 * @author XiaoYu
	 * @date 2017年4月25日
	 * @param parentId
	 * @return List<Classification>
	 */
	public List<Classification> getChildrenClassificationList(String parentId) {
		if (StringUtils.isNotBlank(parentId)) {
			return classificationDAO.getChildrenClassificationList(parentId);
		}
		logger_classificationService.error("传入null");
		return null;
	}

	/**
	 * 根据model获取List
	 * 
	 * @author XiaoYu
	 * @date 2017年4月25日
	 * @param model
	 * @return List<Classification>
	 */
	public List<Classification> getClassificationByClassification(Classification model) {
		if (null != model) {
			return classificationDAO.getClassificationByClassification(model);
		}
		logger_classificationService.error("传入0");
		return null;
	}

	/**
	 * 根据名称获取
	 * 
	 * @author XiaoYu
	 * @date 2017年4月25日
	 * @param name
	 * @return Classification
	 */
	public Classification getClassificationWithName(String name) {
		if (StringUtils.isNotBlank(name)) {
			return classificationDAO.getClassificationWithName(name);
		}
		logger_classificationService.error("传入null");
		return null;
	}

	/**
	 * 获取分类树
	 * 
	 * @author XiaoYu
	 * @date 2017年4月26日
	 * @return String
	 */
	public String getClassificationTree() {
		List<Classification> classificationList = this.getParentClassificationList();
		List<ClassificationTree> classTrees = new ArrayList<ClassificationTree>();

		if (classificationList.isEmpty()) {
			return null;
		}

		for (Classification classification : classificationList) {
			List<String> tags = new ArrayList<String>();
			ClassificationTree node = new ClassificationTree();
			node.setId(classification.getId());
			node.setIsHaveGoods(classification.getIsHaveGoods());
			node.setIsHaveAttr(classification.getOtherAttrJson());
			node.setText(classification.getName());
			node.setLevel(classification.getLevel());
			node.setIsVisible(classification.getIsVisible());
			tags.add(classification.getIsVisibleValue());
			node.setTags(tags);
			this.generateNode(classification, node);
			classTrees.add(node);
		}
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setJavaPropertyFilter(new PropertyFilter() {

			@Override
			public boolean apply(Object source, String name, Object value) {
				System.out.println(source + ":" + name + ":" + value);
				if (value == null || String.valueOf(value).equals("")) {
					return true;
				}
				return false;
			}

		});
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		// 过滤空nodes
		JSONArray jsonObj = removeEmptyNode(JSONArray.fromObject(classTrees, jsonConfig));

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("classification_", jsonObj);
		return jsonObject.toString();
	}

	/**
	 * 生成节点
	 * 
	 * @author XiaoYu
	 * @date 2017年4月28日
	 * @param classification
	 * @param node
	 * @return ClassificationTree
	 */
	public ClassificationTree generateNode(Classification classification, ClassificationTree node) {
		if (classification.getChildrenClassifications().isEmpty()) {
			return node;
		} else {
			if (null != classification.getParentClassification()) {
				node.setParentId(classification.getParentClassification().getId());
			}
			List<ClassificationTree> childClassTreeList = new ArrayList<ClassificationTree>();
			List<Classification> childClassList = classification.getChildrenClassifications();

			for (Classification childClass : childClassList) {
				List<String> tags = new ArrayList<String>();
				ClassificationTree childNode = new ClassificationTree();
				childNode.setId(childClass.getId());
				childNode.setIsHaveGoods(childClass.getIsHaveGoods());
				childNode.setIsHaveAttr(childClass.getOtherAttrJson());
				childNode.setText(childClass.getName());
				childNode.setLevel(childClass.getLevel());
				childNode.setIsVisible(childClass.getIsVisible());
				tags.add(childClass.getIsVisibleValue());
				childNode.setTags(tags);
				childClassTreeList.add(childNode);
				if (null != childClass.getParentClassification()) {
					childNode.setParentId(childClass.getParentClassification().getId());
				}
				node.setNodes(childClassTreeList);
				if (!childClass.getChildrenClassifications().isEmpty()) {
					this.generateNode(childClass, childNode);
				}

				if ((childClassList.indexOf(childClass) + 1) == childClassList.size()) {
					return node;
				}
			}
		}
		return new ClassificationTree();
	}

	/**
	 * 删除空node
	 * 
	 * @author XiaoYu
	 * @date 2017年4月28日
	 * @param jsonArray
	 * @return JSONArray
	 */
	public JSONArray removeEmptyNode(JSONArray jsonArray) {
		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject object = jsonArray.getJSONObject(i);
			JSONArray arry = object.getJSONArray("nodes");
			if (arry.size() <= 0) {
				object.remove("nodes");
				jsonArray.set(i, object);
			} else {
				for (int j = 0; j < arry.size(); j++) {
					JSONObject objectChild = arry.getJSONObject(j);
					JSONArray arryChild = objectChild.getJSONArray("nodes");
					if (arryChild.size() <= 0) {
						objectChild.remove("nodes");
						arry.set(j, objectChild);
					} else {
						this.removeEmptyNode(arryChild);
					}
				}
				object.remove("nodes");
				object.put("nodes", arry);
				jsonArray.set(i, object);
			}
		}
		return jsonArray;
	}

	/**
	 * 获取level
	 * 
	 * @author XiaoYu
	 * @date 2017年5月2日
	 * @param nodeId
	 * @return String
	 */
	public String getClassificationLevel(String nodeId) {
		if (StringUtils.isNotBlank(nodeId)) {
			Classification classification = getClassificationById(nodeId);
			if (null != classification) {
				int tmp = Integer.parseInt(classification.getLevel()) + 1;
				return String.valueOf(tmp);
			}
		}
		return "0";
	}

	/**
	 * 添加或更新
	 * 
	 * @author XiaoYu
	 * @date 2017年5月2日
	 * @param model
	 * @param flag
	 * @return AjaxJson
	 */
	public AjaxJson doAddOrUpdate(Classification model, String flag) {
		AjaxJson json = new AjaxJson();
		json.setSuccess(false);
		json.setMsg("保存失败，请重试");
		if ("add".equals(flag)) {
			int i = this.save(model);
			if (0 < i) {
				json.setMsg("保存成功");
				json.setSuccess(true);
			}
		} else if ("update".equals(flag)) {
			if (this.update(model) <= 0) {
				json.setMsg("更新失败，请重试");
			} else {
				json.setMsg(model.getName() + "分类更新成功！");
				json.setSuccess(true);
			}
		} else if ("delete".equals(flag)) {
			if (this.update(model) <= 0) {
				json.setMsg("删除失败，请重试");
			} else {
				goodsService.abnormalAllByclassificationId(model.getId());
				json.setMsg(model.getName() + "属性删除成功！");
				json.setSuccess(true);
			}
		} else if ("add_attr".equals(flag)) {
			if (this.update(model) <= 0) {
				json.setMsg("添加属性失败，请重试");
			} else {
				goodsService.abnormalAllByclassificationId(model.getId());
				json.setMsg(model.getName() + "属性添加成功！");
				json.setSuccess(true);
			}
		} else if ("update_attr".equals(flag)) {
			if (this.update(model) <= 0) {
				json.setMsg("修改属性失败，请重试");
			} else {
				goodsService.abnormalAllByclassificationId(model.getId());
				json.setMsg(model.getName() + "修改属性成功！");
				json.setSuccess(true);
			}
		}
		return json;
	}

	/**
	 * 删除分类
	 * 
	 * @author XiaoYu
	 * @date 2017年5月2日
	 * @param id
	 * @return AjaxJson
	 */
	public AjaxJson doDelete(String id) {
		AjaxJson json = new AjaxJson();
		json.setSuccess(false);

		if (StringUtils.isNotBlank(id)) {
			Classification model = getClassificationById(id);
			if (model.getChildrenClassifications().isEmpty()) {
				model.setState(Classification.VALUE_STATE_DELETE);
				if (this.update(model) <= 0) {
					json.setMsg("删除失败");
					logger_classificationService.error("返回0");
				} else {
					json.setSuccess(true);
					json.setMsg("删除成功");
				}
			} else {
				json.setMsg("删除失败，该分类有子分类");
			}
		} else {
			json.setMsg("删除失败");
		}

		return json;
	}

	/**
	 * 显示隐藏
	 * 
	 * @author XiaoYu
	 * @date 2017年5月3日
	 * @param id
	 * @return AjaxJson
	 */
	public AjaxJson showHideNode(String id) {
		AjaxJson json = new AjaxJson();
		json.setSuccess(false);

		if (StringUtils.isNotBlank(id)) {
			Classification model = getClassificationById(id);
			String tmp = "";
			if (Classification.VALUE_ISVISIBLE_TRUE.equals(model.getIsVisible())) {
				model.setIsVisible(Classification.VALUE_ISVISIBLE_FALSE);
				tmp = Classification.VALUE_ISVISIBLE_FALSE;
			} else if (Classification.VALUE_ISVISIBLE_FALSE.equals(model.getIsVisible())) {
				if (null != model.getParentClassification()) {
					if (Classification.VALUE_ISVISIBLE_FALSE.equals(model.getParentClassification().getIsVisible())) {
						json.setMsg("操作失败，上级分类已隐藏");
						return json;
					}
				}
				model.setIsVisible(Classification.VALUE_ISVISIBLE_TRUE);
				tmp = Classification.VALUE_ISVISIBLE_TRUE;
			}

			if (this.update(model) <= 0) {
				json.setMsg("操作失败");
				logger_classificationService.error("返回0");
				return json;
			} else {
				if (this.showHideChildNode(model, tmp) <= 0) {
					json.setMsg("操作失败");
					logger_classificationService.error("返回0");
					return json;
				}
				json.setMsg("操作成功");
				json.setSuccess(true);
			}
		} else {
			json.setMsg("参数丢失");
			logger_classificationService.error("传入null");
		}
		return json;
	}

	/**
	 * 显示隐藏子分类
	 * 
	 * @author XiaoYu
	 * @date 2017年5月3日
	 * @param model
	 * @param value
	 * @return int
	 */
	public int showHideChildNode(Classification model, String value) {
		List<Classification> childList = model.getChildrenClassifications();
		for (Classification childNode : childList) {
			childNode.setIsVisible(value);
			if (this.update(childNode) <= 0) {
				logger_classificationService.error("返回0");
				return 0;
			}
			if (!childNode.getChildrenClassifications().isEmpty()) {
				this.showHideChildNode(childNode, value);
			}
		}
		return 1;
	}

	/**
	 *
	 * <P>
	 * 将自定义属性JSON转为对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param classification
	 * @return List<ClassificationVO>
	 */
	public static List<ClassificationVO> getClassificationAttrForClassification(Classification classification) {
		if (null != classification) {
			String classAttr = "";
			if (StringUtils.isBlank(classification.getOtherAttrJson())) {
				return null;
			} else {
				classAttr = classification.getOtherAttrJson();
			}
			JSONArray classAttrJson = JSONArray.fromObject(classAttr);
			List<ClassificationVO> classAttrList = new ArrayList<ClassificationVO>();
			for (int i = 0; i < classAttrJson.size(); i++) {
				ClassificationVO classificationVO = new ClassificationVO();
				classificationVO.setClassification(classification);
				classificationVO.setAttrCode(classAttrJson.getJSONObject(i).getString("attrCode"));
				classificationVO.setAttr(classAttrJson.getJSONObject(i).getString("attr"));
				if (classAttrJson.getJSONObject(i).containsKey("childAttr")) {
					classificationVO.setChildAttr(classAttrJson.getJSONObject(i).getString("childAttr"));
				}
				classificationVO.setInputType(classAttrJson.getJSONObject(i).getString("inputType"));
				classificationVO.setIsRequired(classAttrJson.getJSONObject(i).getString("isRequired"));
				classAttrList.add(classificationVO);
			}
			return classAttrList;
		} else {
			return null;
		}
	}

	/**
	 *
	 * <P>
	 * page方法
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年6月30日
	 * @param page
	 * @return Page<Classification>
	 */
	public Page<ClassificationVO> getPage(Page<ClassificationVO> page, List<ClassificationVO> classAttrList) {
		if (null != classAttrList) {
			if (!classAttrList.isEmpty()) {
				List<ClassificationVO> classificationList = classAttrList;
				page.setTotalRecord(classificationList.size());
				if (classificationList.size() >= (page.getStartOfPage() + page.getPageSize())) {
					page.setResults(classificationList.subList(page.getStartOfPage(),
							page.getStartOfPage() + page.getPageSize()));
				} else {
					page.setResults(classificationList.subList(page.getStartOfPage(), classificationList.size()));
				}
				return page;
			} else {
				return null;
			}
		} else {
			return null;
		}
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
		return classificationDAO.getParentClassByStoreId(storeId);
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
		return classificationDAO.getChildClassByStoreId(storeId);
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
		return classificationDAO.getThreeClassByStoreId(storeId);
	}
}
