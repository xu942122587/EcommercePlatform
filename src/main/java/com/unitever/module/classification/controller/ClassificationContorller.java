package com.unitever.module.classification.controller;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.auth.role.service.RoleService;
import com.unitever.module.classification.model.Classification;
import com.unitever.module.classification.service.ClassificationService;
import com.unitever.module.classification.vo.ClassificationVO;
import com.unitever.module.goods.service.GoodsService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;
import com.unitever.platform.util.UUID;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/classification")
public class ClassificationContorller extends SpringController {

	@Autowired
	private ClassificationService classificationService;
	@Autowired
	private RoleService roleService;
	@Autowired
	private GoodsService goodsService;

	Logger logger_classificationContorller = LoggerFactory.getLogger("ClassificationContorller");

	/**
	 * 分类列表
	 * 
	 * @author XiaoYu
	 * @date 2017年4月28日
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String goClassificationList() {
		return "module/classification/classification-list";
	}

	/**
	 *
	 * <P>
	 * 属性列表
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年6月29日
	 * @return String
	 */
	@RequestMapping(value = "/otherAttrJsonList")
	public String goOtherAttrJsonList(@FormModel("id") String id, @FormModel("page") Page<ClassificationVO> page) {
		setAttribute("pageObj", classificationService.getPage(page, classificationService
				.getClassificationAttrForClassification(classificationService.getClassificationById(id))));
		setAttribute("classStringList", classificationService
				.getClassificationAttrForClassification(classificationService.getClassificationById(id)));
		return "module/classification/classification-otherAttrJsonList";
	}

	/**
	 * 分类树
	 * 
	 * @author XiaoYu
	 * @date 2017年4月28日
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getClassificationTree")
	public String getClassificationTree() {
		return classificationService.getClassificationTree();
	}

	/**
	 * 前往添加或更新
	 * 
	 * @author XiaoYu
	 * @date 2017年5月2日
	 * @param flag
	 * @param nodeId
	 * @return String
	 */
	@RequestMapping(value = "/goAddOrUpdate")
	public String goAddOrUpdate(@RequestParam(value = "flag", required = true) String flag,
			@RequestParam(value = "nodeId", required = false) String nodeId) {
		if ("update".equals(flag)) {
			setAttribute("model", classificationService.getClassificationById(nodeId));
			if (StringUtils.isNotBlank(nodeId)) {
				setAttribute("parentModel",
						classificationService.getClassificationById(nodeId).getParentClassification());
			}
		} else if ("add".equals(flag)) {
			setAttribute("level", classificationService.getClassificationLevel(nodeId));
			if (StringUtils.isNotBlank(nodeId)) {
				setAttribute("parentModel", classificationService.getClassificationById(nodeId));
			}
		}
		setAttribute("flag", flag);
		return "module/classification/classification-add";
	}

	/**
	 * 提交更新/修改
	 * 
	 * @author XiaoYu
	 * @date 2017年5月2日
	 * @param flag
	 * @param model
	 * @return AjaxJson
	 */
	@ResponseBody
	@RequestMapping(value = "/doAddOrUpdate", method = RequestMethod.POST)
	public AjaxJson doAddOrUpdate(@RequestParam(value = "flag", required = true) String flag,
			@FormModel("model") Classification model) {
		return classificationService.doAddOrUpdate(model, flag);
	}

	/**
	 *
	 * <P>
	 * 前往新增/修改界面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年6月29日
	 * @param flag
	 * @param nodeId
	 * @return String
	 */
	@RequestMapping(value = "/otherAttrJsonAddOrUpdate")
	public String otherAttrJsonAddOrUpdate(@RequestParam(value = "flag", required = true) String flag,
			@RequestParam(value = "nodeId", required = false) String nodeId,
			@RequestParam(value = "attrCode", required = false) String attrCode) {
		if ("update".equals(flag)) {
			Classification classification = classificationService.getClassificationById(nodeId);
			JSONArray otherAttrJsonArray = JSONArray.fromObject(classification.getOtherAttrJson());
			for (int i = 0; i < otherAttrJsonArray.size(); i++) {
				if (otherAttrJsonArray.getJSONObject(i).get("attrCode").equals(attrCode)) {

					setAttribute("attrCode", otherAttrJsonArray.getJSONObject(i).get("attrCode"));
					setAttribute("attr", otherAttrJsonArray.getJSONObject(i).get("attr"));
					setAttribute("inputType", otherAttrJsonArray.getJSONObject(i).get("inputType"));
					setAttribute("isRequired", otherAttrJsonArray.getJSONObject(i).get("isRequired"));
					if (StringUtils.isNotBlank((String) otherAttrJsonArray.getJSONObject(i).get("childAttr"))) {
						String childAttr = (String) otherAttrJsonArray.getJSONObject(i).get("childAttr");
						String[] childAttrList = childAttr.split(",");
						setAttribute("childAttrList", childAttrList);
					}
				}
			}
			setAttribute("model", classificationService.getClassificationById(nodeId));
		} else if ("add".equals(flag)) {
			setAttribute("model", classificationService.getClassificationById(nodeId));
		}
		setAttribute("flag", flag);
		return "module/classification/classification-otherAttrJsonAdd";
	}

	/**
	 *
	 * <P>
	 * 提交属性新增/修改
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年6月29日
	 * @param flag
	 * @param model
	 * @return AjaxJson
	 */
	@ResponseBody
	@RequestMapping(value = "/otherAttrJsonDoAddOrUpdate", method = RequestMethod.POST)
	public AjaxJson otherAttrJsonDoAddOrUpdate(@RequestParam(value = "flag", required = true) String flag,
			@FormModel("model") Classification model, @RequestParam(value = "attr") String attr,
			@RequestParam(value = "attrCode") String attrCode, @RequestParam(value = "inputType") String inputType,
			@RequestParam(value = "isRequired") String isRequired,
			@RequestParam(value = "childAttr") String childAttr) {
		if ("update".equals(flag)) {
			flag = "update_attr";
			Classification classification = classificationService.getClassificationById(model.getId());
			JSONArray otherAttrJsonArray = JSONArray.fromObject(classification.getOtherAttrJson());
			for (int i = 0; i < otherAttrJsonArray.size(); i++) {
				if (otherAttrJsonArray.getJSONObject(i).get("attrCode").equals(attrCode)) {
					otherAttrJsonArray.getJSONObject(i).discard("attr");
					if ("2".equals((String) otherAttrJsonArray.getJSONObject(i).get("inputType"))) {
						otherAttrJsonArray.getJSONObject(i).discard("childAttr");
					}
					otherAttrJsonArray.getJSONObject(i).discard("inputType");
					otherAttrJsonArray.getJSONObject(i).discard("isRequired");
					otherAttrJsonArray.getJSONObject(i).put("attr", attr);
					otherAttrJsonArray.getJSONObject(i).put("inputType", inputType);
					otherAttrJsonArray.getJSONObject(i).put("isRequired", isRequired);
					if ("2".equals(inputType)) {
						otherAttrJsonArray.getJSONObject(i).put("childAttr", childAttr);
					}
				}
			}
			classification.setOtherAttrJson(otherAttrJsonArray.toString());
			return classificationService.doAddOrUpdate(classification, flag);
		} else if ("add".equals(flag)) {
			flag = "add_attr";
			Classification classification = classificationService.getClassificationById(model.getId());
			List<Map> otherAttrList = new ArrayList<Map>();
			Map<String, String> otherAttrMap = new LinkedHashMap<String, String>();
			JSONArray otherAttrJSONArray = new JSONArray();
			String otherAttrJson = "";
			otherAttrMap.put("attrCode", UUID.getUUID());
			otherAttrMap.put("attr", attr);
			otherAttrMap.put("inputType", inputType);
			otherAttrMap.put("isRequired", isRequired);
			if ("2".equals(inputType)) {
				otherAttrMap.put("childAttr", childAttr);
			}
			JSONObject otherAttrJsonObject = JSONObject.fromObject(otherAttrMap);
			if (StringUtils.isNotBlank(classification.getOtherAttrJson())) {
				otherAttrJSONArray = JSONArray.fromObject(classification.getOtherAttrJson());
				otherAttrJSONArray.add(otherAttrJsonObject);
				otherAttrJson = otherAttrJSONArray.toString();
			} else {
				otherAttrList.add(otherAttrMap);
				otherAttrJson = JSONArray.fromObject(otherAttrList).toString();
			}
			classification.setOtherAttrJson(otherAttrJson);
			return classificationService.doAddOrUpdate(classification, flag);
		}

		return null;
	}

	/**
	 * 删除分类
	 * 
	 * @author XiaoYu
	 * @date 2017年5月2日
	 * @param nodeId
	 * @return AjaxJson
	 */
	@ResponseBody
	@RequestMapping(value = "/doDelete", method = RequestMethod.POST)
	public AjaxJson doDelete(@RequestParam(value = "nodeId", required = true) String nodeId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			ajaxJson = classificationService.doDelete(nodeId);
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_classificationContorller.error(
					"删除类出错，具体错误如下：\r\n" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除属性
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月1日
	 * @param attrCode
	 * @param id
	 * @return AjaxJson
	 */
	@ResponseBody
	@RequestMapping(value = "/otherAttrJsonDoDelete", method = RequestMethod.POST)
	public AjaxJson otherAttrJsonDoDelete(@RequestParam(value = "attrCode", required = true) String attrCode,
			@RequestParam(value = "id", required = true) String id) {
		String flag = "delete";
		String otherAttrJson = "";
		Classification classification = classificationService.getClassificationById(id);
		JSONArray otherAttrJsonArray = JSONArray.fromObject(classification.getOtherAttrJson());
		for (int i = 0; i < otherAttrJsonArray.size(); i++) {
			if (otherAttrJsonArray.getJSONObject(i).get("attrCode").equals(attrCode)) {
				otherAttrJsonArray.discard(i);
			}
		}
		otherAttrJson = otherAttrJsonArray.toString();
		classification.setOtherAttrJson(otherAttrJson);
		return classificationService.doAddOrUpdate(classification, flag);
	}

	/**
	 * 可见隐藏
	 * 
	 * @author XiaoYu
	 * @date 2017年5月3日
	 * @param nodeId
	 * @return AjaxJson
	 */
	@ResponseBody
	@RequestMapping(value = "/showHideNode", method = RequestMethod.POST)
	public AjaxJson showHideNode(@RequestParam(value = "nodeId", required = true) String nodeId) {
		return classificationService.showHideNode(nodeId);
	}

	/**
	 *
	 * <P>
	 * 拿取子商品
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月4日
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/goodsChild")
	public String goodsChild(@RequestParam(value = "id", required = false) String id,
			@RequestParam(value = "goodsId", required = false) String goodsId) {
		setAttribute("classStringList", classificationService
				.getClassificationAttrForClassification(classificationService.getClassificationById(id)));
		if (StringUtils.isNotBlank(goodsId)) {
			setAttribute("model", goodsService.getGoodsById(goodsId));
		}
		return "module/goods/goods-input-childGoods";
	}

	/**
	 *
	 * <P>
	 * 获取二级分类
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月4日
	 * @param classificationId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/getTwoClassification", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson getTwoClassification(@RequestParam(value = "classificationId") String classificationId) {
		AjaxJson ajaxJson = new AjaxJson();
		ajaxJson.setSuccess(true);
		List<Classification> childrenClassificationList = classificationService
				.getChildrenClassificationList(classificationId);
		for (Classification classification : childrenClassificationList) {
			classification.setChildrenClassifications(null);
		}
		ajaxJson.setMsg(JSONArray.fromObject(childrenClassificationList).toString());
		return ajaxJson;
	}
}
