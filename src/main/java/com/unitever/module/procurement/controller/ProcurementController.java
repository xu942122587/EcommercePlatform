package com.unitever.module.procurement.controller;

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

import com.unitever.auth.user.model.User;
import com.unitever.module.goods.service.GoodsService;
import com.unitever.module.inventory.service.InventoryService;
import com.unitever.module.procurement.model.Procurement;
import com.unitever.module.procurement.service.ProcurementService;
import com.unitever.module.procurementGoods.model.ProcurementGoods;
import com.unitever.module.procurementGoods.service.ProcurementGoodsService;
import com.unitever.module.procurementQrcode.model.ProcurementQrcode;
import com.unitever.module.procurementQrcode.service.ProcurementQrcodeService;
import com.unitever.module.qrcode.model.Qrcode;
import com.unitever.module.qrcode.service.QrcodeService;
import com.unitever.module.qrcode.vo.QrcodeVO;
import com.unitever.module.store.model.Store;
import com.unitever.module.store.service.StoreService;
import com.unitever.module.vende.service.VendeService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.external.UserUtil;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.DoubleUtil;
import com.unitever.platform.util.ExceptionUtil;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.procurement.controller->
 * ProcurementController.java
 * </p>
 * <P>
 * 采购订单（退货单）
 * </p>
 *
 * @author 闫枫
 * @date Jul 6, 2017
 */
@Controller
@RequestMapping(value = "/procurement")
public class ProcurementController extends SpringController {

	@Autowired
	private ProcurementService procurementService;
	@Autowired
	private ProcurementGoodsService procurementGoodsService;
	@Autowired
	private InventoryService inventoryService;
	@Autowired
	private ProcurementQrcodeService procurementQrcodeService;
	@Autowired
	private VendeService vendeService;
	@Autowired
	private StoreService storeService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private QrcodeService qrcodeService;

	private Logger logger_procurementController = LoggerFactory.getLogger("ProcurementController");

	/**
	 *
	 * <P>
	 * 跳转至采购订单列表页面
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param page
	 * @param procurement
	 * @return String
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<Procurement> page, @FormModel("model") Procurement procurement) {
		// 登录用户是门店的，只能查询和本门店有关的采购单
		User user_in_session = UserUtil.getCurrUser();
		if (null != user_in_session.getStore()) {
			if (StringUtils.isNotBlank(user_in_session.getStore().getId())) {
				procurement.setStore(user_in_session.getStore());
			}
		}
		procurement.setType(Procurement.TYPE_ONE);
		setAttribute("pageObj", procurementService.getPage(page, procurement));
		setAttribute("model", procurement);
		return "module/procurement/procurement-list";
	}

	/**
	 *
	 * <P>
	 * 跳转至采购退货列表页面
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月11日
	 * @param page
	 * @param procurement
	 * @return String
	 */
	@RequestMapping(value = "/returnList")
	public String returnList(@FormModel("page") Page<Procurement> page, @FormModel("model") Procurement procurement) {
		// 登录用户是门店的，只能查询和本门店有关的采购单
		procurement.setType(Procurement.TYPE_TWO);
		User userSession = UserUtil.getCurrUser();
		if (null != userSession.getStore()) {
			if (StringUtils.isNotBlank(userSession.getStore().getId())) {
				procurement.setStore(userSession.getStore());
			}
		}
		setAttribute("pageObj", procurementService.getPage(page, procurement));
		setAttribute("model", procurement);

		setAttribute("vendeList", vendeService.getAll());
		setAttribute("storeList", storeService.getAllStore());
		if (null != userSession.getStore() && StringUtils.isNotBlank(userSession.getStore().getId())) {
			String storeId = userSession.getStore().getId();
			List<Store> storeAddList = new ArrayList<Store>();
			storeAddList.add(storeService.getStoreById(storeId));
			setAttribute("storeAddList", storeAddList);
		} else {
			setAttribute("storeAddList", storeService.getAllTianheStore());
		}
		return "module/procurement/returnProcurement-list";
	}

	/**
	 *
	 * <P>
	 * 跳转至添加修改采购订单（退货单）
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/input", method = RequestMethod.GET)
	public String input(@RequestParam(value = "id", required = false) String id,
			@RequestParam(value = "proType", required = false) String proType,
			@RequestParam(value = "isCheck", required = false) String isCheck) {
		boolean isStoreUser = false;
		User user_in_session = UserUtil.getCurrUser();
		if (null != user_in_session.getStore()) {
			if (StringUtils.isNotBlank(user_in_session.getStore().getId())) {
				isStoreUser = true;
			}
		}
		setAttribute("vendeList", vendeService.getAll());
		// setAttribute("storeList", storeService.getAllStore());
		// setAttribute("goodsList", goodsService.getAllParentGoods());
		setAttribute("proType", proType);
		setAttribute("isCheck", isCheck);
		if (StringUtils.isBlank(id)) {
			if (isStoreUser) {
				setAttribute("goodsList", goodsService.getGoodsByStoreId(user_in_session.getStore().getId()));
			} else {
				setAttribute("storeList", storeService.getAllTianheStore());
			}
			return "module/procurement/procurement-input";
		} else {
			Procurement procurement = procurementService.getProcurementById(id);
			setAttribute("model", procurement);
			if ("proGoodsGoHome".equals(isCheck)) {
				return "module/procurement/procurement-proGoodsGoHome";
			} else {
				setAttribute("goodsList", goodsService.getGoodsByStoreId(procurement.getStore().getId()));
				return "module/procurement/procurement-input";
			}
		}
	}

	/**
	 *
	 * <P>
	 * 跳转至添加更新采购退货
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月18日
	 * @param procurementId
	 * @param storeId
	 * @return String
	 */
	@RequestMapping(value = "/returnInput", method = RequestMethod.GET)
	public String returnInput(@RequestParam("procurementId") String procurementId,
			@RequestParam("storeId") String storeId, @RequestParam(value = "isCheck", required = false) String isCheck) {
		List<ProcurementQrcode> procurementQrcodeList = procurementQrcodeService
				.getProcurementQrcodeListByProcurementId(procurementId);
		List<QrcodeVO> qrcodeVOList = new ArrayList<QrcodeVO>();
		for (ProcurementQrcode procurementQrcode : procurementQrcodeList) {
			Qrcode qrcode = qrcodeService.getQrcodeById(procurementQrcode.getQrcode().getId());
			QrcodeVO qrcodeVO = qrcodeService.getQrcodeVOByQrcode(qrcode);
			qrcodeVO.setProcurementQrcodeId(procurementQrcode.getId());
			qrcodeVOList.add(qrcodeVO);
		}
		setAttribute("qrcodeVOList", qrcodeVOList);
		setAttribute("storeId", storeId);
		setAttribute("procurementId", procurementId);
		Procurement procurement = procurementService.getProcurementById(procurementId);
		setAttribute("model", procurement);
		if (StringUtils.isNotBlank(isCheck) && "proGoodsGoHome".equals(isCheck)) {
			return "module/procurement/returnProcurement-proGoodsGoHome";
		} else {
			return "module/procurement/returnProcurement-input";
		}

	}

	/**
	 *
	 * <P>
	 * 跳转至查看采购订单（退货单）
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam(value = "id", required = false) String id) {
		Procurement procurement = procurementService.getProcurementById(id);
		List<ProcurementGoods> procurementGoodsList = procurementGoodsService.getAllByProcurementId(id);

		setAttribute("model", procurement);
		setAttribute("procurementGoodsList", procurementGoodsList);
		return "module/procurement/procurement-view";
	}

	/**
	 *
	 * <P>
	 * 跳转至查看库存调拨
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月20日
	 * @param procurementId
	 * @return String
	 */
	@RequestMapping(value = "/returnView", method = RequestMethod.GET)
	public String returnView(@FormModel("procurementId") String procurementId) {
		List<ProcurementQrcode> procurementQrcodeList = procurementQrcodeService
				.getProcurementQrcodeListByProcurementId(procurementId);
		List<QrcodeVO> qrcodeVOList = new ArrayList<QrcodeVO>();
		for (ProcurementQrcode procurementQrcode : procurementQrcodeList) {
			Qrcode qrcode = qrcodeService.getQrcodeById(procurementQrcode.getQrcode().getId());
			QrcodeVO qrcodeVO = qrcodeService.getQrcodeVOByQrcode(qrcode);
			qrcodeVO.setProcurementQrcodeId(procurementQrcode.getId());
			qrcodeVOList.add(qrcodeVO);
		}
		Procurement procurement = procurementService.getProcurementById(procurementId);
		setAttribute("procurementId", procurementId);
		setAttribute("model", procurement);
		setAttribute("qrcodeVOList", qrcodeVOList);
		return "module/procurement/returnProcurement-view";
	}

	/**
	 *
	 * <P>
	 * 保存采购订单（退货单）信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param procurement
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@FormModel(value = "model") Procurement procurement,
			@RequestParam(value = "isCheck", required = false) String isCheck) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(procurement.getId())) {
				if ("proGoodsGoHome".equals(isCheck)) {
					procurement.setProcurementDate(new Date());
				}
				ajaxJson.setMsg("修改采购订单成功！");
				if (0 >= procurementService.update(procurement)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("修改采购订单失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("修改采购订单成功！");
				}
			} else {
				if (0 >= procurementService.save(procurement)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("添加采购订单失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("添加采购订单成功！");
				}
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_procurementController.error("保存采购订单信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 保存采购退货信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月18日
	 * @param procurement
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/returnSaveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson returnSaveOrUpdate(@FormModel(value = "model") Procurement procurement) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(procurement.getId())) {
				if (Procurement.STATE_FOUR.equals(procurement.getState())) {
					procurement.setProcurementDate(new Date());
				}
				if (0 >= procurementService.update(procurement)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("修改采购退货失败，请稍后重试~");
				} else {
					if (Procurement.STATE_FOUR.equals(procurement.getState())) {
						if (0 >= qrcodeService.updateAllQrcodeStateByProcurementId(Qrcode.STATE_THREE,
								procurement.getId())) {
							ajaxJson.setSuccess(false);
							ajaxJson.setMsg("确认发送采购退货失败！");
						} else {
							List<ProcurementQrcode> procurementQrcodeList = procurementQrcodeService
									.getProcurementQrcodeListByProcurementId(procurement.getId());
							for (ProcurementQrcode procurementQrcode : procurementQrcodeList) {
								Qrcode qrcode = procurementQrcode.getQrcode();
								String logistics = qrcode.getLogistics() + "-" + procurement.getVende().getName();
								qrcode.setLogistics(logistics);
								inventoryService.getSubInventoryNumberByGoodsIdAndStorageId(qrcode.getGoods().getId(),
										qrcode.getStorage().getId(), "1", qrcode.getProcurementPrice());
								qrcodeService.update(qrcode);
							}
							ajaxJson.setSuccess(true);
							ajaxJson.setMsg("确认发送采购退货成功！");
						}
					}

				}
			} else {
				String id = procurementService.returnSave(procurement);
				if (null == id || StringUtils.isBlank(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("添加采购退货失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("添加采购退货成功！");
					ajaxJson.setObj(new Procurement(id));
				}
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_procurementController.error("保存采购退货信息出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除采购订单（退货单）
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param id
	 * @return int
	 */
	@RequestMapping(value = "/doDelete", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doDelete(@RequestParam(value = "id") String id,
			@RequestParam(value = "isReturn", required = false) String isReturn) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(id)) {
				if (0 >= procurementService.deleteProcurement(id)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("删除采购订单（退货单）失败，请稍后重试~");
				} else {
					if (StringUtils.isNotBlank(isReturn) && "isReturn".equals(isReturn)) {
						if (!Procurement.STATE_FOUR.equals(procurementService.getProcurementById(id).getState())) {
							qrcodeService.updateAllQrcodeStateByProcurementId(Qrcode.STATE_ONE, id);
						}
					}
					ajaxJson.setSuccess(true);
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("删除采购订单（退货单）失败，请刷新页面后重试~");
				logger_procurementController.warn("删除采购订单（退货单）时，采购订单（退货单）ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_procurementController.error("删除采购订单（退货单）出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除退货单商品
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param id
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/returnDoDelete", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson returnDoDelete(@RequestParam(value = "procurementQrcodeId") String procurementQrcodeId,
			@RequestParam(value = "qrcodeId") String qrcodeId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(procurementQrcodeId)) {
				if (0 >= procurementQrcodeService.deleteProcurementQrcode(procurementQrcodeId)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("删除退货单商品失败，请稍后重试~");
				} else {
					if (0 >= qrcodeService.updateStateFourToOne(new Qrcode(qrcodeId))) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("删除退货单商品失败，请稍后重试~");
					} else {
						ajaxJson.setSuccess(true);
						ajaxJson.setMsg("删除退货单商品成功！");
					}
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("删除退货单商品失败，请刷新页面后重试~");
				logger_procurementController.warn("删除退货单商品时，商品ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_procurementController.error("删除退货单商品出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 保存采购退货单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param id
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/submitProcurement", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson submitProcurement(@RequestParam(value = "procurementId") String procurementId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(procurementId)) {
				List<ProcurementQrcode> procurementQrcodeList = procurementQrcodeService
						.getProcurementQrcodeListByProcurementId(procurementId);
				Procurement procurement = procurementService.getProcurementById(procurementId);
				procurement.setState(Procurement.STATE_ONE);
				procurement.setBuyCount(String.valueOf(procurementQrcodeList.size()));
				String sumMoney = "0";
				for (ProcurementQrcode procurementQrcode : procurementQrcodeList) {
					sumMoney = (DoubleUtil.add(sumMoney, procurementQrcode.getQrcode().getProcurementPrice())
							.toString());
				}
				procurement.setBuySumMoney(sumMoney);
				procurement.setCheckRemark(null);
				if (0 >= procurementService.update(procurement)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("提交退货单失败，请稍后重试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("提交退货单成功！");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("提交退货单失败，请刷新页面后重试~");
				logger_procurementController.warn("提交退货单时，商品ID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_procurementController.error("提交退货单出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 采购单打印
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月25日
	 * @param procurementId
	 * @return String
	 */
	@RequestMapping(value = "/procurementPrintView", method = RequestMethod.GET)
	public String procurementPrintView(@FormModel("procurementId") String procurementId) {
		Procurement procurement = procurementService.getProcurementById(procurementId);
		List<ProcurementGoods> procurementGoodsList = procurementGoodsService.getAllByProcurementId(procurementId);

		setAttribute("model", procurement);
		setAttribute("procurementGoodsList", procurementGoodsList);
		return "module/procurement/procurement-printView";
	}

	/**
	 *
	 * <P>
	 * 退货单打印
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月25日
	 * @param procurementId
	 * @return String
	 */
	@RequestMapping(value = "/returnProcurementPrintView", method = RequestMethod.GET)
	public String returnProcurementPrintView(@FormModel("procurementId") String procurementId) {
		List<ProcurementQrcode> procurementQrcodeList = procurementQrcodeService
				.getProcurementQrcodeListByProcurementId(procurementId);
		List<QrcodeVO> qrcodeVOList = new ArrayList<QrcodeVO>();
		for (ProcurementQrcode procurementQrcode : procurementQrcodeList) {
			Qrcode qrcode = qrcodeService.getQrcodeById(procurementQrcode.getQrcode().getId());
			QrcodeVO qrcodeVO = qrcodeService.getQrcodeVOByQrcode(qrcode);
			qrcodeVO.setProcurementQrcodeId(procurementQrcode.getId());
			qrcodeVOList.add(qrcodeVO);
		}
		Procurement procurement = procurementService.getProcurementById(procurementId);
		setAttribute("procurementId", procurementId);
		setAttribute("model", procurement);
		setAttribute("qrcodeVOList", qrcodeVOList);
		return "module/procurement/procurement-returnPrint";
	}
}