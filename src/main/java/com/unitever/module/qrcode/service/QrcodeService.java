package com.unitever.module.qrcode.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.zxing.WriterException;
import com.unitever.module.goods.model.Goods;
import com.unitever.module.goods.service.GoodsService;
import com.unitever.module.inventory.model.Inventory;
import com.unitever.module.inventory.service.InventoryService;
import com.unitever.module.order.dao.manual.OrderDAO;
import com.unitever.module.order.model.Order;
import com.unitever.module.procurement.model.Procurement;
import com.unitever.module.procurement.service.ProcurementService;
import com.unitever.module.procurementGoods.model.ProcurementGoods;
import com.unitever.module.procurementGoods.service.ProcurementGoodsService;
import com.unitever.module.qrcode.dao.manual.QrcodeDAO;
import com.unitever.module.qrcode.model.Qrcode;
import com.unitever.module.qrcode.vo.QrcodeVO;
import com.unitever.module.storage.model.Storage;
import com.unitever.module.storage.service.StorageService;
import com.unitever.module.weChat.service.WeChatService;
import com.unitever.module.weChat.util.WeChatUtil;
import com.unitever.platform.component.attachment.service.AttachmentConfigService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.external.UserUtil;
import com.unitever.platform.util.DoubleUtil;
import com.unitever.platform.util.ExceptionUtil;
import com.unitever.platform.util.QRCodeUtil;
import com.unitever.platform.util.ThreadPoolUtil;
import com.unitever.platform.util.UUID;

@Service
@Transactional
public class QrcodeService {
	private static Logger logger_qrcodeService = LoggerFactory.getLogger("QrcodeService");

	@Autowired
	private QrcodeDAO qrcodeDAO;
	@Autowired
	private AttachmentConfigService attachmentConfigService;
	@Autowired
	private ProcurementGoodsService procurementGoodsService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private InventoryService inventoryService;
	@Autowired
	private StorageService storageService;
	@Autowired
	private ProcurementService procurementService;
	@Autowired
	private OrderDAO orderDAO;
	@Autowired
	private WeChatService weChatService;

	/**
	 * <p>
	 * 根据ID获取Qrcode信息
	 * </p>
	 * 
	 * @param id
	 *            ：Qrcode的id
	 * @return Qrcode
	 */
	public Qrcode getQrcodeById(String id) {
		if (StringUtils.isBlank(id)) {
			return null;
		}
		return qrcodeDAO.get(id);
	}

	/**
	 * <p>
	 * 保存二维码记录
	 * </p>
	 * 
	 * @param Qrcode
	 *            ：Qrcode对象
	 */
	public void save(Qrcode qrcode) {
		if (qrcode != null) {
			qrcode.setId(UUID.getUUID());
			qrcodeDAO.save(qrcode);
		}
	}

	/**
	 * <p>
	 * 更新二维码信息记录
	 * </p>
	 * 
	 */
	public int update(Qrcode qrcode) {
		if (qrcode != null) {
			return qrcodeDAO.update(qrcode);
		}
		return 0;
	}

	/**
	 * <p>
	 * 删除二维码信息记录
	 * </p>
	 * 
	 */
	public void delete(String id) {
		if (StringUtils.isNotBlank(id)) {
			qrcodeDAO.delete(id);
		}
	}

	/**
	 * <p>
	 * 获取Qrcode分页对象
	 * </p>
	 * 
	 * @param page
	 * @param Qrcode
	 * @param isList
	 *            是否获取二维码生成明细（true 获取，false 不获取）
	 * @return
	 */
	public Page<Qrcode> getPage(Page<Qrcode> page, Qrcode qrcode, boolean isList) {
		if (StringUtils.isNotBlank(qrcode.getEndDate())) {
			qrcode.setEndDate(qrcode.getEndDate() + " 23:59:59");
		}
		if (isList) {
			page.setTotalRecord(qrcodeDAO.getCountByObject(qrcode));
			qrcode.setStartOfPage(page.getStartOfPage());
			qrcode.setPageSize(page.getPageSize());
			page.setResults(qrcodeDAO.getQrcodeListByQrcode(qrcode));
		} else {
			page.setTotalRecord(qrcodeDAO.getCountByQrcode(qrcode));
			qrcode.setStartOfPage(page.getStartOfPage());
			qrcode.setPageSize(page.getPageSize());
			page.setResults(qrcodeDAO.getQrcodeByQrcode(qrcode));
		}
		if (StringUtils.isNotBlank(qrcode.getEndDate())) {
			qrcode.setEndDate(qrcode.getEndDate().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 生成产品二维码图片
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 12, 2017
	 * @param number
	 *            印刷数量
	 * @param procurementGoodsId
	 *            采购单产品信息
	 * @return
	 * @throws WriterException
	 * @throws IOException
	 *             int
	 */
	public AjaxJson saveQRCode(int number, String procurementGoodsId, String storageId) throws WriterException,
			IOException {
		AjaxJson ajaxJson = new AjaxJson();
		if (0 < number && StringUtils.isNotBlank(procurementGoodsId) && StringUtils.isNotBlank(storageId)) {
			List<Qrcode> qrcodes = new ArrayList<Qrcode>();
			ProcurementGoods procurementGoods = procurementGoodsService.getProcurementGoodsById(procurementGoodsId);
			String printCuont = (number + Integer
					.parseInt(StringUtils.isNotBlank(procurementGoods.getPrintCount()) ? procurementGoods
							.getPrintCount() : "0"))
					+ "";
			if (Integer.parseInt(printCuont) > Integer.parseInt(procurementGoods.getBuyCount())) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("本次要打印数量，不可超过本产品剩余未打印数量");
				return ajaxJson;
			}
			Goods goods = procurementGoods.getGoods();
			Storage storage = storageService.getStorageById(storageId);
			// 获取二维码批次
			String qrcodeBatchValue = QRCodeUtil.getQrcodeBatch();
			String qrcodeSavePath = attachmentConfigService.getAttachmentConfigWithCode("qrcodeImg").getSaveDir()
					.replaceAll("\\\\", "/");
			if (!qrcodeSavePath.endsWith("/")) {
				qrcodeSavePath += "/";
			}
			qrcodeSavePath += goods.getId() + "/" + qrcodeBatchValue + "/";
			File file = new File(qrcodeSavePath);
			if (!file.exists()) {
				file.mkdirs();
			}
			// 生成二维码图片
			for (int i = 0; i < number; i++) {
				Qrcode qrcode = new Qrcode(UUID.getUUID(), goods, qrcodeBatchValue, procurementGoods.getBuyPrice(),
						procurementGoods.getBuyCount(), Qrcode.STATE_ONE, storage.getName(),
						procurementGoods.getProcurement(), new Date());
				qrcode.setStorage(storage);
				QRCodeUtil.saveQRCode(qrcode.getId(), 500, 500, qrcodeSavePath + qrcode.getId());
				qrcodes.add(qrcode);
			}
			if (0 >= procurementGoodsService.updatePrintNumber(procurementGoods.getId(), number,
					UserUtil.getCurrUserID())) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("亲，稍慢了一点，未打印数量不足了哦~");
				return ajaxJson;
			}
			if (0 < this.batchInsert(qrcodes)) {
				if (0 >= inventoryService.getInventoryCountByGoodsIdAndStorageId(goods.getId(), storageId)) {
					// 没有该库存记录，新增一条
					Inventory inventory = new Inventory(UUID.getUUID(), goods, number + "", DoubleUtil.mul(number + "",
							procurementGoods.getBuyPrice(), 2).toString(), storage, new Date());
					if (0 >= inventoryService.save(inventory)) {
						// 保存新记录失败，尝试修改库存量
						inventoryService.getAddInventoryNumberByGoodsIdAndStorageId(goods.getId(), storageId, number
								+ "", DoubleUtil.mul(number + "", procurementGoods.getBuyPrice()).toString());
					}
				} else {
					// 已有相应库存记录，更改库存值
					inventoryService.getAddInventoryNumberByGoodsIdAndStorageId(goods.getId(), storageId, number + "",
							DoubleUtil.mul(number + "", procurementGoods.getBuyPrice()).toString());
				}
				// 更新已打印张数
				if (StringUtils.isBlank(procurementGoods.getPrintUserID_string())
						|| 0 > procurementGoods.getPrintUserID_string().indexOf(UserUtil.getCurrUserID())) {
					procurementGoods.setPrintUserID_string((StringUtils.isNotBlank(procurementGoods
							.getPrintUserID_string()) ? procurementGoods.getPrintUserID_string() + "," : "")
							+ UserUtil.getCurrUserID());
				}
				Procurement procurement = procurementService.getProcurementById(procurementGoods.getProcurement()
						.getId());
				boolean isClose = true;
				for (ProcurementGoods proGods_ : procurement.getProcurementGoodsList()) {
					if (Integer.parseInt(proGods_.getBuyCount()) > Integer.parseInt(StringUtils.isNotBlank(proGods_
							.getPrintCount()) ? proGods_.getPrintCount() : "0")) {
						isClose = false;
						break;
					}
				}
				if (isClose) {
					procurement.setState(Procurement.STATE_FOUR);
					procurementService.update(procurement);
				}
				// 更新产品标价和售价
				goods.setPrice(procurementGoods.getGoodsPrice());
				goods.setSalesPrice(procurementGoods.getSalseMoney());
				// 设置子产品列表为空，
				goods.setGoodsChildList(null);
				goods.setGoodsChildListDelete(null);
				goods.setGoodsChildListNew(null);
				goodsService.updateGoodsAll(goods);
				final String goodsId = goods.getId();
				ThreadPoolUtil.getPool().execute(new Runnable() {
					@Override
					public void run() {
						// TODO 发放预约到货模板消息
						List<Order> orderList = orderDAO.getReserveOrderListByGoodsId(goodsId);
						if (null != orderList && !orderList.isEmpty()) {
							for (Order order : orderList) {
								try {
									if (null != order.getCustomer()
											&& StringUtils.isNotBlank(order.getCustomer().getId())) {
										if (0 < orderDAO.setMsgSendYes(order.getId(), goodsId)) {
											WeChatUtil.sendCustomerReserveOrder(order.getCustomer(), order,
													weChatService.getWeChatList().get(0));
										}
									}
								} catch (Exception e) {
									logger_qrcodeService.error("发送预约到货模板消息出错，具体错误如下："
											+ ExceptionUtil.getExceptionAllinformation(e, QrcodeService.class.getName()));
								}
							}
						}
					}
				});
				ajaxJson.setSuccess(true);
				ajaxJson.setMsg("生成二维码成功");
				ajaxJson.setObj(qrcodeBatchValue);
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("生成二维码失败，请重试~");
			}
		} else {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("生成二维码失败，请刷新页面后重试~");
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 批量保存二维码信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 12, 2017
	 * @param qrcodes
	 * @return int
	 */
	private int batchInsert(List<Qrcode> qrcodeList) {
		if (null != qrcodeList) {
			if (!qrcodeList.isEmpty()) {
				return qrcodeDAO.batchInsert(qrcodeList);
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 依据二维码批次号获取二维码列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 13, 2017
	 * @param qrcodeBatch
	 * @return Object
	 */
	public List<Qrcode> getQrcodeByQRCdodeBatch(String qrcodeBatch) {
		return qrcodeDAO.getQrcodeByQRCdodeBatch(qrcodeBatch);
	}

	/**
	 *
	 * <P>
	 * 依据二维码Id获取二维码list
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 14, 2017
	 * @param qrcodeBatch
	 * @return Object
	 */
	public List<Qrcode> getQrcodeListById(String id) {
		return qrcodeDAO.getQrcodeListById(id);
	}

	/**
	 *
	 * <P>
	 * 根据二维码生成VO
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月18日
	 * @param qrcode
	 * @return QrcodeVO
	 */
	public QrcodeVO getQrcodeVOByQrcode(Qrcode qrcode) {
		QrcodeVO qrcodeVO = new QrcodeVO();
		qrcodeVO.setStorageName(qrcode.getStorage().getName());
		qrcodeVO.setId(qrcode.getId());
		qrcodeVO.setQrcodeBatch(qrcode.getQrcodeBatch());
		qrcodeVO.setProcurementPrice(qrcode.getProcurementPrice());
		qrcodeVO.setGoodsId(qrcode.getGoods().getId());
		qrcodeVO.setGoodsSalePrice(qrcode.getGoods().getSalesPrice());
		if (StringUtils.isNotBlank(qrcode.getGoods().getName())) {
			qrcodeVO.setParentGoodsId(qrcode.getGoods().getId());
			qrcodeVO.setGoodsName(qrcode.getGoods().getName());
			qrcodeVO.setGoodsCode(qrcode.getGoods().getGoodsCode());
			qrcodeVO.setOther_attr_value("无");
		} else {
			qrcodeVO.setParentGoodsId(qrcode.getGoods().getGoods().getId());
			qrcodeVO.setGoodsName(qrcode.getGoods().getGoods().getName());
			qrcodeVO.setGoodsCode(qrcode.getGoods().getGoods().getGoodsCode());
			qrcodeVO.setOther_attr_value(qrcode.getGoods().getOther_attr_value());
		}
		qrcodeVO.setLogistics(qrcode.getLogistics());

		return qrcodeVO;
	}

	/**
	 *
	 * <P>
	 * 根据ProcurementId修改所有qrcode状态
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月12日
	 * @param state
	 * @param procurementId
	 * @return int
	 */
	public int updateAllQrcodeStateByProcurementId(String state, String procurementId) {
		return qrcodeDAO.updateAllQrcodeStateByProcurementId(state, procurementId);
	}

	/**
	 *
	 * <P>
	 * 根据AllocationId修改所有qrcode状态
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月12日
	 * @param state
	 * @param procurementId
	 * @return int
	 */
	public int updateAllQrcodeStateByAllocationId(String state, String procurementId) {
		return qrcodeDAO.updateAllQrcodeStateByAllocationId(state, procurementId);
	}

	/**
	 *
	 * <P>
	 * state由正常变锁定
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月12日
	 * @param state
	 * @param procurementId
	 * @return int
	 */
	public int updateStateOneToFour(Qrcode qrcode) {
		if (StringUtils.isBlank(qrcode.getId())) {
			return 0;
		} else {
			return qrcodeDAO.updateStateOneToFour(qrcode);
		}
	}

	/**
	 *
	 * <P>
	 * state由锁定变正常
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月17日
	 * @param id
	 * @return int
	 */
	public int updateStateFourToOne(Qrcode qrcode) {
		if (StringUtils.isBlank(qrcode.getId())) {
			return 0;
		} else {
			return qrcodeDAO.updateStateFourToOne(qrcode);
		}
	}

	/**
	 *
	 * <P>
	 * state由锁定变卖出
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月17日
	 * @param id
	 * @return int
	 */
	public int updateStateFourToTwo(Qrcode qrcode) {
		if (StringUtils.isBlank(qrcode.getId())) {
			return 0;
		} else {
			return qrcodeDAO.updateStateFourToTwo(qrcode);
		}
	}

	/**
	 *
	 * <P>
	 * state由卖出变正常
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月17日
	 * @param id
	 * @return int
	 */
	public int updateStateTwoToOne(Qrcode qrcode) {
		if (StringUtils.isBlank(qrcode.getId())) {
			return 0;
		} else {
			return qrcodeDAO.updateStateTwoToOne(qrcode);
		}
	}

	/**
	 *
	 * <P>
	 * state由正常变卖出
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月17日
	 * @param id
	 * @return int
	 */
	public int updateStateOneToTwo(Qrcode qrcode) {
		if (StringUtils.isBlank(qrcode.getId())) {
			return 0;
		} else {
			return qrcodeDAO.updateStateOneToTwo(qrcode);
		}

	}

	/**
	 *
	 * <P>
	 * 根据orderId修改qrcode状态从锁定为正常
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月17日
	 * @param id
	 * @return int
	 */
	public int updateStateFourToOneByOrderId(String orderId) {
		return qrcodeDAO.updateStateFourToOneByOrderId(orderId);
	}

	/**
	 *
	 * <P>
	 * 依据订单Ordercode获取订单赠品QrcodeList
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 3, 2017
	 * @param orderCode
	 * @return List<Qrcode>
	 */
	public List<Qrcode> getPutOutQrcodeListByOrderCode(String orderCode) {
		return StringUtils.isBlank(orderCode) ? null : qrcodeDAO.getPutOutQrcodeListByOrderCode(orderCode);
	}
}