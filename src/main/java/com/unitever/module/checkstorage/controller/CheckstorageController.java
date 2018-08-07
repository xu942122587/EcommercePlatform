package com.unitever.module.checkstorage.controller;

import java.util.ArrayList;
import java.util.Date;
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

import com.unitever.auth.role.model.Role;
import com.unitever.auth.user.model.User;
import com.unitever.module.checkstorage.model.Checkstorage;
import com.unitever.module.checkstorage.service.CheckstorageService;
import com.unitever.module.checkstorageGoods.model.CheckstorageGoods;
import com.unitever.module.checkstorageGoods.service.CheckstorageGoodsService;
import com.unitever.module.checkstorageGoods.vo.CheckstorageGoodsVO;
import com.unitever.module.goods.model.Goods;
import com.unitever.module.inventory.service.InventoryService;
import com.unitever.module.inventory.vo.InventoryVO;
import com.unitever.module.qrcode.service.QrcodeService;
import com.unitever.module.storage.service.StorageService;
import com.unitever.module.store.model.Store;
import com.unitever.module.store.service.StoreService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.external.UserUtil;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;

@Controller
@RequestMapping(value = "/checkstorage")
public class CheckstorageController extends SpringController {

	@Autowired
	private CheckstorageService checkstorageService;
	@Autowired
	private InventoryService inventoryService;
	@Autowired
	private StorageService storageService;
	@Autowired
	private StoreService storeService;
	@Autowired
	private QrcodeService qrcodeService;
	@Autowired
	private CheckstorageGoodsService checkstorageGoodsService;

	private Logger logger_checkstorageController = LoggerFactory.getLogger("CheckstorageController");

	/**
	 *
	 * <P>
	 * 跳转至库存盘点列表页面
	 * </p>
	 *
	 * @date Jun 29, 2017
	 * @param page
	 * @param checkstorage
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<Checkstorage> page, @FormModel("model") Checkstorage checkstorage) {
		setAttribute("pageObj", checkstorageService.getPage(page, checkstorage));
		setAttribute("storageList", storageService.getAll());
		setAttribute("model", checkstorage);
		User userSession = UserUtil.getCurrUser();
		if (Role.TYPE_EMPLOYEE.equals(userSession.getRole().getType())) {
			String storeId = userSession.getStore().getId();
			List<Store> storeAddList = new ArrayList<Store>();
			storeAddList.add(storeService.getStoreById(storeId));
			setAttribute("storeAddList", storeAddList);
			setAttribute("storageAddList", storageService.getAllStoreStorageList(storeId));
		} else {
			setAttribute("storeAddList", storeService.getAllTianheStore());
			setAttribute("storageAddList", storageService.getAll());
		}
		return "module/checkstorage/checkstorage-list";
	}

	/**
	 *
	 * <P>
	 * 跳转至添加更新库存盘点
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月18日
	 * @param checkstorageId
	 * @param storeId
	 * @return String
	 */
	@RequestMapping(value = "/input", method = RequestMethod.GET)
	public String input(@FormModel("checkstorageId") String checkstorageId) {

		List<CheckstorageGoods> checkstorageGoodsList = checkstorageGoodsService
				.getCheckstorageGoodsListByCheckstorageId(checkstorageId);
		List<CheckstorageGoodsVO> checkstorageGoodsVOList = new ArrayList<CheckstorageGoodsVO>();
		for (CheckstorageGoods checkstorageGoods : checkstorageGoodsList) {
			CheckstorageGoodsVO checkstorageGoodsVO = checkstorageGoodsService
					.getCheckstorageGoodsVOByCheckstorageGoods(checkstorageGoods);
			checkstorageGoodsVOList.add(checkstorageGoodsVO);
		}
		setAttribute("checkstorageGoodsVOList", checkstorageGoodsVOList);

		Checkstorage checkstorage = checkstorageService.getCheckstorageById(checkstorageId);
		InventoryVO inventoryVO = new InventoryVO();
		Goods goods = new Goods();
		goods.setStore(checkstorage.getStore());
		inventoryVO.setStorage(checkstorage.getStorage());
		inventoryVO.setGoods(goods);
		setAttribute("storageGoodsList", inventoryService.getInventoryVOList(inventoryVO));

		setAttribute("checkstorageId", checkstorage.getId());
		setAttribute("storageId", checkstorage.getStorage().getId());
		return "module/checkstorage/checkstorage-input";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看库存盘点
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月20日
	 * @param checkstorageId
	 * @return String
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@FormModel("checkstorageId") String checkstorageId) {

		List<CheckstorageGoods> checkstorageGoodsList = checkstorageGoodsService
				.getCheckstorageGoodsListByCheckstorageId(checkstorageId);
		List<CheckstorageGoodsVO> checkstorageGoodsVOList = new ArrayList<CheckstorageGoodsVO>();
		for (CheckstorageGoods checkstorageGoods : checkstorageGoodsList) {
			CheckstorageGoodsVO checkstorageGoodsVO = checkstorageGoodsService
					.getCheckstorageGoodsVOByCheckstorageGoods(checkstorageGoods);
			checkstorageGoodsVOList.add(checkstorageGoodsVO);
		}
		setAttribute("checkstorageGoodsVOList", checkstorageGoodsVOList);

		setAttribute("model", checkstorageService.getCheckstorageById(checkstorageId));
		return "module/checkstorage/checkstorage-view";
	}

	/**
	 *
	 * <P>
	 * 保存库存盘点信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月18日
	 * @param checkstorage
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") Checkstorage checkstorage) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(checkstorage.getId())) {
				ajaxJson.setMsg("修改库存盘点成功！");
				if (0 >= checkstorageService.update(checkstorage)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("修改库存盘点失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("修改库存盘点成功！");
				}
			} else {
				String id = checkstorageService.save(checkstorage);
				if (null == id || StringUtils.isBlank(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("添加库存盘点失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("添加库存盘点成功！");
					ajaxJson.setObj(new Checkstorage(id));
				}
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_checkstorageController.error("保存库存盘点信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 保存库存盘点信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月18日
	 * @param checkstorage
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveCheckstorageGoodsByGoodsId", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveCheckstorageGoodsByGoodsId(@FormModel(value = "goodsId") String goodsId,
			@FormModel(value = "checkstorageId") String checkstorageId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(goodsId)) {
				if (StringUtils.isNotBlank(checkstorageId)) {
					CheckstorageGoods checkstorageGoods = new CheckstorageGoods();
					checkstorageGoods.setGoods(new Goods(goodsId));
					checkstorageGoods.setCheckstorage(new Checkstorage(checkstorageId));
					String id = checkstorageGoodsService.save(checkstorageGoods);
					if (null == id || StringUtils.isBlank(id)) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("添加库存盘点明细失败，请稍后重试~");
					} else {
						CheckstorageGoodsVO checkstorageGoodsVO = checkstorageGoodsService
								.getCheckstorageGoodsVOByCheckstorageGoods(checkstorageGoodsService
										.getCheckstorageGoodsById(id));
						ajaxJson.setSuccess(true);
						ajaxJson.setMsg("添加库存盘点明细成功！");
						ajaxJson.setObj(checkstorageGoodsVO);
					}
				} else {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("添加盘点明细记录失败，请刷新页面后重试~");
					logger_checkstorageController.warn("添加盘点明细记录时，checkstorageId为空，请检查代码实现~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("添加盘点明细记录失败，请刷新页面后重试~");
				logger_checkstorageController.warn("添加盘点明细记录时，goodsId为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_checkstorageController.error("保存库存盘点明细信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除空盘点单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param id
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/doDeleteEmpty", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doDeleteEmpty(@RequestParam(value = "checkstorageId") String checkstorageId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(checkstorageId)) {
				Checkstorage checkstorage = checkstorageService.getCheckstorageById(checkstorageId);
				if (null != checkstorage && StringUtils.isNotBlank(checkstorage.getId())) {
					if (null != checkstorage.getCheckstorageGoodsList()
							&& 0 < checkstorage.getCheckstorageGoodsList().size()) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("该盘点单以有盘点记录,无法删除,请完成!");
					} else {
						if (0 >= checkstorageService.deleteCheckstorage(checkstorageId)) {
							ajaxJson.setSuccess(false);
							ajaxJson.setMsg("删除盘点单失败，请稍后重试~");
						} else {
							ajaxJson.setSuccess(true);
							ajaxJson.setMsg("删除盘点单成功！");
						}
					}
				} else {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("删除盘点单失败，请重试!");
					logger_checkstorageController.warn("删除盘点单时，商品为空，请检查代码实现~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("删除盘点记录失败，请刷新页面后重试~");
				logger_checkstorageController.warn("删除盘点记录时，商品ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_checkstorageController.error("删除盘点单出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除盘点记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param id
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/doDelete", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doDelete(@RequestParam(value = "checkstorageGoodsId") String checkstorageGoodsId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(checkstorageGoodsId)) {
				if (0 >= checkstorageGoodsService.deleteCheckstorageGoods(checkstorageGoodsId)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("删除盘点记录失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("删除盘点记录成功！");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("删除盘点记录失败，请刷新页面后重试~");
				logger_checkstorageController.warn("删除盘点记录时，商品ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_checkstorageController.error("删除盘点记录出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 盘库对比
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param id
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/doCheckstorage", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doCheckstorage(@RequestParam(value = "checkstorageGoodsId") String checkstorageGoodsId,
			@RequestParam(value = "checkNumber") String checkNumber) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(checkstorageGoodsId)) {
				if (StringUtils.isNotBlank(checkNumber)) {
					if (0 >= checkstorageService.doCheckstorage(checkstorageGoodsId, checkNumber)) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("盘库对比失败，请稍后重试~");
					} else {
						ajaxJson.setSuccess(true);
						ajaxJson.setMsg("盘库对比成功！");
					}
				} else {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("盘库对比失败，请刷新页面后重试~");
					logger_checkstorageController.warn("盘库对比时，checkstorage_checkNumber为空，请检查代码实现~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("盘库对比失败，请刷新页面后重试~");
				logger_checkstorageController.warn("盘库对比时，checkstorageGoodsId为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_checkstorageController.error("删除盘点记录出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 提交盘点记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param id
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/submitCheckstorage", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson submitcheckstorage(@RequestParam(value = "checkstorageId") String checkstorageId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(checkstorageId)) {
				Checkstorage checkstorage = checkstorageService.getCheckstorageById(checkstorageId);
				checkstorage.setState(Checkstorage.STATE_ONE);
				checkstorage.setCheckDate(new Date());
				if (0 >= checkstorageService.update(checkstorage)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("提交盘点单失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("提交盘点单成功！");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("提交盘点单失败，请刷新页面后重试~");
				logger_checkstorageController.warn("提交盘点单时，checkstorageId为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_checkstorageController.error("提交盘点单出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}
}