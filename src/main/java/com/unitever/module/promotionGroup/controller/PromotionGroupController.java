package com.unitever.module.promotionGroup.controller;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.unitever.module.classification.service.ClassificationService;
import com.unitever.module.goods.service.GoodsService;
import com.unitever.module.promotionGroup.model.PromotionGroup;
import com.unitever.module.promotionGroup.service.PromotionGroupService;
import com.unitever.module.store.model.Store;
import com.unitever.module.store.service.StoreService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.promotionGroup.controller->
 * PromotionGroupController.java
 * </p>
 * <P>
 * 活动组controller
 * </p>
 *
 * @author 闫枫
 * @date Aug 2, 2017
 */
@Controller
@RequestMapping(value = "/promotionGroup")
public class PromotionGroupController extends SpringController {

	@Autowired
	private PromotionGroupService promotionGroupService;
	@Autowired
	private StoreService storeService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private ClassificationService classificationService;

	private Logger logger_promotionGroupController = LoggerFactory.getLogger("PromotionGroupController");

	/**
	 *
	 * <P>
	 * 跳转至活动组列表页面
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param page
	 * @param promotionGroup
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<PromotionGroup> page,
			@FormModel("model") PromotionGroup promotionGroup) {
		setAttribute("pageObj", promotionGroupService.getPage(page, promotionGroup));
		setAttribute("model", promotionGroup);
		return "module/promotionGroup/promotionGroup-list";
	}

	/**
	 *
	 * <P>
	 * 跳转至添加更新活动组
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/input", method = RequestMethod.GET)
	public String input(@RequestParam(value = "id", required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			setAttribute("model", promotionGroupService.getPromotionGroupById(id));
		}
		List<Store> storeList = storeService.getAllStore();
		storeList.addAll(storeService.getAllNoTianheStore());
		setAttribute("parentGoodsList", goodsService.getAllParentGoods());
		setAttribute("gaveGoodsList", goodsService.getAllGaveGoodsList());
		setAttribute("storeList", storeList);
		// setAttribute("storeList", storeService.getAllStore());
		setAttribute("classificationList", classificationService.getParentClassificationList());
		return "module/promotionGroup/promotionGroup-input";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看活动组
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam(value = "id", required = false) String id) {
		PromotionGroup promotionGroup = promotionGroupService.getPromotionGroupById(id);
		if (PromotionGroup.SCOPE_STORE.equals(promotionGroup.getScope())) {
			setAttribute("storeName", storeService.getStoreById(promotionGroup.getOwnerId()));
		}
		setAttribute("parentGoodsList", goodsService.getAllParentGoods());
		setAttribute("gaveGoodsList", goodsService.getAllGaveGoodsList());
		setAttribute("model", promotionGroup);
		return "module/promotionGroup/promotionGroup-view";
	}

	/**
	 *
	 * <P>
	 * 保存活动组信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param promotionGroup
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") PromotionGroup promotionGroup) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			ajaxJson = promotionGroupService.checkGroupIsNeedSave(promotionGroup);
			if (!ajaxJson.isSuccess()) {
				return ajaxJson;
			}
			if (StringUtils.isNotBlank(promotionGroup.getId())) {
				ajaxJson.setMsg("修改活动组成功！");
				if (0 >= promotionGroupService.update(promotionGroup)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("修改活动组失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("修改活动组成功！");
				}
			} else {
				if (0 >= promotionGroupService.save(promotionGroup)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("添加活动组失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("添加活动组成功！");
				}
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_promotionGroupController.error(
					"保存活动组信息出错，具体错误如下：\r\n" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除活动组
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return int
	 */
	@RequestMapping(value = "/doDelete", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doDelete(@RequestParam(value = "id") String id) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(id)) {
				if (0 >= promotionGroupService.deletePromotionGroup(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("删除活动组失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("删除活动组失败，请刷新页面后重试~");
				logger_promotionGroupController.warn("删除活动组时，活动组ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_promotionGroupController.error(
					"删除活动组出错，具体错误如下：\r\n" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

}