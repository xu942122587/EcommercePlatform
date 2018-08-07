package com.unitever.module.allocation.controller;

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
import com.unitever.module.allocation.model.Allocation;
import com.unitever.module.allocation.service.AllocationService;
import com.unitever.module.allocationQrcode.model.AllocationQrcode;
import com.unitever.module.allocationQrcode.service.AllocationQrcodeService;
import com.unitever.module.inventory.model.Inventory;
import com.unitever.module.inventory.service.InventoryService;
import com.unitever.module.qrcode.model.Qrcode;
import com.unitever.module.qrcode.service.QrcodeService;
import com.unitever.module.qrcode.vo.QrcodeVO;
import com.unitever.module.storage.service.StorageService;
import com.unitever.module.store.model.Store;
import com.unitever.module.store.service.StoreService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.external.UserUtil;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.ExceptionUtil;
import com.unitever.platform.util.UUID;

@Controller
@RequestMapping(value = "/allocation")
public class AllocationController extends SpringController {

	@Autowired
	private AllocationService allocationService;
	@Autowired
	private InventoryService inventoryService;
	@Autowired
	private StorageService storageService;
	@Autowired
	private StoreService storeService;
	@Autowired
	private QrcodeService qrcodeService;
	@Autowired
	private AllocationQrcodeService allocationQrcodeService;

	private Logger logger_allocationController = LoggerFactory.getLogger("AllocationController");

	/**
	 *
	 * <P>
	 * 跳转至库存调拨列表页面
	 * </p>
	 *
	 * @date Jun 29, 2017
	 * @param page
	 * @param allocation
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<Allocation> page, @FormModel("model") Allocation allocation) {
		setAttribute("pageObj", allocationService.getPage(page, allocation));
		setAttribute("storageList", storageService.getAll());
		setAttribute("storeList", storeService.getAllStore());
		setAttribute("model", allocation);
		User userSession = UserUtil.getCurrUser();
		if (Role.TYPE_EMPLOYEE.equals(userSession.getRole().getType())) {
			String storeId = userSession.getStore().getId();
			List<Store> storeAddList = new ArrayList<Store>();
			storeAddList.add(storeService.getStoreById(storeId));
			setAttribute("storeAddList", storeAddList);
			setAttribute("storageAddList", storageService.getAllStoreStorageList(storeId));
		} else {
			setAttribute("storeAddList", storeService.getAllStore());
			setAttribute("storageAddList", storageService.getAll());
		}
		return "module/allocation/allocation-list";
	}

	/**
	 *
	 * <P>
	 * 跳转至添加更新库存调拨
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月18日
	 * @param allocationId
	 * @param storeId
	 * @return String
	 */
	@RequestMapping(value = "/input", method = RequestMethod.GET)
	public String input(@FormModel("allocationId") String allocationId, @FormModel("storeId") String storeId) {
		List<AllocationQrcode> allocationQrcodeList = allocationQrcodeService
				.getAllocationQrcodeListByAllocationId(allocationId);
		List<AllocationQrcode> qrcodeGoodsList = allocationQrcodeService.getQrcodeCountByAllocationId(allocationId);
		List<QrcodeVO> qrcodeVOList = new ArrayList<QrcodeVO>();
		for (AllocationQrcode allocationQrcode : allocationQrcodeList) {
			Qrcode qrcode = qrcodeService.getQrcodeById(allocationQrcode.getQrcode().getId());
			QrcodeVO qrcodeVO = qrcodeService.getQrcodeVOByQrcode(qrcode);
			qrcodeVO.setAllocationQrcodeId(allocationQrcode.getId());
			qrcodeVOList.add(qrcodeVO);
		}
		setAttribute("qrcodeGoodsList", qrcodeGoodsList);
		setAttribute("qrcodeVOList", qrcodeVOList);
		setAttribute("outStorageId", allocationService.getAllocationById(allocationId).getOutStorage().getId());
		setAttribute("inStorageId", allocationService.getAllocationById(allocationId).getInStorage().getId());
		setAttribute("storeId", storeId);
		setAttribute("allocationId", allocationId);
		return "module/allocation/allocation-input";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看库存调拨
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月20日
	 * @param allocationId
	 * @return String
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@FormModel("allocationId") String allocationId) {
		List<AllocationQrcode> allocationQrcodeList = allocationQrcodeService
				.getAllocationQrcodeListByAllocationId(allocationId);
		List<AllocationQrcode> qrcodeGoodsList = allocationQrcodeService.getQrcodeCountByAllocationId(allocationId);
		List<QrcodeVO> qrcodeVOList = new ArrayList<QrcodeVO>();
		for (AllocationQrcode allocationQrcode : allocationQrcodeList) {
			Qrcode qrcode = qrcodeService.getQrcodeById(allocationQrcode.getQrcode().getId());
			QrcodeVO qrcodeVO = qrcodeService.getQrcodeVOByQrcode(qrcode);
			qrcodeVO.setAllocationQrcodeId(allocationQrcode.getId());
			qrcodeVOList.add(qrcodeVO);
		}
		setAttribute("qrcodeGoodsList", qrcodeGoodsList);
		setAttribute("qrcodeVOList", qrcodeVOList);
		return "module/allocation/allocation-view";
	}

	/**
	 *
	 * <P>
	 * 保存库存调拨信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月18日
	 * @param allocation
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") Allocation allocation) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(allocation.getId())) {
				ajaxJson.setMsg("修改库存调拨成功！");
				if (0 >= allocationService.update(allocation)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("修改库存调拨失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("修改库存调拨成功！");
				}
			} else {
				String id = allocationService.save(allocation);
				if (null == id || StringUtils.isBlank(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("添加库存调拨失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("添加库存调拨成功！");
					ajaxJson.setObj(new Allocation(id));
				}
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_allocationController.error("保存库存调拨信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除调拨记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param id
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/doDelete", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doDelete(@RequestParam(value = "allocationQrcodeId") String allocationQrcodeId,
			@RequestParam(value = "qrcodeId") String qrcodeId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(allocationQrcodeId)) {
				if (0 >= allocationQrcodeService.deleteAllocationQrcode(allocationQrcodeId)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("删除调拨记录失败，请稍后重试~");
				} else {
					if (0 >= qrcodeService.updateStateFourToOne(new Qrcode(qrcodeId))) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("删除调拨记录失败，请稍后重试~");
					} else {
						ajaxJson.setSuccess(true);
						ajaxJson.setMsg("删除调拨记录成功！");
					}
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("删除调拨记录失败，请刷新页面后重试~");
				logger_allocationController.warn("删除调拨记录时，商品ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_allocationController.error("删除调拨记录出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除调拨单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月17日
	 * @param id
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/doAllDelete", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doAllDelete(@RequestParam(value = "id") String id) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(id)) {
				if (0 >= allocationService.deleteAllocation(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("删除调拨单失败，请稍后重试~");
				} else {
					if (!Allocation.STATE_TURE.equals(allocationService.getAllocationById(id).getState())) {
						qrcodeService.updateAllQrcodeStateByAllocationId(Qrcode.STATE_ONE, id);
					}
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("删除调拨单成功!");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("删除调拨单失败，请刷新页面后重试~");
				logger_allocationController.warn("删除调拨单时，调拨单ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_allocationController.error("删除调拨单出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 保存调拨记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param id
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/submitAllocation", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson submitAllocation(@RequestParam(value = "allocationId") String allocationId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(allocationId)) {
				List<AllocationQrcode> allocationQrcodeList = allocationQrcodeService
						.getAllocationQrcodeListByAllocationId(allocationId);
				Allocation allocation = allocationService.getAllocationById(allocationId);
				allocation.setState(Allocation.STATE_TURE);
				if (0 >= allocationService.update(allocation)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("提交调拨单失败，请稍后重试~");
				} else {
					for (AllocationQrcode allocationQrcode : allocationQrcodeList) {
						Qrcode qrcode = allocationQrcode.getQrcode();
						qrcode.setLogistics(allocation.getInStorage().getName());
						qrcode.setStorage(allocation.getInStorage());
						inventoryService.getSubInventoryNumberByGoodsIdAndStorageId(qrcode.getGoods().getId(),
								allocation.getOutStorage().getId(), "1", qrcode.getProcurementPrice());
						if (0 >= inventoryService.getInventoryCountByGoodsIdAndStorageId(qrcode.getGoods().getId(),
								allocation.getInStorage().getId())) {
							// 没有该库存记录，新增一条
							Inventory inventory = new Inventory(UUID.getUUID(), qrcode.getGoods(), "1",
									qrcode.getProcurementPrice(), allocation.getInStorage(), new Date());
							if (0 >= inventoryService.save(inventory)) {
								// 保存新记录失败，尝试修改库存量
								inventoryService.getAddInventoryNumberByGoodsIdAndStorageId(qrcode.getGoods().getId(),
										allocation.getInStorage().getId(), "1", qrcode.getProcurementPrice());
							}
						} else {
							// 已有相应库存记录，更改库存值
							inventoryService.getAddInventoryNumberByGoodsIdAndStorageId(qrcode.getGoods().getId(),
									allocation.getInStorage().getId(), "1", qrcode.getProcurementPrice());
						}
						qrcodeService.updateStateFourToOne(qrcode);
					}
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("提交调拨单成功！");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("提交调拨单失败，请刷新页面后重试~");
				logger_allocationController.warn("提交调拨单时，商品ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_allocationController.error("提交调拨单出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}
}