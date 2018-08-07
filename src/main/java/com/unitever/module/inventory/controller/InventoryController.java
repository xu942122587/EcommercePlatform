package com.unitever.module.inventory.controller;

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

import com.unitever.auth.user.model.User;
import com.unitever.module.brand.service.BrandService;
import com.unitever.module.classification.service.ClassificationService;
import com.unitever.module.goods.model.Goods;
import com.unitever.module.goods.service.GoodsService;
import com.unitever.module.inventory.model.Inventory;
import com.unitever.module.inventory.service.InventoryService;
import com.unitever.module.inventory.vo.InventoryVO;
import com.unitever.module.storage.service.StorageService;
import com.unitever.module.store.service.StoreService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.external.UserUtil;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

@Controller
@RequestMapping(value = "/inventory")
public class InventoryController extends SpringController {

	@Autowired
	private InventoryService inventoryService;
	@Autowired
	private ClassificationService classificationService;
	@Autowired
	private BrandService brandService;
	@Autowired
	private StoreService storeService;
	@Autowired
	private StorageService storageService;
	@Autowired
	private GoodsService goodsService;

	private Logger logger_inventoryController = LoggerFactory.getLogger("InventoryController");

	/**
	 *
	 * <P>
	 * 跳转至库存信息列表页面
	 * </p>
	 *
	 * @date Jun 29, 2017
	 * @param page
	 * @param inventory
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<InventoryVO> page, @FormModel("model") InventoryVO inventoryVO) {
		User userSession = UserUtil.getCurrUser();
		if (null != userSession.getStore() && StringUtils.isNotBlank(userSession.getStore().getId()))
			if (null != inventoryVO.getGoods()) {
				inventoryVO.getGoods().setStore(userSession.getStore());
			} else {
				Goods goods = new Goods();
				goods.setStore(userSession.getStore());
				inventoryVO.setGoods(goods);
			}
		InventoryVO sumInventoryVO = inventoryService.getSumInventoryVOList(inventoryVO);
		setAttribute("sumInventoryVO", sumInventoryVO);
		setAttribute("pageObj", inventoryService.getPage(page, inventoryVO));
		setAttribute("model", inventoryVO);
		setAttribute("classificationList", classificationService.getParentClassificationList());
		setAttribute("brandList", brandService.getAllBrand());
		setAttribute("storeList", storeService.getAllTianheStore());
		setAttribute("storageList", storageService.getAll());
		return "module/inventory/inventory-list";
	}

	/**
	 *
	 * <P>
	 * 跳转至添加更新库存信息
	 * </p>
	 *
	 * @date Jun 29, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/input", method = RequestMethod.GET)
	public String input(@RequestParam(value = "id", required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			setAttribute("model", inventoryService.getInventoryById(id));
		}
		return "module/inventory/inventory-input";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看库存信息
	 * </p>
	 *
	 * @date Jun 29, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam(value = "id") String id, @RequestParam(value = "storageId") String storageId) {
		setAttribute("goods", goodsService.getGoodsById(id));
		setAttribute("goodsChildInventoryList", inventoryService.getGoodsChildInventoryListByGoodsId(id, storageId));
		return "module/inventory/inventory-view";
	}

	/**
	 *
	 * <P>
	 * 依据父产品ID获取子产品信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月21日
	 * @param goodsId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/getGoodsChildInventoryListByGoodsId", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson getSubGoodsByGoodsId(@RequestParam(value = "id") String id,
			@RequestParam(value = "storageId") String storageId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(id)) {
				List<Inventory> inventoryList = inventoryService.getGoodsChildInventoryListByGoodsId(id, storageId);
				if (null != inventoryList) {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("获取产品信息成功");
					ajaxJson.setObj(inventoryList);
				} else {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("获取产品信息失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("获取产品信息失败，请刷新页面后重试~");
				logger_inventoryController.warn("获取产品信息时，商品ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_inventoryController.error("依据产品ID获取产品信息--出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

}