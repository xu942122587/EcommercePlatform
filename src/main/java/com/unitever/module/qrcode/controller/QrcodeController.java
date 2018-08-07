package com.unitever.module.qrcode.controller;

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
import com.unitever.module.allocationQrcode.model.AllocationQrcode;
import com.unitever.module.allocationQrcode.service.AllocationQrcodeService;
import com.unitever.module.order.model.Order;
import com.unitever.module.order.service.OrderService;
import com.unitever.module.orderGoods.model.OrderGoods;
import com.unitever.module.orderGoods.service.OrderGoodsService;
import com.unitever.module.procurement.model.Procurement;
import com.unitever.module.procurement.service.ProcurementService;
import com.unitever.module.procurementQrcode.model.ProcurementQrcode;
import com.unitever.module.procurementQrcode.service.ProcurementQrcodeService;
import com.unitever.module.qrcode.model.Qrcode;
import com.unitever.module.qrcode.service.QrcodeService;
import com.unitever.module.qrcode.vo.QrcodeVO;
import com.unitever.module.storage.service.StorageService;
import com.unitever.module.store.service.StoreService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.external.UserUtil;
import com.unitever.platform.core.web.argument.annotation.FormModel;
import com.unitever.platform.core.web.controller.SpringController;
import com.unitever.platform.util.DoubleUtil;
import com.unitever.platform.util.ExceptionUtil;

@Controller
@RequestMapping(value = "/qrcode")
public class QrcodeController extends SpringController {

	@Autowired
	private QrcodeService qrcodeService;
	@Autowired
	private AllocationQrcodeService allocationQrcodeService;
	@Autowired
	private StorageService storageService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private OrderGoodsService orderGoodsService;
	@Autowired
	private ProcurementService procurementService;
	@Autowired
	private StoreService storeService;
	@Autowired
	private ProcurementQrcodeService procurementQrcodeService;

	private Logger logger_qrcodeController = LoggerFactory.getLogger("QrcodeController");

	/**
	 * 跳转至二维码信息列表页面
	 * 
	 * @param page
	 * @param propaganda
	 * @return
	 */
	@RequestMapping(value = "/list")
	public String list(@FormModel("page") Page<Qrcode> page, @FormModel("model") Qrcode qrcode,
			@RequestParam(value = "isList", required = false) String isList) {
		User userSession = UserUtil.getCurrUser();
		if (!Role.TYPE_EMPLOYEE.equals(userSession.getRole().getType())) {
			setAttribute("storeList", storeService.getAllTianheStore());
		} else {
			qrcode.setStoreId(userSession.getStore().getId());
		}
		if (StringUtils.isNotBlank(qrcode.getId())) {
			setAttribute("pageObj", qrcodeService.getPage(page, qrcode, true));
			isList = "true";
		} else if (StringUtils.isBlank(isList)) {
			setAttribute("pageObj", qrcodeService.getPage(page, qrcode, false));
		} else {
			if ("true".equals(isList)) {
				setAttribute("pageObj", qrcodeService.getPage(page, qrcode, true));
			} else {
				setAttribute("pageObj", qrcodeService.getPage(page, qrcode, false));
			}
		}
		setAttribute("isList", isList);
		setAttribute("model", qrcode);
		return "module/qrcode/qrcode-list";
	}

	/**
	 * 跳转至查看二维码信息
	 * 
	 * @return
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(@RequestParam(value = "id") String id) {
		setAttribute("model", qrcodeService.getQrcodeById(id));
		return "module/qrcode/qrcode-view";
	}

	/**
	 *
	 * <P>
	 * 生成二维码
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 12, 2017
	 * @param procurementGoodsId
	 *            采购单产品ID
	 * @param number
	 *            生成数量
	 * @param storageId
	 *            仓库ID
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveOrUpdate(@RequestParam(value = "procurementGoodsId") String procurementGoodsId,
			@RequestParam(value = "number") String number, @RequestParam(value = "storageId") String storageId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			ajaxJson = qrcodeService.saveQRCode(Integer.parseInt(number), procurementGoodsId, storageId);
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_qrcodeController.error(
					"生成产品二维码出错，具体错误如下：" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 跳转二维码生成页面
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 13, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/input", method = RequestMethod.GET)
	public String input(@RequestParam(value = "proCode", required = false) String proCode) {
		setAttribute("proCode", proCode);
		if (StringUtils.isNotBlank(proCode)) {
			setAttribute("model", procurementService.getProcurementByProCode(proCode));
			User user = UserUtil.getCurrUser();
			if (Role.TYPE_EMPLOYEE.equals(user.getRole().getType())) {
				setAttribute("storageList", storageService.getAllStoreStorageList(user.getStore().getId()));
			} else {
				setAttribute("storageList", storageService.getAll());
			}
		}
		return "module/qrcode/qrcode-input";
	}

	/**
	 *
	 * <P>
	 * 跳转二维码打印页面
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 13, 2017
	 * @param id
	 * @return String
	 */
	@RequestMapping(value = "/printQRCode", method = RequestMethod.GET)
	public String printQRCode(@RequestParam(value = "qrcodeBatch", required = false) String qrcodeBatch,
			@RequestParam(value = "qrcodeId", required = false) String qrcodeId) {
		if (StringUtils.isNotBlank(qrcodeId)) {
			setAttribute("qrcodeList", qrcodeService.getQrcodeListById(qrcodeId));
		} else if (StringUtils.isNotBlank(qrcodeBatch)) {
			setAttribute("qrcodeList", qrcodeService.getQrcodeByQRCdodeBatch(qrcodeBatch));
		}
		return "module/qrcode/qrcode-printQRCode";
	}

	@RequestMapping(value = "/doDelete", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doDelete(String id) {
		AjaxJson json = new AjaxJson();
		qrcodeService.delete(id);
		json.setSuccess(true);
		return json;
	}

	/**
	 *
	 * <P>
	 * 依据QRCodeID获取产品信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月17日
	 * @param qrcodeID
	 * @param storeId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/getQrcodeByQrcodeId", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson getGoodsByQrcodeId(@RequestParam(value = "QrcodeID") String qrcodeID,
			@RequestParam(value = "storeId") String storeId, @RequestParam(value = "allocationId") String allocationId,
			@RequestParam(value = "storageId") String storageId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(qrcodeID)) {
				Qrcode qrcode = qrcodeService.getQrcodeById(qrcodeID);
				if (Qrcode.STATE_FOUR.equals(qrcode.getState())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("本商品已经被锁定,请检查!");
				} else if (Qrcode.STATE_TWO.equals(qrcode.getState())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("本商品已售出,请检查!");
				} else if (Qrcode.STATE_THREE.equals(qrcode.getState())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("本商品已退还厂家,请检查!");
				} else {
					if (StringUtils.isNotBlank(storeId)) {
						if (StringUtils.isNotBlank(storageId)) {
							if (storageId.equals(qrcode.getStorage().getId())) {
								if (storeId.equals(qrcode.getGoods().getStore().getId())) {
									AllocationQrcode allocationQrcode = new AllocationQrcode();
									allocationQrcode.setQrcode(qrcode);
									allocationQrcode.setAllocation(new Allocation(allocationId));
									allocationQrcode.setGoods(qrcode.getGoods());
									String allocationQrcodeId = allocationQrcodeService.save(allocationQrcode);
									if (StringUtils.isBlank(allocationQrcodeId)) {
										ajaxJson.setSuccess(false);
										ajaxJson.setMsg("保存库存调拨失败，请稍后重试~");
									} else {
										QrcodeVO qrcodeVO = qrcodeService.getQrcodeVOByQrcode(qrcode);
										qrcodeVO.setAllocationQrcodeId(allocationQrcodeId);
										ajaxJson.setSuccess(true);
										ajaxJson.setMsg("获取产品信息成功");
										qrcodeService.updateStateOneToFour(qrcode);
										ajaxJson.setObj(qrcodeVO);
									}
								} else {
									ajaxJson.setSuccess(false);
									ajaxJson.setMsg("该商品不在所选门店内，请重试~");
								}
							} else {
								ajaxJson.setSuccess(false);
								ajaxJson.setMsg("该商品不在所选仓库内，请重试~");
							}
						} else {
							ajaxJson.setSuccess(false);
							ajaxJson.setMsg("获取产品信息失败，请刷新页面后重试~");
							logger_qrcodeController.warn("获取产品信息时，storageID为空，请检查代码实现~");
						}
					} else {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("获取产品信息失败，请刷新页面后重试~");
						logger_qrcodeController.warn("获取产品信息时，storeID为空，请检查代码实现~");
					}
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("获取产品信息失败，请刷新页面后重试~");
				logger_qrcodeController.warn("获取产品信息时，qrcodeID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_qrcodeController.error("依据qrcodeID获取产品信息--出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 依据QRCodeID获取产品信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月17日
	 * @param qrcodeID
	 * @param storeId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/getQrcodeByQrcodeIdForProcurement", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson getQrcodeByQrcodeIdForProcurement(@RequestParam(value = "QrcodeID") String qrcodeID,
			@RequestParam(value = "storeId") String storeId,
			@RequestParam(value = "procurementId") String procurementId) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(qrcodeID)) {
				Qrcode qrcode = qrcodeService.getQrcodeById(qrcodeID);
				if (Qrcode.STATE_FOUR.equals(qrcode.getState())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("本商品已经被锁定,请检查!");
				} else if (Qrcode.STATE_TWO.equals(qrcode.getState())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("本商品已售出,请检查!");
				} else if (Qrcode.STATE_THREE.equals(qrcode.getState())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("本商品已退还厂家,请检查!");
				} else {
					if (StringUtils.isNotBlank(storeId)) {
						if (storeId.equals(qrcode.getGoods().getStore().getId())) {
							ProcurementQrcode procurementQrcode = new ProcurementQrcode();
							procurementQrcode.setQrcode(qrcode);
							procurementQrcode.setProcurement(new Procurement(procurementId));
							String procurementQrcodeId = procurementQrcodeService.save(procurementQrcode);
							if (StringUtils.isBlank(procurementQrcodeId)) {
								ajaxJson.setSuccess(false);
								ajaxJson.setMsg("添加退货二维码失败，请稍后重试~");
							} else {
								QrcodeVO qrcodeVO = qrcodeService.getQrcodeVOByQrcode(qrcode);
								qrcodeVO.setProcurementQrcodeId(procurementQrcodeId);
								ajaxJson.setSuccess(true);
								ajaxJson.setMsg("添加产品信息成功");
								qrcodeService.updateStateOneToFour(qrcode);
								ajaxJson.setObj(qrcodeVO);
							}
						} else {
							ajaxJson.setSuccess(false);
							ajaxJson.setMsg("该商品不在所选门店内，请重试~");
						}
					} else {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("获取产品信息失败，请刷新页面后重试~");
						logger_qrcodeController.warn("获取产品信息时，storeID为空，请检查代码实现~");
					}
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("获取产品信息失败，请刷新页面后重试~");
				logger_qrcodeController.warn("获取产品信息时，qrcodeID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_qrcodeController.error("依据qrcodeID获取产品信息--出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 依据QRCodeID获取产品信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月17日
	 * @param qrcodeID
	 * @param storeId
	 * @return AjaxJson
	 */
	@RequestMapping(value = "/getQrcodeByQrcodeIdForOrder", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson getQrcodeByQrcodeIdForOrder(@RequestParam(value = "QrcodeID") String qrcodeID) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isNotBlank(qrcodeID)) {
				Qrcode qrcode = qrcodeService.getQrcodeById(qrcodeID);
				if (null != UserUtil.getCurrUser().getStore()
						&& UserUtil.getCurrUser().getStore().getId().equals(qrcode.getGoods().getStore().getId())) {
					if (Qrcode.STATE_FOUR.equals(qrcode.getState())) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("本商品已经被锁定,请检查!");
					} else if (Qrcode.STATE_TWO.equals(qrcode.getState())) {
						QrcodeVO qrcodeVO = qrcodeService.getQrcodeVOByQrcode(qrcode);
						Order order = orderService.getOrderByQrcodeId(qrcodeID);
						if (null != order && StringUtils.isNotBlank(order.getId())) {
							if (Order.TYPE_ONE.equals(order.getType())) {
								if (Order.STATE_FOUR.equals(order.getState())
										|| Order.STATE_FIVE.equals(order.getState())
										|| Order.STATE_SIX.equals(order.getState())) {
									OrderGoods orderGoods = orderGoodsService.getOrderGoodsByQrcodeId(qrcodeID).get(0);
									qrcodeVO.setGoodsSalePrice(orderGoods.getPrice());
									qrcodeVO.setSubMoney(DoubleUtil
											.div(orderGoods.getSubMoney(), orderGoods.getCount(), 2).toString());
								}
							} else {
								if (Order.STATE_SIX.equals(order.getState())) {
									OrderGoods orderGoods = orderGoodsService.getOrderGoodsByQrcodeId(qrcodeID).get(0);
									qrcodeVO.setGoodsSalePrice(orderGoods.getPrice());
									qrcodeVO.setSubMoney(DoubleUtil
											.div(orderGoods.getSubMoney(), orderGoods.getCount(), 2).toString());
								}
							}
						}
						ajaxJson.setSuccess(true);
						ajaxJson.setMsg("添加产品信息成功");
						ajaxJson.setObj(qrcodeVO);
					} else if (Qrcode.STATE_ONE.equals(qrcode.getState())) {
						QrcodeVO qrcodeVO = qrcodeService.getQrcodeVOByQrcode(qrcode);
						ajaxJson.setSuccess(true);
						ajaxJson.setMsg("添加产品信息成功");
						ajaxJson.setObj(qrcodeVO);
					}
				} else if (null == UserUtil.getCurrUser().getStore()) {
					if (Qrcode.STATE_FOUR.equals(qrcode.getState())) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("本商品已经被锁定,请检查!");
					} else if (Qrcode.STATE_TWO.equals(qrcode.getState())) {
						QrcodeVO qrcodeVO = qrcodeService.getQrcodeVOByQrcode(qrcode);
						Order order = orderService.getOrderByQrcodeId(qrcodeID);
						if (null != order && StringUtils.isNotBlank(order.getId())) {
							if (Order.TYPE_ONE.equals(order.getType())) {
								if (Order.STATE_FOUR.equals(order.getState())
										|| Order.STATE_FIVE.equals(order.getState())
										|| Order.STATE_SIX.equals(order.getState())) {
									OrderGoods orderGoods = orderGoodsService.getOrderGoodsByQrcodeId(qrcodeID).get(0);
									qrcodeVO.setGoodsSalePrice(orderGoods.getPrice());
									qrcodeVO.setSubMoney(DoubleUtil
											.div(orderGoods.getSubMoney(), orderGoods.getCount(), 2).toString());
								}
							} else {
								if (Order.STATE_SIX.equals(order.getState())) {
									OrderGoods orderGoods = orderGoodsService.getOrderGoodsByQrcodeId(qrcodeID).get(0);
									qrcodeVO.setGoodsSalePrice(orderGoods.getPrice());
									qrcodeVO.setSubMoney(DoubleUtil
											.div(orderGoods.getSubMoney(), orderGoods.getCount(), 2).toString());
								}
							}
						}
						ajaxJson.setSuccess(true);
						ajaxJson.setMsg("添加产品信息成功");
						ajaxJson.setObj(qrcodeVO);
					} else if (Qrcode.STATE_ONE.equals(qrcode.getState())) {
						QrcodeVO qrcodeVO = qrcodeService.getQrcodeVOByQrcode(qrcode);
						ajaxJson.setSuccess(true);
						ajaxJson.setMsg("添加产品信息成功");
						ajaxJson.setObj(qrcodeVO);
					}
				} else {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("该商品不属于本门店!");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("获取产品信息失败，请刷新页面后重试~");
				logger_qrcodeController.warn("获取产品信息时，qrcodeID为空，请检查代码实现~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲~服务器一个不小心就走丢了，请稍后刷新页面重试~");
			logger_qrcodeController.error("依据qrcodeID获取产品信息--出错，具体错误如下：\r\n"
					+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}
}