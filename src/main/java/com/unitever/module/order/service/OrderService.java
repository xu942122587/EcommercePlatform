package com.unitever.module.order.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.joda.time.DateTime;
import org.joda.time.Minutes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.zxing.WriterException;
import com.unitever.auth.user.model.User;
import com.unitever.module.consume.dao.manual.ConsumeDAO;
import com.unitever.module.consume.model.Consume;
import com.unitever.module.customer.dao.manual.CustomerDAO;
import com.unitever.module.customer.model.Customer;
import com.unitever.module.eticket.model.Eticket;
import com.unitever.module.eticketoutRecord.dao.manual.EticketOutRecordDAO;
import com.unitever.module.eticketoutRecord.model.EticketOutRecord;
import com.unitever.module.eticketoutRecord.service.EticketOutRecordService;
import com.unitever.module.eticketuseRecord.dao.manual.EticketUseRecordDAO;
import com.unitever.module.eticketuseRecord.model.EticketUseRecord;
import com.unitever.module.goods.controller.GoodsController;
import com.unitever.module.goods.model.Goods;
import com.unitever.module.goods.service.GoodsService;
import com.unitever.module.inventory.service.InventoryService;
import com.unitever.module.order.dao.manual.OrderDAO;
import com.unitever.module.order.model.Order;
import com.unitever.module.order.model.OrderVo;
import com.unitever.module.orderGoods.dao.manual.OrderGoodsDAO;
import com.unitever.module.orderGoods.model.OrderGoods;
import com.unitever.module.orderGoods.vo.OrderGoodsVo;
import com.unitever.module.orderGoodsQrcode.dao.manual.OrderGoodsQrcodeDAO;
import com.unitever.module.orderGoodsQrcode.model.OrderGoodsQrcode;
import com.unitever.module.orderSubremark.dao.manual.OrderSubremarkDAO;
import com.unitever.module.orderSubremark.model.OrderSubremark;
import com.unitever.module.postageBonus.model.PostageBonus;
import com.unitever.module.postageBonus.service.PostageBonusService;
import com.unitever.module.promotion.model.Promotion;
import com.unitever.module.promotionGroup.model.PromotionGroup;
import com.unitever.module.promotionGroup.service.PromotionGroupService;
import com.unitever.module.promotionLadder.model.PromotionLadder;
import com.unitever.module.qrcode.dao.manual.QrcodeDAO;
import com.unitever.module.qrcode.model.Qrcode;
import com.unitever.module.qrcode.service.QrcodeService;
import com.unitever.module.qrcode.vo.QrcodeVO;
import com.unitever.module.store.model.Store;
import com.unitever.module.store.service.StoreService;
import com.unitever.module.weChat.service.WeChatService;
import com.unitever.module.weChat.util.WeChatUtil;
import com.unitever.platform.component.attachment.service.AttachmentConfigService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.external.UserUtil;
import com.unitever.platform.core.spring.SpringContextHolder;
import com.unitever.platform.util.AlipayApiUtil;
import com.unitever.platform.util.DateUtil;
import com.unitever.platform.util.DoubleUtil;
import com.unitever.platform.util.ExceptionUtil;
import com.unitever.platform.util.OrderCodeID;
import com.unitever.platform.util.QRCodeUtil;
import com.unitever.platform.util.ThreadPoolUtil;
import com.unitever.platform.util.UUID;
import com.unitever.platform.util.WeChatScanPayUtil;
import com.unitever.tencent.bridge.BridgeForRefundBusinessTest;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.order.service->OrderService.java
 * </p>
 * <P>
 * 订单
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月7日
 */
@Service
@Transactional
public class OrderService {

	private Logger logger_orderService = LoggerFactory.getLogger("OrderService");

	@Autowired
	private OrderDAO orderDAO;
	@Autowired
	private OrderGoodsDAO orderGoodsDAO;
	@Autowired
	private PostageBonusService postageBonusService;
	@Autowired
	private OrderSubremarkDAO orderSubremarkDAO;
	@Autowired
	private WeChatService weChatService;
	@Autowired
	private QrcodeDAO qrcodeDAO;
	@Autowired
	private OrderGoodsQrcodeDAO orderGoodsQrcodeDAO;
	@Autowired
	private PromotionGroupService promotionGroupService;
	@Autowired
	private InventoryService inventoryService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private QrcodeService qrcodeService;
	@Autowired
	private AttachmentConfigService attachmentConfigService;
	@Autowired
	private CustomerDAO customerDAO;
	@Autowired
	private ConsumeDAO consumeDAO;
	@Autowired
	private EticketOutRecordService eticketOutRecordService;
	@Autowired
	private EticketOutRecordDAO eticketOutRecordDAO;
	@Autowired
	private EticketUseRecordDAO eticketUseRecordDAO;
	@Autowired
	private StoreService storeService;

	/**
	 *
	 * <P>
	 * 根据用户和状态获取订单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年3月17日
	 * @param customerId
	 * @param state
	 * @return List<Object>
	 */
	public List<OrderVo> getOrderGroupByBatchCodeByCustomerIdAndState(String customerId, String state) {
		return orderDAO.getOrderGroupByBatchCodeByCustomerIdAndState(customerId, state);
	}

	/**
	 *
	 * <P>
	 * 保存新订单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param order
	 * @return int
	 */
	public int save(Order order) {
		if (order != null) {
			order.setId(UUID.getUUID());
			order.setCreateTime(new Date());
			order.setCode(OrderCodeID.nextCode());
			int i = orderDAO.save(order);
			return i;
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 更新订单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param order
	 * @return int
	 */
	public int update(Order order) {
		if (null != order) {
			if (StringUtils.isNotBlank(order.getId())) {
				int i = orderDAO.update(order);
				return i;
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 根据Id获取订单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param id
	 * @return Order
	 */
	public Order getOrderById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return orderDAO.get(id);
		}
		return null;
	}

	/**
	 *
	 * <P>
	 * 根据订单获取订单列表
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param order
	 * @return List<Order>
	 */
	public List<Order> getOrderByOrder(Order order) {
		return orderDAO.getOrderByOrder(order);
	}

	/**
	 *
	 * 根据ParentOrder获取
	 *
	 * @author 徐昊
	 * @date 2017年6月29日
	 * @param order
	 * @return List<Order>
	 */
	public List<Order> getParentOrderByParentOrder(Order order) {
		return orderDAO.getParentOrderByParentOrder(order);
	}

	/**
	 *
	 * <P>
	 * 获取符合当前条件的订单数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param order
	 * @return int
	 */
	public int getCountByOrder(Order order) {
		return orderDAO.getCountByOrder(order);
	}

	/**
	 *
	 * <P>
	 * 获取订单分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param page
	 * @param order
	 * @return Page<Order>
	 */
	public Page<Order> getPage(Page<Order> page, Order order) {
		if (StringUtils.isNotBlank(order.getEndDate())) {
			order.setEndDate(order.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(orderDAO.getCountByObject(order));
		order.setStartOfPage(page.getStartOfPage());
		order.setPageSize(page.getPageSize());
		page.setResults(orderDAO.getParentOrderByParentOrder(order));
		if (StringUtils.isNotBlank(order.getEndDate())) {
			order.setEndDate(order.getEndDate().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 获取订单分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param page
	 * @param order
	 * @return Page<Order>
	 */
	public Page<Order> getSameChangePage(Page<Order> page, Order order) {
		if (StringUtils.isNotBlank(order.getEndDate())) {
			order.setEndDate(order.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(orderDAO.getCountByOrder(order));
		order.setStartOfPage(page.getStartOfPage());
		order.setPageSize(page.getPageSize());
		page.setResults(orderDAO.getOrderByOrder(order));
		if (StringUtils.isNotBlank(order.getEndDate())) {
			order.setEndDate(order.getEndDate().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 同商品换货
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月16日
	 * @param orderId
	 * @param oldQrcodeId
	 * @param newQrcodeId
	 * @return int
	 */
	public AjaxJson sameChangeSave(String orderId, String oldQrcodeId, String newQrcodeId) {
		AjaxJson ajaxJson = new AjaxJson();
		if (StringUtils.isNotBlank(orderId) && StringUtils.isNotBlank(oldQrcodeId)
				&& StringUtils.isNotBlank(newQrcodeId)) {
			Order parentOrder = orderDAO.get(orderId);
			Qrcode oldQrcode = qrcodeService.getQrcodeById(oldQrcodeId);
			Qrcode newQrcode = qrcodeService.getQrcodeById(newQrcodeId);
			OrderGoodsQrcode orderGoodsQrcode = orderGoodsQrcodeDAO.getOrderGoodsQrcodeByOrderGoodsQrcode(
					new OrderGoodsQrcode(null, null, oldQrcode, null, null)).get(0);
			OrderGoods orderGoods = orderGoodsDAO.getOrderGoodsByOrderGoods(
					new OrderGoods(orderGoodsQrcode.getOrderGoods().getId())).get(0);

			Order order = new Order();
			order.setId(UUID.getUUID());
			if (null != parentOrder.getCustomer() && StringUtils.isNotBlank(parentOrder.getCustomer().getId())) {
				order.setCustomer(parentOrder.getCustomer());
			}
			if (null != parentOrder.getGuideUser() && StringUtils.isNotBlank(parentOrder.getGuideUser().getId())) {
				order.setGuideUser(parentOrder.getGuideUser());
			}
			order.setStore(parentOrder.getStore());
			order.setSubMoney("0.0");
			order.setSumMoney("0.0");
			order.setSumNumber("0");
			order.setPayMoney("0.0");

			order.setOnePayMoney("0.0");
			order.setOneReturnMoney("0.0");
			order.setTwoPayMoney("0.0");
			order.setTwoReturnMoney("0.0");

			order.setOrder(new Order(orderId));
			order.setType(Order.TYPE_SEVEN);
			order.setState(Order.STATE_SIX);
			order.setCreateTime(new Date());
			order.setCode(OrderCodeID.nextCode());

			this.saveOrderCodeQrcodeImg(order.getCode());

			if (0 >= orderDAO.save(order)) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("换货失败");
			} else {
				OrderGoods oldOrderGoods = new OrderGoods();
				OrderGoods newOrderGoods = new OrderGoods();

				oldOrderGoods.setId(UUID.getUUID());
				newOrderGoods.setId(UUID.getUUID());
				oldOrderGoods.setOrder(order);
				newOrderGoods.setOrder(order);
				oldOrderGoods.setGoods(oldQrcode.getGoods());
				newOrderGoods.setGoods(newQrcode.getGoods());
				oldOrderGoods.setCount("1");
				newOrderGoods.setCount("1");
				oldOrderGoods.setPrice(orderGoods.getPrice());
				newOrderGoods.setPrice(orderGoods.getPrice());
				oldOrderGoods.setCreateTime(new Date());
				newOrderGoods.setCreateTime(new Date());
				oldOrderGoods.setSubMoney(DoubleUtil.mul(
						DoubleUtil.div(orderGoods.getSubMoney(), orderGoods.getCount()).toString(),
						oldOrderGoods.getCount(), 2).toString());
				newOrderGoods.setSubMoney(DoubleUtil.mul(
						DoubleUtil.div(orderGoods.getSubMoney(), orderGoods.getCount()).toString(),
						newOrderGoods.getCount(), 2).toString());
				oldOrderGoods.setType(OrderGoods.TYPE_RETURN_TIANHE);
				newOrderGoods.setType(OrderGoods.TYPE_OUT);
				if (0 >= orderGoodsDAO.save(oldOrderGoods) || 0 >= orderGoodsDAO.save(newOrderGoods)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("换货失败");
				} else {
					OrderGoodsQrcode oldOrderGoodsQrcode = new OrderGoodsQrcode();
					OrderGoodsQrcode newOrderGoodsQrcode = new OrderGoodsQrcode();

					oldOrderGoodsQrcode.setId(UUID.getUUID());
					newOrderGoodsQrcode.setId(UUID.getUUID());
					oldOrderGoodsQrcode.setOrderGoods(oldOrderGoods);
					newOrderGoodsQrcode.setOrderGoods(newOrderGoods);
					oldOrderGoodsQrcode.setQrcode(oldQrcode);
					newOrderGoodsQrcode.setQrcode(newQrcode);
					oldOrderGoodsQrcode.setIsJoin(orderGoodsQrcode.getIsJoin());
					newOrderGoodsQrcode.setIsJoin(orderGoodsQrcode.getIsJoin());
					oldOrderGoodsQrcode.setCreateTime(new Date());
					newOrderGoodsQrcode.setCreateTime(new Date());
					if (0 >= orderGoodsQrcodeDAO.save(oldOrderGoodsQrcode)
							|| 0 >= orderGoodsQrcodeDAO.save(newOrderGoodsQrcode)) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("换货失败");
					} else {
						oldQrcode.setLogistics(oldQrcode.getStorage().getName());

						newQrcode.setLogistics("卖出");

						if (0 >= qrcodeDAO.updateStateTwoToOne(oldQrcode)
								|| 0 >= qrcodeDAO.updateStateOneToTwo(newQrcode)) {
							ajaxJson.setSuccess(false);
							ajaxJson.setMsg("换货失败");
						} else {
							if (0 >= inventoryService.getSubInventoryNumberByGoodsIdAndStorageId(newOrderGoods
									.getGoods().getId(), newQrcode.getStorage().getId(), "1", newQrcode
									.getProcurementPrice())
									|| 0 >= inventoryService.getAddInventoryNumberByGoodsIdAndStorageId(oldOrderGoods
											.getGoods().getId(), oldQrcode.getStorage().getId(), "1", oldQrcode
											.getProcurementPrice())) {
								ajaxJson.setSuccess(false);
								ajaxJson.setMsg("换货失败");
							} else {
								ajaxJson.setSuccess(true);
								ajaxJson.setMsg("换货成功");
								ajaxJson.setObj(order.getId());
							}

						}
					}
				}
			}
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 换货
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月16日
	 * @param orderId
	 * @param oldQrcodeId
	 * @param newQrcodeId
	 * @return int
	 */
	public AjaxJson changeSave(String orderId, List<QrcodeVO> oldQrcodeVOList, List<QrcodeVO> newQrcodeVOList) {
		AjaxJson ajaxJson = new AjaxJson();
		if (null != oldQrcodeVOList && !oldQrcodeVOList.isEmpty() && null != newQrcodeVOList
				&& !newQrcodeVOList.isEmpty() && null != orderId && StringUtils.isNotBlank(orderId)) {
			Order parentOrder = orderDAO.get(orderId);

			String newSubMoney = "0";
			String newSumMoney = "0";
			String newSumNumber = "0";
			String newPayMoney = "0";
			for (QrcodeVO qrcodeVO : newQrcodeVOList) {
				if (qrcodeVO != null && StringUtils.isNotBlank(qrcodeVO.getId())) {
					newSubMoney = DoubleUtil.add(newSubMoney, qrcodeVO.getSubMoney()).toString();
					newSumMoney = DoubleUtil.add(newSumMoney, qrcodeVO.getStrikePrice()).toString();
					newSumNumber = ((Integer.parseInt(newSumNumber) + 1) + "");
				}
			}
			newPayMoney = DoubleUtil.sub(newSumMoney, newSubMoney).toString();

			String oldSubMoney = "0";
			String oldSumMoney = "0";
			String oldSumNumber = "0";
			String oldPayMoney = "0";
			for (QrcodeVO qrcodeVO : oldQrcodeVOList) {
				if (qrcodeVO != null && StringUtils.isNotBlank(qrcodeVO.getId())) {
					oldSubMoney = DoubleUtil.add(oldSubMoney, qrcodeVO.getSubMoney()).toString();
					oldSumMoney = DoubleUtil.add(oldSumMoney, qrcodeVO.getStrikePrice()).toString();
					oldSumNumber = ((Integer.parseInt(oldSumNumber) + 1) + "");
				}
			}
			oldPayMoney = DoubleUtil.sub(oldSumMoney, oldSubMoney).toString();

			if (0F < DoubleUtil.sub(oldPayMoney, newPayMoney)) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("换货商品价值必须大于待换商品价值~");
				return ajaxJson;
			}

			Order order = new Order();
			order.setId(UUID.getUUID());
			if (null != parentOrder.getCustomer() && StringUtils.isNotBlank(parentOrder.getCustomer().getId())) {
				order.setCustomer(parentOrder.getCustomer());
			}
			if (null != parentOrder.getGuideUser() && StringUtils.isNotBlank(parentOrder.getGuideUser().getId())) {
				order.setGuideUser(parentOrder.getGuideUser());
			}
			if (null != UserUtil.getCurrUser().getStore()
					&& StringUtils.isNotBlank(UserUtil.getCurrUser().getStore().getId())) {
				order.setStore(UserUtil.getCurrUser().getStore());
			} else {
				order.setStore(parentOrder.getStore());
			}
			order.setSubMoney(DoubleUtil.sub(newSubMoney, oldSubMoney).toString());
			order.setSumMoney(DoubleUtil.sub(newSumMoney, oldSumMoney).toString());
			order.setSumNumber((Integer.parseInt(newSumNumber) - Integer.parseInt(oldSumNumber)) + "");
			order.setPayMoney(DoubleUtil.sub(newPayMoney, oldPayMoney).toString());

			// 设置首次支付金额、未退款金额、第二次支付金额、第二次未退款金额
			order.setOnePayMoney(DoubleUtil.toDecimalString(order.getPayMoney(), 1));
			order.setOneReturnMoney(DoubleUtil.toDecimalString(order.getPayMoney(), 1));
			order.setTwoPayMoney("0.0");
			order.setTwoReturnMoney("0.0");

			order.setOrder(new Order(orderId));
			order.setType(Order.TYPE_SIX);
			order.setState(Order.STATE_ONE);
			order.setCreateTime(new Date());
			order.setCode(OrderCodeID.nextCode());

			List<OrderGoods> newOrderGoodsList = new ArrayList<OrderGoods>();
			List<OrderGoods> oldOrderGoodsList = new ArrayList<OrderGoods>();

			Iterator<QrcodeVO> it_newQrcode = newQrcodeVOList.iterator();
			Iterator<QrcodeVO> it_oldQrcode = oldQrcodeVOList.iterator();
			while (it_newQrcode.hasNext()) {
				QrcodeVO qrcodeVO = it_newQrcode.next();
				if (null != qrcodeVO && StringUtils.isNotBlank(qrcodeVO.getId())) {
					boolean isHaveOrderGoods = false;
					for (OrderGoods orderGoods_for : newOrderGoodsList) {
						if (orderGoods_for.getGoods().getId().equals(qrcodeVO.getGoodsId())
								&& 0F == DoubleUtil.sub(
										DoubleUtil.div(orderGoods_for.getSubMoney(), orderGoods_for.getCount())
												.toString(), qrcodeVO.getSubMoney())) {
							orderGoods_for.setSubMoney(DoubleUtil.add(orderGoods_for.getSubMoney(),
									qrcodeVO.getSubMoney()).toString());
							orderGoods_for.setCount((Integer.parseInt(orderGoods_for.getCount()) + 1) + "");
							List<OrderGoodsQrcode> ogqList = orderGoods_for.getoGQList();
							ogqList.add(new OrderGoodsQrcode(UUID.getUUID(), orderGoods_for, new Qrcode(qrcodeVO
									.getId()), OrderGoodsQrcode.ISJOIN_NO, new Date()));
							orderGoods_for.setoGQList(ogqList);
							isHaveOrderGoods = true;
							break;
						}
					}
					if (!isHaveOrderGoods) {
						OrderGoods orderGoods_for = new OrderGoods(UUID.getUUID(), order, new Goods(
								qrcodeVO.getGoodsId()), "1", qrcodeVO.getStrikePrice(), qrcodeVO.getSubMoney(),
								OrderGoods.TYPE_OUT, new Date());
						List<OrderGoodsQrcode> ogqList = orderGoods_for.getoGQList();
						if (null == ogqList || ogqList.isEmpty()) {
							ogqList = new ArrayList<OrderGoodsQrcode>();
						}
						ogqList.add(new OrderGoodsQrcode(UUID.getUUID(), orderGoods_for, new Qrcode(qrcodeVO.getId()),
								OrderGoodsQrcode.ISJOIN_NO, new Date()));
						orderGoods_for.setoGQList(ogqList);
						newOrderGoodsList.add(orderGoods_for);
					}
					it_newQrcode.remove();
				}
			}

			while (it_oldQrcode.hasNext()) {
				QrcodeVO qrcodeVO = it_oldQrcode.next();
				if (null != qrcodeVO && StringUtils.isNotBlank(qrcodeVO.getId())) {
					boolean isHaveOrderGoods = false;
					for (OrderGoods orderGoods_for : oldOrderGoodsList) {
						if (orderGoods_for.getGoods().getId().equals(qrcodeVO.getGoodsId())
								&& 0F == DoubleUtil.sub(
										DoubleUtil.div(orderGoods_for.getSubMoney(), orderGoods_for.getCount())
												.toString(), qrcodeVO.getSubMoney())) {
							orderGoods_for.setSubMoney(DoubleUtil.add(orderGoods_for.getSubMoney(),
									qrcodeVO.getSubMoney()).toString());
							orderGoods_for.setCount((Integer.parseInt(orderGoods_for.getCount()) + 1) + "");
							List<OrderGoodsQrcode> ogqList = orderGoods_for.getoGQList();
							ogqList.add(new OrderGoodsQrcode(UUID.getUUID(), orderGoods_for, new Qrcode(qrcodeVO
									.getId()), OrderGoodsQrcode.ISJOIN_NO, new Date()));
							orderGoods_for.setoGQList(ogqList);
							isHaveOrderGoods = true;
							break;
						}
					}
					if (!isHaveOrderGoods) {
						OrderGoods orderGoods_for = new OrderGoods(UUID.getUUID(), order, new Goods(
								qrcodeVO.getGoodsId()), "1", qrcodeVO.getStrikePrice(), qrcodeVO.getSubMoney(),
								OrderGoods.TYPE_RETURN_TIANHE, new Date());
						List<OrderGoodsQrcode> ogqList = orderGoods_for.getoGQList();
						if (null == ogqList || ogqList.isEmpty()) {
							ogqList = new ArrayList<OrderGoodsQrcode>();
						}
						ogqList.add(new OrderGoodsQrcode(UUID.getUUID(), orderGoods_for, new Qrcode(qrcodeVO.getId()),
								OrderGoodsQrcode.ISJOIN_NO, new Date()));
						orderGoods_for.setoGQList(ogqList);
						oldOrderGoodsList.add(orderGoods_for);
					}
					it_oldQrcode.remove();
				}
			}

			oldOrderGoodsList.addAll(newOrderGoodsList);
			order.setOrderGoodList(oldOrderGoodsList);
			List<Order> changeOrderList = new ArrayList<Order>();
			changeOrderList.add(order);
			parentOrder.setOrderList(changeOrderList);

			if (0 < this.saveChangeOeder(parentOrder)) {
				ajaxJson.setSuccess(true);
				ajaxJson.setMsg("换货成功");
				ajaxJson.setObj(order.getId());
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("换货失败");
			}
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 保存换货订单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月22日
	 * @param order
	 * @return int
	 */
	public int saveChangeOeder(Order order) {
		if (null != order) {
			this.saveOrderCodeQrcodeImg(order.getOrderList().get(0).getCode());
			int i = orderDAO.update(order);
			if (0 < i) {
				for (Order child_order : order.getOrderList()) {
					if (0F == DoubleUtil.sub(child_order.getPayMoney(), "0")&& 0F == DoubleUtil.sub(child_order.getSumNumber(), "0")) {
						child_order.setState(Order.STATE_SIX);
						if (0 < orderDAO.save(child_order)) {
							for (OrderGoods orderGoods : child_order.getOrderGoodList()) {
								if (OrderGoods.TYPE_RETURN_TIANHE.equals(orderGoods.getType())) {
									if (0 < orderGoodsDAO.save(orderGoods)) {
										// 保存二维码（如果有）
										List<OrderGoodsQrcode> orderGoodsQrcoedes = orderGoods.getoGQList();
										if (null != orderGoodsQrcoedes && !orderGoodsQrcoedes.isEmpty()) {
											for (OrderGoodsQrcode orderGoodsQrcoede : orderGoodsQrcoedes) {
												if (0 < orderGoodsQrcodeDAO.save(orderGoodsQrcoede)) {
													Qrcode qrcode = qrcodeService.getQrcodeById(orderGoodsQrcoede
															.getQrcode().getId());
													inventoryService.getAddInventoryNumberByGoodsIdAndStorageId(qrcode
															.getGoods().getId(), qrcode.getStorage().getId(), "1",
															qrcode.getProcurementPrice());
													orderGoodsQrcoede.getQrcode().setLogistics(
															qrcode.getStorage().getName());
													qrcodeService.updateStateTwoToOne(orderGoodsQrcoede.getQrcode());// TODO
												}
											}
										}
									}
								} else {
									if (0 < orderGoodsDAO.save(orderGoods)) {
										// 保存二维码（如果有）
										List<OrderGoodsQrcode> orderGoodsQrcoedes = orderGoods.getoGQList();
										if (null != orderGoodsQrcoedes && !orderGoodsQrcoedes.isEmpty()) {
											for (OrderGoodsQrcode orderGoodsQrcoede : orderGoodsQrcoedes) {
												if (0 < orderGoodsQrcodeDAO.save(orderGoodsQrcoede)) {
													Qrcode qrcode = qrcodeService.getQrcodeById(orderGoodsQrcoede
															.getQrcode().getId());
													inventoryService.getSubInventoryNumberByGoodsIdAndStorageId(qrcode
															.getGoods().getId(), qrcode.getStorage().getId(), "1",
															qrcode.getProcurementPrice());
													orderGoodsQrcoede.getQrcode().setLogistics("卖出");
													qrcodeService.updateStateOneToTwo(orderGoodsQrcoede.getQrcode());
												}
											}
										}
									}
								}
							}
						}
					}else if(0F == DoubleUtil.sub(child_order.getPayMoney(), "0")&& 0F != DoubleUtil.sub(child_order.getSumNumber(), "0")){
						child_order.setState(Order.STATE_SIX);
						if (0 < orderDAO.save(child_order)) {
							if (0 >= this.updateAddParentOrderMoney(child_order.getId())) {
								return 0;
							} else {
								for (OrderGoods orderGoods : child_order.getOrderGoodList()) {
									if (OrderGoods.TYPE_RETURN_TIANHE.equals(orderGoods.getType())) {
										if (0 < orderGoodsDAO.save(orderGoods)) {
											// 保存二维码（如果有）
											List<OrderGoodsQrcode> orderGoodsQrcoedes = orderGoods.getoGQList();
											if (null != orderGoodsQrcoedes && !orderGoodsQrcoedes.isEmpty()) {
												for (OrderGoodsQrcode orderGoodsQrcoede : orderGoodsQrcoedes) {
													if (0 < orderGoodsQrcodeDAO.save(orderGoodsQrcoede)) {
														Qrcode qrcode = qrcodeService.getQrcodeById(orderGoodsQrcoede
																.getQrcode().getId());
														inventoryService.getAddInventoryNumberByGoodsIdAndStorageId(qrcode
																.getGoods().getId(), qrcode.getStorage().getId(), "1",
																qrcode.getProcurementPrice());
														orderGoodsQrcoede.getQrcode().setLogistics(
																qrcode.getStorage().getName());
														qrcodeService.updateStateTwoToOne(orderGoodsQrcoede.getQrcode());// TODO
													}
												}
											}
										}
									} else {
										if (0 < orderGoodsDAO.save(orderGoods)) {
											// 保存二维码（如果有）
											List<OrderGoodsQrcode> orderGoodsQrcoedes = orderGoods.getoGQList();
											if (null != orderGoodsQrcoedes && !orderGoodsQrcoedes.isEmpty()) {
												for (OrderGoodsQrcode orderGoodsQrcoede : orderGoodsQrcoedes) {
													if (0 < orderGoodsQrcodeDAO.save(orderGoodsQrcoede)) {
														Qrcode qrcode = qrcodeService.getQrcodeById(orderGoodsQrcoede
																.getQrcode().getId());
														inventoryService.getSubInventoryNumberByGoodsIdAndStorageId(qrcode
																.getGoods().getId(), qrcode.getStorage().getId(), "1",
																qrcode.getProcurementPrice());
														orderGoodsQrcoede.getQrcode().setLogistics("卖出");
														qrcodeService.updateStateOneToTwo(orderGoodsQrcoede.getQrcode());
													}
												}
											}
										}
									}
								}
							}
						}
					} else {
						if (0 < orderDAO.save(child_order)) {
							if (0 >= this.updateAddParentOrderMoney(child_order.getId())) {
								return 0;
							} else {
								for (OrderGoods orderGoods : child_order.getOrderGoodList()) {
									if (OrderGoods.TYPE_RETURN_TIANHE.equals(orderGoods.getType())) {
										if (0 < orderGoodsDAO.save(orderGoods)) {
											// 保存二维码（如果有）
											List<OrderGoodsQrcode> orderGoodsQrcoedes = orderGoods.getoGQList();
											if (null != orderGoodsQrcoedes && !orderGoodsQrcoedes.isEmpty()) {
												for (OrderGoodsQrcode orderGoodsQrcoede : orderGoodsQrcoedes) {
													orderGoodsQrcodeDAO.save(orderGoodsQrcoede);
												}
											}
										}
									} else {
										if (0 < orderGoodsDAO.save(orderGoods)) {
											// 保存二维码（如果有）
											List<OrderGoodsQrcode> orderGoodsQrcoedes = orderGoods.getoGQList();
											if (null != orderGoodsQrcoedes && !orderGoodsQrcoedes.isEmpty()) {
												for (OrderGoodsQrcode orderGoodsQrcoede : orderGoodsQrcoedes) {
													if (0 < orderGoodsQrcodeDAO.save(orderGoodsQrcoede)) {
														qrcodeService.updateStateOneToFour(orderGoodsQrcoede
																.getQrcode());
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
			return i;
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 退货
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月16日
	 * @param orderId
	 * @param oldQrcodeId
	 * @return int
	 */
	public AjaxJson returnSave(String orderId, List<QrcodeVO> oldQrcodeVOList) {
		AjaxJson ajaxJson = new AjaxJson();
		if (null != oldQrcodeVOList && !oldQrcodeVOList.isEmpty() && null != orderId && StringUtils.isNotBlank(orderId)) {
			Order parentOrder = orderDAO.get(orderId);

			String oldSubMoney = "0";
			String oldSumMoney = "0";
			String oldSumNumber = "0";
			String oldPayMoney = "0";
			for (QrcodeVO qrcodeVO : oldQrcodeVOList) {
				if (qrcodeVO != null && StringUtils.isNotBlank(qrcodeVO.getId())) {
					oldSubMoney = DoubleUtil.add(oldSubMoney, qrcodeVO.getSubMoney()).toString();
					oldSumMoney = DoubleUtil.add(oldSumMoney, qrcodeVO.getStrikePrice()).toString();
					oldSumNumber = ((Integer.parseInt(oldSumNumber) + 1) + "");
				}
			}
			oldPayMoney = DoubleUtil.sub(oldSumMoney, oldSubMoney).toString();

			Order order = new Order();
			order.setId(UUID.getUUID());
			if (null != parentOrder.getCustomer() && StringUtils.isNotBlank(parentOrder.getCustomer().getId())) {
				order.setCustomer(parentOrder.getCustomer());
			}
			if (null != parentOrder.getGuideUser() && StringUtils.isNotBlank(parentOrder.getGuideUser().getId())) {
				order.setGuideUser(parentOrder.getGuideUser());
			}
			if (null != UserUtil.getCurrUser().getStore()
					&& StringUtils.isNotBlank(UserUtil.getCurrUser().getStore().getId())) {
				order.setStore(UserUtil.getCurrUser().getStore());
			} else {
				order.setStore(parentOrder.getStore());
			}
			order.setSubMoney(DoubleUtil.sub("0", oldSubMoney).toString());
			order.setSumMoney(DoubleUtil.sub("0", oldSumMoney).toString());
			order.setSumNumber((Integer.parseInt("0") - Integer.parseInt(oldSumNumber)) + "");
			order.setPayMoney(DoubleUtil.sub("0", oldPayMoney).toString());
			order.setOrder(new Order(orderId));
			order.setType(Order.TYPE_FIVE);
			order.setState(Order.STATE_ONE);
			order.setCreateTime(new Date());
			order.setCode(OrderCodeID.nextCode());

			// 设置首次支付金额、未退款金额、第二次支付金额、第二次未退款金额
			if (0 <= order.getPayMoney().indexOf(".") && 2 <= order.getPayMoney().split("\\.")[1].length()) {
				order.setOnePayMoney(order.getPayMoney().split("\\.")[0] + "."
						+ order.getPayMoney().split("\\.")[1].substring(0, 1));// 天和应支付给消费者的金额
				order.setOneReturnMoney(order.getPayMoney().split("\\.")[0] + "."
						+ order.getPayMoney().split("\\.")[1].substring(0, 1));// 设置退款单剩余未退款金额
			} else {
				order.setOnePayMoney(order.getPayMoney());// 天和应支付给消费者的金额
				order.setOneReturnMoney(order.getPayMoney());// 设置退款单剩余未退款金额
			}
			order.setTwoPayMoney("0.0");
			order.setTwoReturnMoney("0.0");

			List<OrderGoods> oldOrderGoodsList = new ArrayList<OrderGoods>();

			Iterator<QrcodeVO> it_oldQrcode = oldQrcodeVOList.iterator();

			while (it_oldQrcode.hasNext()) {
				QrcodeVO qrcodeVO = it_oldQrcode.next();
				if (null != qrcodeVO && StringUtils.isNotBlank(qrcodeVO.getId())) {
					boolean isHaveOrderGoods = false;
					for (OrderGoods orderGoods_for : oldOrderGoodsList) {
						if (orderGoods_for.getGoods().getId().equals(qrcodeVO.getGoodsId())
								&& 0F == DoubleUtil.sub(
										DoubleUtil.div(orderGoods_for.getSubMoney(), orderGoods_for.getCount())
												.toString(), qrcodeVO.getSubMoney())) {
							orderGoods_for.setSubMoney(DoubleUtil.add(orderGoods_for.getSubMoney(),
									qrcodeVO.getSubMoney()).toString());
							orderGoods_for.setCount((Integer.parseInt(orderGoods_for.getCount()) + 1) + "");
							List<OrderGoodsQrcode> ogqList = orderGoods_for.getoGQList();
							ogqList.add(new OrderGoodsQrcode(UUID.getUUID(), orderGoods_for, new Qrcode(qrcodeVO
									.getId()), OrderGoodsQrcode.ISJOIN_NO, new Date()));
							orderGoods_for.setoGQList(ogqList);
							isHaveOrderGoods = true;
							break;
						}
					}
					if (!isHaveOrderGoods) {
						OrderGoods orderGoods_for = new OrderGoods(UUID.getUUID(), order, new Goods(
								qrcodeVO.getGoodsId()), "1", qrcodeVO.getStrikePrice(), qrcodeVO.getSubMoney(),
								OrderGoods.TYPE_RETURN_TIANHE, new Date());
						List<OrderGoodsQrcode> ogqList = orderGoods_for.getoGQList();
						if (null == ogqList || ogqList.isEmpty()) {
							ogqList = new ArrayList<OrderGoodsQrcode>();
						}
						ogqList.add(new OrderGoodsQrcode(UUID.getUUID(), orderGoods_for, new Qrcode(qrcodeVO.getId()),
								OrderGoodsQrcode.ISJOIN_NO, new Date()));
						orderGoods_for.setoGQList(ogqList);
						oldOrderGoodsList.add(orderGoods_for);
					}
					it_oldQrcode.remove();
				}
			}

			order.setOrderGoodList(oldOrderGoodsList);
			List<Order> changeOrderList = new ArrayList<Order>();
			changeOrderList.add(order);
			parentOrder.setOrderList(changeOrderList);

			if (0 < this.saveReturnOeder(parentOrder)) {
				ajaxJson.setSuccess(true);
				ajaxJson.setMsg("退货成功");
				ajaxJson.setObj(order.getId());
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("退货失败");
			}

		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 保存退货订单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月22日
	 * @param order
	 * @return int
	 */
	public int saveReturnOeder(Order order) {
		if (null != order) {
			this.saveOrderCodeQrcodeImg(order.getOrderList().get(0).getCode());

			int i = orderDAO.update(order);
			if (0 < i) {
				for (Order child_order : order.getOrderList()) {
					if (0 < orderDAO.save(child_order)) {
						if (0 >= this.updateAddParentOrderMoney(child_order.getId())) {
							return 0;
						} else {
							for (OrderGoods orderGoods : child_order.getOrderGoodList()) {
								if (OrderGoods.TYPE_RETURN_TIANHE.equals(orderGoods.getType())) {
									if (0 < orderGoodsDAO.save(orderGoods)) {
										// 保存二维码（如果有）
										List<OrderGoodsQrcode> orderGoodsQrcoedes = orderGoods.getoGQList();
										if (null != orderGoodsQrcoedes && !orderGoodsQrcoedes.isEmpty()) {
											for (OrderGoodsQrcode orderGoodsQrcoede : orderGoodsQrcoedes) {
												orderGoodsQrcodeDAO.save(orderGoodsQrcoede);
											}
										}
									}
								}
							}
						}
					}
				}
			}
			return i;
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 赔偿单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月16日
	 * @param orderId
	 * @param oldQrcodeId
	 * @return int
	 */
	public AjaxJson reparationSave(String orderId, List<QrcodeVO> oldQrcodeVOList) {
		AjaxJson ajaxJson = new AjaxJson();
		if (null != oldQrcodeVOList && !oldQrcodeVOList.isEmpty() && null != orderId && StringUtils.isNotBlank(orderId)) {
			Order parentOrder = orderDAO.get(orderId);
			List<OrderGoods> oldOrderGoodsList = new ArrayList<OrderGoods>();
			Order order = new Order();

			String subMoney = "0";
			String sumMoney = "0";
			String sumNumber = "0";
			String payMoney = "0";

			order.setId(UUID.getUUID());
			if (null != parentOrder.getCustomer() && StringUtils.isNotBlank(parentOrder.getCustomer().getId())) {
				order.setCustomer(parentOrder.getCustomer());
			}
			if (null != parentOrder.getGuideUser() && StringUtils.isNotBlank(parentOrder.getGuideUser().getId())) {
				order.setGuideUser(parentOrder.getGuideUser());
			}

			if (null != UserUtil.getCurrUser().getStore()
					&& StringUtils.isNotBlank(UserUtil.getCurrUser().getStore().getId())) {
				order.setStore(UserUtil.getCurrUser().getStore());
			} else {
				order.setStore(parentOrder.getStore());
			}
			order.setOrder(new Order(orderId));
			order.setType(Order.TYPE_EIGHT);
			order.setState(Order.STATE_ONE);
			order.setCreateTime(new Date());
			order.setCode(OrderCodeID.nextCode());

			for (QrcodeVO qrcodeVO : oldQrcodeVOList) {
				if (qrcodeVO != null && StringUtils.isNotBlank(qrcodeVO.getId())) {
					Qrcode qrcode = qrcodeService.getQrcodeById(qrcodeVO.getId());
					Order childOrder = orderDAO.getThreeOrderByOrderCodeAndQrcodeId(parentOrder.getCode(),
							qrcode.getId());
					if (null != childOrder && StringUtils.isNotBlank(childOrder.getId())) {
						String orderGoodsPrice = "";
						for (OrderGoods orderGoods : childOrder.getOrderGoodList()) {
							boolean isThis = false;
							for (OrderGoodsQrcode orderGoodsQrcode : orderGoods.getoGQList()) {
								if (qrcodeVO.getId().equals(orderGoodsQrcode.getQrcode().getId())) {
									isThis = true;
									break;
								}
							}
							if (isThis) {
								orderGoodsPrice = DoubleUtil.sub(qrcode.getGoods().getSalesPrice(),
										orderGoods.getPrice()).toString();
								if (0 > DoubleUtil.compareTo(orderGoodsPrice, "0")) {
									orderGoodsPrice = "0";
								}
								break;
							}
						}
						OrderGoods orderGoods_for = new OrderGoods(UUID.getUUID(), order, new Goods(qrcode.getGoods()
								.getId()), "1", orderGoodsPrice, subMoney, OrderGoods.TYPE_OUT, new Date());
						List<OrderGoodsQrcode> ogqList = orderGoods_for.getoGQList();
						if (null == ogqList || ogqList.isEmpty()) {
							ogqList = new ArrayList<OrderGoodsQrcode>();
						}
						ogqList.add(new OrderGoodsQrcode(UUID.getUUID(), orderGoods_for, new Qrcode(qrcode.getId()),
								OrderGoodsQrcode.ISJOIN_NO, new Date()));
						orderGoods_for.setoGQList(ogqList);
						oldOrderGoodsList.add(orderGoods_for);
						sumMoney = DoubleUtil.add(sumMoney, orderGoodsPrice, 2).toString();
						payMoney = DoubleUtil.add(payMoney,
								DoubleUtil.sub(qrcode.getGoods().getSalesPrice(), orderGoodsPrice).toString(), 2)
								.toString();
						sumNumber = ((Integer.parseInt(sumNumber) + 1) + "");
					} else {
						sumMoney = DoubleUtil.add(sumMoney, qrcode.getGoods().getSalesPrice(), 2).toString();
						payMoney = DoubleUtil.add(payMoney, qrcode.getGoods().getSalesPrice(), 2).toString();
						sumNumber = ((Integer.parseInt(sumNumber) + 1) + "");
						OrderGoods orderGoods_for = new OrderGoods(UUID.getUUID(), order, new Goods(qrcode.getGoods()
								.getId()), "1", qrcode.getGoods().getSalesPrice(), subMoney, OrderGoods.TYPE_OUT,
								new Date());
						List<OrderGoodsQrcode> ogqList = orderGoods_for.getoGQList();
						if (null == ogqList || ogqList.isEmpty()) {
							ogqList = new ArrayList<OrderGoodsQrcode>();
						}
						ogqList.add(new OrderGoodsQrcode(UUID.getUUID(), orderGoods_for, new Qrcode(qrcodeVO.getId()),
								OrderGoodsQrcode.ISJOIN_NO, new Date()));
						orderGoods_for.setoGQList(ogqList);
						oldOrderGoodsList.add(orderGoods_for);

					}
				}
			}
			order.setSubMoney(subMoney);
			order.setSumMoney(DoubleUtil.add(sumMoney, "0", 1).toString());
			order.setSumNumber(sumNumber);
			order.setPayMoney(order.getSumMoney());

			order.setOnePayMoney(order.getPayMoney());// 天和应支付给消费者的金额
			order.setOneReturnMoney(order.getPayMoney());// 设置退款单剩余未退款金额
			order.setTwoPayMoney("0.0");
			order.setTwoReturnMoney("0.0");
			order.setOrderGoodList(oldOrderGoodsList);
			List<Order> changeOrderList = new ArrayList<Order>();
			changeOrderList.add(order);
			parentOrder.setOrderList(changeOrderList);

			if (0 < this.saveReparationOeder(parentOrder)) {
				ajaxJson.setSuccess(true);
				ajaxJson.setMsg("赔偿成功");
				ajaxJson.setObj(order.getId());
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("赔偿失败");
			}

		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 保存赔偿订单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月22日
	 * @param order
	 * @return int
	 */
	public int saveReparationOeder(Order order) {
		if (null != order) {
			this.saveOrderCodeQrcodeImg(order.getOrderList().get(0).getCode());

			int i = orderDAO.update(order);
			if (0 < i) {// TODO
				for (Order child_order : order.getOrderList()) {
					if (0 < orderDAO.save(child_order)) {
						if (0 >= this.updateAddParentOrderMoney(child_order.getId())) {
							return 0;
						} else {
							for (OrderGoods orderGoods : child_order.getOrderGoodList()) {
								if (OrderGoods.TYPE_OUT.equals(orderGoods.getType())) {
									if (0 < orderGoodsDAO.save(orderGoods)) {
										// 保存二维码（如果有）
										List<OrderGoodsQrcode> orderGoodsQrcoedes = orderGoods.getoGQList();
										if (null != orderGoodsQrcoedes && !orderGoodsQrcoedes.isEmpty()) {
											for (OrderGoodsQrcode orderGoodsQrcoede : orderGoodsQrcoedes) {
												orderGoodsQrcodeDAO.save(orderGoodsQrcoede);
											}
										}
									}
								}
							}
						}
					}
				}
			}
			return i;
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 根据子订单Id更新主订单金额
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月22日
	 * @param order
	 * @return int
	 */
	public int updateAddParentOrderMoney(String orderId) {
		if (StringUtils.isNotBlank(orderId)) {
			Order order = this.getOrderById(orderId);
			Order parentOrder = order.getOrder();
			parentOrder.setSubMoney(DoubleUtil.add(parentOrder.getSubMoney(), order.getSubMoney()).toString());
			parentOrder.setSumMoney(DoubleUtil.add(parentOrder.getSumMoney(), order.getSumMoney()).toString());
			parentOrder.setSumNumber((Integer.parseInt(parentOrder.getSumNumber()) + Integer.parseInt(order
					.getSumNumber())) + "");
			parentOrder.setPayMoney(DoubleUtil.add(parentOrder.getPayMoney(), order.getPayMoney()).toString());
			if (0 >= this.update(parentOrder)) {
				return 0;
			} else {
				return 1;
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 根据子订单Id更新主订单金额
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月22日
	 * @param order
	 * @return int
	 */
	public int updateSubParentOrderMoney(String orderId) {
		if (StringUtils.isNotBlank(orderId)) {
			Order order = this.getOrderById(orderId);
			Order parentOrder = order.getOrder();
			parentOrder.setSubMoney(DoubleUtil.sub(parentOrder.getSubMoney(), order.getSubMoney()).toString());
			parentOrder.setSumMoney(DoubleUtil.sub(parentOrder.getSumMoney(), order.getSumMoney()).toString());
			parentOrder.setSumNumber((Integer.parseInt(parentOrder.getSumNumber()) - Integer.parseInt(order
					.getSumNumber())) + "");
			parentOrder.setPayMoney(DoubleUtil.sub(parentOrder.getPayMoney(), order.getPayMoney()).toString());
			if (0 >= this.update(parentOrder)) {
				return 0;
			} else {
				return 1;
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 放弃未支付订单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月22日
	 * @param order
	 * @return int
	 */
	public int updateOrderStateBySeven(String orderId) {
		if (StringUtils.isNotBlank(orderId)) {
			Order order = this.getOrderById(orderId);
			if (Order.STATE_ONE.equals(order.getState())) {
				order.setState(Order.STATE_SEVEN);
				if (0 >= this.update(order)) {
					return 0;
				} else {
					if (null != order.getOrder() && StringUtils.isNotBlank(order.getOrder().getId())) {
						if (Order.TYPE_THREE.equals(order.getType())) {
							String OSM_ID_STRING = "";
							for (OrderGoods orderGoods : order.getOrderGoodList()) {
								OSM_ID_STRING += orderGoods.getOSM_ID();
							}
							if (0 >= orderSubremarkDAO.setNoFinishByOSM_ID(OSM_ID_STRING)) {
								throw new Error("设置换购类活动为未发放失败，回滚数据");
							} else {
								if (0 >= this.updateSubParentOrderMoney(order.getId())) {
									throw new Error("换购单放弃 时更新主订单信息失败，回滚数据~");
								} else {
									return 1;
								}
							}
						} else if (Order.TYPE_FIVE.equals(order.getType())) {
							if (0 >= this.updateSubParentOrderMoney(order.getId())) {
								throw new Error("退货单放弃 时更新主订单信息失败，回滚数据~");
							} else {
								return 1;
							}
						} else if (Order.TYPE_EIGHT.equals(order.getType())) {
							if (0 >= this.updateSubParentOrderMoney(order.getId())) {
								throw new Error("赔偿单放弃 时更新主订单信息失败，回滚数据~");
							} else {
								return 1;
							}
						} else {
							if (0 >= this.updateSubParentOrderMoney(order.getId())) {
								throw new Error("其他订单放弃 时更新主订单信息失败，回滚数据~");
							} else {
								if (0 >= qrcodeService.updateStateFourToOneByOrderId(order.getId())) {
									throw new Error("依据订单ID更新二维码状态由锁定变正常失败，回滚数据，订单ID：" + order.getId());
								} else {
									return 1;
								}
							}
						}
					} else {
						int i = 0;
						for (Order childOrder : order.getOrderList()) {
							childOrder.setState(Order.STATE_SEVEN);
							if (0 >= this.update(childOrder)) {
								throw new Error("放弃子订单失败，回滚数据，订单ID：" + order.getId());
							} else {
								i = 1;
								boolean idNeedUpdateQrcode = false;
								if (Order.TYPE_FOUR.equals(childOrder.getType())) {
									for (OrderGoods orderGoods : childOrder.getOrderGoodList()) {
										if (null != orderGoods.getoGQList() && !orderGoods.getoGQList().isEmpty()) {
											idNeedUpdateQrcode = true;
										}
										if (idNeedUpdateQrcode)
											break;
									}
								} else if (Order.TYPE_ONE.equals(childOrder.getType())) {
									for (OrderGoods orderGoods : childOrder.getOrderGoodList()) {
										if (null != orderGoods.getoGQList() && !orderGoods.getoGQList().isEmpty()) {
											idNeedUpdateQrcode = true;
										}
										if (idNeedUpdateQrcode)
											break;
									}
								} else {
									idNeedUpdateQrcode = true;
								}
								if (idNeedUpdateQrcode) {
									if (0 >= qrcodeService.updateStateFourToOneByOrderId(childOrder.getId())) {
										throw new Error("依据订单ID更新二维码状态由锁定变正常失败，回滚数据，订单ID：" + childOrder.getId());
									} else {
										i = 1;
									}
								}
							}
						}
						return i;
					}
				}
			} else {
				return 0;
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 根据qrcodeId获取主订单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月16日
	 * @param qrcodeId
	 * @return Order
	 */
	public Order getOrderByQrcodeId(String qrcodeId) {
		if (StringUtils.isNotBlank(qrcodeId))
			return orderDAO.getOrderByQrcodeId(qrcodeId);
		return null;
	}

	/**
	 *
	 * <P>
	 * 删除订单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param id
	 * @return int
	 */
	public int deleteOrder(String id) {
		if (StringUtils.isNotBlank(id)) {
			return orderDAO.delete(id);
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 获取所有订单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @return List<Order>
	 */
	public List<Order> getAllOrder() {
		return orderDAO.getAll();
	}

	/**
	 *
	 * <P>
	 * 根据用户获取订单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月2日
	 * @param customerId
	 * @return List<Order>
	 */
	public List<Order> getOrderByCustomerId(String customerId) {
		return orderDAO.getOrderByCustomerId(customerId);
	}

	/**
	 *
	 * <P>
	 * 依据活动切割订单(无需切割的 请直接走 电子券等)
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 10, 2017
	 * @param orderGoodsList
	 *            可参与活动的产品列表(务必传入同一门店的产品)
	 * @param order
	 *            主订单
	 * @param isOnline
	 *            线上线下
	 * @return Map<String, Goods> 切割好的各级活动的订单
	 *         key值：goodsOrder对应产品级活动子订单，storeOrder对应门店级活动子订单，
	 *         tianheOrder对应天和级活动子订单，otherOrder代表无活动子订单产品
	 * @throws Exception
	 */
	public Map<String, Order> splitOrderGoods(List<OrderGoods> orderGoodsList, Order order, String isOnline) {
		if (null == orderGoodsList || orderGoodsList.isEmpty()) {
			return null;
		}
		Map<String, Order> order_map_to_return = new HashMap<>();
		List<PromotionGroup> promGroupList = promotionGroupService
				.getAllPromotionGroupByStoreId(order.getStore().getId(), order.getPayType(), isOnline);
		if (null == promGroupList || promGroupList.isEmpty()) {
			// 当前没有活动
			String sumMoney = "0.0";
			int sumNumber = 0;
			for (OrderGoods orderGoods : orderGoodsList) {
				sumMoney = DoubleUtil
						.add(sumMoney, DoubleUtil.mul(orderGoods.getCount(), orderGoods.getPrice()).toString())
						.toString();
				sumNumber += Integer.parseInt(orderGoods.getCount());
			}
			Order otherOrder = new Order();
			otherOrder.setOrderGoodList(orderGoodsList);
			otherOrder.setSumMoney(sumMoney);
			otherOrder.setSumNumber(sumNumber + "");
			otherOrder.setSubMoney("0.0");
			otherOrder.setPayMoney(sumMoney);
			otherOrder.setCode(OrderCodeID.nextCode());
			otherOrder.setCreateTime(new Date());
			otherOrder.setState(order.getState());
			otherOrder.setStore(order.getStore());
			order_map_to_return.put("otherOrder", otherOrder);
		} else {
			// 有活动
			List<OrderGoods> orderGoodsList_goodsOrder = new ArrayList<>();
			List<OrderGoods> orderGoodsList_storeOrder = new ArrayList<>();
			List<OrderGoods> orderGoodsList_tianheOrder = new ArrayList<>();
			Map<String, OrderGoodsVo> parentGoods_map = new HashMap<>();
			for (OrderGoods orderGoods : orderGoodsList) {
				Goods goods = goodsService.getGoodsById(orderGoods.getGoods().getId());
				String goods_id_check_pro = "";
				if (null == goods.getGoods() || StringUtils.isBlank(goods.getGoods().getId())) {
					goods_id_check_pro = goods.getId();
				} else {
					goods_id_check_pro = goods.getGoods().getId();
				}
				if (parentGoods_map.containsKey(goods_id_check_pro)) {
					OrderGoodsVo orderGoodsVo = parentGoods_map.get(goods_id_check_pro);
					orderGoodsVo.setSumCount(
							(Integer.parseInt(orderGoodsVo.getSumCount()) + Integer.parseInt(orderGoods.getCount()))
									+ "");
					orderGoodsVo.setSumMoney(DoubleUtil
							.add(orderGoodsVo.getSumMoney(),
									DoubleUtil.mul(orderGoods.getCount(), orderGoods.getPrice()).toString())
							.toString());
					parentGoods_map.put(goods_id_check_pro, orderGoodsVo);
				} else {
					List<OrderGoods> orderGoods_temp = new ArrayList<>();
					orderGoods_temp.add(orderGoods);
					OrderGoodsVo orderGoodsVo = new OrderGoodsVo(orderGoods_temp, orderGoods.getCount(),
							DoubleUtil.mul(orderGoods.getCount(), orderGoods.getPrice()).toString());
					parentGoods_map.put(goods_id_check_pro, orderGoodsVo);
				}
			}
			for (PromotionGroup promotionGroup : promGroupList) {
				if (PromotionGroup.SCOPE_GOODS.equals(promotionGroup.getScope())) {
					// 产品级活动
					if (parentGoods_map.isEmpty()) {
						continue;
					}

					Order goodsOrder = null;
					if (order_map_to_return.containsKey("goodsOrder")) {
						goodsOrder = order_map_to_return.get("goodsOrder");
					} else {
						goodsOrder = new Order(UUID.getUUID());
						goodsOrder.setCustomer(order.getCustomer());
						goodsOrder.setCode(OrderCodeID.nextCode());
						goodsOrder.setCreateTime(new Date());
						goodsOrder.setOrder(order);
						goodsOrder.setType(order.getType());
						goodsOrder.setState(order.getState());
						goodsOrder.setGuideUser(order.getGuideUser());
						goodsOrder.setProType("goodsOrder");
						goodsOrder.setStore(order.getStore());
					}

					Iterator<Map.Entry<String, OrderGoodsVo>> it = parentGoods_map.entrySet().iterator();
					while (it.hasNext()) {
						Map.Entry<String, OrderGoodsVo> entry = it.next();
						if (0 <= promotionGroup.getOwnerId().indexOf(entry.getKey())) {
							// 本OrderGoods可参与产品级优惠
							OrderGoodsVo orderGoodsVo = entry.getValue();
							boolean isNeedNextPro = true;
							for (Promotion promotion : promotionGroup.getPromotionList()) {
								// 确保单个产品只参与一次活动
								if (!isNeedNextPro)
									break;

								switch (promotion.getType()) {
								case Promotion.TYPE_1:
									// 折扣--满折";
									for (PromotionLadder promotionLadder : promotion.getPromotionLadderList()) {
										if (0f <= DoubleUtil.sub(orderGoodsVo.getSumMoney(),
												promotionLadder.getLadderStart())) {
											// 本活动本档位满足，计入本活动档位的orderlist中
											// 待匹配order中移除本主产品对应的ordergoods
											List<OrderGoods> orderGoods_list_temp = orderGoodsVo.getOrderGoodsList();
											orderGoodsList.removeAll(orderGoods_list_temp);
											// 计入活动中去

											goodsOrder.setSumMoney(
													DoubleUtil.add(orderGoodsVo.getSumMoney(), goodsOrder.getSumMoney())
															.toString());
											goodsOrder.setSumNumber((Integer.parseInt(orderGoodsVo.getSumCount())
													+ Integer.parseInt(goodsOrder.getSumNumber())) + "");

											for (OrderGoods orderGoods_for : orderGoods_list_temp) {
												String order_sumMoney = DoubleUtil
														.mul(orderGoods_for.getCount(), orderGoods_for.getPrice())
														.toString();
												String sub_money_temp = DoubleUtil
														.sub(order_sumMoney,
																DoubleUtil.mul(order_sumMoney,
																		DoubleUtil
																				.div(promotionLadder
																						.getPromotionMoney(), "100")
																				.toString())
																		.toString())
														.toString();
												goodsOrder.setSubMoney(DoubleUtil
														.add(sub_money_temp, goodsOrder.getSubMoney()).toString());
												orderGoods_for.setSubMoney(sub_money_temp);

												orderGoods_for.setOrder(goodsOrder);
												orderGoodsList_goodsOrder.add(orderGoods_for);
											}

											OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(),
													goodsOrder, promotionLadder, OrderSubremark.ISSENDLADDER_YES,
													new Date());
											List<OrderSubremark> orderSubremarkList_temp = goodsOrder
													.getOrderSubremarkList();
											if (null == orderSubremarkList_temp)
												orderSubremarkList_temp = new ArrayList<>();
											orderSubremarkList_temp.add(orderSubremark);
											goodsOrder.setOrderSubremarkList(orderSubremarkList_temp);

											goodsOrder.setOrderGoodList(orderGoodsList_goodsOrder);
											it.remove();// 使用迭代器的remove()方法删除元素
											isNeedNextPro = false;
											break;
										}
									}
									break;
								case Promotion.TYPE_2:
									// 满减";
									for (PromotionLadder promotionLadder : promotion.getPromotionLadderList()) {
										if (0f <= DoubleUtil.sub(orderGoodsVo.getSumMoney(),
												promotionLadder.getLadderStart())) {
											// 本活动本档位满足，计入本活动档位的orderlist中
											// 待匹配order中移除本主产品对应的ordergoods
											List<OrderGoods> orderGoods_list_temp = orderGoodsVo.getOrderGoodsList();
											orderGoodsList.removeAll(orderGoods_list_temp);

											goodsOrder.setSumMoney(
													DoubleUtil.add(orderGoodsVo.getSumMoney(), goodsOrder.getSumMoney())
															.toString());
											goodsOrder.setSumNumber((Integer.parseInt(orderGoodsVo.getSumCount())
													+ Integer.parseInt(goodsOrder.getSumNumber())) + "");
											goodsOrder.setSubMoney(DoubleUtil
													.add(promotionLadder.getPromotionMoney(), goodsOrder.getSubMoney())
													.toString());

											// 计入活动中去
											for (OrderGoods orderGoods_for : orderGoods_list_temp) {
												orderGoods_for
														.setSubMoney(
																DoubleUtil
																		.mul(promotionLadder.getPromotionMoney(),
																				DoubleUtil
																						.div(orderGoods_for.getCount(),
																								orderGoodsVo
																										.getSumCount())
																						.toString())
																		.toString());
												orderGoods_for.setOrder(goodsOrder);
												orderGoodsList_goodsOrder.add(orderGoods_for);
											}

											OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(),
													goodsOrder, promotionLadder, OrderSubremark.ISSENDLADDER_YES,
													new Date());
											List<OrderSubremark> orderSubremarkList_temp = goodsOrder
													.getOrderSubremarkList();
											if (null == orderSubremarkList_temp)
												orderSubremarkList_temp = new ArrayList<>();
											orderSubremarkList_temp.add(orderSubremark);
											goodsOrder.setOrderSubremarkList(orderSubremarkList_temp);

											goodsOrder.setOrderGoodList(orderGoodsList_goodsOrder);
											it.remove();// 使用迭代器的remove()方法删除元素
											isNeedNextPro = false;
											break;
										}
									}
									break;
								case Promotion.TYPE_3:
									// 满返";
									for (PromotionLadder promotionLadder : promotion.getPromotionLadderList()) {
										if (0f <= DoubleUtil.sub(orderGoodsVo.getSumMoney(),
												promotionLadder.getLadderStart())) {
											// 本活动本档位满足，计入本活动档位的orderlist中
											// 待匹配order中移除本主产品对应的ordergoods
											List<OrderGoods> orderGoods_list_temp = orderGoodsVo.getOrderGoodsList();
											orderGoodsList.removeAll(orderGoods_list_temp);

											goodsOrder.setSumMoney(
													DoubleUtil.add(orderGoodsVo.getSumMoney(), goodsOrder.getSumMoney())
															.toString());
											goodsOrder.setSumNumber((Integer.parseInt(orderGoodsVo.getSumCount())
													+ Integer.parseInt(goodsOrder.getSumNumber())) + "");
													/*
													 * goodsOrder.setSubMoney(
													 * DoubleUtil
													 * .add(promotionLadder.
													 * getPromotionMoney(),
													 * goodsOrder.getSubMoney())
													 * .toString());
													 */

											// 计入活动中去
											for (OrderGoods orderGoods_for : orderGoods_list_temp) {
												orderGoods_for.setSubMoney("0.0");
												orderGoods_for.setOrder(goodsOrder);
												orderGoodsList_goodsOrder.add(orderGoods_for);
											}

											OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(),
													goodsOrder, promotionLadder, OrderSubremark.ISSENDLADDER_NO,
													new Date());
											List<OrderSubremark> orderSubremarkList_temp = goodsOrder
													.getOrderSubremarkList();
											if (null == orderSubremarkList_temp)
												orderSubremarkList_temp = new ArrayList<>();
											orderSubremarkList_temp.add(orderSubremark);
											goodsOrder.setOrderSubremarkList(orderSubremarkList_temp);

											goodsOrder.setOrderGoodList(orderGoodsList_goodsOrder);
											it.remove();// 使用迭代器的remove()方法删除元素
											isNeedNextPro = false;
											break;
										}
									}
									break;
								case Promotion.TYPE_4:
								// 特价促销";
								{// 待匹配order中移除本主产品对应的ordergoods
									List<OrderGoods> orderGoods_list_temp = orderGoodsVo.getOrderGoodsList();// TODO
									if (0 <= DoubleUtil.compareTo(orderGoods_list_temp.get(0).getSalesPrice(),
											promotion.getOtherPro1())) {
										// 商品当前售价不大于特价价格
										orderGoodsList.removeAll(orderGoods_list_temp);

										goodsOrder.setSumMoney(DoubleUtil
												.add(orderGoodsVo.getSumMoney(), goodsOrder.getSumMoney()).toString());
										goodsOrder.setSumNumber((Integer.parseInt(orderGoodsVo.getSumCount())
												+ Integer.parseInt(goodsOrder.getSumNumber())) + "");

										// 计入活动中去
										for (OrderGoods orderGoods_for : orderGoods_list_temp) {
											String sub_money_temp = DoubleUtil.mul(orderGoods_for.getCount(),
													DoubleUtil.sub(orderGoods_for.getPrice(), promotion.getOtherPro1())
															.toString())
													.toString();
											goodsOrder.setSubMoney(DoubleUtil
													.add(sub_money_temp, goodsOrder.getSubMoney()).toString());
											orderGoods_for.setSubMoney(sub_money_temp);
											OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(),
													orderGoods_for, promotion, OrderSubremark.ISSENDLADDER_YES,
													new Date());
											orderGoods_for.setOrderSubremark(orderSubremark);
											orderGoods_for.setOrder(goodsOrder);
											orderGoodsList_goodsOrder.add(orderGoods_for);
										}

										goodsOrder.setOrderGoodList(orderGoodsList_goodsOrder);
										it.remove();// 使用迭代器的remove()方法删除元素
										isNeedNextPro = false;
									}
								}
									break;
								case Promotion.TYPE_5:
									// 前二件折扣";
									break;
								case Promotion.TYPE_6:
									// 前三件折扣";
									break;
								case Promotion.TYPE_7:
									// 满送促销";
									break;
								case Promotion.TYPE_8:
									// 买赠促销";
									for (PromotionLadder promotionLadder : promotion.getPromotionLadderList()) {
										if (0f <= DoubleUtil.sub(orderGoodsVo.getSumCount(),
												promotionLadder.getGoodsNumberBuy())) {
											// 本活动本档位满足，计入本活动档位的orderlist中
											// 待匹配order中移除本主产品对应的ordergoods
											List<OrderGoods> orderGoods_list_temp = orderGoodsVo.getOrderGoodsList();
											orderGoodsList.removeAll(orderGoods_list_temp);

											goodsOrder.setSumMoney(
													DoubleUtil.add(orderGoodsVo.getSumMoney(), goodsOrder.getSumMoney())
															.toString());
											goodsOrder.setSumNumber((Integer.parseInt(orderGoodsVo.getSumCount())
													+ Integer.parseInt(goodsOrder.getSumNumber())) + "");

											// 计入活动中去
											for (OrderGoods orderGoods_for : orderGoods_list_temp) {
												orderGoods_for.setSubMoney("0.0");
												orderGoods_for.setOrder(goodsOrder);
												orderGoodsList_goodsOrder.add(orderGoods_for);
											}

											OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(),
													goodsOrder, promotionLadder, OrderSubremark.ISSENDLADDER_NO,
													new Date());
											List<OrderSubremark> orderSubremarkList_temp = goodsOrder
													.getOrderSubremarkList();
											if (null == orderSubremarkList_temp)
												orderSubremarkList_temp = new ArrayList<>();
											orderSubremarkList_temp.add(orderSubremark);
											goodsOrder.setOrderSubremarkList(orderSubremarkList_temp);

											goodsOrder.setOrderGoodList(orderGoodsList_goodsOrder);
											it.remove();// 使用迭代器的remove()方法删除元素
											isNeedNextPro = false;
											break;
										}
									}
									break;
								case Promotion.TYPE_9:
									// 加钱换购";
									break;
								case Promotion.TYPE_10:
									// 第二件折扣";
									break;
								case Promotion.TYPE_11:
									// 单品折扣";
									// 本活动本档位满足，计入本活动档位的orderlist中
									// 待匹配order中移除本主产品对应的ordergoods
									List<OrderGoods> orderGoods_list_temp = orderGoodsVo.getOrderGoodsList();
									orderGoodsList.removeAll(orderGoods_list_temp);

									goodsOrder.setSumMoney(DoubleUtil
											.add(orderGoodsVo.getSumMoney(), goodsOrder.getSumMoney()).toString());
									goodsOrder.setSumNumber((Integer.parseInt(orderGoodsVo.getSumCount())
											+ Integer.parseInt(goodsOrder.getSumNumber())) + "");

									// 计入活动中去
									String order_sub_money_temp = "0.0";
									for (OrderGoods orderGoods_for : orderGoods_list_temp) {
										String sub_money_temp = DoubleUtil
												.mul(orderGoods_for.getCount(),
														DoubleUtil
																.sub(orderGoods_for.getPrice(),
																		DoubleUtil
																				.mul(orderGoods_for.getPrice(),
																						DoubleUtil.div(
																								promotion
																										.getOtherPro1(),
																								"100").toString())
																		.toString())
																.toString())
												.toString();
										orderGoods_for.setSubMoney(sub_money_temp);
										orderGoods_for.setOrder(goodsOrder);
										orderGoodsList_goodsOrder.add(orderGoods_for);
										order_sub_money_temp = DoubleUtil.add(order_sub_money_temp, sub_money_temp)
												.toString();
									}
									goodsOrder.setSubMoney(
											DoubleUtil.add(goodsOrder.getSubMoney(), order_sub_money_temp).toString());

									OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), goodsOrder,
											promotion, OrderSubremark.ISSENDLADDER_YES, new Date());
									List<OrderSubremark> orderSubremarkList_temp = goodsOrder.getOrderSubremarkList();
									if (null == orderSubremarkList_temp)
										orderSubremarkList_temp = new ArrayList<>();
									orderSubremarkList_temp.add(orderSubremark);
									goodsOrder.setOrderSubremarkList(orderSubremarkList_temp);

									goodsOrder.setOrderGoodList(orderGoodsList_goodsOrder);
									it.remove();// 使用迭代器的remove()方法删除元素
									isNeedNextPro = false;
									break;
								default:
									// 未知";
									break;
								}
							}
						}
					}

					if (!orderGoodsList_goodsOrder.isEmpty()) {
						goodsOrder.setPayMoney(
								DoubleUtil.sub(goodsOrder.getSumMoney(), goodsOrder.getSubMoney()).toString());
						order_map_to_return.put("goodsOrder", goodsOrder);
					}
				} else if (PromotionGroup.SCOPE_STORE.equals(promotionGroup.getScope())) {
					// 门店级活动
					if (orderGoodsList.isEmpty()) {
						continue;
					}

					Order storeOrder = null;
					if (order_map_to_return.containsKey("storeOrder")) {
						storeOrder = order_map_to_return.get("storeOrder");
					} else {
						storeOrder = new Order(UUID.getUUID());
						storeOrder.setCustomer(order.getCustomer());
						storeOrder.setCode(OrderCodeID.nextCode());
						storeOrder.setCreateTime(new Date());
						storeOrder.setOrder(order);
						storeOrder.setType(order.getType());
						storeOrder.setState(order.getState());
						storeOrder.setGuideUser(order.getGuideUser());
						storeOrder.setProType("storeOrder");
						storeOrder.setStore(order.getStore());
					}

					String sumMoney = "0.0";
					int sumCount = 0;
					for (OrderGoods orderGoods : orderGoodsList) {
						sumMoney = DoubleUtil
								.add(sumMoney, DoubleUtil.mul(orderGoods.getPrice(), orderGoods.getCount()).toString())
								.toString();
						sumCount += Integer.parseInt(orderGoods.getCount());
					}

					boolean isNeedNextPro = true;
					for (Promotion promotion : promotionGroup.getPromotionList()) {
						// 控制住 门店级 只能参与一个活动
						if (!isNeedNextPro)
							break;

						switch (promotion.getType()) {
						case Promotion.TYPE_1:
							// 折扣";
							for (PromotionLadder promotionLadder : promotion.getPromotionLadderList()) {
								if (0F <= DoubleUtil.sub(sumMoney, promotionLadder.getLadderStart())) {
									orderGoodsList_storeOrder.addAll(orderGoodsList);
									orderGoodsList.clear();
									storeOrder
											.setSumMoney(DoubleUtil.add(sumMoney, storeOrder.getSumMoney()).toString());
									storeOrder.setSumNumber(
											(Integer.parseInt(storeOrder.getSumNumber()) + sumCount) + "");

									storeOrder
											.setPayMoney(DoubleUtil
													.mul(sumMoney, DoubleUtil
															.div(promotionLadder.getPromotionMoney(), "100").toString())
											.toString());

									storeOrder.setSubMoney(DoubleUtil
											.add(storeOrder.getSubMoney(),
													DoubleUtil.sub(sumMoney, storeOrder.getPayMoney()).toString())
											.toString());

									for (OrderGoods orderGoods : orderGoodsList_storeOrder) {
										double order_sum_money = DoubleUtil.mul(orderGoods.getPrice(),
												orderGoods.getCount());
										orderGoods.setSubMoney(DoubleUtil
												.sub(order_sum_money,
														DoubleUtil.mul(order_sum_money, DoubleUtil
																.div(promotionLadder.getPromotionMoney(), "100")),
														2)
												.toString());
										orderGoods.setOrder(storeOrder);
									}

									OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), storeOrder,
											promotionLadder, OrderSubremark.ISSENDLADDER_YES, new Date());
									List<OrderSubremark> orderSubremarkList_temp = storeOrder.getOrderSubremarkList();
									if (null == orderSubremarkList_temp)
										orderSubremarkList_temp = new ArrayList<>();
									orderSubremarkList_temp.add(orderSubremark);
									storeOrder.setOrderSubremarkList(orderSubremarkList_temp);

									storeOrder.setOrderGoodList(orderGoodsList_storeOrder);
									isNeedNextPro = false;
									break;
								}
							}
							break;
						case Promotion.TYPE_2:
							// 满减";
							for (PromotionLadder promotionLadder : promotion.getPromotionLadderList()) {
								if (0F <= DoubleUtil.sub(sumMoney, promotionLadder.getLadderStart())) {
									orderGoodsList_storeOrder.addAll(orderGoodsList);
									orderGoodsList.clear();
									storeOrder
											.setSumMoney(DoubleUtil.add(sumMoney, storeOrder.getSumMoney()).toString());
									storeOrder.setSumNumber(
											(Integer.parseInt(storeOrder.getSumNumber()) + sumCount) + "");

									storeOrder.setSubMoney(DoubleUtil
											.add(storeOrder.getSubMoney(), promotionLadder.getPromotionMoney())
											.toString());

									storeOrder.setPayMoney(DoubleUtil
											.sub(storeOrder.getSumMoney(), storeOrder.getSubMoney()).toString());

									for (OrderGoods orderGoods : orderGoodsList_storeOrder) {
										orderGoods
												.setSubMoney(
														DoubleUtil.mul(
																DoubleUtil
																		.div(DoubleUtil
																				.mul(orderGoods.getPrice(),
																						orderGoods.getCount())
																				.toString(), sumMoney)
																		.toString(),
																promotionLadder.getPromotionMoney()).toString());
										orderGoods.setOrder(storeOrder);
									}

									OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), storeOrder,
											promotionLadder, OrderSubremark.ISSENDLADDER_YES, new Date());
									List<OrderSubremark> orderSubremarkList_temp = storeOrder.getOrderSubremarkList();
									if (null == orderSubremarkList_temp)
										orderSubremarkList_temp = new ArrayList<>();
									orderSubremarkList_temp.add(orderSubremark);
									storeOrder.setOrderSubremarkList(orderSubremarkList_temp);

									storeOrder.setOrderGoodList(orderGoodsList_storeOrder);
									isNeedNextPro = false;
									break;
								}
							}
							break;
						case Promotion.TYPE_3:
							// 满返";
							for (PromotionLadder promotionLadder : promotion.getPromotionLadderList()) {
								if (0F <= DoubleUtil.sub(sumMoney, promotionLadder.getLadderStart())) {
									orderGoodsList_storeOrder.addAll(orderGoodsList);
									orderGoodsList.clear();
									storeOrder
											.setSumMoney(DoubleUtil.add(sumMoney, storeOrder.getSumMoney()).toString());
									storeOrder.setSumNumber(
											(Integer.parseInt(storeOrder.getSumNumber()) + sumCount) + "");

									storeOrder.setSubMoney("0.0");

									storeOrder.setPayMoney(storeOrder.getSumMoney());

									for (OrderGoods orderGoods : orderGoodsList_storeOrder) {
										orderGoods.setSubMoney("0.0");
										orderGoods.setOrder(storeOrder);
									}

									OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), storeOrder,
											promotionLadder, OrderSubremark.ISSENDLADDER_NO, new Date());
									List<OrderSubremark> orderSubremarkList_temp = storeOrder.getOrderSubremarkList();
									if (null == orderSubremarkList_temp)
										orderSubremarkList_temp = new ArrayList<>();
									orderSubremarkList_temp.add(orderSubremark);
									storeOrder.setOrderSubremarkList(orderSubremarkList_temp);

									storeOrder.setOrderGoodList(orderGoodsList_storeOrder);
									isNeedNextPro = false;
									break;
								}
							}
							break;
						case Promotion.TYPE_4:
							// 特价促销";
							break;
						case Promotion.TYPE_5:
							// 前二件折扣";
							if (2 <= sumCount) {
								storeOrder.setSumNumber((Integer.parseInt(storeOrder.getSumNumber()) + 2) + "");
								List<Double> zhekou_numbers = new ArrayList<>();
								zhekou_numbers.add(DoubleUtil.div(promotion.getOtherPro1(), "100"));
								zhekou_numbers.add(DoubleUtil.div(promotion.getOtherPro2(), "100"));
								Collections.sort(zhekou_numbers);

								int needGoodsNumber = 2;
								Iterator<OrderGoods> it = orderGoodsList.iterator();
								while (it.hasNext()) {
									OrderGoods orderGoods = it.next();
									if (needGoodsNumber < Integer.parseInt(orderGoods.getCount())) {
										orderGoods.setCount(
												(Integer.parseInt(orderGoods.getCount()) - needGoodsNumber) + "");

										List<OrderGoodsQrcode> ogQrcodeList = new ArrayList<>();
										List<OrderGoodsQrcode> ogQrcodeList_return_orderGoods = orderGoods.getoGQList();
										if (null != ogQrcodeList_return_orderGoods
												&& !ogQrcodeList_return_orderGoods.isEmpty()) {
											ogQrcodeList
													.addAll(ogQrcodeList_return_orderGoods.subList(0, needGoodsNumber));
											ogQrcodeList_return_orderGoods.removeAll(ogQrcodeList);
											orderGoods.setoGQList(ogQrcodeList_return_orderGoods);
										}

										for (int i = 0; i < needGoodsNumber; i++) {
											OrderGoods orderGoods_temp = new OrderGoods(UUID.getUUID(), storeOrder,
													orderGoods.getGoods(), "1", orderGoods.getPrice(), "0.0",
													OrderGoods.TYPE_OUT, new Date());
											if (null != ogQrcodeList && !ogQrcodeList.isEmpty()) {
												List<OrderGoodsQrcode> ogQrcodeList_temp = ogQrcodeList.subList(i,
														i + 1);
												ogQrcodeList_temp.get(0).setOrderGoods(orderGoods_temp);
												orderGoods_temp.setoGQList(ogQrcodeList_temp);
											}
											orderGoodsList_storeOrder.add(orderGoods_temp);
										}

										needGoodsNumber = 0;
									} else if (needGoodsNumber == Integer.parseInt(orderGoods.getCount())) {
										List<OrderGoodsQrcode> ogQrcodeList = orderGoods.getoGQList();

										for (int i = 0; i < needGoodsNumber; i++) {
											OrderGoods orderGoods_temp = new OrderGoods(UUID.getUUID(), storeOrder,
													orderGoods.getGoods(), "1", orderGoods.getPrice(), "0.0",
													OrderGoods.TYPE_OUT, new Date());
											if (null != ogQrcodeList && !ogQrcodeList.isEmpty()) {
												List<OrderGoodsQrcode> ogQrcodeList_temp = ogQrcodeList.subList(i,
														i + 1);
												ogQrcodeList_temp.get(0).setOrderGoods(orderGoods_temp);
												orderGoods_temp.setoGQList(ogQrcodeList_temp);
											}
											orderGoodsList_storeOrder.add(orderGoods_temp);
										}

										needGoodsNumber = 0;
										it.remove();
									} else {
										List<OrderGoodsQrcode> ogQrcodeList = orderGoods.getoGQList();

										for (int i = 0; i < Integer.parseInt(orderGoods.getCount()); i++) {
											OrderGoods orderGoods_temp = new OrderGoods(UUID.getUUID(), storeOrder,
													orderGoods.getGoods(), "1", orderGoods.getPrice(), "0.0",
													OrderGoods.TYPE_OUT, new Date());
											if (null != ogQrcodeList && !ogQrcodeList.isEmpty()) {
												List<OrderGoodsQrcode> ogQrcodeList_temp = ogQrcodeList.subList(i,
														i + 1);
												ogQrcodeList_temp.get(0).setOrderGoods(orderGoods_temp);
												orderGoods_temp.setoGQList(ogQrcodeList_temp);
											}
											orderGoodsList_storeOrder.add(orderGoods_temp);
										}

										needGoodsNumber -= Integer.parseInt(orderGoods.getCount());
										it.remove();
									}

									if (0 >= needGoodsNumber) {
										break;
									}
								}
								String order_sub_money = "0.0";
								for (int i = 0; i < orderGoodsList_storeOrder.size(); i++) {
									OrderGoods orderGoods_temp = orderGoodsList_storeOrder.get(i);
									String old_price = orderGoods_temp.getPrice();
									String sub_money = DoubleUtil.sub(old_price, DoubleUtil
											.mul(Double.parseDouble(old_price), zhekou_numbers.get(i)).toString())
											.toString();
									orderGoods_temp.setSubMoney(sub_money);
									storeOrder.setSumMoney(DoubleUtil
											.add(orderGoods_temp.getPrice(), storeOrder.getSumMoney()).toString());
									order_sub_money = DoubleUtil.add(sub_money, order_sub_money).toString();
								}
								storeOrder.setSubMoney(order_sub_money);
								storeOrder.setPayMoney(
										DoubleUtil.sub(storeOrder.getSumMoney(), storeOrder.getSubMoney()).toString());

								OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), storeOrder,
										promotion, OrderSubremark.ISSENDLADDER_YES, new Date());
								List<OrderSubremark> orderSubremarkList_temp = storeOrder.getOrderSubremarkList();
								if (null == orderSubremarkList_temp)
									orderSubremarkList_temp = new ArrayList<>();
								orderSubremarkList_temp.add(orderSubremark);
								storeOrder.setOrderSubremarkList(orderSubremarkList_temp);

								storeOrder.setOrderGoodList(orderGoodsList_storeOrder);
								isNeedNextPro = false;
							}
							break;
						case Promotion.TYPE_6:
							// 前三件折扣";
							if (3 <= sumCount) {
								storeOrder.setSumNumber((Integer.parseInt(storeOrder.getSumNumber()) + 3) + "");
								List<Double> zhekou_numbers = new ArrayList<>();
								zhekou_numbers.add(DoubleUtil.div(promotion.getOtherPro1(), "100"));
								zhekou_numbers.add(DoubleUtil.div(promotion.getOtherPro2(), "100"));
								zhekou_numbers.add(DoubleUtil.div(promotion.getOtherPro3(), "100"));
								Collections.sort(zhekou_numbers);

								int needGoodsNumber = 3;
								Iterator<OrderGoods> it = orderGoodsList.iterator();
								while (it.hasNext()) {
									OrderGoods orderGoods = it.next();
									if (needGoodsNumber < Integer.parseInt(orderGoods.getCount())) {
										orderGoods.setCount(
												(Integer.parseInt(orderGoods.getCount()) - needGoodsNumber) + "");

										List<OrderGoodsQrcode> ogQrcodeList = new ArrayList<>();
										List<OrderGoodsQrcode> ogQrcodeList_return_orderGoods = orderGoods.getoGQList();
										if (null != ogQrcodeList_return_orderGoods
												&& !ogQrcodeList_return_orderGoods.isEmpty()) {
											ogQrcodeList
													.addAll(ogQrcodeList_return_orderGoods.subList(0, needGoodsNumber));
											ogQrcodeList_return_orderGoods.removeAll(ogQrcodeList);
											orderGoods.setoGQList(ogQrcodeList_return_orderGoods);
										}

										for (int i = 0; i < needGoodsNumber; i++) {
											OrderGoods orderGoods_temp = new OrderGoods(UUID.getUUID(), storeOrder,
													orderGoods.getGoods(), "1", orderGoods.getPrice(), "0.0",
													OrderGoods.TYPE_OUT, new Date());
											if (null != ogQrcodeList && !ogQrcodeList.isEmpty()) {
												List<OrderGoodsQrcode> ogQrcodeList_temp = ogQrcodeList.subList(i,
														i + 1);
												ogQrcodeList_temp.get(0).setOrderGoods(orderGoods_temp);
												orderGoods_temp.setoGQList(ogQrcodeList_temp);
											}
											orderGoodsList_storeOrder.add(orderGoods_temp);
										}

										needGoodsNumber = 0;
									} else if (needGoodsNumber == Integer.parseInt(orderGoods.getCount())) {
										List<OrderGoodsQrcode> ogQrcodeList = orderGoods.getoGQList();

										for (int i = 0; i < needGoodsNumber; i++) {
											OrderGoods orderGoods_temp = new OrderGoods(UUID.getUUID(), storeOrder,
													orderGoods.getGoods(), "1", orderGoods.getPrice(), "0.0",
													OrderGoods.TYPE_OUT, new Date());
											if (null != ogQrcodeList && !ogQrcodeList.isEmpty()) {
												List<OrderGoodsQrcode> ogQrcodeList_temp = ogQrcodeList.subList(i,
														i + 1);
												ogQrcodeList_temp.get(0).setOrderGoods(orderGoods_temp);
												orderGoods_temp.setoGQList(ogQrcodeList_temp);
											}
											orderGoodsList_storeOrder.add(orderGoods_temp);
										}

										needGoodsNumber = 0;
										it.remove();
									} else {
										List<OrderGoodsQrcode> ogQrcodeList = orderGoods.getoGQList();

										for (int i = 0; i < Integer.parseInt(orderGoods.getCount()); i++) {
											OrderGoods orderGoods_temp = new OrderGoods(UUID.getUUID(), storeOrder,
													orderGoods.getGoods(), "1", orderGoods.getPrice(), "0.0",
													OrderGoods.TYPE_OUT, new Date());
											if (null != ogQrcodeList && !ogQrcodeList.isEmpty()) {
												List<OrderGoodsQrcode> ogQrcodeList_temp = ogQrcodeList.subList(i,
														i + 1);
												ogQrcodeList_temp.get(0).setOrderGoods(orderGoods_temp);
												orderGoods_temp.setoGQList(ogQrcodeList_temp);
											}
											orderGoodsList_storeOrder.add(orderGoods_temp);
										}

										needGoodsNumber -= Integer.parseInt(orderGoods.getCount());
										it.remove();
									}

									if (0 >= needGoodsNumber) {
										break;
									}
								}
								String order_sub_money = "0.0";
								for (int i = 0; i < orderGoodsList_storeOrder.size(); i++) {
									OrderGoods orderGoods_temp = orderGoodsList_storeOrder.get(i);
									String old_price = orderGoods_temp.getPrice();
									String sub_money = DoubleUtil.sub(old_price, DoubleUtil
											.mul(Double.parseDouble(old_price), zhekou_numbers.get(i)).toString())
											.toString();
									orderGoods_temp.setSubMoney(sub_money);
									storeOrder.setSumMoney(DoubleUtil
											.add(orderGoods_temp.getPrice(), storeOrder.getSumMoney()).toString());
									order_sub_money = DoubleUtil.add(sub_money, order_sub_money).toString();
								}
								storeOrder.setSubMoney(order_sub_money);
								storeOrder.setPayMoney(
										DoubleUtil.sub(storeOrder.getSumMoney(), storeOrder.getSubMoney()).toString());

								OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), storeOrder,
										promotion, OrderSubremark.ISSENDLADDER_YES, new Date());
								List<OrderSubremark> orderSubremarkList_temp = storeOrder.getOrderSubremarkList();
								if (null == orderSubremarkList_temp)
									orderSubremarkList_temp = new ArrayList<>();
								orderSubremarkList_temp.add(orderSubremark);
								storeOrder.setOrderSubremarkList(orderSubremarkList_temp);

								storeOrder.setOrderGoodList(orderGoodsList_storeOrder);
								isNeedNextPro = false;
							}
							break;
						case Promotion.TYPE_7:
							// 满送促销";
							for (PromotionLadder promotionLadder : promotion.getPromotionLadderList()) {
								if (0F <= DoubleUtil.sub(sumMoney, promotionLadder.getLadderStart())) {
									orderGoodsList_storeOrder.addAll(orderGoodsList);
									orderGoodsList.clear();
									storeOrder
											.setSumMoney(DoubleUtil.add(sumMoney, storeOrder.getSumMoney()).toString());
									storeOrder.setSumNumber(
											(Integer.parseInt(storeOrder.getSumNumber()) + sumCount) + "");
									storeOrder.setPayMoney(storeOrder.getSumMoney());

									for (OrderGoods orderGoods : orderGoodsList_storeOrder) {
										orderGoods.setSubMoney("0.0");
										orderGoods.setOrder(storeOrder);
									}

									OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), storeOrder,
											promotionLadder, OrderSubremark.ISSENDLADDER_NO, new Date());
									List<OrderSubremark> orderSubremarkList_temp = storeOrder.getOrderSubremarkList();
									if (null == orderSubremarkList_temp)
										orderSubremarkList_temp = new ArrayList<>();
									orderSubremarkList_temp.add(orderSubremark);
									storeOrder.setOrderSubremarkList(orderSubremarkList_temp);

									storeOrder.setOrderGoodList(orderGoodsList_storeOrder);
									isNeedNextPro = false;
									break;
								}
							}
							break;
						case Promotion.TYPE_8:
							// 买赠促销";
							for (PromotionLadder promotionLadder : promotion.getPromotionLadderList()) {
								if (0F <= DoubleUtil.sub(sumMoney, promotionLadder.getLadderStart())) {
									orderGoodsList_storeOrder.addAll(orderGoodsList);
									orderGoodsList.clear();
									storeOrder
											.setSumMoney(DoubleUtil.add(sumMoney, storeOrder.getSumMoney()).toString());
									storeOrder.setSumNumber(
											(Integer.parseInt(storeOrder.getSumNumber()) + sumCount) + "");
									storeOrder.setPayMoney(storeOrder.getSumMoney());

									for (OrderGoods orderGoods : orderGoodsList_storeOrder) {
										orderGoods.setSubMoney("0.0");
										orderGoods.setOrder(storeOrder);
									}

									OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), storeOrder,
											promotionLadder, OrderSubremark.ISSENDLADDER_NO, new Date());
									List<OrderSubremark> orderSubremarkList_temp = storeOrder.getOrderSubremarkList();
									if (null == orderSubremarkList_temp)
										orderSubremarkList_temp = new ArrayList<>();
									orderSubremarkList_temp.add(orderSubremark);
									storeOrder.setOrderSubremarkList(orderSubremarkList_temp);

									storeOrder.setOrderGoodList(orderGoodsList_storeOrder);
									isNeedNextPro = false;
									break;
								}
							}
							break;
						case Promotion.TYPE_9:
							// 加钱换购";
							for (PromotionLadder promotionLadder : promotion.getPromotionLadderList()) {
								if (0F <= DoubleUtil.sub(sumMoney, promotionLadder.getLadderStart())) {
									orderGoodsList_storeOrder.addAll(orderGoodsList);
									orderGoodsList.clear();
									storeOrder
											.setSumMoney(DoubleUtil.add(sumMoney, storeOrder.getSumMoney()).toString());
									storeOrder.setSumNumber(
											(Integer.parseInt(storeOrder.getSumNumber()) + sumCount) + "");
									storeOrder.setPayMoney(storeOrder.getSumMoney());

									for (OrderGoods orderGoods : orderGoodsList_storeOrder) {
										orderGoods.setSubMoney("0.0");
										orderGoods.setOrder(storeOrder);
									}

									OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), storeOrder,
											promotionLadder, OrderSubremark.ISSENDLADDER_NO, new Date());
									orderSubremark.setSalesMoney(promotionLadder.getGoodsPrice());
									List<OrderSubremark> orderSubremarkList_temp = storeOrder.getOrderSubremarkList();
									if (null == orderSubremarkList_temp)
										orderSubremarkList_temp = new ArrayList<>();
									orderSubremarkList_temp.add(orderSubremark);
									storeOrder.setOrderSubremarkList(orderSubremarkList_temp);

									storeOrder.setOrderGoodList(orderGoodsList_storeOrder);
									isNeedNextPro = false;
									break;
								}
							}
							break;
						case Promotion.TYPE_10:
							// 第二件折扣";
							if (2 <= sumCount) {
								storeOrder.setSumNumber((Integer.parseInt(storeOrder.getSumNumber()) + 2) + "");
								int needGoodsNumber = 2;
								Iterator<OrderGoods> it = orderGoodsList.iterator();
								while (it.hasNext()) {
									OrderGoods orderGoods = it.next();
									if (needGoodsNumber < Integer.parseInt(orderGoods.getCount())) {
										orderGoods.setCount(
												(Integer.parseInt(orderGoods.getCount()) - needGoodsNumber) + "");

										List<OrderGoodsQrcode> ogQrcodeList = new ArrayList<>();
										List<OrderGoodsQrcode> ogQrcodeList_return_orderGoods = orderGoods.getoGQList();
										if (null != ogQrcodeList_return_orderGoods
												&& !ogQrcodeList_return_orderGoods.isEmpty()) {
											ogQrcodeList
													.addAll(ogQrcodeList_return_orderGoods.subList(0, needGoodsNumber));
											ogQrcodeList_return_orderGoods.removeAll(ogQrcodeList);
											orderGoods.setoGQList(ogQrcodeList_return_orderGoods);
										}

										for (int i = 0; i < needGoodsNumber; i++) {
											OrderGoods orderGoods_temp = new OrderGoods(UUID.getUUID(), storeOrder,
													orderGoods.getGoods(), "1", orderGoods.getPrice(), "0.0",
													OrderGoods.TYPE_OUT, new Date());
											if (null != ogQrcodeList && !ogQrcodeList.isEmpty()) {
												List<OrderGoodsQrcode> ogQrcodeList_temp = ogQrcodeList.subList(i,
														i + 1);
												ogQrcodeList_temp.get(0).setOrderGoods(orderGoods_temp);
												orderGoods_temp.setoGQList(ogQrcodeList_temp);
											}
											storeOrder.setSumMoney(
													DoubleUtil.add(orderGoods_temp.getPrice(), storeOrder.getSumMoney())
															.toString());
											orderGoodsList_storeOrder.add(orderGoods_temp);
										}

										needGoodsNumber = 0;
									} else if (needGoodsNumber == Integer.parseInt(orderGoods.getCount())) {
										List<OrderGoodsQrcode> ogQrcodeList = orderGoods.getoGQList();

										for (int i = 0; i < needGoodsNumber; i++) {
											OrderGoods orderGoods_temp = new OrderGoods(UUID.getUUID(), storeOrder,
													orderGoods.getGoods(), "1", orderGoods.getPrice(), "0.0",
													OrderGoods.TYPE_OUT, new Date());
											if (null != ogQrcodeList && !ogQrcodeList.isEmpty()) {
												List<OrderGoodsQrcode> ogQrcodeList_temp = ogQrcodeList.subList(i,
														i + 1);
												ogQrcodeList_temp.get(0).setOrderGoods(orderGoods_temp);
												orderGoods_temp.setoGQList(ogQrcodeList_temp);
											}
											storeOrder.setSumMoney(
													DoubleUtil.add(orderGoods_temp.getPrice(), storeOrder.getSumMoney())
															.toString());
											orderGoodsList_storeOrder.add(orderGoods_temp);
										}

										needGoodsNumber = 0;
										it.remove();
									} else {
										List<OrderGoodsQrcode> ogQrcodeList = orderGoods.getoGQList();

										for (int i = 0; i < Integer.parseInt(orderGoods.getCount()); i++) {
											OrderGoods orderGoods_temp = new OrderGoods(UUID.getUUID(), storeOrder,
													orderGoods.getGoods(), "1", orderGoods.getPrice(), "0.0",
													OrderGoods.TYPE_OUT, new Date());
											if (null != ogQrcodeList && !ogQrcodeList.isEmpty()) {
												List<OrderGoodsQrcode> ogQrcodeList_temp = ogQrcodeList.subList(i,
														i + 1);
												ogQrcodeList_temp.get(0).setOrderGoods(orderGoods_temp);
												orderGoods_temp.setoGQList(ogQrcodeList_temp);
											}
											storeOrder.setSumMoney(
													DoubleUtil.add(orderGoods_temp.getPrice(), storeOrder.getSumMoney())
															.toString());
											orderGoodsList_storeOrder.add(orderGoods_temp);
										}

										needGoodsNumber -= Integer.parseInt(orderGoods.getCount());
										it.remove();
									}

									if (0 >= needGoodsNumber) {
										break;
									}
								}

								String order_sub_money = "0.0";
								OrderGoods orderGoods_temp = orderGoodsList_storeOrder.get(1);
								String old_price = orderGoods_temp.getPrice();
								String sub_money = DoubleUtil.sub(old_price,
										DoubleUtil
												.mul(old_price,
														DoubleUtil.div(promotion.getOtherPro1(), "100").toString())
												.toString())
										.toString();
								orderGoods_temp.setSubMoney(sub_money);
								order_sub_money = DoubleUtil.add(sub_money, order_sub_money).toString();
								storeOrder.setSubMoney(order_sub_money);
								storeOrder.setPayMoney(
										DoubleUtil.sub(storeOrder.getSumMoney(), storeOrder.getSubMoney()).toString());

								OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), storeOrder,
										promotion, OrderSubremark.ISSENDLADDER_YES, new Date());
								List<OrderSubremark> orderSubremarkList_temp = storeOrder.getOrderSubremarkList();
								if (null == orderSubremarkList_temp)
									orderSubremarkList_temp = new ArrayList<>();
								orderSubremarkList_temp.add(orderSubremark);
								storeOrder.setOrderSubremarkList(orderSubremarkList_temp);

								storeOrder.setOrderGoodList(orderGoodsList_storeOrder);
								isNeedNextPro = false;
							}
							break;
						case Promotion.TYPE_11:
							// 单品折扣";
							break;
						default:
							// 未知";
							break;
						}
					}
					if (!orderGoodsList_storeOrder.isEmpty())
						order_map_to_return.put("storeOrder", storeOrder);
				} else if (PromotionGroup.SCOPE_ALL.equals(promotionGroup.getScope())) {
					// 天和级活动
					if (orderGoodsList.isEmpty()) {
						continue;
					}

					String sumMoney = "0.0";
					int sumCount = 0;
					for (OrderGoods orderGoods : orderGoodsList) {
						sumMoney = DoubleUtil
								.add(sumMoney, DoubleUtil.mul(orderGoods.getPrice(), orderGoods.getCount()).toString())
								.toString();
						sumCount += Integer.parseInt(orderGoods.getCount());
					}

					Order tianheOrder = null;
					if (order_map_to_return.containsKey("tianheOrder")) {
						tianheOrder = order_map_to_return.get("tianheOrder");
					} else {
						tianheOrder = new Order(UUID.getUUID());
						tianheOrder.setCustomer(order.getCustomer());
						tianheOrder.setCode(OrderCodeID.nextCode());
						tianheOrder.setCreateTime(new Date());
						tianheOrder.setOrder(order);
						tianheOrder.setType(order.getType());
						tianheOrder.setState(order.getState());
						tianheOrder.setGuideUser(order.getGuideUser());
						tianheOrder.setProType("tianheOrder");
						tianheOrder.setStore(order.getStore());
					}

					boolean isNeedNextPro = true;
					for (Promotion promotion : promotionGroup.getPromotionList()) {
						// 控制住 天和级 只能参与一个活动
						if (!isNeedNextPro)
							break;

						switch (promotion.getType()) {
						case Promotion.TYPE_1:
							// 折扣";
							for (PromotionLadder promotionLadder : promotion.getPromotionLadderList()) {
								if (0F <= DoubleUtil.sub(sumMoney, promotionLadder.getLadderStart())) {
									orderGoodsList_tianheOrder.addAll(orderGoodsList);
									orderGoodsList.clear();
									tianheOrder.setSumMoney(
											DoubleUtil.add(sumMoney, tianheOrder.getSumMoney()).toString());
									tianheOrder.setSumNumber(
											(Integer.parseInt(tianheOrder.getSumNumber()) + sumCount) + "");

									tianheOrder
											.setPayMoney(DoubleUtil
													.mul(sumMoney, DoubleUtil
															.div(promotionLadder.getPromotionMoney(), "100").toString())
											.toString());

									tianheOrder.setSubMoney(DoubleUtil
											.add(tianheOrder.getSubMoney(),
													DoubleUtil.sub(sumMoney, tianheOrder.getPayMoney()).toString())
											.toString());

									for (OrderGoods orderGoods : orderGoodsList_tianheOrder) {
										double order_sum_money = DoubleUtil.mul(orderGoods.getPrice(),
												orderGoods.getCount());
										orderGoods.setSubMoney(DoubleUtil
												.sub(order_sum_money,
														DoubleUtil.mul(order_sum_money, DoubleUtil
																.div(promotionLadder.getPromotionMoney(), "100")),
														2)
												.toString());
										orderGoods.setOrder(tianheOrder);
									}

									OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), tianheOrder,
											promotionLadder, OrderSubremark.ISSENDLADDER_YES, new Date());
									List<OrderSubremark> orderSubremarkList_temp = tianheOrder.getOrderSubremarkList();
									if (null == orderSubremarkList_temp)
										orderSubremarkList_temp = new ArrayList<>();
									orderSubremarkList_temp.add(orderSubremark);
									tianheOrder.setOrderSubremarkList(orderSubremarkList_temp);

									tianheOrder.setOrderGoodList(orderGoodsList_tianheOrder);
									isNeedNextPro = false;
									break;
								}
							}
							break;
						case Promotion.TYPE_2:
							// 满减";
							for (PromotionLadder promotionLadder : promotion.getPromotionLadderList()) {
								if (0F <= DoubleUtil.sub(sumMoney, promotionLadder.getLadderStart())) {
									orderGoodsList_tianheOrder.addAll(orderGoodsList);
									orderGoodsList.clear();
									tianheOrder.setSumMoney(
											DoubleUtil.add(sumMoney, tianheOrder.getSumMoney()).toString());
									tianheOrder.setSumNumber(
											(Integer.parseInt(tianheOrder.getSumNumber()) + sumCount) + "");

									tianheOrder.setSubMoney(DoubleUtil
											.add(tianheOrder.getSubMoney(), promotionLadder.getPromotionMoney())
											.toString());

									tianheOrder.setPayMoney(DoubleUtil
											.sub(tianheOrder.getSumMoney(), tianheOrder.getSubMoney()).toString());

									for (OrderGoods orderGoods : orderGoodsList_tianheOrder) {
										orderGoods
												.setSubMoney(
														DoubleUtil.mul(
																DoubleUtil
																		.div(DoubleUtil
																				.mul(orderGoods.getPrice(),
																						orderGoods.getCount())
																				.toString(), sumMoney)
																		.toString(),
																promotionLadder.getPromotionMoney()).toString());
										orderGoods.setOrder(tianheOrder);
									}

									OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), tianheOrder,
											promotionLadder, OrderSubremark.ISSENDLADDER_YES, new Date());
									List<OrderSubremark> orderSubremarkList_temp = tianheOrder.getOrderSubremarkList();
									if (null == orderSubremarkList_temp)
										orderSubremarkList_temp = new ArrayList<>();
									orderSubremarkList_temp.add(orderSubremark);
									tianheOrder.setOrderSubremarkList(orderSubremarkList_temp);

									tianheOrder.setOrderGoodList(orderGoodsList_tianheOrder);
									isNeedNextPro = false;
									break;
								}
							}
							break;
						case Promotion.TYPE_3:
							// 满返";
							for (PromotionLadder promotionLadder : promotion.getPromotionLadderList()) {
								if (0F <= DoubleUtil.sub(sumMoney, promotionLadder.getLadderStart())) {
									orderGoodsList_tianheOrder.addAll(orderGoodsList);
									orderGoodsList.clear();
									tianheOrder.setSumMoney(
											DoubleUtil.add(sumMoney, tianheOrder.getSumMoney()).toString());
									tianheOrder.setSumNumber(
											(Integer.parseInt(tianheOrder.getSumNumber()) + sumCount) + "");

									tianheOrder.setSubMoney("0.0");

									tianheOrder.setPayMoney(tianheOrder.getSumMoney());

									for (OrderGoods orderGoods : orderGoodsList_tianheOrder) {
										orderGoods.setSubMoney("0.0");
										orderGoods.setOrder(tianheOrder);
									}

									OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), tianheOrder,
											promotionLadder, OrderSubremark.ISSENDLADDER_NO, new Date());
									List<OrderSubremark> orderSubremarkList_temp = tianheOrder.getOrderSubremarkList();
									if (null == orderSubremarkList_temp)
										orderSubremarkList_temp = new ArrayList<>();
									orderSubremarkList_temp.add(orderSubremark);
									tianheOrder.setOrderSubremarkList(orderSubremarkList_temp);

									tianheOrder.setOrderGoodList(orderGoodsList_tianheOrder);
									isNeedNextPro = false;
									break;
								}
							}
							break;
						case Promotion.TYPE_4:
							// 特价促销";
							break;
						case Promotion.TYPE_5:
							// 前二件折扣";
							if (2 <= sumCount) {
								tianheOrder.setSumNumber((Integer.parseInt(tianheOrder.getSumNumber()) + 2) + "");
								List<Double> zhekou_numbers = new ArrayList<>();
								zhekou_numbers.add(DoubleUtil.div(promotion.getOtherPro1(), "100"));
								zhekou_numbers.add(DoubleUtil.div(promotion.getOtherPro2(), "100"));
								Collections.sort(zhekou_numbers);

								int needGoodsNumber = 2;
								Iterator<OrderGoods> it = orderGoodsList.iterator();
								while (it.hasNext()) {
									OrderGoods orderGoods = it.next();
									if (needGoodsNumber < Integer.parseInt(orderGoods.getCount())) {
										orderGoods.setCount(
												(Integer.parseInt(orderGoods.getCount()) - needGoodsNumber) + "");

										List<OrderGoodsQrcode> ogQrcodeList = new ArrayList<>();
										List<OrderGoodsQrcode> ogQrcodeList_return_orderGoods = orderGoods.getoGQList();
										if (null != ogQrcodeList_return_orderGoods
												&& !ogQrcodeList_return_orderGoods.isEmpty()) {
											ogQrcodeList
													.addAll(ogQrcodeList_return_orderGoods.subList(0, needGoodsNumber));
											ogQrcodeList_return_orderGoods.removeAll(ogQrcodeList);
											orderGoods.setoGQList(ogQrcodeList_return_orderGoods);
										}

										for (int i = 0; i < needGoodsNumber; i++) {
											OrderGoods orderGoods_temp = new OrderGoods(UUID.getUUID(), tianheOrder,
													orderGoods.getGoods(), "1", orderGoods.getPrice(), "0.0",
													OrderGoods.TYPE_OUT, new Date());
											if (null != ogQrcodeList && !ogQrcodeList.isEmpty()) {
												List<OrderGoodsQrcode> ogQrcodeList_temp = ogQrcodeList.subList(i,
														i + 1);
												ogQrcodeList_temp.get(0).setOrderGoods(orderGoods_temp);
												orderGoods_temp.setoGQList(ogQrcodeList_temp);
											}
											orderGoodsList_tianheOrder.add(orderGoods_temp);
										}

										needGoodsNumber = 0;
									} else if (needGoodsNumber == Integer.parseInt(orderGoods.getCount())) {
										List<OrderGoodsQrcode> ogQrcodeList = orderGoods.getoGQList();

										for (int i = 0; i < needGoodsNumber; i++) {
											OrderGoods orderGoods_temp = new OrderGoods(UUID.getUUID(), tianheOrder,
													orderGoods.getGoods(), "1", orderGoods.getPrice(), "0.0",
													OrderGoods.TYPE_OUT, new Date());
											if (null != ogQrcodeList && !ogQrcodeList.isEmpty()) {
												List<OrderGoodsQrcode> ogQrcodeList_temp = ogQrcodeList.subList(i,
														i + 1);
												ogQrcodeList_temp.get(0).setOrderGoods(orderGoods_temp);
												orderGoods_temp.setoGQList(ogQrcodeList_temp);
											}
											orderGoodsList_tianheOrder.add(orderGoods_temp);
										}

										needGoodsNumber = 0;
										it.remove();
									} else {
										List<OrderGoodsQrcode> ogQrcodeList = orderGoods.getoGQList();

										for (int i = 0; i < Integer.parseInt(orderGoods.getCount()); i++) {
											OrderGoods orderGoods_temp = new OrderGoods(UUID.getUUID(), tianheOrder,
													orderGoods.getGoods(), "1", orderGoods.getPrice(), "0.0",
													OrderGoods.TYPE_OUT, new Date());
											if (null != ogQrcodeList && !ogQrcodeList.isEmpty()) {
												List<OrderGoodsQrcode> ogQrcodeList_temp = ogQrcodeList.subList(i,
														i + 1);
												ogQrcodeList_temp.get(0).setOrderGoods(orderGoods_temp);
												orderGoods_temp.setoGQList(ogQrcodeList_temp);
											}
											orderGoodsList_tianheOrder.add(orderGoods_temp);
										}

										needGoodsNumber -= Integer.parseInt(orderGoods.getCount());
										it.remove();
									}

									if (0 >= needGoodsNumber) {
										break;
									}
								}
								String order_sub_money = "0.0";
								for (int i = 0; i < orderGoodsList_tianheOrder.size(); i++) {
									OrderGoods orderGoods_temp = orderGoodsList_tianheOrder.get(i);
									String old_price = orderGoods_temp.getPrice();
									String sub_money = DoubleUtil.sub(old_price, DoubleUtil
											.mul(Double.parseDouble(old_price), zhekou_numbers.get(i)).toString())
											.toString();
									orderGoods_temp.setSubMoney(sub_money);
									tianheOrder.setSumMoney(DoubleUtil
											.add(orderGoods_temp.getPrice(), tianheOrder.getSumMoney()).toString());
									order_sub_money = DoubleUtil.add(sub_money, order_sub_money).toString();
								}
								tianheOrder.setSubMoney(order_sub_money);
								tianheOrder.setPayMoney(DoubleUtil
										.sub(tianheOrder.getSumMoney(), tianheOrder.getSubMoney()).toString());

								OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), tianheOrder,
										promotion, OrderSubremark.ISSENDLADDER_YES, new Date());
								List<OrderSubremark> orderSubremarkList_temp = tianheOrder.getOrderSubremarkList();
								if (null == orderSubremarkList_temp)
									orderSubremarkList_temp = new ArrayList<>();
								orderSubremarkList_temp.add(orderSubremark);
								tianheOrder.setOrderSubremarkList(orderSubremarkList_temp);

								tianheOrder.setOrderGoodList(orderGoodsList_tianheOrder);
								isNeedNextPro = false;
							}
							break;
						case Promotion.TYPE_6:
							// 前三件折扣";
							if (3 <= sumCount) {
								tianheOrder.setSumNumber((Integer.parseInt(tianheOrder.getSumNumber()) + 3) + "");
								List<Double> zhekou_numbers = new ArrayList<>();
								zhekou_numbers.add(DoubleUtil.div(promotion.getOtherPro1(), "100"));
								zhekou_numbers.add(DoubleUtil.div(promotion.getOtherPro2(), "100"));
								zhekou_numbers.add(DoubleUtil.div(promotion.getOtherPro3(), "100"));
								Collections.sort(zhekou_numbers);

								int needGoodsNumber = 3;
								Iterator<OrderGoods> it = orderGoodsList.iterator();
								while (it.hasNext()) {
									OrderGoods orderGoods = it.next();
									if (needGoodsNumber < Integer.parseInt(orderGoods.getCount())) {
										orderGoods.setCount(
												(Integer.parseInt(orderGoods.getCount()) - needGoodsNumber) + "");

										List<OrderGoodsQrcode> ogQrcodeList = new ArrayList<>();
										List<OrderGoodsQrcode> ogQrcodeList_return_orderGoods = orderGoods.getoGQList();
										if (null != ogQrcodeList_return_orderGoods
												&& !ogQrcodeList_return_orderGoods.isEmpty()) {
											ogQrcodeList
													.addAll(ogQrcodeList_return_orderGoods.subList(0, needGoodsNumber));
											ogQrcodeList_return_orderGoods.removeAll(ogQrcodeList);
											orderGoods.setoGQList(ogQrcodeList_return_orderGoods);
										}

										for (int i = 0; i < needGoodsNumber; i++) {
											OrderGoods orderGoods_temp = new OrderGoods(UUID.getUUID(), tianheOrder,
													orderGoods.getGoods(), "1", orderGoods.getPrice(), "0.0",
													OrderGoods.TYPE_OUT, new Date());
											if (null != ogQrcodeList && !ogQrcodeList.isEmpty()) {
												List<OrderGoodsQrcode> ogQrcodeList_temp = ogQrcodeList.subList(i,
														i + 1);
												ogQrcodeList_temp.get(0).setOrderGoods(orderGoods_temp);
												orderGoods_temp.setoGQList(ogQrcodeList_temp);
											}
											orderGoodsList_tianheOrder.add(orderGoods_temp);
										}

										needGoodsNumber = 0;
									} else if (needGoodsNumber == Integer.parseInt(orderGoods.getCount())) {
										List<OrderGoodsQrcode> ogQrcodeList = orderGoods.getoGQList();

										for (int i = 0; i < needGoodsNumber; i++) {
											OrderGoods orderGoods_temp = new OrderGoods(UUID.getUUID(), tianheOrder,
													orderGoods.getGoods(), "1", orderGoods.getPrice(), "0.0",
													OrderGoods.TYPE_OUT, new Date());
											if (null != ogQrcodeList && !ogQrcodeList.isEmpty()) {
												List<OrderGoodsQrcode> ogQrcodeList_temp = ogQrcodeList.subList(i,
														i + 1);
												ogQrcodeList_temp.get(0).setOrderGoods(orderGoods_temp);
												orderGoods_temp.setoGQList(ogQrcodeList_temp);
											}
											orderGoodsList_tianheOrder.add(orderGoods_temp);
										}

										needGoodsNumber = 0;
										it.remove();
									} else {
										List<OrderGoodsQrcode> ogQrcodeList = orderGoods.getoGQList();

										for (int i = 0; i < Integer.parseInt(orderGoods.getCount()); i++) {
											OrderGoods orderGoods_temp = new OrderGoods(UUID.getUUID(), tianheOrder,
													orderGoods.getGoods(), "1", orderGoods.getPrice(), "0.0",
													OrderGoods.TYPE_OUT, new Date());
											if (null != ogQrcodeList && !ogQrcodeList.isEmpty()) {
												List<OrderGoodsQrcode> ogQrcodeList_temp = ogQrcodeList.subList(i,
														i + 1);
												ogQrcodeList_temp.get(0).setOrderGoods(orderGoods_temp);
												orderGoods_temp.setoGQList(ogQrcodeList_temp);
											}
											orderGoodsList_tianheOrder.add(orderGoods_temp);
										}

										needGoodsNumber -= Integer.parseInt(orderGoods.getCount());
										it.remove();
									}

									if (0 >= needGoodsNumber) {
										break;
									}
								}
								String order_sub_money = "0.0";
								for (int i = 0; i < orderGoodsList_tianheOrder.size(); i++) {
									OrderGoods orderGoods_temp = orderGoodsList_tianheOrder.get(i);
									String old_price = orderGoods_temp.getPrice();
									String sub_money = DoubleUtil.sub(old_price, DoubleUtil
											.mul(Double.parseDouble(old_price), zhekou_numbers.get(i)).toString())
											.toString();
									orderGoods_temp.setSubMoney(sub_money);
									tianheOrder.setSumMoney(DoubleUtil
											.add(orderGoods_temp.getPrice(), tianheOrder.getSumMoney()).toString());
									order_sub_money = DoubleUtil.add(sub_money, order_sub_money).toString();
								}
								tianheOrder.setSubMoney(order_sub_money);
								tianheOrder.setPayMoney(DoubleUtil
										.sub(tianheOrder.getSumMoney(), tianheOrder.getSubMoney()).toString());

								OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), tianheOrder,
										promotion, OrderSubremark.ISSENDLADDER_YES, new Date());
								List<OrderSubremark> orderSubremarkList_temp = tianheOrder.getOrderSubremarkList();
								if (null == orderSubremarkList_temp)
									orderSubremarkList_temp = new ArrayList<>();
								orderSubremarkList_temp.add(orderSubremark);
								tianheOrder.setOrderSubremarkList(orderSubremarkList_temp);

								tianheOrder.setOrderGoodList(orderGoodsList_tianheOrder);
								isNeedNextPro = false;
							}
							break;
						case Promotion.TYPE_7:
							// 满送促销";
							for (PromotionLadder promotionLadder : promotion.getPromotionLadderList()) {
								if (0F <= DoubleUtil.sub(sumMoney, promotionLadder.getLadderStart())) {
									orderGoodsList_tianheOrder.addAll(orderGoodsList);
									orderGoodsList.clear();
									tianheOrder.setSumMoney(
											DoubleUtil.add(sumMoney, tianheOrder.getSumMoney()).toString());
									tianheOrder.setSumNumber(
											(Integer.parseInt(tianheOrder.getSumNumber()) + sumCount) + "");
									tianheOrder.setPayMoney(tianheOrder.getSumMoney());

									for (OrderGoods orderGoods : orderGoodsList_tianheOrder) {
										orderGoods.setSubMoney("0.0");
										orderGoods.setOrder(tianheOrder);
									}

									OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), tianheOrder,
											promotionLadder, OrderSubremark.ISSENDLADDER_NO, new Date());
									List<OrderSubremark> orderSubremarkList_temp = tianheOrder.getOrderSubremarkList();
									if (null == orderSubremarkList_temp)
										orderSubremarkList_temp = new ArrayList<>();
									orderSubremarkList_temp.add(orderSubremark);
									tianheOrder.setOrderSubremarkList(orderSubremarkList_temp);

									tianheOrder.setOrderGoodList(orderGoodsList_tianheOrder);
									isNeedNextPro = false;
									break;
								}
							}
							break;
						case Promotion.TYPE_8:
							// 买赠促销";
							for (PromotionLadder promotionLadder : promotion.getPromotionLadderList()) {
								if (0F <= DoubleUtil.sub(sumMoney, promotionLadder.getLadderStart())) {
									orderGoodsList_tianheOrder.addAll(orderGoodsList);
									orderGoodsList.clear();
									tianheOrder.setSumMoney(
											DoubleUtil.add(sumMoney, tianheOrder.getSumMoney()).toString());
									tianheOrder.setSumNumber(
											(Integer.parseInt(tianheOrder.getSumNumber()) + sumCount) + "");
									tianheOrder.setPayMoney(tianheOrder.getSumMoney());

									for (OrderGoods orderGoods : orderGoodsList_tianheOrder) {
										orderGoods.setSubMoney("0.0");
										orderGoods.setOrder(tianheOrder);
									}

									OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), tianheOrder,
											promotionLadder, OrderSubremark.ISSENDLADDER_NO, new Date());
									List<OrderSubremark> orderSubremarkList_temp = tianheOrder.getOrderSubremarkList();
									if (null == orderSubremarkList_temp)
										orderSubremarkList_temp = new ArrayList<>();
									orderSubremarkList_temp.add(orderSubremark);
									tianheOrder.setOrderSubremarkList(orderSubremarkList_temp);

									tianheOrder.setOrderGoodList(orderGoodsList_tianheOrder);
									isNeedNextPro = false;
									break;
								}
							}
							break;
						case Promotion.TYPE_9:
							// 加钱换购";
							for (PromotionLadder promotionLadder : promotion.getPromotionLadderList()) {
								if (0F <= DoubleUtil.sub(sumMoney, promotionLadder.getLadderStart())) {
									orderGoodsList_tianheOrder.addAll(orderGoodsList);
									orderGoodsList.clear();
									tianheOrder.setSumMoney(
											DoubleUtil.add(sumMoney, tianheOrder.getSumMoney()).toString());
									tianheOrder.setSumNumber(
											(Integer.parseInt(tianheOrder.getSumNumber()) + sumCount) + "");
									tianheOrder.setPayMoney(tianheOrder.getSumMoney());

									for (OrderGoods orderGoods : orderGoodsList_tianheOrder) {
										orderGoods.setSubMoney("0.0");
										orderGoods.setOrder(tianheOrder);
									}

									OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), tianheOrder,
											promotionLadder, OrderSubremark.ISSENDLADDER_NO, new Date());
									orderSubremark.setSalesMoney(promotionLadder.getGoodsPrice());
									List<OrderSubremark> orderSubremarkList_temp = tianheOrder.getOrderSubremarkList();
									if (null == orderSubremarkList_temp)
										orderSubremarkList_temp = new ArrayList<>();
									orderSubremarkList_temp.add(orderSubremark);
									tianheOrder.setOrderSubremarkList(orderSubremarkList_temp);

									tianheOrder.setOrderGoodList(orderGoodsList_tianheOrder);
									isNeedNextPro = false;
									break;
								}
							}
							break;
						case Promotion.TYPE_10:
							// 第二件折扣";
							if (2 <= sumCount) {
								tianheOrder.setSumNumber((Integer.parseInt(tianheOrder.getSumNumber()) + 2) + "");
								int needGoodsNumber = 2;
								Iterator<OrderGoods> it = orderGoodsList.iterator();
								while (it.hasNext()) {
									OrderGoods orderGoods = it.next();
									if (needGoodsNumber < Integer.parseInt(orderGoods.getCount())) {
										orderGoods.setCount(
												(Integer.parseInt(orderGoods.getCount()) - needGoodsNumber) + "");

										List<OrderGoodsQrcode> ogQrcodeList = new ArrayList<>();
										List<OrderGoodsQrcode> ogQrcodeList_return_orderGoods = orderGoods.getoGQList();
										if (null != ogQrcodeList_return_orderGoods
												&& !ogQrcodeList_return_orderGoods.isEmpty()) {
											ogQrcodeList
													.addAll(ogQrcodeList_return_orderGoods.subList(0, needGoodsNumber));
											ogQrcodeList_return_orderGoods.removeAll(ogQrcodeList);
											orderGoods.setoGQList(ogQrcodeList_return_orderGoods);
										}

										for (int i = 0; i < needGoodsNumber; i++) {
											OrderGoods orderGoods_temp = new OrderGoods(UUID.getUUID(), tianheOrder,
													orderGoods.getGoods(), "1", orderGoods.getPrice(), "0.0",
													OrderGoods.TYPE_OUT, new Date());
											if (null != ogQrcodeList && !ogQrcodeList.isEmpty()) {
												List<OrderGoodsQrcode> ogQrcodeList_temp = ogQrcodeList.subList(i,
														i + 1);
												ogQrcodeList_temp.get(0).setOrderGoods(orderGoods_temp);
												orderGoods_temp.setoGQList(ogQrcodeList_temp);
											}
											tianheOrder.setSumMoney(DoubleUtil
													.add(orderGoods_temp.getPrice(), tianheOrder.getSumMoney())
													.toString());
											orderGoodsList_tianheOrder.add(orderGoods_temp);
										}

										needGoodsNumber = 0;
									} else if (needGoodsNumber == Integer.parseInt(orderGoods.getCount())) {
										List<OrderGoodsQrcode> ogQrcodeList = orderGoods.getoGQList();

										for (int i = 0; i < needGoodsNumber; i++) {
											OrderGoods orderGoods_temp = new OrderGoods(UUID.getUUID(), tianheOrder,
													orderGoods.getGoods(), "1", orderGoods.getPrice(), "0.0",
													OrderGoods.TYPE_OUT, new Date());
											if (null != ogQrcodeList && !ogQrcodeList.isEmpty()) {
												List<OrderGoodsQrcode> ogQrcodeList_temp = ogQrcodeList.subList(i,
														i + 1);
												ogQrcodeList_temp.get(0).setOrderGoods(orderGoods_temp);
												orderGoods_temp.setoGQList(ogQrcodeList_temp);
											}
											tianheOrder.setSumMoney(DoubleUtil
													.add(orderGoods_temp.getPrice(), tianheOrder.getSumMoney())
													.toString());
											orderGoodsList_tianheOrder.add(orderGoods_temp);
										}

										needGoodsNumber = 0;
										it.remove();
									} else {
										List<OrderGoodsQrcode> ogQrcodeList = orderGoods.getoGQList();

										for (int i = 0; i < Integer.parseInt(orderGoods.getCount()); i++) {
											OrderGoods orderGoods_temp = new OrderGoods(UUID.getUUID(), tianheOrder,
													orderGoods.getGoods(), "1", orderGoods.getPrice(), "0.0",
													OrderGoods.TYPE_OUT, new Date());
											if (null != ogQrcodeList && !ogQrcodeList.isEmpty()) {
												List<OrderGoodsQrcode> ogQrcodeList_temp = ogQrcodeList.subList(i,
														i + 1);
												ogQrcodeList_temp.get(0).setOrderGoods(orderGoods_temp);
												orderGoods_temp.setoGQList(ogQrcodeList_temp);
											}
											tianheOrder.setSumMoney(DoubleUtil
													.add(orderGoods_temp.getPrice(), tianheOrder.getSumMoney())
													.toString());
											orderGoodsList_tianheOrder.add(orderGoods_temp);
										}

										needGoodsNumber -= Integer.parseInt(orderGoods.getCount());
										it.remove();
									}

									if (0 >= needGoodsNumber) {
										break;
									}
								}

								String order_sub_money = "0.0";
								OrderGoods orderGoods_temp = orderGoodsList_tianheOrder.get(1);
								String old_price = orderGoods_temp.getPrice();
								String sub_money = DoubleUtil.sub(old_price,
										DoubleUtil
												.mul(old_price,
														DoubleUtil.div(promotion.getOtherPro1(), "100").toString())
												.toString())
										.toString();
								orderGoods_temp.setSubMoney(sub_money);
								order_sub_money = DoubleUtil.add(sub_money, order_sub_money).toString();
								tianheOrder.setSubMoney(order_sub_money);
								tianheOrder.setPayMoney(DoubleUtil
										.sub(tianheOrder.getSumMoney(), tianheOrder.getSubMoney()).toString());

								OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), tianheOrder,
										promotion, OrderSubremark.ISSENDLADDER_YES, new Date());
								List<OrderSubremark> orderSubremarkList_temp = tianheOrder.getOrderSubremarkList();
								if (null == orderSubremarkList_temp)
									orderSubremarkList_temp = new ArrayList<>();
								orderSubremarkList_temp.add(orderSubremark);
								tianheOrder.setOrderSubremarkList(orderSubremarkList_temp);

								tianheOrder.setOrderGoodList(orderGoodsList_tianheOrder);
								isNeedNextPro = false;
							}
							break;
						case Promotion.TYPE_11:
							// 单品折扣";
							break;
						default:
							// 未知";
							break;
						}
					}
					if (!orderGoodsList_tianheOrder.isEmpty())
						order_map_to_return.put("tianheOrder", tianheOrder);
				}
			}
			if (!orderGoodsList.isEmpty()) {
				Order order_other = new Order();

				String sumMoney = "0.0";
				int sumCount = 0;
				for (OrderGoods orderGoods : orderGoodsList) {
					sumMoney = DoubleUtil
							.add(sumMoney, DoubleUtil.mul(orderGoods.getPrice(), orderGoods.getCount()).toString())
							.toString();
					sumCount += Integer.parseInt(orderGoods.getCount());
				}
				order_other.setSumMoney(sumMoney);
				order_other.setSumNumber(sumCount + "");
				order_other.setSubMoney("0.0");
				order_other.setPayMoney(sumMoney);
				order_other.setOrderGoodList(orderGoodsList);
				order_map_to_return.put("otherOrder", order_other);
			}
		}
		return order_map_to_return;
	}

	/**
	 *
	 * <P>
	 * 导购开票保存
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 11, 2017
	 * @param order
	 * @return AjaxJson
	 * @throws Exception
	 */
	public AjaxJson saveSaleOrderInpute(Order order) {
		// goodsOrder对应产品级活动子订单，storeOrder对应门店级活动子订单，
		// tianheOrder对应天和级活动子订单，otherOrder代表无活动子订单产品，
		// nullOrder 代表讲价优惠订单
		AjaxJson ajaxJson = new AjaxJson();
		boolean isNeedAddEticket = false;
		List<Qrcode> qrcodeList = order.getQrcodeList();

		Iterator<Qrcode> it = qrcodeList.iterator();
		while (it.hasNext()) {
			Qrcode qrcode = it.next();
			if (null == qrcode || StringUtils.isBlank(qrcode.getId())) {
				it.remove();
			}
		}

		order.setId(UUID.getUUID());
		order.setSumNumber(qrcodeList.size() + "");
		order.setCode(OrderCodeID.nextCode());
		order.setState(Order.STATE_ONE);
		order.setType(Order.TYPE_TWO);
		order.setCreateTime(new Date());
		String order_sumMoney = "0.0";
		List<Order> order_child_list = new ArrayList<>();

		if (StringUtils.isNotBlank(order.getSubUserType()) || null == order.getCustomer()
				|| StringUtils.isBlank(order.getCustomer().getId())) {
			Order nullOrder = new Order(UUID.getUUID());
			nullOrder.setOrder(order);
			nullOrder.setProType("nullOrder");
			nullOrder.setSumNumber(qrcodeList.size() + "");
			nullOrder.setCode(OrderCodeID.nextCode());
			nullOrder.setState(order.getState());
			nullOrder.setGuideUser(order.getGuideUser());
			nullOrder.setCreateTime(new Date());
			nullOrder.setCustomer(null);
			nullOrder.setStore(order.getStore());
			nullOrder.setType(order.getType());
			order.setCustomer(null);

			List<OrderGoods> orderGoods_no_pro = new ArrayList<>();
			// 主管优惠等，无需依据切订单（保存主订单和一个主管优惠的子订单）
			// 计算每件产品成交金额，权重方式计算
			for (Qrcode qrcode : qrcodeList) {
				if (StringUtils.isNotBlank(qrcode.getId()))
					order_sumMoney = DoubleUtil.add(order_sumMoney, qrcode.getGoods().getSalesPrice()).toString();
			}
			String zhekou = DoubleUtil
					.div(StringUtils.isNotBlank(order.getSubMoney()) ? order.getSubMoney() : "0.0", order_sumMoney)
					.toString();
			order.setSumMoney(order_sumMoney);
			order.setPayMoney(DoubleUtil.sub(order.getSumMoney(), order.getSubMoney()).toString());

			// 设置首次支付金额、未退款金额、第二次支付金额、第二次未退款金额
			order.setOnePayMoney(order.getPayMoney());
			order.setOneReturnMoney(order.getPayMoney());
			order.setTwoPayMoney("0.0");
			order.setTwoReturnMoney("0.0");

			nullOrder.setSumMoney(order_sumMoney);
			nullOrder.setPayMoney(DoubleUtil.sub(nullOrder.getSumMoney(), nullOrder.getSubMoney()).toString());
			for (Qrcode qrcode : qrcodeList) {
				if (null != qrcode && StringUtils.isNotBlank(qrcode.getId())) {
					boolean no_pro_have_this_qrcode = false;
					if (!orderGoods_no_pro.isEmpty())
						for (OrderGoods orderGoods_for : orderGoods_no_pro) {
							if (orderGoods_for.getGoods().getId().equals(qrcode.getGoods().getId())) {
								no_pro_have_this_qrcode = true;
								orderGoods_for
										.setCount(String.valueOf(Integer.parseInt(orderGoods_for.getCount()) + 1));
								orderGoods_for.setSubMoney(DoubleUtil
										.add(orderGoods_for.getSubMoney(),
												DoubleUtil.mul(zhekou, qrcode.getGoods().getSalesPrice()).toString())
										.toString());
								List<OrderGoodsQrcode> ogqList = orderGoods_for.getoGQList();
								ogqList.add(new OrderGoodsQrcode(UUID.getUUID(), orderGoods_for, qrcode,
										OrderGoodsQrcode.ISJOIN_NO, new Date()));
								orderGoods_for.setoGQList(ogqList);
								break;
							}
						}
					if (!no_pro_have_this_qrcode) {
						// 没有
						OrderGoods orderGoods = this.getOrcodeGoodsByQrcode(qrcode, OrderGoodsQrcode.ISJOIN_NO);
						if (null != orderGoods) {
							orderGoods.setOrder(nullOrder);
							orderGoods
									.setSubMoney(DoubleUtil.mul(zhekou, qrcode.getGoods().getSalesPrice()).toString());
							orderGoods_no_pro.add(orderGoods);
						}
					}
				}
			}
			nullOrder.setOrderGoodList(orderGoods_no_pro);
			order_child_list.add(nullOrder);
			order.setOrderList(order_child_list);
		} else {
			// 无主管优惠，则页面内打勾的二维码切分为要参与活动的orderGoodslist进行按照活动切订单的操作
			// 未打勾的 直接保存在无活动子订单中，重新切分订单时
			// 不参与活动订单
			Order otherOrder = new Order(UUID.getUUID());
			otherOrder.setOrder(order);
			otherOrder.setProType("otherOrder");
			otherOrder.setState(order.getState());
			otherOrder.setGuideUser(order.getGuideUser());
			otherOrder.setCode(OrderCodeID.nextCode());
			otherOrder.setType(order.getType());
			otherOrder.setStore(order.getStore());
			otherOrder.setCreateTime(new Date());
			Map<String, Order> map_order = null;
			int otherNumber = 0;
			String otherMoney = "0.0";
			List<OrderGoods> orderGoods_no_pro = new ArrayList<>();

			// 参与活动的，等待切订单用
			List<OrderGoods> orderGoods_have_pro = new ArrayList<>();
			for (Qrcode qrcode : qrcodeList) {
				if (null != qrcode && StringUtils.isNotBlank(qrcode.getId())) {
					order_sumMoney = DoubleUtil.add(order_sumMoney, qrcode.getGoods().getSalesPrice()).toString();
					if ("true".equals(qrcode.getIsJoin())) {
						// 参与活动的二维码
						boolean pro_have_this_qrcode = false;
						if (!orderGoods_have_pro.isEmpty())
							for (OrderGoods orderGoods_for : orderGoods_have_pro) {
								if (orderGoods_for.getGoods().getId().equals(qrcode.getGoods().getId())) {
									pro_have_this_qrcode = true;
									orderGoods_for
											.setCount(String.valueOf(Integer.parseInt(orderGoods_for.getCount()) + 1));
									List<OrderGoodsQrcode> ogqList = orderGoods_for.getoGQList();
									ogqList.add(new OrderGoodsQrcode(UUID.getUUID(), orderGoods_for, qrcode,
											OrderGoodsQrcode.ISJOIN_YES, new Date()));
									orderGoods_for.setoGQList(ogqList);
									break;
								}
							}
						if (!pro_have_this_qrcode) {
							// 没有
							OrderGoods orderGoods = this.getOrcodeGoodsByQrcode(qrcode, OrderGoodsQrcode.ISJOIN_YES);
							if (null != orderGoods) {
								orderGoods_have_pro.add(orderGoods);
							}
						}
						// list排序，依据自定义的排序条件（商品单价）降序排序
						Collections.sort(orderGoods_have_pro);
					} else {
						otherNumber++;
						otherMoney = DoubleUtil.add(otherMoney, qrcode.getGoods().getSalesPrice()).toString();
						// 不参与活动的二维码
						boolean no_pro_have_this_qrcode = false;
						isNeedAddEticket = true;
						if (!orderGoods_no_pro.isEmpty())
							for (OrderGoods orderGoods_for : orderGoods_no_pro) {
								if (orderGoods_for.getGoods().getId().equals(qrcode.getGoods().getId())) {
									no_pro_have_this_qrcode = true;
									orderGoods_for
											.setCount(String.valueOf(Integer.parseInt(orderGoods_for.getCount()) + 1));
									List<OrderGoodsQrcode> ogqList = orderGoods_for.getoGQList();
									ogqList.add(new OrderGoodsQrcode(UUID.getUUID(), orderGoods_for, qrcode,
											OrderGoodsQrcode.ISJOIN_NO, new Date()));
									orderGoods_for.setoGQList(ogqList);
									break;
								}
							}
						if (!no_pro_have_this_qrcode) {
							// 没有
							OrderGoods orderGoods = this.getOrcodeGoodsByQrcode(qrcode, OrderGoodsQrcode.ISJOIN_NO);
							if (null != orderGoods) {
								orderGoods.setOrder(otherOrder);
								orderGoods_no_pro.add(orderGoods);
							}
						}
					}
				}
			}
			// 调起切割分订单
			if (!orderGoods_have_pro.isEmpty())
				map_order = this.splitOrderGoods(orderGoods_have_pro, order, Order.TYPE_TWO);

			order.setSumMoney(order_sumMoney);
			otherOrder.setOrderGoodList(orderGoods_no_pro);
			otherOrder.setSumNumber(otherNumber + "");
			otherOrder.setSumMoney(otherMoney);
			otherOrder.setSubMoney("0.0");
			otherOrder.setPayMoney(otherMoney);
			otherOrder.setCustomer(order.getCustomer());
			String order_sum_payMoney = "0.0";
			String order_sum_subMoney = "0.0";
			if (null != map_order) {
				if (!map_order.isEmpty()) {
					for (Map.Entry<String, Order> entry : map_order.entrySet()) {
						if ("otherOrder".equals(entry.getKey())) {
							isNeedAddEticket = true;
							List<OrderGoods> ogList_no_setOrder = entry.getValue().getOrderGoodList();
							for (OrderGoods orderGoods : ogList_no_setOrder) {
								orderGoods.setOrder(otherOrder);
							}
							orderGoods_no_pro.addAll(ogList_no_setOrder);
							otherOrder.setOrderGoodList(orderGoods_no_pro);
							otherOrder
									.setSumMoney(DoubleUtil.add(otherMoney, entry.getValue().getSumMoney()).toString());
							otherOrder.setSumNumber(
									(Integer.parseInt(entry.getValue().getSumNumber()) + otherNumber) + "");
							otherOrder.setSubMoney(DoubleUtil
									.add(otherOrder.getSubMoney(), entry.getValue().getSubMoney()).toString());
							otherOrder.setPayMoney(DoubleUtil
									.add(otherOrder.getPayMoney(), entry.getValue().getPayMoney()).toString());
						} else {
							order_sum_payMoney = DoubleUtil.add(order_sum_payMoney, entry.getValue().getPayMoney())
									.toString();
							order_sum_subMoney = DoubleUtil.add(order_sum_subMoney, entry.getValue().getSubMoney())
									.toString();
							order_child_list.add(entry.getValue());
						}
					}
				}
			}
			if (!orderGoods_no_pro.isEmpty()) {
				order_sum_payMoney = DoubleUtil.add(order_sum_payMoney, otherOrder.getPayMoney()).toString();
				order_sum_subMoney = DoubleUtil.add(order_sum_subMoney, otherOrder.getSubMoney()).toString();
				order_child_list.add(otherOrder);
			}
			order.setPayMoney(order_sum_payMoney);
			order.setSubMoney(order_sum_subMoney);
			order.setOrderList(order_child_list);

			// 设置首次支付金额、未退款金额、第二次支付金额、第二次未退款金额
			order.setOnePayMoney(order.getPayMoney());
			order.setOneReturnMoney(order.getPayMoney());
			order.setOnePayType(order.getPayType());
			order.setTwoPayType(order.getPayType());
			order.setTwoPayMoney("0.0");
			order.setTwoReturnMoney("0.0");
		}

		this.saveOrderCodeQrcodeImg(order.getCode());

		int qrcode1to4Number = 0;
		for (Qrcode qrcode : qrcodeList) {
			if (null != qrcode && StringUtils.isNotBlank(qrcode.getId())) {
				if (0 < qrcodeDAO.updateStateOneToFour(qrcode)) {
					qrcode1to4Number++;
				} else {
					throw new Error("订单二维码锁定失败，可能原因：该二维码已被其他地区锁定或已卖出~");
				}
			}
		}
		if (qrcode1to4Number != qrcodeList.size())
			throw new Error("订单二维码锁定失败，可能原因：某二维码已被其他地区锁定或已卖出~");

		if (0 >= this.saveOrderAll(order)) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("保存订单出错，请重试~");
		} else {
			if (!isNeedAddEticket)
				bindNoScopeGroup(order.getId());
			ajaxJson.setSuccess(true);
			Map<String, String> map = new HashMap<>();
			map.put("orderId", order.getId());
			if (isNeedAddEticket) {
				map.put("isNeedAddEticket", "yes");
			} else {
				map.put("isNeedAddEticket", "no");
			}
			ajaxJson.setObj(map);
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 绑定全场叠加级活动（只绑定单个目前）
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 8, 2017
	 * @param orderId
	 *            主订单Id void
	 */
	public void bindNoScopeGroup(String orderId) {
		Order order = orderDAO.get(orderId);
		if (null == order.getCustomer() || StringUtils.isBlank(order.getCustomer().getId())) {
			// 无会员的订单，不参与叠加级活动
			return;
		}
		String order_sum_payMoney = order.getPayMoney();
		List<PromotionGroup> noScopeGroupList = promotionGroupService.getNoScopeGroup();
		boolean isNeedNextPro = true;
		if (null != noScopeGroupList && !noScopeGroupList.isEmpty()) {
			for (PromotionGroup promotionGroup : noScopeGroupList) {
				if (!isNeedNextPro)
					break;

				for (Promotion promotion : promotionGroup.getPromotionList()) {
					if (!isNeedNextPro)
						break;

					switch (promotion.getType()) {
					case Promotion.TYPE_1:
						// 折扣--满折";
						break;
					case Promotion.TYPE_2:
						// 满减";
						break;
					case Promotion.TYPE_3:
						// 满返";
						break;
					case Promotion.TYPE_4:
						// 特价促销";
						break;
					case Promotion.TYPE_5:
						// 前二件折扣";
						break;
					case Promotion.TYPE_6:
						// 前三件折扣";
						break;
					case Promotion.TYPE_7:
						// 满送促销";
						break;
					case Promotion.TYPE_8:
						// 买赠促销";
						break;
					case Promotion.TYPE_9:
						// 加钱换购";
						for (PromotionLadder promotionLadder : promotion.getPromotionLadderList()) {
							if (0F <= DoubleUtil.sub(order_sum_payMoney, promotionLadder.getLadderStart())) {
								OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), order,
										promotionLadder, OrderSubremark.ISSENDLADDER_NO, new Date());
								if (0 < orderSubremarkDAO.save(orderSubremark)) {
									isNeedNextPro = false;
								}
								break;
							}
						}
						break;
					case Promotion.TYPE_10:
						// 第二件折扣";
						break;
					case Promotion.TYPE_11:
						// 单品折扣";
						break;
					default:
						// 未知";
						break;
					}
				}
			}
		}

	}

	/**
	 *
	 * <P>
	 * qrcode转换为orderGoods
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 11, 2017
	 * @param qrcode
	 * @return OrderGoods
	 */
	private OrderGoods getOrcodeGoodsByQrcode(Qrcode qrcode, String isJoin) {
		if (null != qrcode) {
			if (StringUtils.isNotBlank(qrcode.getId()) && StringUtils.isNotBlank(isJoin)) {
				OrderGoods orderGoods = new OrderGoods(UUID.getUUID());
				orderGoods.setCount("1");
				orderGoods.setPrice(qrcode.getGoods().getSalesPrice());
				orderGoods.setSubMoney("0.0");
				orderGoods.setType(OrderGoods.TYPE_OUT);
				orderGoods.setCreateTime(new Date());
				orderGoods.setGoods(qrcode.getGoods());
				List<OrderGoodsQrcode> ogqList = new ArrayList<>();
				ogqList.add(new OrderGoodsQrcode(UUID.getUUID(), orderGoods, qrcode, isJoin, new Date()));
				orderGoods.setoGQList(ogqList);
				return orderGoods;
			}
		}
		return null;
	}

	/**
	 *
	 * <P>
	 * 保存订单信息（同时保存二级订单、各订单对应oederGoods以及orderGoods对应的qrcode信息）
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 11, 2017
	 * @param order
	 * @return int
	 */
	public int saveOrderAll(Order order) {
		if (null != order) {
			boolean isTianheOrder = true;
			if (Store.TYPE_TWO.equals(order.getStore().getType())) {
				isTianheOrder = false;
			}
			order.setOnePayMoney(DoubleUtil.toDecimalString(order.getOnePayMoney(), 1));
			order.setOneReturnMoney(DoubleUtil.toDecimalString(order.getOneReturnMoney(), 1));
			order.setTwoPayMoney(DoubleUtil.toDecimalString(order.getTwoPayMoney(), 1));
			order.setTwoReturnMoney(DoubleUtil.toDecimalString(order.getTwoReturnMoney(), 1));
			order.setPayMoney(DoubleUtil.toDecimalString(order.getPayMoney(), 2));
			order.setSumMoney(DoubleUtil.toDecimalString(order.getSumMoney(), 2));
			order.setSubMoney(DoubleUtil.toDecimalString(order.getSubMoney(), 2));
			int i = orderDAO.save(order);
			if (0 < i) {
				for (Order child_order : order.getOrderList()) {
					if (0 < orderDAO.save(child_order)) {
						if (isTianheOrder) {// 不是商家的的，保存订单商品信息
							for (OrderGoods orderGoods : child_order.getOrderGoodList()) {
								if (0 < orderGoodsDAO.save(orderGoods)) {
									// 保存二维码和减免记录（如果有）
									OrderSubremark orderSubremarks = orderGoods.getOrderSubremark();
									if (null != orderSubremarks) {
										orderSubremarkDAO.save(orderSubremarks);
									}
									List<OrderGoodsQrcode> orderGoodsQrcoedes = orderGoods.getoGQList();
									if (null != orderGoodsQrcoedes && !orderGoodsQrcoedes.isEmpty()) {
										for (OrderGoodsQrcode orderGoodsQrcoede : orderGoodsQrcoedes) {
											orderGoodsQrcodeDAO.save(orderGoodsQrcoede);
										}
									}
								}
							}
						}
						// 保存减免记录（如果有）
						List<OrderSubremark> orderSubremarks = child_order.getOrderSubremarkList();
						if (null != orderSubremarks && !orderSubremarks.isEmpty()) {
							for (OrderSubremark orderSubremark : orderSubremarks) {
								orderSubremarkDAO.save(orderSubremark);
							}
						}
					}
				}
			}
			return i;
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 批量保存订单信息（同时保存二级订单、各订单对应oederGoods以及orderGoods对应的qrcode信息）
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月4日
	 * @param orderList
	 * @return int
	 */
	public int saveOrderListAll(List<Order> orderList, String inLinePayMoney) {

		String postage = "0";
		if (null != postageBonusService.getAll() && 0 < postageBonusService.getAll().size()) {
			PostageBonus postageBonus = postageBonusService.getAll().get(0);
			if (0 <= DoubleUtil.sub(inLinePayMoney, postageBonus.getStartMoney())) {
				postage = "0";
			} else {
				postage = postageBonus.getProportion();
				inLinePayMoney = DoubleUtil.add(inLinePayMoney, postage).toString();
			}
		}

		for (Order order : orderList) {
			if (null != order) {

				this.saveOrderCodeQrcodeImg(order.getCode());

				order.setPostage(postage);
				order.setInLinePayMoney(inLinePayMoney);
				int i = orderDAO.save(order);
				if (0 < i) {
					for (Order child_order : order.getOrderList()) {
						if (0 < orderDAO.save(child_order)) {
							for (OrderGoods orderGoods : child_order.getOrderGoodList()) {
								if (0 < orderGoodsDAO.save(orderGoods)) {
									// 保存二维码和减免记录（如果有）
									OrderSubremark orderSubremarks = orderGoods.getOrderSubremark();
									if (null != orderSubremarks) {
										if (0 >= orderSubremarkDAO.save(orderSubremarks)) {
											throw new Error("保存orderSubremarks出错");
										}
									}
									List<OrderGoodsQrcode> orderGoodsQrcoedes = orderGoods.getoGQList();
									if (null != orderGoodsQrcoedes && !orderGoodsQrcoedes.isEmpty()) {
										for (OrderGoodsQrcode orderGoodsQrcoede : orderGoodsQrcoedes) {
											if (0 >= orderGoodsQrcodeDAO.save(orderGoodsQrcoede)) {
												throw new Error("保存orderGoodsQrcoede出错");
											}
										}
									}
								}
							}
							// 保存减免记录（如果有）
							List<OrderSubremark> orderSubremarks = child_order.getOrderSubremarkList();
							if (null != orderSubremarks && !orderSubremarks.isEmpty()) {
								for (OrderSubremark orderSubremark : orderSubremarks) {
									if (0 >= orderSubremarkDAO.save(orderSubremark)) {
										throw new Error("保存orderSubremark出错");
									}
								}
							}
						} else {
							throw new Error("保存orderSubremark出错");
						}
					}
				} else {
					throw new Error("批量保存订单出错");
				}
			}
		}
		return 1;
	}

	/**
	 *
	 * <P>
	 * 客户端获取订单信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 23, 2017
	 * @param orderCode
	 * @return AjaxJson
	 */
	public AjaxJson getClientOrderByOrderCode(String orderCode, String cashierCode, String cashierUser_id) {
		AjaxJson ajaxJson = new AjaxJson();
		Order order = this.getNoPayOrderByOrderCode(orderCode);
		if (null != order && StringUtils.isNotBlank(order.getId())) {
			if (Order.TYPE_ONE.equals(order.getType())) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("线上订单不可在收银台结算哦~");
			} else {
				AjaxJson ajaxJson_return = new AjaxJson();
				ajaxJson_return.setSuccess(false);
				if (Order.TYPE_FIVE.equals(order.getType())) {
					// 走退款流程
					order.setCashierCode(cashierCode);
					order.setCashierUser(new User(cashierUser_id));
					ajaxJson_return = this.returnMoneyAll(order);
					if (!ajaxJson_return.isSuccess())
						return ajaxJson_return;
				}
				Map<String, Object> orderMap = new HashMap<>();
				List<Map<String, String>> goodsMsgListMap = new ArrayList<>();
				Customer customer = order.getCustomer();
				orderMap.put("id", order.getId());
				if (null != customer && StringUtils.isNotBlank(customer.getId())) {
					orderMap.put("customerPhone", customer.getPhone());
					orderMap.put("customerId", customer.getId());
				} else {
					orderMap.put("customerPhone", "");
					orderMap.put("customerId", "");
				}
				orderMap.put("storeName", order.getStore().getName());
				orderMap.put("code", orderCode);
				orderMap.put("sumMoney", order.getSumMoney());
				orderMap.put("sumNumber", order.getSumNumber());
				orderMap.put("subMoney", order.getSubMoney());
				orderMap.put("payType", order.getPayType());
				orderMap.put("storeCode", order.getStore().getStoreCode());
				if (Order.TYPE_FOUR.equals(order.getType())) {
					if (StringUtils.isBlank(order.getCashierCode())) {
						orderMap.put("payMoney", order.getOnePayMoney());
					} else {
						if (order.getSumNumber().equals(order.getQrcodeCount())) {
							orderMap.put("payMoney", order.getTwoPayMoney());
						} else {
							ajaxJson.setSuccess(false);
							ajaxJson.setMsg("预约单请发货数量不足，不可支付，请引导客户去往导购处录入商品！");
							return ajaxJson;
						}
					}
				} else {
					orderMap.put("payMoney", order.getOnePayMoney());
				}

				List<OrderGoods> orderGoodsList = new ArrayList<>();
				if (null != order.getOrderList() && !order.getOrderList().isEmpty()) {
					for (Order childOrder : order.getOrderList()) {
						orderGoodsList.addAll(childOrder.getOrderGoodList());
					}
				} else {
					orderGoodsList = order.getOrderGoodList();
				}

				for (OrderGoods orderGoods : orderGoodsList) {
					if (Order.TYPE_FOUR.equals(order.getType()) || Order.TYPE_THREE.equals(order.getType())) {
						Map<String, String> goodsMsgMap = new HashMap<>();
						goodsMsgMap.put("qrcodeCode", "----");
						goodsMsgMap.put("goodsName",
								(StringUtils.isNotBlank(orderGoods.getGoods().getName())
										? orderGoods.getGoods().getName() : orderGoods.getGoods().getGoods().getName())
								+ (StringUtils.isNotBlank(orderGoods.getGoods().getOther_attr_value())
										? orderGoods.getGoods().getOther_attr_value() : ""));
						goodsMsgMap.put("number", orderGoods.getCount());
						goodsMsgMap.put("price", orderGoods.getPrice());
						goodsMsgMap.put("type", orderGoods.getType());
						goodsMsgMap.put("goodsCode",
								StringUtils.isNotBlank(orderGoods.getGoods().getGoodsCode())
										? orderGoods.getGoods().getGoodsCode()
										: orderGoods.getGoods().getGoods().getGoodsCode());
						goodsMsgListMap.add(goodsMsgMap);
					} else {
						for (OrderGoodsQrcode orderGoodsQrcode : orderGoods.getoGQList()) {
							Map<String, String> goodsMsgMap = new HashMap<>();
							goodsMsgMap.put("qrcodeCode", orderGoodsQrcode.getQrcode().getId());
							goodsMsgMap.put("goodsName",
									(StringUtils.isNotBlank(orderGoods.getGoods().getName())
											? orderGoods.getGoods().getName()
											: orderGoods.getGoods().getGoods().getName())
											+ (StringUtils.isNotBlank(orderGoods.getGoods().getOther_attr_value())
													? orderGoods.getGoods().getOther_attr_value() : ""));
							goodsMsgMap.put("number", "1");
							goodsMsgMap.put("price", orderGoods.getPrice());
							goodsMsgMap.put("type", orderGoods.getType());
							goodsMsgMap.put("goodsCode",
									StringUtils.isNotBlank(orderGoods.getGoods().getGoodsCode())
											? orderGoods.getGoods().getGoodsCode()
											: orderGoods.getGoods().getGoods().getGoodsCode());
							goodsMsgListMap.add(goodsMsgMap);
						}
					}
				}
				orderMap.put("goodsList", goodsMsgListMap);
				if (ajaxJson_return.isSuccess()) {
					Map<String, Object> map = (Map<String, Object>) ajaxJson_return.getObj();
					orderMap.putAll(map);
				}
				ajaxJson.setSuccess(true);
				ajaxJson.setObj(orderMap);
			}
		} else {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("获取订单失败（可能原因：该订单已结算或已作废）");
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 退款
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 30, 2017
	 * @param order
	 *            务必传入退货单
	 * @return AjaxJson
	 */
	public AjaxJson returnMoneyAll(Order order) {
		AjaxJson ajaxJson = new AjaxJson();
		Map<String, Object> map = new HashMap<>();
		if (null == order || StringUtils.isBlank(order.getId())) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("退款失败，请重试！");
			logger_orderService.warn("订单退款业务传入空订单信息，无法执行退款操作~");
			return ajaxJson;
		}
		if (!Order.TYPE_FIVE.equals(order.getType())) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("退款失败，请重试！");
			logger_orderService.warn("订单退款业务传入订单信息不是退货单，不与执行退款操作~");
			return ajaxJson;
		}
		order.setPayTime(new Date());
		String sumReturnMoney_all = DoubleUtil.sub("0.0", order.getOneReturnMoney()).toString(), // 总应退款金额
				returnMoney = StringUtils.isBlank(order.getReturnMoney()) ? "0.0" : order.getReturnMoney(), // 现金应退款总和
				returnCard = StringUtils.isBlank(order.getReturnCard()) ? "0.0" : order.getReturnCard(), // 银行卡应退款总和
				returnWeChatPay = StringUtils.isBlank(order.getReturnWeChatPay()) ? "0.0" : order.getReturnWeChatPay(), // 微信应退款总和
				returnAliPay = StringUtils.isBlank(order.getReturnAliPay()) ? "0.0" : order.getReturnAliPay(), // 支付宝应退款总和
				returnTianhe = StringUtils.isBlank(order.getReturnTianhe()) ? "0.0" : order.getReturnTianhe();// 银行卡应退款总和
		if (Order.STATE_SIX.equals(order.getState())) {
			map.put("returnMoney", returnMoney);
			map.put("returnCard", returnCard);
			map.put("returnWeChatPay", returnWeChatPay);
			map.put("returnAliPay", returnAliPay);
			map.put("returnTianhe", returnTianhe);
			map.put("isNeedAddEticket", false);
			map.put("id", order.getId());
			ajaxJson.setSuccess(true);
			ajaxJson.setMsg("退款成功，无需重复退款");
			ajaxJson.setObj(map);
			return ajaxJson;
		}

		// 开启独立事物，每一步退款操作，都单独回滚或提交事物
		DataSourceTransactionManager transactionManager = SpringContextHolder
				.getBean(org.springframework.jdbc.datasource.DataSourceTransactionManager.class);
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		// 事物隔离级别，开启新事务，这样会比较安全些。
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
		// 获得事务状态
		TransactionStatus status = transactionManager.getTransaction(def);

		String return_money_this = null;

		Order order_parent = order.getOrder();
		List<Order> childOrderList = order_parent.getOrderList();
		boolean isSuccess_returnMoney = false,
				isTianheStore = !Store.TYPE_TWO.equals(order_parent.getStore().getType());

		// 总应退款的金额为0时，不需调起接口，直接退款完成即可
		if (0 <= DoubleUtil.compareTo("0.0", sumReturnMoney_all)) {
			try {
				status = transactionManager.getTransaction(def);// 开启事物
				// 总应退金额为0元，直接更新退款的状态为退款成功，并返回数据
				order.setState(Order.STATE_SIX);
				if (0 < orderDAO.update(order)) {
					if (isTianheStore) {
						// 二维码退回，加库存
						for (OrderGoods orderGoods : order.getOrderGoodList()) {
							if (OrderGoods.TYPE_RETURN_TIANHE.equals(orderGoods.getType())) {
								for (OrderGoodsQrcode orderGoodsQrcode : orderGoods.getoGQList()) {
									Qrcode qrcode = orderGoodsQrcode.getQrcode();
									if (0 >= inventoryService.getAddInventoryNumberByGoodsIdAndStorageId(
											qrcode.getGoods().getId(), qrcode.getStorage().getId(), "1",
											qrcode.getProcurementPrice())) {
										throw new Exception("加库存失败，更新条数为0,产品ID：" + qrcode.getGoods().getId() + "库ID："
												+ qrcode.getStorage().getId());
									}
									qrcode.setLogistics("退回");
									if (0 >= qrcodeDAO.updateStateTwoToOne(qrcode)) {
										throw new Exception("二维码变更状态由卖出到正常失败，更新条数为0，二维码ID：" + qrcode.getId());
									}
								}
							}
						}
					}
				}
				transactionManager.commit(status);
				map.put("returnMoney", returnMoney);
				map.put("returnCard", returnCard);
				map.put("returnWeChatPay", returnWeChatPay);
				map.put("returnAliPay", returnAliPay);
				map.put("returnTianhe", returnTianhe);
				map.put("isNeedAddEticket", false);
				map.put("id", order.getId());
				map.put("payMoney", order.getPayMoney());
				ajaxJson.setSuccess(true);
				ajaxJson.setMsg("退款成功");
				ajaxJson.setObj(map);
				return ajaxJson;
			} catch (Exception e) {
				// 本次退款过程中出错，回滚事物，返回前端退款失败提示信息
				transactionManager.rollback(status);
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("退款失败~请稍后重试~");
				logger_orderService
						.error("退款出错。错误如下：" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
				return ajaxJson;
			}
		}

		// 先过滤主订单首次未退款金额
		if (0 > DoubleUtil.compareTo("0.0", order_parent.getOneReturnMoney())
				&& 0 > DoubleUtil.compareTo("0.0", sumReturnMoney_all)) {
			// 未退金额大于0，可退
			try {
				status = transactionManager.getTransaction(def);// 开启事物
				if (0 >= DoubleUtil.compareTo(sumReturnMoney_all, order_parent.getOneReturnMoney())) {
					// 订单剩余未退金额大于等于应退金额(成功后，会退完所有应退金额)
					return_money_this = sumReturnMoney_all;
					order_parent.setOneReturnMoney(
							DoubleUtil.sub(order_parent.getOneReturnMoney(), return_money_this).toString());
					sumReturnMoney_all = "0.0";
					order.setOneReturnMoney(DoubleUtil.sub("0.0", sumReturnMoney_all).toString());
					order.setState(Order.STATE_SIX);
					isSuccess_returnMoney = true;
				} else {
					// 订单剩余未退金额小于应退金额(退光当前订单剩余未退金额)
					return_money_this = order_parent.getOneReturnMoney();
					order_parent.setOneReturnMoney("0.0");
					sumReturnMoney_all = DoubleUtil.sub(sumReturnMoney_all, return_money_this).toString();
					order.setOneReturnMoney(DoubleUtil.sub("0.0", sumReturnMoney_all).toString());
					order.setState(null);// 不能更新订单状态
					isSuccess_returnMoney = false;// 退款未完成，防止误退出退款流程
				}

				if (0 < orderDAO.update(order_parent)) {
					if (0 < orderDAO.update(order)) {
						if (isSuccess_returnMoney && isTianheStore) {
							// 二维码退回，加库存
							for (OrderGoods orderGoods : order.getOrderGoodList()) {
								if (OrderGoods.TYPE_RETURN_TIANHE.equals(orderGoods.getType())) {
									for (OrderGoodsQrcode orderGoodsQrcode : orderGoods.getoGQList()) {
										Qrcode qrcode = orderGoodsQrcode.getQrcode();
										if (0 >= inventoryService.getAddInventoryNumberByGoodsIdAndStorageId(
												qrcode.getGoods().getId(), qrcode.getStorage().getId(), "1",
												qrcode.getProcurementPrice())) {
											throw new Exception("加库存失败，更新条数为0,产品ID：" + qrcode.getGoods().getId()
													+ "库ID：" + qrcode.getStorage().getId());
										}
										qrcode.setLogistics("退回");
										if (0 >= qrcodeDAO.updateStateTwoToOne(qrcode)) {
											throw new Exception("二维码变更状态由卖出到正常失败，更新条数为0，二维码ID：" + qrcode.getId());
										}
									}
								}
							}
						}
					} else {
						throw new Exception("更新退款单剩余未退金额失败");
					}
				} else {
					throw new Exception("更新主订单剩余未退金额失败");
				}

				if (Order.PAYTYPE_ONE.equals(order_parent.getOnePayType())) {
					returnMoney = DoubleUtil.add(returnMoney, return_money_this).toString();
					order.setReturnMoney(returnMoney);
					if (0 >= orderDAO.update(order)) {
						throw new Exception("更新现金应退总和出错");
					}
				} else if (Order.PAYTYPE_TWO.equals(order_parent.getOnePayType())) {
					returnCard = DoubleUtil.add(returnCard, return_money_this).toString();
					order.setReturnCard(returnCard);
					if (0 >= orderDAO.update(order)) {
						throw new Exception("更新银行卡应退总和出错");
					}
				} else if (Order.PAYTYPE_THREE.equals(order_parent.getOnePayType())) {
					returnWeChatPay = DoubleUtil.add(returnWeChatPay, return_money_this).toString();
					order.setReturnWeChatPay(returnWeChatPay);
					if (0 >= orderDAO.update(order)) {
						throw new Exception("更新微信支付应退总和出错");
					}
					int i = 1;
					String payMoney = Order.TYPE_ONE.equals(order_parent.getType()) ? order_parent.getInLinePayMoney()
							: order_parent.getOnePayMoney();

					BridgeForRefundBusinessTest bridge = new BridgeForRefundBusinessTest(
							WeChatScanPayUtil.mul(payMoney, "100"), WeChatScanPayUtil.mul(return_money_this, "100"),
							order_parent.getOnePayCode(), order_parent.getCashierCode());
					do {
						if (WeChatScanPayUtil.refundBusinessRun(bridge)) {
							break;
						} else {
							i++;
							if (4 > i)
								Thread.sleep(1000);// 退款失败时，等待一秒进入下一次
						}
					} while (i <= 3);
					if (4 <= i) {
						throw new Exception("微信支付退款失败");
					}
				} else if (Order.PAYTYPE_FOUR.equals(order_parent.getOnePayType())) {
					returnAliPay = DoubleUtil.add(returnAliPay, return_money_this).toString();
					order.setReturnAliPay(returnAliPay);
					if (0 >= orderDAO.update(order)) {
						throw new Exception("更新支付宝应退总和出错");
					}
					int i = 1;
					do {
						if (AlipayApiUtil.refund(order_parent.getOnePayCode(), return_money_this)) {
							break;
						} else {
							i++;
							if (4 > i)
								Thread.sleep(1000);// 退款失败时，等待一秒进入下一次
						}
					} while (i <= 3);
					if (4 <= i) {
						throw new Exception("支付宝退款失败");
					}
				} else if (Order.PAYTYPE_FIVE.equals(order_parent.getOnePayType())) {
					returnTianhe = DoubleUtil.add(returnTianhe, return_money_this).toString();
					order.setReturnTianhe(returnTianhe);
					if (0 >= orderDAO.update(order)) {
						throw new Exception("更新天和钱包应退总和出错");
					}
					Customer customer = order_parent.getCustomer();
					if (0 < customerDAO.addTianheMoney(customer.getId(), return_money_this)) {
						if (0 >= consumeDAO
								.save(new Consume(UUID.getUUID(), customer, null, null, Consume.TYPE_RETURN_MONEY,
										return_money_this, "订单退款到账" + return_money_this + "元", new Date()))) {
							throw new Exception("记录客户钱包流水退款记录失败");
						}
					} else {
						throw new Exception("退款到天和钱包失败");
					}
				}

				transactionManager.commit(status);// 本次退款成功，提交本次事物
				if (isSuccess_returnMoney) {// 退款完成 退出退款流程
					map.put("returnMoney", returnMoney);
					map.put("returnCard", returnCard);
					map.put("returnWeChatPay", returnWeChatPay);
					map.put("returnAliPay", returnAliPay);
					map.put("returnTianhe", returnTianhe);
					map.put("isNeedAddEticket", false);
					map.put("id", order.getId());
					map.put("payMoney", order.getPayMoney());
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("退款成功");
					ajaxJson.setObj(map);
					return ajaxJson;
				}
			} catch (Exception e) {
				// 本次退款过程中出错，回滚事物，返回前端退款失败提示信息
				transactionManager.rollback(status);
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("退款失败~请稍后重试~");
				logger_orderService
						.error("退款出错。错误如下：" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
				return ajaxJson;
			}
		}

		if (Order.TYPE_FOUR.equals(order_parent.getType())) {
			// 预约单过滤第二次支付
			if (0 > DoubleUtil.compareTo("0.0", order_parent.getTwoReturnMoney())
					&& 0 > DoubleUtil.compareTo("0.0", sumReturnMoney_all)) {
				try {
					status = transactionManager.getTransaction(def);// 开启事物
					// 未退金额大于0，可退
					if (0 >= DoubleUtil.compareTo(sumReturnMoney_all, order_parent.getTwoReturnMoney())) {
						// 订单剩余未退金额大于等于应退金额(成功后，会退完所有应退金额)
						return_money_this = sumReturnMoney_all;
						order_parent.setTwoReturnMoney(
								DoubleUtil.sub(order_parent.getTwoReturnMoney(), return_money_this).toString());
						sumReturnMoney_all = "0.0";
						order.setOneReturnMoney(DoubleUtil.sub("0.0", sumReturnMoney_all).toString());
						order.setState(Order.STATE_SIX);
						isSuccess_returnMoney = true;
					} else {
						// 订单剩余未退金额小于应退金额(退光当前订单剩余未退金额)
						return_money_this = order_parent.getTwoReturnMoney();
						order_parent.setTwoReturnMoney("0.0");
						sumReturnMoney_all = DoubleUtil.sub(sumReturnMoney_all, return_money_this).toString();
						order.setOneReturnMoney(DoubleUtil.sub("0.0", sumReturnMoney_all).toString());
						order.setState(null);// 不能更新订单状态
						isSuccess_returnMoney = false;// 退款未完成，防止误退出退款流程
					}

					if (0 < orderDAO.update(order_parent)) {
						if (0 < orderDAO.update(order)) {
							if (isSuccess_returnMoney && isTianheStore) {
								// 二维码退回，加库存
								for (OrderGoods orderGoods : order.getOrderGoodList()) {
									if (OrderGoods.TYPE_RETURN_TIANHE.equals(orderGoods.getType())) {
										for (OrderGoodsQrcode orderGoodsQrcode : orderGoods.getoGQList()) {
											Qrcode qrcode = orderGoodsQrcode.getQrcode();
											if (0 >= inventoryService.getAddInventoryNumberByGoodsIdAndStorageId(
													qrcode.getGoods().getId(), qrcode.getStorage().getId(), "1",
													qrcode.getProcurementPrice())) {
												throw new Exception("加库存失败，更新条数为0,产品ID：" + qrcode.getGoods().getId()
														+ "库ID：" + qrcode.getStorage().getId());
											}
											qrcode.setLogistics("退回");
											if (0 >= qrcodeDAO.updateStateTwoToOne(qrcode)) {
												throw new Exception("二维码变更状态由卖出到正常失败，更新条数为0，二维码ID：" + qrcode.getId());
											}
										}
									}
								}
							}
						} else {
							throw new Exception("更新退款单剩余未退金额失败");
						}
					} else {
						throw new Exception("更新主订单剩余未退金额失败");
					}

					if (Order.PAYTYPE_ONE.equals(order_parent.getTwoPayType())) {
						returnMoney = DoubleUtil.add(returnMoney, return_money_this).toString();
						order.setReturnMoney(returnMoney);
						if (0 >= orderDAO.update(order)) {
							throw new Exception("更新现金应退总和出错");
						}
					} else if (Order.PAYTYPE_TWO.equals(order_parent.getTwoPayType())) {
						returnCard = DoubleUtil.add(returnCard, return_money_this).toString();
						order.setReturnCard(returnCard);
						if (0 >= orderDAO.update(order)) {
							throw new Exception("更新银行卡应退总和出错");
						}
					} else if (Order.PAYTYPE_THREE.equals(order_parent.getTwoPayType())) {
						returnWeChatPay = DoubleUtil.add(returnWeChatPay, return_money_this).toString();
						order.setReturnWeChatPay(returnWeChatPay);
						if (0 >= orderDAO.update(order)) {
							throw new Exception("更新微信支付应退总和出错");
						}
						int i = 1;
						String payMoney = Order.TYPE_ONE.equals(order_parent.getType())
								? order_parent.getInLinePayMoney() : order_parent.getTwoPayMoney();

						BridgeForRefundBusinessTest bridge = new BridgeForRefundBusinessTest(
								WeChatScanPayUtil.mul(payMoney, "100"), WeChatScanPayUtil.mul(return_money_this, "100"),
								order_parent.getTwoPayCode(), order_parent.getTwoCashierCode());
						do {
							if (WeChatScanPayUtil.refundBusinessRun(bridge)) {
								break;
							} else {
								i++;
								if (4 > i)
									Thread.sleep(1000);// 退款失败时，等待一秒进入下一次
							}
						} while (i <= 3);
						if (4 <= i) {
							throw new Exception("微信支付退款失败");
						}
					} else if (Order.PAYTYPE_FOUR.equals(order_parent.getTwoPayType())) {
						returnAliPay = DoubleUtil.add(returnAliPay, return_money_this).toString();
						order.setReturnAliPay(returnAliPay);
						if (0 >= orderDAO.update(order)) {
							throw new Exception("更新支付宝应退总和出错");
						}
						int i = 1;
						do {
							if (AlipayApiUtil.refund(order_parent.getTwoPayCode(), return_money_this)) {
								break;
							} else {
								i++;
								if (4 > i)
									Thread.sleep(1000);// 退款失败时，等待一秒进入下一次
							}
						} while (i <= 3);
						if (4 <= i) {
							throw new Exception("支付宝退款失败");
						}
					} else if (Order.PAYTYPE_FIVE.equals(order_parent.getTwoPayType())) {
						returnTianhe = DoubleUtil.add(returnTianhe, return_money_this).toString();
						order.setReturnTianhe(returnTianhe);
						if (0 >= orderDAO.update(order)) {
							throw new Exception("更新天和钱包应退总和出错");
						}
						Customer customer = order_parent.getCustomer();
						if (0 < customerDAO.addTianheMoney(customer.getId(), return_money_this)) {

							// new Consume(UUID.getUUID(), customer, null, null,
							// Consume.TYPE_RETURN_MONEY,return_money_this,
							// "订单退款到账" + return_money_this + "元", new Date()))
							if (0 >= consumeDAO
									.save(new Consume(UUID.getUUID(), customer, null, null, Consume.TYPE_RETURN_MONEY,
											return_money_this, "订单退款到账" + return_money_this + "元", new Date()))) {
								throw new Exception("记录客户钱包流水退款记录失败");
							}
						} else {
							throw new Exception("退款到天和钱包失败");
						}
					}

					transactionManager.commit(status);// 本次退款成功，提交本次事物
					if (isSuccess_returnMoney) {
						map.put("returnMoney", returnMoney);
						map.put("returnCard", returnCard);
						map.put("returnWeChatPay", returnWeChatPay);
						map.put("returnAliPay", returnAliPay);
						map.put("returnTianhe", returnTianhe);
						map.put("isNeedAddEticket", false);
						map.put("id", order.getId());
						map.put("payMoney", order.getPayMoney());
						ajaxJson.setSuccess(true);
						ajaxJson.setMsg("退款成功");
						ajaxJson.setObj(map);
						return ajaxJson;
					}
				} catch (Exception e) {
					transactionManager.rollback(status);
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("退款失败~请稍后重试~");
					logger_orderService.error(
							"退款出错。错误如下：" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
					return ajaxJson;
				}
			}
		}

		// 过滤换货单\换购单
		for (Order childOrder : childOrderList) {
			if ((Order.TYPE_SIX.equals(childOrder.getType()) || Order.TYPE_THREE.equals(childOrder.getType())
					|| Order.TYPE_EIGHT.equals(childOrder.getType()))
					&& 0 > DoubleUtil.compareTo("0.0",
							StringUtils.isBlank(childOrder.getOneReturnMoney()) ? "0.0"
									: childOrder.getOneReturnMoney())
					&& 0 > DoubleUtil.compareTo("0.0", sumReturnMoney_all)) {
				// 未退金额大于0，可退(排除首次下单的子订单)
				try {
					// 每次循环开启新事物
					status = transactionManager.getTransaction(def);
					if (0 >= DoubleUtil.compareTo(sumReturnMoney_all, childOrder.getOneReturnMoney())) {
						// 订单剩余未退金额大于等于应退金额(成功后，会退完所有应退金额)
						return_money_this = sumReturnMoney_all;
						childOrder.setOneReturnMoney(
								DoubleUtil.sub(childOrder.getOneReturnMoney(), return_money_this).toString());
						sumReturnMoney_all = "0.0";
						order.setOneReturnMoney(DoubleUtil.sub("0.0", sumReturnMoney_all).toString());
						order.setState(Order.STATE_SIX);
						isSuccess_returnMoney = true;
					} else {
						// 订单剩余未退金额小于应退金额(退光当前订单剩余未退金额)
						return_money_this = childOrder.getOneReturnMoney();
						childOrder.setOneReturnMoney("0.0");
						sumReturnMoney_all = DoubleUtil.sub(sumReturnMoney_all, return_money_this).toString();
						order.setOneReturnMoney(DoubleUtil.sub("0.0", sumReturnMoney_all).toString());
						order.setState(null);// 不能更新订单状态
						isSuccess_returnMoney = false;// 退款未完成，防止误退出退款流程
					}

					if (0 < orderDAO.update(childOrder)) {
						if (0 < orderDAO.update(order)) {
							if (isSuccess_returnMoney && isTianheStore) {
								// 二维码退回，加库存
								for (OrderGoods orderGoods : order.getOrderGoodList()) {
									if (OrderGoods.TYPE_RETURN_TIANHE.equals(orderGoods.getType())) {
										for (OrderGoodsQrcode orderGoodsQrcode : orderGoods.getoGQList()) {
											Qrcode qrcode = orderGoodsQrcode.getQrcode();
											if (0 >= inventoryService.getAddInventoryNumberByGoodsIdAndStorageId(
													qrcode.getGoods().getId(), qrcode.getStorage().getId(), "1",
													qrcode.getProcurementPrice())) {
												throw new Exception("加库存失败，更新条数为0,产品ID：" + qrcode.getGoods().getId()
														+ "库ID：" + qrcode.getStorage().getId());
											}
											qrcode.setLogistics("退回");
											if (0 >= qrcodeDAO.updateStateTwoToOne(qrcode)) {
												throw new Exception("二维码变更状态由卖出到正常失败，更新条数为0，二维码ID：" + qrcode.getId());
											}
										}
									}
								}
							}
						} else {
							throw new Exception("更新退款单剩余未退金额失败");
						}
					} else {
						throw new Exception("更新主订单剩余未退金额失败");
					}

					if (Order.PAYTYPE_ONE.equals(childOrder.getOnePayType())) {
						returnMoney = DoubleUtil.add(returnMoney, return_money_this).toString();
						order.setReturnMoney(returnMoney);
						if (0 >= orderDAO.update(order)) {
							throw new Exception("更新现金应退总和出错");
						}
					} else if (Order.PAYTYPE_TWO.equals(childOrder.getOnePayType())) {
						returnCard = DoubleUtil.add(returnCard, return_money_this).toString();
						order.setReturnCard(returnCard);
						if (0 >= orderDAO.update(order)) {
							throw new Exception("更新银行卡应退总和出错");
						}
					} else if (Order.PAYTYPE_THREE.equals(childOrder.getOnePayType())) {
						returnWeChatPay = DoubleUtil.add(returnWeChatPay, return_money_this).toString();
						order.setReturnWeChatPay(returnWeChatPay);
						if (0 >= orderDAO.update(order)) {
							throw new Exception("更新微信支付应退总和出错");
						}
						int i = 1;
						String payMoney = Order.TYPE_ONE.equals(childOrder.getType()) ? childOrder.getInLinePayMoney()
								: childOrder.getOnePayMoney();
						BridgeForRefundBusinessTest bridge = new BridgeForRefundBusinessTest(
								WeChatScanPayUtil.mul(payMoney, "100"), WeChatScanPayUtil.mul(return_money_this, "100"),
								childOrder.getOnePayCode(), childOrder.getCashierCode());
						do {
							if (WeChatScanPayUtil.refundBusinessRun(bridge)) {
								break;
							} else {
								i++;
								if (4 > i)
									Thread.sleep(1000);// 退款失败时，等待一秒进入下一次
							}
						} while (i <= 3);
						if (4 <= i) {
							throw new Exception("微信支付退款失败");
						}
					} else if (Order.PAYTYPE_FOUR.equals(childOrder.getOnePayType())) {
						returnAliPay = DoubleUtil.add(returnAliPay, return_money_this).toString();
						order.setReturnAliPay(returnAliPay);
						if (0 >= orderDAO.update(order)) {
							throw new Exception("更新支付宝应退总和出错");
						}
						int i = 1;
						do {
							if (AlipayApiUtil.refund(childOrder.getOnePayCode(), return_money_this)) {
								break;
							} else {
								i++;
								if (4 > i)
									Thread.sleep(1000);// 退款失败时，等待一秒进入下一次
							}
						} while (i <= 3);
						if (4 <= i) {
							throw new Exception("支付宝退款失败");
						}
					} else if (Order.PAYTYPE_FIVE.equals(childOrder.getOnePayType())) {
						returnTianhe = DoubleUtil.add(returnTianhe, return_money_this).toString();
						order.setReturnTianhe(returnTianhe);
						if (0 >= orderDAO.update(order)) {
							throw new Exception("更新天和钱包应退总和出错");
						}
						Customer customer = childOrder.getCustomer();
						if (0 < customerDAO.addTianheMoney(customer.getId(), return_money_this)) {
							if (0 >= consumeDAO
									.save(new Consume(UUID.getUUID(), customer, null, null, Consume.TYPE_RETURN_MONEY,
											return_money_this, "订单退款到账" + return_money_this + "元", new Date()))) {
								throw new Exception("记录客户钱包流水退款记录失败");
							}
						} else {
							throw new Exception("退款到天和钱包失败");
						}
					}

					transactionManager.commit(status);// 本次退款成功，提交本次事物
					if (isSuccess_returnMoney) {
						map.put("returnMoney", returnMoney);
						map.put("returnCard", returnCard);
						map.put("returnWeChatPay", returnWeChatPay);
						map.put("returnAliPay", returnAliPay);
						map.put("returnTianhe", returnTianhe);
						map.put("isNeedAddEticket", false);
						map.put("id", order.getId());
						map.put("payMoney", order.getPayMoney());
						ajaxJson.setSuccess(true);
						ajaxJson.setMsg("退款成功");
						ajaxJson.setObj(map);
						return ajaxJson;
					}
				} catch (Exception e) {
					transactionManager.rollback(status);
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("退款失败~请稍后重试~");
					logger_orderService.error(
							"退款出错。错误如下：" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
					return ajaxJson;
				}
			}
		}
		ajaxJson.setSuccess(false);
		ajaxJson.setMsg("退款失败");
		return ajaxJson;

	}

	/**
	 *
	 * <P>
	 * 依据OrderCode获取订单信息--只获取未支付订单
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 23, 2017
	 * @param orderCode
	 * @return Order
	 */
	public Order getNoPayOrderByOrderCode(String orderCode) {
		return StringUtils.isNotBlank(orderCode) ? orderDAO.getNoPayOrderByOrderCode(orderCode) : null;
	}

	/**
	 *
	 * <P>
	 * 接收客户端订单支付成功通知
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 26, 2017
	 * @param orderId
	 * @param cashierUserId
	 * @param cashierCode
	 * @param payType
	 * @param customerId
	 * @param isOnline
	 *            是否线上订单（true：是）
	 * @param getMoney
	 * @return AjaxJson
	 * @throws Exception
	 */
	public AjaxJson orderPaySuccess(String orderId, String cashierUserId, String cashierCode, String payType,
			String customerId, String customerPayCode, String payCode, boolean isOnline, String getMoney)
					throws Exception {
		AjaxJson ajaxJson = new AjaxJson();
		if (isOnline) {
			if (StringUtils.isBlank(orderId)) {
				throw new Exception("确认支付传入订单号为空，不与确认，请检查微信端代码实现~");
			}
		} else {
			if (StringUtils.isBlank(orderId) || StringUtils.isBlank(cashierUserId)
					|| StringUtils.isBlank(cashierCode)) {
				throw new Exception("确认支付传入订单号，导购编号或柜台号为空，不与确认，请检查客户端代码实现~");
			}
		}

		Order order = this.getOrderById(orderId);
		if (StringUtils.isBlank(order.getPayType())) {
			if (StringUtils.isBlank(payType)) {
				throw new Exception("待确认订单为收银指定支付方式订单，但客户端未回传支付方式，不与确认，请检查客户端代码实现");
			} else {
				if (Order.PAYTYPE_FIVE.equals(payType)) {
					if (StringUtils.isBlank(customerId) || StringUtils.isBlank(customerPayCode)) {
						throw new Exception("待确认订单为收银指定支付方式，接收到使用天和钱包支付，但未回传消费者ID或天和支付动态密码，不与确认，请检查客户端代码实现~");
					}
				}
			}
		}

		String payType_value = StringUtils.isNotBlank(order.getPayType()) ? order.getPayType() : payType;
		if (Order.PAYTYPE_FIVE.equals(payType_value)) {
			Customer customer = (null != order.getCustomer() && StringUtils.isNotBlank(order.getCustomer().getId()))
					? order.getCustomer() : customerDAO.get(customerId);
			if (null == customer.getEmployee() || StringUtils.isBlank(customer.getEmployee().getId())) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("客户未登陆，请先引导客户在微信公众号中登陆本账号后再次支付~");
				return ajaxJson;
			}
			if (!customerPayCode.equals(customer.getPayCode())) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("支付动态密码错误，请重试！");
				return ajaxJson;
			}
			DateTime before = new DateTime(customer.getPayCodeCreateTime().getTime());
			DateTime now = new DateTime(new Date().getTime());
			int minute = Minutes.minutesBetween(before, now).getMinutes();
			if (minute <= 10) {
				String payMoneyThis = StringUtils.isBlank(order.getCashierCode()) ? order.getOnePayMoney()
						: order.getTwoPayMoney();
				if (0F <= DoubleUtil.sub(customer.getMoney(), payMoneyThis)) {
					if (0 >= customerDAO.subTianheMoney(customer.getId(), payMoneyThis)) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("客户余额不足，请引导客户充值后支付或选择其他支付方式!");
						return ajaxJson;
					} else {
						if (0 >= customerDAO.clearPayCode(customer.getId())) {
							throw new Error("支付成功后，清空支付动态密码失败，回滚数据");
						}
						if (0 >= consumeDAO.save(new Consume(UUID.getUUID(), customer, null, null,
								Consume.TYPE_THREE_DOWN, payMoneyThis, "线下消费" + payMoneyThis + "元", new Date()))) {
							throw new Error("支付成功后，记录客户钱包流水失败，回滚数据");
						}
					}
				} else {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("客户余额不足，请引导客户充值后支付或选择其他支付方式~");
					return ajaxJson;
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("支付动态密码过期失效，请重新获取！");
				return ajaxJson;
			}
		}

		Order order_to_update = new Order(orderId);
		order_to_update.setType(order.getType());
		order_to_update.setCustomer(new Customer(customerId));
		if (Order.TYPE_FOUR.equals(order.getType())) {
			if (StringUtils.isBlank(order.getCashierCode())) {
				order_to_update.setOnePayCode(payCode);
				order_to_update.setOnePayType(StringUtils.isBlank(order.getPayType()) ? payType : order.getPayType());
				order_to_update.setCashierCode(cashierCode);
				order_to_update.setCashierUser(new User(cashierUserId));
				order_to_update.setOneGetMoney(getMoney);
			} else {
				order_to_update.setTwoCashierCode(cashierCode);
				order_to_update.setTwoCashierUser(new User(cashierUserId));
				order_to_update.setTwoPayCode(payCode);
				order_to_update.setTwoPayType(StringUtils.isBlank(order.getPayType()) ? payType : order.getPayType());
				order_to_update.setTwoGetMoney(getMoney);
			}
		} else {
			order_to_update.setCashierCode(cashierCode);
			order_to_update.setCashierUser(new User(cashierUserId));
			order_to_update.setOnePayCode(payCode);
			order_to_update.setPayType(payType);
			order_to_update.setOneGetMoney(getMoney);
		}

		if (0 >= orderDAO.orderPaySuccess(order_to_update)) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("确认支付失败，请重试~");
			throw new Error("订单确认支付失败，影响记录条数为0");
		} else {
			// 二维码已卖出
			order = this.getOrderById(orderId);
			if (Order.STATE_SIX.equals(order.getState())) {
				if (!Store.TYPE_TWO.equals(order.getStore().getType()) && !Order.TYPE_THREE.equals(order.getType())
						&& !Order.TYPE_EIGHT.equals(order.getType())) {
					if (null != order.getOrderList() && !order.getOrderList().isEmpty()) {
						for (Order order_ : order.getOrderList()) {
							for (OrderGoods orderGoods : order_.getOrderGoodList()) {
								if (OrderGoods.TYPE_OUT.equals(orderGoods.getType())) {
									for (OrderGoodsQrcode orderGoodsQrcode : orderGoods.getoGQList()) {
										Qrcode qrcode = orderGoodsQrcode.getQrcode();
										if (0 >= inventoryService.getSubInventoryNumberByGoodsIdAndStorageId(
												qrcode.getGoods().getId(), qrcode.getStorage().getId(), "1",
												qrcode.getProcurementPrice())) {
											throw new Error("减库存失败，更新条数为0,产品ID：" + qrcode.getGoods().getId() + "库ID："
													+ qrcode.getStorage().getId());
										}
										qrcode.setLogistics("卖出");
										if (0 >= qrcodeDAO.updateStateFourToTwo(qrcode)) {
											throw new Error("二维码变更状态为卖出失败，更新条数为0，二维码ID：" + qrcode.getId());
										}
									}
								} else if (OrderGoods.TYPE_RETURN_TIANHE.equals(orderGoods.getType())) {
									for (OrderGoodsQrcode orderGoodsQrcode : orderGoods.getoGQList()) {
										Qrcode qrcode = orderGoodsQrcode.getQrcode();
										if (0 >= inventoryService.getAddInventoryNumberByGoodsIdAndStorageId(
												qrcode.getGoods().getId(), qrcode.getStorage().getId(), "1",
												qrcode.getProcurementPrice())) {
											throw new Error("加库存失败，更新条数为0,产品ID：" + qrcode.getGoods().getId() + "库ID："
													+ qrcode.getStorage().getId());
										}
										qrcode.setLogistics("退回");
										if (0 >= qrcodeDAO.updateStateTwoToOne(qrcode)) {
											throw new Error("二维码变更状态由卖出到正常失败，更新条数为0，二维码ID：" + qrcode.getId());
										}
									}
								}
							}
						}
					} else {
						for (OrderGoods orderGoods : order.getOrderGoodList()) {
							if (OrderGoods.TYPE_OUT.equals(orderGoods.getType())) {
								for (OrderGoodsQrcode orderGoodsQrcode : orderGoods.getoGQList()) {
									Qrcode qrcode = orderGoodsQrcode.getQrcode();
									if (0 >= inventoryService.getSubInventoryNumberByGoodsIdAndStorageId(
											qrcode.getGoods().getId(), qrcode.getStorage().getId(), "1",
											qrcode.getProcurementPrice())) {
										throw new Error("减库存失败，更新条数为0,产品ID：" + qrcode.getGoods().getId() + "库ID："
												+ qrcode.getStorage().getId());
									}
									qrcode.setLogistics("卖出");
									if (0 >= qrcodeDAO.updateStateFourToTwo(qrcode)) {
										throw new Error("二维码变更状态为卖出失败，更新条数为0，二维码ID：" + qrcode.getId());
									}
								}
							} else if (OrderGoods.TYPE_RETURN_TIANHE.equals(orderGoods.getType())) {
								for (OrderGoodsQrcode orderGoodsQrcode : orderGoods.getoGQList()) {
									Qrcode qrcode = orderGoodsQrcode.getQrcode();
									if (0 >= inventoryService.getAddInventoryNumberByGoodsIdAndStorageId(
											qrcode.getGoods().getId(), qrcode.getStorage().getId(), "1",
											qrcode.getProcurementPrice())) {
										throw new Error("加库存失败，更新条数为0,产品ID：" + qrcode.getGoods().getId() + "库ID："
												+ qrcode.getStorage().getId());
									}
									qrcode.setLogistics("退回");
									if (0 >= qrcodeDAO.updateStateTwoToOne(qrcode)) {
										throw new Error("二维码变更状态由卖出到正常失败，更新条数为0，二维码ID：" + qrcode.getId());
									}
								}
							}
						}
					}
				}
				this.sendPromotionAndEticket(order);
			}
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 订单支付成功后，发放电子券和满返活动
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 26, 2017
	 * @param order
	 *            务必传入主订单（线上和线下订单才会发） void
	 */
	private void sendPromotionAndEticket(Order order) {
		if (null != order && StringUtils.isNotBlank(order.getId()) && null != order.getOrderList()
				&& !order.getOrderList().isEmpty()) {
			for (Order order_ : order.getOrderList()) {
				if ("otherOrder".equals(order_.getProType())) {
					// 调起发放电子券
					if (null != order.getCustomer() && StringUtils.isNotBlank(order.getCustomer().getId())
							&& 0 >= DoubleUtil.compareTo(order_.getSubMoney(), "0")) {
						eticketOutRecordService.sendEticketBuy(order_.getPayMoney(), order.getStore().getId(),
								order.getCustomer().getId());
					}
				} else if (!"nullOrder".equals(order_.getProType()) && null != order_.getOrderSubremarkList()
						&& !order_.getOrderSubremarkList().isEmpty()) {
					// 调起发放满返
					for (OrderSubremark orderSubremark : order_.getOrderSubremarkList()) {
						if (OrderSubremark.ISSENDLADDER_NO.equals(orderSubremark.getIsSendLadder())) {
							PromotionLadder promotionLadder = orderSubremark.getPromotionLadder();
							Promotion promotion = promotionLadder.getPromotion();
							if (Promotion.TYPE_3.equals(promotion.getType())) {
								Customer customer = order.getCustomer();
								if (0 < customerDAO.addTianheMoney(customer.getId(),
										promotionLadder.getPromotionMoney())) {
									consumeDAO.save(new Consume(UUID.getUUID(), customer, null, null,
											Consume.TYPE_TWO_OUT, promotionLadder.getPromotionMoney(),
											"消费返现" + promotionLadder.getPromotionMoney() + "元", new Date()));
									orderSubremark.setIsSendLadder(OrderSubremark.ISSENDLADDER_YES);
									orderSubremarkDAO.update(orderSubremark);
									final Customer customer2 = order.getCustomer();
									final PromotionLadder promotionLadder1 = promotionLadder;
									ThreadPoolUtil.getPool().execute(new Runnable() {
										@Override
										public void run() {
											try {
												WeChatUtil.sendCustomerBackCash(customer2,
														promotionLadder1.getPromotionMoney(), new Date(),
														weChatService.getWeChatList().get(0));
											} catch (Exception e) {
												logger_orderService.error("消费返现成功通知模板消息出错，具体错误如下：" + ExceptionUtil
														.getExceptionAllinformation(e, this.getClass().getName()));
											}
										}
									});
								}
							}
						}
					}
				}
			}
		}
	}

	/**
	 *
	 * <P>
	 * 保存预约订单
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 31, 2017
	 * @param order
	 * @return AjaxJson
	 */
	public AjaxJson saveReserveOrderInpute(Order order) {
		AjaxJson ajaxJson = new AjaxJson();
		order.setCode(OrderCodeID.nextCode());
		order.setId(UUID.getUUID());
		order.setCode(OrderCodeID.nextCode());
		order.setState(Order.STATE_ONE);
		order.setType(Order.TYPE_FOUR);
		order.setCreateTime(new Date());
		order.setReserveTime(new Date());

		String order_sumMoney = "0.0";
		int order_sumNumber = 0;
		List<Order> order_child_list = new ArrayList<>();
		List<OrderGoods> orderGoodsList = order.getOrderGoodList();
		order.setOrderGoodList(null);

		if (StringUtils.isNotBlank(order.getSubUserType()) || null == order.getCustomer()
				|| StringUtils.isBlank(order.getCustomer().getId())) {
			Order nullOrder = new Order(UUID.getUUID());
			nullOrder.setOrder(order);
			nullOrder.setProType("nullOrder");
			nullOrder.setCode(OrderCodeID.nextCode());
			nullOrder.setState(order.getState());
			nullOrder.setGuideUser(order.getGuideUser());
			nullOrder.setCreateTime(new Date());
			nullOrder.setCustomer(null);
			nullOrder.setStore(order.getStore());
			nullOrder.setType(order.getType());
			order.setCustomer(null);

			for (OrderGoods orderGoods : orderGoodsList) {
				order_sumNumber += Integer.parseInt(orderGoods.getCount());
				order_sumMoney = DoubleUtil
						.add(order_sumMoney, DoubleUtil.mul(orderGoods.getCount(), orderGoods.getPrice()).toString())
						.toString();
				orderGoods.setOrder(nullOrder);
				orderGoods.setType(OrderGoods.TYPE_OUT);
				orderGoods.setSubMoney("0.0");
				orderGoods.setCreateTime(new Date());
			}
			String zhekou = DoubleUtil
					.div(StringUtils.isNotBlank(order.getSubMoney()) ? order.getSubMoney() : "0.0", order_sumMoney)
					.toString();
			for (OrderGoods orderGoods : orderGoodsList) {
				orderGoods.setSubMoney(
						DoubleUtil.mul(zhekou, DoubleUtil.mul(orderGoods.getCount(), orderGoods.getPrice()).toString())
								.toString());
			}
			nullOrder.setOrderGoodList(orderGoodsList);
			order.setSumMoney(order_sumMoney);
			order.setSumNumber(order_sumNumber + "");
			order.setPayMoney(DoubleUtil.sub(order.getSumMoney(), order.getSubMoney()).toString());
			nullOrder.setSumMoney(order_sumMoney);
			nullOrder.setSumNumber(order_sumNumber + "");
			nullOrder.setPayMoney(DoubleUtil.sub(nullOrder.getSumMoney(), nullOrder.getSubMoney()).toString());
			order_child_list.add(nullOrder);
			order.setOrderList(order_child_list);
		} else {
			Order otherOrder = new Order(UUID.getUUID());
			otherOrder.setOrder(order);
			otherOrder.setProType("otherOrder");
			otherOrder.setState(order.getState());
			otherOrder.setGuideUser(order.getGuideUser());
			otherOrder.setCode(OrderCodeID.nextCode());
			otherOrder.setType(order.getType());
			otherOrder.setStore(order.getStore());
			otherOrder.setCustomer(order.getCustomer());
			otherOrder.setCreateTime(new Date());
			Map<String, Order> map_order = null;
			int otherNumber = 0;
			String otherMoney = "0.0";
			List<OrderGoods> orderGoods_no_pro = new ArrayList<>();

			Iterator<OrderGoods> it = orderGoodsList.iterator();
			while (it.hasNext()) {
				OrderGoods orderGoods = it.next();
				if (StringUtils.isBlank(orderGoods.getCount())) {
					it.remove();
				} else {
					orderGoods.setType(OrderGoods.TYPE_OUT);
					orderGoods.setSubMoney("0.0");
					orderGoods.setCreateTime(new Date());
					order_sumNumber += Integer.parseInt(orderGoods.getCount());
					order_sumMoney = DoubleUtil.add(order_sumMoney,
							DoubleUtil.mul(orderGoods.getCount(), orderGoods.getPrice()).toString()).toString();
					if (!OrderGoods.ISJOIN_YES.equals(orderGoods.getIsJoin())) {
						orderGoods.setOrder(otherOrder);
						otherNumber += Integer.parseInt(orderGoods.getCount());
						otherMoney = DoubleUtil
								.add(otherMoney,
										DoubleUtil.mul(orderGoods.getCount(), orderGoods.getPrice()).toString())
								.toString();
						orderGoods_no_pro.add(orderGoods);
						// 去掉不参与活动的ordereGoods
						it.remove();
					}
				}
			}

			// list排序，依据自定义的排序条件（商品单价）降序排序
			Collections.sort(orderGoodsList);

			// 调起切割分订单
			if (!orderGoodsList.isEmpty())
				map_order = this.splitOrderGoods(orderGoodsList, order, Order.TYPE_TWO);

			order.setSumMoney(order_sumMoney);
			order.setSumNumber(order_sumNumber + "");
			otherOrder.setOrderGoodList(orderGoods_no_pro);
			otherOrder.setSumNumber(otherNumber + "");
			otherOrder.setSumMoney(otherMoney);
			otherOrder.setSubMoney("0.0");
			otherOrder.setPayMoney(otherMoney);
			String order_sum_payMoney = "0.0";
			String order_sum_subMoney = "0.0";
			if (null != map_order) {
				if (!map_order.isEmpty()) {
					for (Map.Entry<String, Order> entry : map_order.entrySet()) {
						if ("otherOrder".equals(entry.getKey())) {
							List<OrderGoods> ogList_no_setOrder = entry.getValue().getOrderGoodList();
							for (OrderGoods orderGoods : ogList_no_setOrder) {
								orderGoods.setOrder(otherOrder);
							}
							orderGoods_no_pro.addAll(ogList_no_setOrder);
							otherOrder.setOrderGoodList(orderGoods_no_pro);
							otherOrder
									.setSumMoney(DoubleUtil.add(otherMoney, entry.getValue().getSumMoney()).toString());
							otherOrder.setSumNumber(
									(Integer.parseInt(entry.getValue().getSumNumber()) + otherNumber) + "");
							otherOrder.setSubMoney(DoubleUtil
									.add(otherOrder.getSubMoney(), entry.getValue().getSubMoney()).toString());
							otherOrder.setPayMoney(DoubleUtil
									.add(otherOrder.getPayMoney(), entry.getValue().getPayMoney()).toString());
						} else {
							order_sum_payMoney = DoubleUtil.add(order_sum_payMoney, entry.getValue().getPayMoney())
									.toString();
							order_sum_subMoney = DoubleUtil.add(order_sum_subMoney, entry.getValue().getSubMoney())
									.toString();
							order_child_list.add(entry.getValue());
						}
					}
				}
			}
			if (!orderGoods_no_pro.isEmpty()) {
				order_sum_payMoney = DoubleUtil.add(order_sum_payMoney, otherOrder.getPayMoney()).toString();
				order_sum_subMoney = DoubleUtil.add(order_sum_subMoney, otherOrder.getSubMoney()).toString();
				order_child_list.add(otherOrder);
			}
			order.setPayMoney(order_sum_payMoney);
			order.setSubMoney(order_sum_subMoney);
			order.setOrderList(order_child_list);
		}

		this.saveOrderCodeQrcodeImg(order.getCode());

		if (0 >= this.saveOrderAll(order)) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("保存订单出错，请重试~");
		} else {
			ajaxJson.setSuccess(true);
			ajaxJson.setObj(order.getId());
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 订单添加发货二维码
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 1, 2017
	 * @param orderId
	 *            订单ID
	 * @param QRCodeID
	 *            二维码ID
	 * @return AjaxJson
	 */
	public AjaxJson orderAddQrcode(String orderId, String qRCodeID) {
		AjaxJson ajaxJson = new AjaxJson();
		ajaxJson.setMsg("");// 清空默认提示
		if (StringUtils.isBlank(orderId) || StringUtils.isBlank(qRCodeID)) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲，出错了，请刷新页面重试~");
			logger_orderService.error("订单添加发货二维码,传入订单ID和二维码ID为空，请检查代码实现~");
		} else {
			Qrcode qrcode = qrcodeDAO.get(qRCodeID);
			if (Qrcode.STATE_FOUR.equals(qrcode.getState())) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("亲，本二维码已被锁定了，换一个试试吧~");
			} else if (Qrcode.STATE_THREE.equals(qrcode.getState())) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("亲，本二维码已经退还给厂家了，换一个试试吧~");
			} else if (Qrcode.STATE_TWO.equals(qrcode.getState())) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("亲，本二维码已经卖掉了，换一个试试吧~");
			} else if (Qrcode.STATE_ONE.equals(qrcode.getState())) {
				Order order = orderDAO.get(orderId);
				List<OrderGoods> allOrdergoods = new ArrayList<>();
				if (null != order.getOrder() && StringUtils.isNotBlank(order.getOrder().getId())) {
					// 传入的订单为子订单，获取主订单来过滤发货
					for (Order order_child : order.getOrder().getOrderList()) {
						allOrdergoods.addAll(order_child.getOrderGoodList());
					}
				} else {
					// 传入订单为主订单，直接过滤
					for (Order order_child : order.getOrderList()) {
						allOrdergoods.addAll(order_child.getOrderGoodList());
					}
				}
				boolean isAddSuccess = false;
				boolean isHaveThisGoods = false;
				for (OrderGoods orderGoods : allOrdergoods) {
					if ((!Order.TYPE_THREE.equals(order.getType())
							&& qrcode.getGoods().getId().equals(orderGoods.getGoods().getId()))
							|| (Order.TYPE_THREE.equals(order.getType())
									&& (qrcode.getGoods().getId().equals(orderGoods.getGoods().getId())
											|| (null != qrcode.getGoods().getGoods() && qrcode.getGoods().getGoods()
													.getId().equals(orderGoods.getGoods().getId()))))) {
						// 传入二维码和本orderGoods匹配，检查本orderGoods是否发货完成
						isHaveThisGoods = true;
						List<OrderGoodsQrcode> ogq_list = orderGoods.getoGQList();
						if (null != ogq_list && !ogq_list.isEmpty()) {
							if (Integer.parseInt(orderGoods.getCount()) <= ogq_list.size()) {
								// 发货已满，走入下一次循环
								continue;
							}
						}
						// 可添加发货
						// 验证库存
						Goods goods_return = GoodsController.getGoodsToJsp(goodsService.getGoodsByQRCodeID(qRCodeID));
						if (0 >= Integer.parseInt(goods_return.getGoods_inventory())) {
							ajaxJson.setSuccess(false);
							ajaxJson.setMsg("本产品库存不足，无法发货");
							return ajaxJson;
						}
						// 添加发货
						String isJoin = (0 >= DoubleUtil.compareTo(
								StringUtils.isBlank(orderGoods.getSubMoney()) ? "0.0" : orderGoods.getSubMoney(),
								"0.0")) ? OrderGoodsQrcode.ISJOIN_NO : OrderGoodsQrcode.ISJOIN_YES;
						if (0 >= orderGoodsQrcodeDAO.saveOGQ(
								new OrderGoodsQrcode(UUID.getUUID(), orderGoods, qrcode, isJoin, new Date()))) {
							// 添加发货失败
							ajaxJson.setSuccess(false);
							ajaxJson.setMsg("亲，添加产品二维码失败了，请重试一下吧~");
						} else {
							if (Order.TYPE_THREE.equals(order.getType()) || Order.TYPE_ONE.equals(order.getType())) {
								qrcode.setLogistics("发货");
								if (0 >= qrcodeDAO.updateStateOneToTwo(qrcode)) {
									throw new Error("订单发货，卖出二维码失败，回滚数据");
								} else {
									if (0 >= inventoryService.getSubInventoryNumberByGoodsIdAndStorageId(
											qrcode.getGoods().getId(), qrcode.getStorage().getId(), "1",
											qrcode.getProcurementPrice())) {
										throw new Error("订单发货减少库存失败，回滚数据");
									} else {
										ajaxJson.setObj(goods_return);
										// 添加发货成功
										isAddSuccess = true;
									}
								}
							} else {
								if (0 >= qrcodeDAO.updateStateOneToFour(qrcode)) {
									throw new Error("订单发货锁定二维码失败，回滚数据");
								} else {
									ajaxJson.setObj(goods_return);
									// 添加发货成功
									isAddSuccess = true;
								}
							}
						}
					}
					if (isAddSuccess)
						break;
				}
				if (!isHaveThisGoods) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("亲，该订单不包含扫码商品，请仔细确认！");
				} else if (!isAddSuccess) {
					ajaxJson.setSuccess(false);
					if (StringUtils.isBlank(ajaxJson.getMsg()))
						ajaxJson.setMsg("本产品已满，请换一个试试~");
				} else {
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("添加产品二维码成功！");
				}
			}
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 订单删除发货二维码
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 1, 2017
	 * @param orderId
	 * @param qRCodeID
	 * @return AjaxJson
	 */
	public AjaxJson orderDeleteQrcode(String orderId, String qRCodeID) {
		AjaxJson ajaxJson = new AjaxJson();
		if (StringUtils.isBlank(orderId) || StringUtils.isBlank(qRCodeID)) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲，出错了，请刷新页面重试~");
			logger_orderService.error("订单删除发货二维码,传入订单ID和二维码ID为空，请检查代码实现~");
		} else {
			if (0 >= orderGoodsQrcodeDAO.orderDeleteQrcode(orderId, qRCodeID)) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("删除二维码失败，请刷新页面后重试~");
			} else {
				Order order = orderDAO.get(orderId);
				if (Order.TYPE_THREE.equals(order.getType()) || Order.TYPE_ONE.equals(order.getType())) {
					Qrcode qrcode = qrcodeDAO.get(qRCodeID);
					qrcode.setLogistics("解除发货");
					if (0 >= qrcodeDAO.updateStateTwoToOne(qrcode)) {
						throw new Error("订单删除发货二维码，刚刚二维码为正常失败");
					} else {
						if (0 >= inventoryService.getAddInventoryNumberByGoodsIdAndStorageId(qrcode.getGoods().getId(),
								qrcode.getStorage().getId(), "1", qrcode.getProcurementPrice())) {
							throw new Error("订单解除发货回滚库存失败");
						}
					}
				} else {
					if (0 >= qrcodeDAO.updateStateFourToOne(new Qrcode(qRCodeID))) {
						throw new Error("订单删除发货二维码,解绑二维码失败，回滚数据~");
					}
				}
			}
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 依据订单Code获取订单信息--完成
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 3, 2017
	 * @param orderCode
	 * @return Object
	 */
	public Order getFinishOrderByOrderCode(String orderCode) {
		return StringUtils.isBlank(orderCode) ? null : orderDAO.getFinishOrderByOrderCode(orderCode);
	}

	/**
	 *
	 * <P>
	 * 发放赠品
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 3, 2017
	 * @param orderId
	 * @param qRCodeID
	 * @return AjaxJson
	 */
	public AjaxJson orderAddPutOutGoods(String orderId, String qRCodeID) {
		AjaxJson ajaxJson = new AjaxJson();
		if (StringUtils.isBlank(orderId) || StringUtils.isBlank(qRCodeID)) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("发放赠品失败，请刷新页面重试~");
		} else {
			Qrcode qrcode = qrcodeDAO.get(qRCodeID);
			if (Qrcode.STATE_FOUR.equals(qrcode.getState())) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("亲，本二维码已被锁定了，换一个试试吧~");
			} else if (Qrcode.STATE_THREE.equals(qrcode.getState())) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("亲，本二维码已经退还给厂家了，换一个试试吧~");
			} else if (Qrcode.STATE_TWO.equals(qrcode.getState())) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("亲，本二维码已经卖掉了，换一个试试吧~");
			} else if (Qrcode.STATE_ONE.equals(qrcode.getState())) {
				// 发放赠品
				Goods goods_return = GoodsController.getGoodsToJsp(goodsService.getGoodsByQRCodeID(qRCodeID));
				if (0 >= Integer.parseInt(goods_return.getGoods_inventory())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("本产品库存不足，无法发货");
					return ajaxJson;
				}
				Order order = orderDAO.get(orderId);
				List<OrderSubremark> subremarks = new ArrayList<>();
				if (null != order.getOrder() && StringUtils.isNotBlank(order.getOrder().getId())) {
					// 传入的订单为子订单，获取主订单来过滤发货
					if (null != order.getOrder().getOrderSubremarkList()
							&& !order.getOrder().getOrderSubremarkList().isEmpty())
						subremarks.addAll(order.getOrder().getOrderSubremarkList());
					for (Order order_child : order.getOrder().getOrderList()) {
						if (null != order_child.getOrderSubremarkList()
								&& !order_child.getOrderSubremarkList().isEmpty())
							subremarks.addAll(order_child.getOrderSubremarkList());
						if (null != order_child.getOrderGoodList() && !order_child.getOrderGoodList().isEmpty())
							for (OrderGoods orderGoods : order_child.getOrderGoodList()) {
								if (null != orderGoods.getOrderSubremark()
										&& StringUtils.isNotBlank(orderGoods.getOrderSubremark().getId()))
									subremarks.add(orderGoods.getOrderSubremark());
							}
					}
				} else {
					// 传入订单为主订单，直接过滤
					if (null != order.getOrderSubremarkList() && !order.getOrderSubremarkList().isEmpty())
						subremarks.addAll(order.getOrderSubremarkList());
					for (Order order_child : order.getOrderList()) {
						if (null != order_child.getOrderSubremarkList()
								&& !order_child.getOrderSubremarkList().isEmpty())
							subremarks.addAll(order_child.getOrderSubremarkList());
						if (null != order_child.getOrderGoodList() && !order_child.getOrderGoodList().isEmpty())
							for (OrderGoods orderGoods : order_child.getOrderGoodList()) {
								if (null != orderGoods.getOrderSubremark()
										&& StringUtils.isNotBlank(orderGoods.getOrderSubremark().getId()))
									subremarks.add(orderGoods.getOrderSubremark());
							}
					}
				}
				if (null == subremarks || subremarks.isEmpty()) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("本订单无优惠记录，无需发放赠品");
				} else {
					String parent_goods_id = (null != qrcode.getGoods().getGoods()
							&& StringUtils.isNotBlank(qrcode.getGoods().getGoods().getId()))
									? qrcode.getGoods().getGoods().getId() : qrcode.getGoods().getId();
					boolean isHaveThisGoods = false;
					boolean isSendSuccess = false;
					for (OrderSubremark orderSubremark : subremarks) {
						if (StringUtils.isBlank(orderSubremark.getPutOutGoodsQrcodeString())
								|| 0 > orderSubremark.getPutOutGoodsQrcodeString().indexOf(qRCodeID)) {
							PromotionLadder ladder = orderSubremark.getPromotionLadder();
							if (null != ladder && StringUtils.isNotBlank(ladder.getId())) {
								if (null != ladder.getGoods() && StringUtils.isNotBlank(ladder.getGoods().getId())) {
									if (Promotion.TYPE_7.equals(ladder.getPromotion().getType())
											|| Promotion.TYPE_8.equals(ladder.getPromotion().getType())) {
										if (ladder.getGoods().getId().equals(parent_goods_id)) {
											isHaveThisGoods = true;
											if (StringUtils.isBlank(orderSubremark.getPutOutGoodsQrcodeString())
													|| orderSubremark.getPutOutGoodsQrcodeString().split(
															"_").length < Integer.parseInt(ladder.getGoodsNumber())) {
												orderSubremark.setPutOutGoodsQrcodeString(qRCodeID);
												if (0 >= orderSubremarkDAO.update(orderSubremark)) {
													throw new Error("绑定赠品领取记录失败");
												} else {
													qrcode.setLogistics("领取");
													if (0 >= qrcodeDAO.updateStateOneToTwo(qrcode)) {
														throw new Error("锁定赠品二维码失败，二维码ID为：" + qRCodeID);
													} else {
														if (0 >= inventoryService
																.getSubInventoryNumberByGoodsIdAndStorageId(
																		qrcode.getGoods().getId(),
																		qrcode.getStorage().getId(), "1",
																		qrcode.getProcurementPrice())) {
															throw new Error("减少赠品库存失败");
														} else {
															ajaxJson.setObj(goods_return);
															isSendSuccess = true;
															break;
														}
													}
												}
											}
										}
									}
								}
							}
						} else {
							ajaxJson.setSuccess(false);
							ajaxJson.setMsg("本产品已经添加过了，换一个试试吧~");
							break;
						}
					}
					if (!isHaveThisGoods) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("扫描产品非可领取赠品！不可发放！");
					} else if (!isSendSuccess) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("该赠品发放已满，换一个试试吧");
					}
				}
			}
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 删除发放赠品
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 3, 2017
	 * @param orderId
	 * @param qRCodeID
	 * @return AjaxJson
	 */
	public AjaxJson orderDeletePutOutGoods(String orderId, String qRCodeID) {
		AjaxJson ajaxJson = new AjaxJson();
		if (StringUtils.isBlank(orderId) || StringUtils.isBlank(qRCodeID)) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("删除赠品失败，请刷新页面重试~");
		} else {
			Order order = orderDAO.get(orderId);
			List<OrderSubremark> subremarks = new ArrayList<>();
			if (null != order.getOrder() && StringUtils.isNotBlank(order.getOrder().getId())) {
				// 传入的订单为子订单，获取主订单来过滤发货
				subremarks.addAll(order.getOrder().getOrderSubremarkList());
				for (Order order_child : order.getOrder().getOrderList()) {
					subremarks.addAll(order_child.getOrderSubremarkList());
					if (null != order_child.getOrderGoodList() && !order_child.getOrderGoodList().isEmpty())
						for (OrderGoods orderGoods : order_child.getOrderGoodList()) {
							subremarks.add(orderGoods.getOrderSubremark());
						}
				}
			} else {
				// 传入订单为主订单，直接过滤
				subremarks.addAll(order.getOrderSubremarkList());
				for (Order order_child : order.getOrderList()) {
					subremarks.addAll(order_child.getOrderSubremarkList());
					if (null != order_child.getOrderGoodList() && !order_child.getOrderGoodList().isEmpty())
						for (OrderGoods orderGoods : order_child.getOrderGoodList()) {
							subremarks.add(orderGoods.getOrderSubremark());
						}
				}
			}
			if (null == subremarks || subremarks.isEmpty()) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("本订单无优惠记录，删除赠品失败");
			} else {
				boolean isDeleteFinal = true;
				for (OrderSubremark orderSubremark : subremarks) {
					if (0 <= orderSubremark.getPutOutGoodsQrcodeString().indexOf(qRCodeID)) {
						if (0 >= orderSubremarkDAO.deletePutOutQrcode(orderSubremark.getId(), qRCodeID)) {
							throw new Error("删除赠品失败");
						} else {
							Qrcode qrcode = qrcodeDAO.get(qRCodeID);
							qrcode.setLogistics("退回");
							if (0 >= qrcodeDAO.updateStateTwoToOne(qrcode)) {
								throw new Error("删除赠品时更改二维码为正常失败，二维码ID：" + qRCodeID);
							} else {
								if (0 >= inventoryService.getAddInventoryNumberByGoodsIdAndStorageId(
										qrcode.getGoods().getId(), qrcode.getStorage().getId(), "1",
										qrcode.getProcurementPrice())) {
									throw new Error("删除赠品时回滚库存出错");
								} else {
									isDeleteFinal = false;
								}
							}
						}
						break;
					}
				}
				if (isDeleteFinal) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("删除赠品失败，请稍后重试或刷新页面后重试~");
				}
			}
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 保存换购订单
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 4, 2017
	 * @param order
	 * @return AjaxJson
	 */
	public AjaxJson saveChangeEnough(Order order) {
		AjaxJson ajaxJson = new AjaxJson();
		if (null != order) {
			Order parentOrder = orderDAO.get(order.getOrder().getId());
			Store store = (null == UserUtil.getCurrUser().getStore()
					|| StringUtils.isBlank(UserUtil.getCurrUser().getStore().getId())) ? parentOrder.getStore()
							: UserUtil.getCurrUser().getStore();
			order.setId(UUID.getUUID());
			order.setCode(OrderCodeID.nextCode());
			order.setSubMoney("0.0");
			order.setCreateTime(new Date());
			order.setCustomer(parentOrder.getCustomer());
			order.setStore(store);
			order.setOrderSubremarkList(null);
			order.setType(Order.TYPE_THREE);
			order.setState(Order.STATE_ONE);
			List<OrderGoods> orderGoodsList = order.getOrderGoodList();

			Iterator<OrderGoods> iterator = orderGoodsList.iterator();
			while (iterator.hasNext()) {
				OrderGoods orderGoods = iterator.next();
				if (StringUtils.isBlank(orderGoods.getPrice())) {
					iterator.remove();
				}
			}

			if (null == orderGoodsList || orderGoodsList.isEmpty()) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("请先添加换购产品！");
				return ajaxJson;
			}
			String sumMoney = "0.0", OSM_ID_STRING = "";
			for (OrderGoods orderGoods : orderGoodsList) {
				orderGoods.setId(UUID.getUUID());
				orderGoods.setOrder(order);
				orderGoods.setCount("1");
				orderGoods.setCreateTime(new Date());
				orderGoods.setSubMoney("0.0");
				orderGoods.setType(OrderGoods.TYPE_OUT);
				orderGoods.setOrderSubremark(null);
				orderGoods.setoGQList(null);
				sumMoney = DoubleUtil.add(sumMoney, orderGoods.getPrice()).toString();
				OSM_ID_STRING += orderGoods.getOSM_ID();
			}
			order.setSumNumber(orderGoodsList.size() + "");
			order.setSumMoney(sumMoney);
			order.setOnePayMoney(sumMoney);
			order.setOneReturnMoney(sumMoney);
			order.setTwoPayMoney("0.0");
			order.setTwoReturnMoney("0.0");
			order.setOrderGoodList(orderGoodsList);
			order.setPayMoney(sumMoney);

			this.saveOrderCodeQrcodeImg(order.getCode());

			int i = orderDAO.save(order);
			if (0 < i) {
				for (OrderGoods orderGoods : orderGoodsList) {
					if (0 >= orderGoodsDAO.save(orderGoods)) {
						throw new Error("保存换购单商品信息失败");
					}
				}
				if (0 >= orderSubremarkDAO.setFinishByOSM_ID(OSM_ID_STRING)) {
					throw new Error("活动记录更改为已发放失败");
				}
				this.updateAddParentOrderMoney(order.getId());
				ajaxJson.setSuccess(true);
				ajaxJson.setMsg("保存换购单成功");
				ajaxJson.setObj(order.getId());
				return ajaxJson;
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("保存换购单失败，请重试~");
				return ajaxJson;
			}
		} else {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("保存换购单失败，请刷新页面重试");
			return ajaxJson;
		}
	}

	/**
	 *
	 * <P>
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 14, 2017
	 * @param code
	 *            void
	 */
	private void saveOrderCodeQrcodeImg(String code) {
		String qrcodeSavePath = attachmentConfigService.getAttachmentConfigWithCode("qrcodeImg").getSaveDir()
				.replaceAll("\\\\", "/");
		if (!qrcodeSavePath.endsWith("/")) {
			qrcodeSavePath += "/";
		}
		qrcodeSavePath += "order/";
		File file = new File(qrcodeSavePath);
		if (!file.exists()) {
			file.mkdirs();
		}
		qrcodeSavePath += code;
		try {
			QRCodeUtil.saveQRCode(code, 100, 100, qrcodeSavePath);
		} catch (WriterException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 *
	 * <P>
	 * 通过订单ID串获取订单列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 5, 2017
	 * @param orderId
	 * @return List<Order>
	 */
	public List<Order> getOrderByIdString(String orderId) {
		return StringUtils.isNotBlank(orderId) ? orderDAO.getOrderByIdString(orderId) : null;
	}

	/**
	 *
	 * <P>
	 * 根据用户获取某一类订单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月2日
	 * @param customerId
	 * @return List<Consume>
	 */
	public List<Order> getOrderByCustomerIdAndState(String customerId, String state) {
		return orderDAO.getOrderByCustomerIdAndState(customerId, state);
	}

	/**
	 *
	 * <P>
	 * 订单绑定电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 8, 2017
	 * @param orderId
	 *            主订单ID
	 * @param eticketOutCode
	 *            要绑定的电子券发放记录CODE（电子券二维码的内容）
	 * @return AjaxJson
	 */
	public AjaxJson bindEticket(String orderId, String eticketOutCode) {
		AjaxJson ajaxJson = new AjaxJson();
		ajaxJson.setSuccess(false);
		ajaxJson.setMsg("订单绑定电子券返回未知状态，请仔细检查代码实现~");
		boolean isNeedAddEticket = false;
		if (StringUtils.isBlank(orderId) || StringUtils.isBlank(eticketOutCode)) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("绑定电子券失败，请刷新页面重试");
			logger_orderService.error("订单绑定电子券失败，传入订单编号或电子券code值为空，请检查代码实现");
		} else {
			Order order = this.getOrderById(orderId);
			if (null != order.getOrder() && StringUtils.isNotBlank(order.getOrder().getId())) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("绑定电子券失败，刷新页面后重试~");
				logger_orderService.error("绑定电子券传入订单ID为子订单ID，不可用来绑定，请检查代码实现");
			} else {
				if (Order.TYPE_FOUR.equals(order.getType())) {
					if (StringUtils.isBlank(order.getCashierCode())) {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("预约订单请先支付定金哦~");
						return ajaxJson;
					}
				}
				if (null == order.getCustomer() || StringUtils.isBlank(order.getCustomer().getId())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("亲~本订单不支持使用电子券哦~");
				} else {
					Order otherOrder = null;
					for (Order order_ : order.getOrderList()) {
						if ("otherOrder".equals(order_.getProType())) {
							isNeedAddEticket = true;
							otherOrder = order_;
							break;
						}
					}
					if (isNeedAddEticket) {
						EticketOutRecord eticketOutRecord = eticketOutRecordService
								.getEticketOutRecordByCode(eticketOutCode);
						if (null == eticketOutRecord || StringUtils.isBlank(eticketOutRecord.getId())) {
							ajaxJson.setSuccess(false);
							ajaxJson.setMsg("无效的电子券");
						} else {
							if (EticketOutRecord.STATUS_USED.equals(eticketOutRecord.getState())) {
								ajaxJson.setSuccess(false);
								ajaxJson.setMsg("本电子券已使用~");
								return ajaxJson;
							}
							if (EticketOutRecord.STATUS_FAIL.equals(eticketOutRecord.getState())
									|| !DateUtil.compareDay(DateUtil.getDateString(eticketOutRecord.getEndDate()),
											DateUtil.getCurrDateString())) {
								ajaxJson.setSuccess(false);
								ajaxJson.setMsg("电子券过期失效，无法使用~");
							} else {
								if (!order.getCustomer().getId().equals(eticketOutRecord.getCustomer().getId())) {
									ajaxJson.setSuccess(false);
									ajaxJson.setMsg("亲~只能使用自己的电子券哦~");
								} else {
									if (Eticket.TYPE_ONE.equals(eticketOutRecord.getEticket().getType())) {
										if (!order.getStore().getId()
												.equals(eticketOutRecord.getEticket().getUseStore().getId())) {
											ajaxJson.setSuccess(false);
											ajaxJson.setMsg("亲，本电子券只能在"
													+ eticketOutRecord.getEticket().getUseStore().getName() + "门店使用哦~");
											return ajaxJson;
										}
									}
									if (0 <= DoubleUtil.compareTo(otherOrder.getPayMoney(),
											eticketOutRecord.getEticket().getUseLimit())) {
										String subMoney_all = (0 <= DoubleUtil.compareTo(otherOrder.getPayMoney(),
												eticketOutRecord.getEticket().getPrice()))
														? eticketOutRecord.getEticket().getPrice()
														: otherOrder.getPayMoney();
										otherOrder.setPayMoney(
												DoubleUtil.sub(otherOrder.getPayMoney(), subMoney_all).toString());
										otherOrder.setSubMoney(
												DoubleUtil.add(otherOrder.getSubMoney(), subMoney_all).toString());
										otherOrder
												.setEticketMoney(DoubleUtil
														.add(StringUtils.isBlank(otherOrder.getEticketMoney()) ? "0.0"
																: otherOrder.getEticketMoney(), subMoney_all)
														.toString());
										order.setEticketMoney(
												DoubleUtil.add(StringUtils.isBlank(order.getEticketMoney()) ? "0.0"
														: order.getEticketMoney(), subMoney_all).toString());
										order.setSubMoney(DoubleUtil.add(order.getSubMoney(), subMoney_all).toString());
										order.setPayMoney(DoubleUtil.sub(order.getPayMoney(), subMoney_all).toString());

										if (Order.TYPE_FOUR.equals(order.getType())) {
											order.setTwoPayMoney(
													DoubleUtil.sub(order.getTwoPayMoney(), subMoney_all).toString());
											order.setTwoReturnMoney(
													DoubleUtil.sub(order.getTwoReturnMoney(), subMoney_all).toString());
										} else {
											order.setOnePayMoney(
													DoubleUtil.sub(order.getOnePayMoney(), subMoney_all).toString());
											order.setOneReturnMoney(
													DoubleUtil.sub(order.getOneReturnMoney(), subMoney_all).toString());
										}

										List<OrderGoods> orderGoodsList = otherOrder.getOrderGoodList();
										for (OrderGoods orderGoods : orderGoodsList) {
											String zhekou = DoubleUtil
													.div(DoubleUtil.mul(orderGoods.getPrice(), orderGoods.getCount())
															.toString(), otherOrder.getSumMoney())
													.toString();
											orderGoods.setSubMoney(DoubleUtil
													.add(orderGoods.getSubMoney(),
															DoubleUtil.mul(subMoney_all, zhekou).toString())
													.toString());
										}
										if (0 >= update(order)) {
											throw new Error("使用电子券更新主订单待支付金额失败，回滚数据");
										} else {
											if (Order.TYPE_ONE.equals(order.getType()))
												orderDAO.updateInLinePayMoneyByBatchCode(order.getBatchCode(),
														DoubleUtil.sub(order.getInLinePayMoney(), subMoney_all)
																.toString());
											if (0 >= orderDAO.update(otherOrder)) {
												throw new Error("使用电子券减免otherOrder订单金额失败，回滚数据");
											} else {
												for (OrderGoods orderGoods : orderGoodsList) {
													if (0 >= orderGoodsDAO.update(orderGoods)) {
														throw new Error("订单绑定电子券更新orderGoods减免金额失败，回滚数据");
													}
												}
												if (0 >= eticketOutRecordDAO
														.setEticketUsedByEticketOutRecordId(eticketOutRecord.getId())) {
													throw new Error("设置电子券为已使用失败，回滚数据");
												} else {
													if (0 >= eticketUseRecordDAO
															.save(new EticketUseRecord(UUID.getUUID(), new Date(),
																	otherOrder, eticketOutRecord))) {
														throw new Error("保存电子券使用记录失败，回滚数据");
													} else {
														Map<String, Object> map = new HashMap<String, Object>();
														map.put("subMoney_all", subMoney_all);
														ajaxJson.setAttributes(map);
														ajaxJson.setSuccess(true);
														ajaxJson.setMsg("使用电子券成功");
														eticketOutRecord.setCustomer(null);
														Eticket eticket = eticketOutRecord.getEticket();
														eticket.setOutStore(null);
														eticket.setUseStore(null);
														eticketOutRecord.setEticket(eticket);
														ajaxJson.setObj(eticketOutRecord);
													}
												}
											}
										}
									} else {
										ajaxJson.setSuccess(false);
										ajaxJson.setMsg("亲，本电子券不满足使用条件哦，换一张试试吧~");
									}
								}
							}
						}
					} else {
						ajaxJson.setSuccess(false);
						ajaxJson.setMsg("亲~本订单不可使用电子券哦~");
					}
				}
			}
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 预约订单的更新方法
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 8, 2017
	 * @param order
	 * @return AjaxJson
	 */
	public AjaxJson reserveOrderUpdate(Order order) {
		AjaxJson ajaxJson = new AjaxJson();
		Order order_by_get = this.getOrderById(order.getId());
		if (StringUtils.isNotBlank(order_by_get.getReserveMoney())
				&& StringUtils.isNotBlank(order_by_get.getCashierCode())) {
			// 录入二维码和电子券
			if (!order_by_get.getQrcodeCount().equals(order_by_get.getSumNumber())) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("发货数量不足订单预约数量，请确认~");
				return ajaxJson;
			} else {
				this.bindNoScopeGroup(order.getId());
				// 走到这里 订单不能再绑定电子券了，尾款金额已定，直接保留一位小数收银用
				order_by_get.setTwoPayMoney(DoubleUtil.toDecimalString(order_by_get.getTwoPayMoney(), 1));
				order_by_get.setTwoReturnMoney(DoubleUtil.toDecimalString(order_by_get.getTwoReturnMoney(), 1));
				orderDAO.update(order_by_get);
			}
			return ajaxJson;
		}
		if (StringUtils.isBlank(order_by_get.getLestMoney())) {
			order.setLestMoney(DoubleUtil.sub(order_by_get.getPayMoney(), order.getReserveMoney()).toString());

			// 设置首次支付金额、未退款金额、第二次支付金额、第二次未退款金额
			order.setOnePayMoney(order.getReserveMoney());
			order.setOneReturnMoney(order.getReserveMoney());
			order.setTwoPayMoney(order.getLestMoney());
			order.setTwoReturnMoney(order.getLestMoney());
		}
		if (0 >= orderDAO.update(order)) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("保存预约订单失败请重试~");
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 获取要打印订单信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 11, 2017
	 * @param printOrderId
	 *            要打印订单Id
	 * @return String
	 */
	public AjaxJson getPrintOrderByPrintOrderId(String printOrderId) {
		AjaxJson ajaxJson = new AjaxJson();
		if (StringUtils.isBlank(printOrderId)) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("获取待打印订单失败~");
			logger_orderService.error("获取要打印订单信息,传入订单ID为空，请检查代码实现~");
			return ajaxJson;
		}
		Order order = orderDAO.get(printOrderId);
		if (null == order || StringUtils.isBlank(order.getId())) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("获取待打印订单失败了，请稍后重试~");
			return ajaxJson;
		}

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("type", order.getType());
		if (StringUtils.isNotBlank(order.getSubUserType()))
			jsonObject.put("subUserTypeValue", order.getSubUserTypeValue() + "优惠");
		jsonObject.put("code", order.getCode());
		jsonObject.put("storeCode", order.getStore().getStoreCode());
		jsonObject.put("guideUserName",
				(null != order.getGuideUser() && StringUtils.isNotBlank(order.getGuideUser().getId()))
						? order.getGuideUser().getName() : "");
		jsonObject.put("sumMoney", order.getSumMoney());
		jsonObject.put("sumNumber", order.getSumNumber());

		if (Order.TYPE_SIX.equals(order.getType())) {
			jsonObject.put("subMoney_huodong", order.getSubMoney());
			jsonObject.put("subMoney_eticket", "0.0");
			jsonObject.put("payTypeValue", order.getPayTypeValue());
			jsonObject.put("payMoney", order.getOnePayMoney());
		} else if (Order.TYPE_THREE.equals(order.getType())) {
			jsonObject.put("payTypeValue", order.getPayTypeValue());
			if (Order.PAYTYPE_ONE.equals(order.getOnePayType()) || Order.PAYTYPE_TWO.equals(order.getOnePayType())) {
				jsonObject.put("payMoney", order.getOneGetMoney());
			} else {
				jsonObject.put("payMoney", order.getOnePayMoney());
			}
		} else if (Order.TYPE_FIVE.equals(order.getType())) {
			jsonObject.put("returnMoney", StringUtils.isBlank(order.getReturnMoney()) ? "0.0" : order.getReturnMoney());
			jsonObject.put("returnCard", StringUtils.isBlank(order.getReturnCard()) ? "0.0" : order.getReturnCard());
			jsonObject.put("returnAliPay",
					StringUtils.isBlank(order.getReturnAliPay()) ? "0.0" : order.getReturnAliPay());
			jsonObject.put("returnWeChatPay",
					StringUtils.isBlank(order.getReturnWeChatPay()) ? "0.0" : order.getReturnWeChatPay());
			jsonObject.put("returnTianhe",
					StringUtils.isBlank(order.getReturnTianhe()) ? "0.0" : order.getReturnTianhe());
			jsonObject.put("payMoney", order.getOnePayMoney());
		} else if (Order.TYPE_FOUR.equals(order.getType())) {
			jsonObject.put("subMoney_eticket",
					StringUtils.isBlank(order.getEticketMoney()) ? "0.0" : order.getEticketMoney());
			jsonObject.put("subMoney_huodong",
					DoubleUtil
							.sub(order.getSubMoney(),
									StringUtils.isBlank(order.getEticketMoney()) ? "0.0" : order.getEticketMoney(), 2)
							.toString());
			jsonObject.put("reserveMoney", order.getReserveMoney());
			jsonObject.put("lestMoney", order.getLestMoney());
			if (StringUtils.isBlank(order.getTwoCashierCode())) {
				jsonObject.put("payTypeValue", Order.getPayTypeValue(order.getOnePayType()));
				jsonObject.put("payMoney", order.getOnePayMoney());
			} else {
				jsonObject.put("payTypeValue", Order.getPayTypeValue(order.getTwoPayType()));
				jsonObject.put("payMoney", order.getTwoPayMoney());
			}
		} else if (Order.TYPE_EIGHT.equals(order.getType())) {
			jsonObject.put("payMoney", order.getOnePayMoney());
			jsonObject.put("payTypeValue", Order.getPayTypeValue(order.getOnePayType()));
		} else if (Order.TYPE_TWO.equals(order.getType())) {
			jsonObject.put("subMoney_eticket",
					StringUtils.isBlank(order.getEticketMoney()) ? "0.0" : order.getEticketMoney());
			jsonObject.put("subMoney_huodong",
					DoubleUtil
							.sub(order.getSubMoney(),
									StringUtils.isBlank(order.getEticketMoney()) ? "0.0" : order.getEticketMoney(), 2)
							.toString());
			jsonObject.put("payTypeValue", Order.getPayTypeValue(order.getOnePayType()));
			jsonObject.put("payMoney", order.getOnePayMoney());
		}

		if (Order.TYPE_SIX.equals(order.getType()) && null != order.getOrderGoodList()
				&& !order.getOrderGoodList().isEmpty()) {
			String sumMoney_upOrder = "0.0";
			JSONArray returnGoodsList = new JSONArray();
			// 换货单，添加退货商品json段
			for (OrderGoods orderGoods : order.getOrderGoodList()) {
				if (OrderGoods.TYPE_RETURN_TIANHE.equals(orderGoods.getType())) {
					JSONObject goods = new JSONObject();
					goods.put("name",
							(StringUtils.isNotBlank(orderGoods.getGoods().getName()) ? orderGoods.getGoods().getName()
									: orderGoods.getGoods().getGoods().getName())
									+ (StringUtils.isNotBlank(orderGoods.getGoods().getOther_attr_value())
											? orderGoods.getGoods().getOther_attr_value()
											: orderGoods.getGoods().getGoods().getOther_attr_value()));
					goods.put("number", orderGoods.getCount());
					goods.put("price", orderGoods.getPrice());
					goods.put("sumPrice", DoubleUtil.mul(orderGoods.getCount(), orderGoods.getPrice(), 2).toString());
					sumMoney_upOrder = DoubleUtil.add(sumMoney_upOrder, goods.getString("sumPrice"), 2).toString();
					returnGoodsList.add(goods);
				}
			}
			jsonObject.put("sumMoney_upOrder", sumMoney_upOrder);
			jsonObject.put("returnGoodsList", returnGoodsList);
		}

		List<OrderGoods> orderGoodsList = new ArrayList<>();
		JSONArray goodsList = new JSONArray();
		if ((Order.TYPE_FIVE.equals(order.getType()) || Order.TYPE_THREE.equals(order.getType())
				|| Order.TYPE_EIGHT.equals(order.getType())) && null != order.getOrderGoodList()
				&& !order.getOrderGoodList().isEmpty()) {
			orderGoodsList.addAll(order.getOrderGoodList());
		} else if (Order.TYPE_SIX.equals(order.getType()) && null != order.getOrderGoodList()
				&& !order.getOrderGoodList().isEmpty()) {
			for (OrderGoods orderGoods : order.getOrderGoodList()) {
				if (OrderGoods.TYPE_OUT.equals(orderGoods.getType())) {
					orderGoodsList.add(orderGoods);
				}
			}
		} else if (Order.TYPE_FOUR.equals(order.getType()) || Order.TYPE_TWO.equals(order.getType())) {
			for (Order order_ : order.getOrderList()) {
				if (StringUtils.isNotBlank(order_.getProType()) && null != order_.getOrderGoodList()
						&& !order_.getOrderGoodList().isEmpty()) {
					orderGoodsList.addAll(order_.getOrderGoodList());
				}
			}
		}

		if (null != orderGoodsList && !orderGoodsList.isEmpty()) {
			for (OrderGoods orderGoods : orderGoodsList) {
				JSONObject goods = new JSONObject();
				goods.put("name",
						(StringUtils.isNotBlank(orderGoods.getGoods().getName()) ? orderGoods.getGoods().getName()
								: orderGoods.getGoods().getGoods().getName())
								+ (StringUtils.isNotBlank(orderGoods.getGoods().getOther_attr_value())
										? orderGoods.getGoods().getOther_attr_value() : ""));
				goods.put("number", orderGoods.getCount());
				goods.put("price", orderGoods.getPrice());
				goods.put("sumPrice", DoubleUtil.mul(orderGoods.getCount(), orderGoods.getPrice(), 2));
				goodsList.add(goods);
			}
			jsonObject.put("goodsList", goodsList);
		}
		ajaxJson.setObj(jsonObject);
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 保存客户端开具的商家的订单
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 13, 2017
	 * @param order
	 *            待保存订单信息
	 * @param upOrderCode
	 *            上单Code
	 * @return AjaxJson
	 */
	public AjaxJson saveClientOrder(Order order, String upOrderCode) {
		AjaxJson ajaxJson = new AjaxJson();
		Order upOrder = null;
		if (null == order) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("保存订单失败，未传入订单信息，请联系技术人员~");
			return ajaxJson;
		}
		if (null == order.getStore() || StringUtils.isBlank(order.getStore().getId())) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("请录入订单所属门店！");
			return ajaxJson;
		}
		if (StringUtils.isNotBlank(upOrderCode)) {
			upOrder = this.getFinishOrderByOrderCode(upOrderCode);
			if (null == upOrder || StringUtils.isBlank(upOrder.getId())) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("无效的上单信息~");
				return ajaxJson;
			} else {
				if (!order.getStore().getId().equals(upOrder.getStore().getId())) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("上单不是本门店订单哦~请与客户仔细确认~");
					return ajaxJson;
				}
			}
		}

		Order upOrder_parent = null;
		if (null != upOrder && null != upOrder.getOrder() && StringUtils.isNotBlank(upOrder.getOrder().getId())) {
			upOrder_parent = upOrder.getOrder();
		} else {
			upOrder_parent = upOrder;
		}

		order.setId(UUID.getUUID());
		order.setOrder(upOrder_parent);
		order.setCode(OrderCodeID.nextCode());
		order.setStore(storeService.getStoreById(order.getStore().getId()));
		order.setEticketMoney("0.0");
		order.setPayMoney(order.getSumMoney());
		order.setCreateTime(new Date());

		if (0 < DoubleUtil.compareTo("0.0", order.getSumMoney())) {
			// 退货
			if (StringUtils.isBlank(upOrderCode)) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("退货单必须传入上单code");
				return ajaxJson;
			}
			String sumNoReturnMoney = upOrder_parent.getOneReturnMoney(),
					returnMOneyWhile = DoubleUtil.sub("0.0", order.getSumMoney()).toString();
			for (Order childOrder : upOrder_parent.getOrderList()) {
				if (!Order.TYPE_FIVE.equals(childOrder.getType()))
					if (StringUtils.isBlank(childOrder.getProType()))
						sumNoReturnMoney = DoubleUtil.add(sumNoReturnMoney, childOrder.getOneReturnMoney()).toString();
			}
			if (0 > DoubleUtil.compareTo(sumNoReturnMoney, returnMOneyWhile)) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("可退款金额不足，请与客户确认上单单号是否正确，或走人工处理流程");
				return ajaxJson;
			}
			order.setType(Order.TYPE_FIVE);
			order.setState(Order.STATE_ONE);
			order.setEticketMoney("0.0");
			// 设置首次支付金额、未退款金额、第二次支付金额、第二次未退款金额
			order.setOnePayMoney(order.getPayMoney());// 天和应支付给消费者的金额
			order.setOneReturnMoney(order.getPayMoney());// 设置退款单剩余未退款金额
			order.setTwoPayMoney("0.0");
			order.setTwoReturnMoney("0.0");
			this.saveOrderCodeQrcodeImg(order.getCode());
			if (0 < orderDAO.save(order)) {
				// 调起退款
				this.updateAddParentOrderMoney(order.getId());
				ajaxJson.setSuccess(true);
				ajaxJson.setMsg("returnMoney");
				ajaxJson.setObj(order.getId());
				return ajaxJson;
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("退款失败");
				return ajaxJson;
			}
		} else {
			order.setCashierCode(null);
			boolean isNeedAddEticket = false;
			if (null != order.getOrder() && StringUtils.isNotBlank(order.getOrder().getId())) {
				// TODO 线下-商家店-换货单
				order.setType(Order.TYPE_SIX);
				order.setState(Order.STATE_ONE);
				order.setOnePayType(order.getPayType());
				order.setPayMoney(DoubleUtil.sub(order.getSumMoney(), order.getSubMoney()).toString());
				// 设置首次支付金额、未退款金额、第二次支付金额、第二次未退款金额
				order.setOnePayMoney(DoubleUtil.toDecimalString(order.getPayMoney(), 1));
				order.setOneReturnMoney(DoubleUtil.toDecimalString(order.getPayMoney(), 1));
				order.setTwoPayMoney("0.0");
				order.setTwoReturnMoney("0.0");
				this.saveOrderCodeQrcodeImg(order.getCode());
				if (0 >= orderDAO.save(order)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("保存订单失败，请稍后重试~");
				} else {
					this.updateAddParentOrderMoney(order.getId());
					ajaxJson.setSuccess(true);
					JSONObject jsonObject = new JSONObject();
					jsonObject.put("id", order.getId());
					jsonObject.put("isNeedAddEticket", isNeedAddEticket);
					jsonObject.put("payMoney", order.getPayMoney());
					jsonObject.put("subMoney", order.getSubMoney());
					ajaxJson.setObj(jsonObject);
				}
			} else {
				// TODO 线下-商家店-首次下单
				order.setType(Order.TYPE_TWO);
				order.setState(Order.STATE_ONE);
				order.setOnePayType(order.getPayType());
				// 卖出
				Order child_order = this.splitNoTianheOrder(order);
				if ("otherOrder".equals(child_order.getProType())) {
					isNeedAddEticket = true;
				}
				List<Order> orderList = new ArrayList<>();
				orderList.add(child_order);
				order.setOrderList(orderList);
				// 设置首次支付金额、未退款金额、第二次支付金额、第二次未退款金额
				order.setOnePayMoney(child_order.getPayMoney());
				order.setOneReturnMoney(child_order.getPayMoney());
				order.setTwoPayMoney("0.0");
				order.setTwoReturnMoney("0.0");
				order.setPayMoney(child_order.getPayMoney());
				order.setSubMoney(child_order.getSubMoney());
				this.saveOrderCodeQrcodeImg(order.getCode());
				if (0 >= this.saveOrderAll(order)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("保存订单失败，请稍后重试~");
				} else {
					if (!isNeedAddEticket)
						this.bindNoScopeGroup(order.getId());
					ajaxJson.setSuccess(true);
					JSONObject jsonObject = new JSONObject();
					jsonObject.put("id", order.getId());
					jsonObject.put("isNeedAddEticket", isNeedAddEticket);
					jsonObject.put("payMoney", order.getPayMoney());
					jsonObject.put("subMoney", order.getSubMoney());
					ajaxJson.setObj(jsonObject);
				}
			}
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 获取订单IdListbybatchCode
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月11日
	 * @param batchCode
	 * @return List<String>
	 */
	public List<String> getOrderIdListByBatchCode(String batchCode) {
		if (StringUtils.isNotBlank(batchCode)) {
			return orderDAO.getOrderIdListByBatchCode(batchCode);
		} else {
			return null;
		}
	}

	/**
	 *
	 * <P>
	 * 获取订单bybatchCode
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月11日
	 * @param batchCode
	 * @return List<String>
	 */
	public List<Order> getOrderByBatchCode(String batchCode) {
		if (StringUtils.isNotBlank(batchCode)) {
			return orderDAO.getOrderByBatchCode(batchCode);
		} else {
			return null;
		}
	}

	/**
	 *
	 * <P>
	 * 确认收货
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月12日
	 * @param batchCode
	 * @return int
	 */
	public int sendGoodsByBatchCode(String batchCode) {
		List<Order> orderList = this.getOrderByBatchCode(batchCode);
		int i = 0;
		if (orderList != null && 0 < orderList.size()) {
			for (Order order : orderList) {
				if (0 >= orderDAO.updateStateFourToFive(order.getId())) {
					throw new Error("更新收货失败，回滚数据");
				} else {
					i = 1;
				}
			}
			return i;
		} else {
			return i;
		}
	}

	/**
	 *
	 * <P>
	 * 余额支付
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月12日
	 * @param id
	 * @param state
	 * @return int
	 */
	public AjaxJson walletPay(List<Order> orderList, Customer customer, String passWord) {
		AjaxJson ajaxJson = new AjaxJson();
		if (null != customer && StringUtils.isNotBlank(customer.getId()) && null != orderList && 0 < orderList.size()
				&& StringUtils.isNotBlank(passWord)) {
			if (passWord.equals(customer.getPayPassword())) {
				if (null != customer.getMoney()
						&& 0 < DoubleUtil.sub(customer.getMoney(), orderList.get(0).getInLinePayMoney())) {
					int i = 0;
					String payMoney = "0";
					String postage = "0";
					String inLinePayMoney = "0";
					for (Order order : orderList) {
						postage = order.getPostage();
						inLinePayMoney = order.getInLinePayMoney();
						if (0 >= orderDAO.updateStateOneToTwo(order.getId())) {
							i = 0;
							throw new Error("支付失败，回滚数据");
						} else {
							payMoney = DoubleUtil.add(payMoney, order.getPayMoney()).toString();
							i = 1;
						}
					}
					if (0 >= i) {
						throw new Error("支付失败，回滚数据");
					} else {
						payMoney = DoubleUtil.add(payMoney, postage).toString();
						if (0 == DoubleUtil.compareTo(payMoney, inLinePayMoney)) {
							Consume consume = new Consume(UUID.getUUID(), customer, null, null, Consume.TYPE_THREE_UP,
									payMoney, "线上消费" + payMoney + "元", new Date());
							if (0 >= consumeDAO.save(consume)) {
								throw new Error("支付失败,保存流水失败!");
							} else {
								if (0 >= customerDAO.subTianheMoney(customer.getId(),
										DoubleUtil.add(payMoney, "0", 2).toString())) {
									ajaxJson.setSuccess(false);
									ajaxJson.setMsg("扣款失败,请重试!");
									throw new Error("更新状态失败，回滚数据");
								} else {
									for (Order order : orderList) {
										this.sendPromotionAndEticket(order);
									}
									final Customer customer1 = customer;
									final List<Order> orderList1 = orderList;
									ThreadPoolUtil.getPool().execute(new Runnable() {
										@Override
										public void run() {
											try {
												WeChatUtil.sendCustomerOrderSuccess(customer1, orderList1,
														weChatService.getWeChatList().get(0));
											} catch (Exception e) {
												logger_orderService.error("订单支付成功的通知(线上)出错，具体错误如下：" + ExceptionUtil
														.getExceptionAllinformation(e, this.getClass().getName()));
											}
										}
									});
									ajaxJson.setSuccess(true);
									ajaxJson.setMsg("支付成功!");
								}
							}
						} else {
							throw new Error("支付失败,inLinePayMoney与payMoney不等!");
						}
					}
				} else {
					ajaxJson.setObj("payMoney");
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("余额不足,请充值!");
				}

			} else {
				ajaxJson.setObj("password");
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("密码错误,请重试!");
			}
		} else {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("传参错误,请重试!");
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 切割天和商家的订单
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 13, 2017
	 * @param order_parent
	 * @return Order
	 */
	private Order splitNoTianheOrder(Order order_parent) {
		Order child_order = new Order(UUID.getUUID());
		child_order.setCustomer(order_parent.getCustomer());
		child_order.setStore(order_parent.getStore());
		child_order.setOrder(order_parent);
		child_order.setCode(OrderCodeID.nextCode());
		child_order.setType(order_parent.getType());
		child_order.setState(Order.STATE_ONE);
		child_order.setCreateTime(new Date());
		child_order.setEticketMoney("0.0");
		child_order.setSumMoney(order_parent.getSumMoney());
		child_order.setSubMoney(order_parent.getSubMoney());
		child_order.setPayMoney(order_parent.getSumMoney());

		if (0 <= DoubleUtil.compareTo("0.0", order_parent.getSubMoney()) && null != order_parent.getCustomer()
				&& StringUtils.isNotBlank(order_parent.getCustomer().getId())) {
			// 参与活动
			List<PromotionGroup> promGroupList = promotionGroupService.getAllPromotionGroupByNoTianheStoreId(
					order_parent.getStore().getId(), order_parent.getPayType(), Order.TYPE_TWO);
			boolean isHavePromotion = false;
			if (null != promGroupList && !promGroupList.isEmpty()) {
				for (PromotionGroup promotionGroup : promGroupList) {
					for (Promotion promotion : promotionGroup.getPromotionList()) {
						switch (promotion.getType()) {
						case Promotion.TYPE_1:// 满折
							for (PromotionLadder promotionLadder : promotion.getPromotionLadderList()) {
								if (0 >= DoubleUtil.compareTo(promotionLadder.getLadderStart(),
										order_parent.getPayMoney())) {
									child_order.setPayMoney(DoubleUtil
											.mul(child_order.getSumMoney(), DoubleUtil
													.div(promotionLadder.getPromotionMoney(), "100").toString())
											.toString());
									child_order.setSubMoney(DoubleUtil
											.sub(child_order.getSumMoney(), child_order.getPayMoney()).toString());
									OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), child_order,
											promotionLadder, OrderSubremark.ISSENDLADDER_YES, new Date());
									List<OrderSubremark> orderSubremarkList_temp = child_order.getOrderSubremarkList();
									if (null == orderSubremarkList_temp)
										orderSubremarkList_temp = new ArrayList<>();
									orderSubremarkList_temp.add(orderSubremark);
									child_order.setOrderSubremarkList(orderSubremarkList_temp);
									isHavePromotion = true;
									break;
								}
							}
							break;
						case Promotion.TYPE_2:// 满减
							for (PromotionLadder promotionLadder : promotion.getPromotionLadderList()) {
								if (0 >= DoubleUtil.compareTo(promotionLadder.getLadderStart(),
										order_parent.getPayMoney())) {
									child_order.setPayMoney(DoubleUtil
											.sub(child_order.getSumMoney(), promotionLadder.getPromotionMoney())
											.toString());
									child_order.setSubMoney(promotionLadder.getPromotionMoney());
									OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), child_order,
											promotionLadder, OrderSubremark.ISSENDLADDER_YES, new Date());
									List<OrderSubremark> orderSubremarkList_temp = child_order.getOrderSubremarkList();
									if (null == orderSubremarkList_temp)
										orderSubremarkList_temp = new ArrayList<>();
									orderSubremarkList_temp.add(orderSubremark);
									child_order.setOrderSubremarkList(orderSubremarkList_temp);
									isHavePromotion = true;
									break;
								}
							}
							break;
						case Promotion.TYPE_3:// 满返
							for (PromotionLadder promotionLadder : promotion.getPromotionLadderList()) {
								if (0 >= DoubleUtil.compareTo(promotionLadder.getLadderStart(),
										order_parent.getPayMoney())) {
									child_order.setSubMoney("0.0");
									OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), child_order,
											promotionLadder, OrderSubremark.ISSENDLADDER_NO, new Date());
									List<OrderSubremark> orderSubremarkList_temp = child_order.getOrderSubremarkList();
									if (null == orderSubremarkList_temp)
										orderSubremarkList_temp = new ArrayList<>();
									orderSubremarkList_temp.add(orderSubremark);
									child_order.setOrderSubremarkList(orderSubremarkList_temp);
									isHavePromotion = true;
									break;
								}
							}
							break;
						case Promotion.TYPE_7:// 满送
							for (PromotionLadder promotionLadder : promotion.getPromotionLadderList()) {
								if (0 >= DoubleUtil.compareTo(promotionLadder.getLadderStart(),
										order_parent.getPayMoney())) {
									child_order.setSubMoney("0.0");
									OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), child_order,
											promotionLadder, OrderSubremark.ISSENDLADDER_NO, new Date());
									List<OrderSubremark> orderSubremarkList_temp = child_order.getOrderSubremarkList();
									if (null == orderSubremarkList_temp)
										orderSubremarkList_temp = new ArrayList<>();
									orderSubremarkList_temp.add(orderSubremark);
									child_order.setOrderSubremarkList(orderSubremarkList_temp);
									isHavePromotion = true;
									break;
								}
							}
							break;
						case Promotion.TYPE_9:// 加钱换购
							for (PromotionLadder promotionLadder : promotion.getPromotionLadderList()) {
								if (0 >= DoubleUtil.compareTo(promotionLadder.getLadderStart(),
										order_parent.getPayMoney())) {
									child_order.setSubMoney("0.0");
									OrderSubremark orderSubremark = new OrderSubremark(UUID.getUUID(), child_order,
											promotionLadder, OrderSubremark.ISSENDLADDER_NO, new Date());
									orderSubremark.setSalesMoney(promotionLadder.getGoodsPrice());
									List<OrderSubremark> orderSubremarkList_temp = child_order.getOrderSubremarkList();
									if (null == orderSubremarkList_temp)
										orderSubremarkList_temp = new ArrayList<>();
									orderSubremarkList_temp.add(orderSubremark);
									child_order.setOrderSubremarkList(orderSubremarkList_temp);
									isHavePromotion = true;
									break;
								}
							}
							break;
						default:
							break;
						}

						if (isHavePromotion)
							break;
					}

					if (isHavePromotion) { // 本活动组有匹配活动
						if (PromotionGroup.SCOPE_STORE.equals(promotionGroup.getScope())) {
							child_order.setProType("storeOrder");
						} else if (PromotionGroup.SCOPE_ALL.equals(promotionGroup.getScope())) {
							child_order.setProType("tianheOrder");
						}
						break;
					}
				}
				if (!isHavePromotion) { // 无匹配活动
					child_order.setProType("otherOrder");
				}
			} else {
				// 无活动可匹配
				child_order.setProType("otherOrder");
			}
		} else {
			// 减免金额大于0或会员信息为空，不参与活动
			child_order.setProType("nullOrder");
			child_order.setSubMoney(order_parent.getSubMoney());
			child_order.setPayMoney(DoubleUtil.sub(child_order.getSumMoney(), order_parent.getSubMoney()).toString());
		}
		child_order.setPayMoney(DoubleUtil.toDecimalString(child_order.getPayMoney(), 2));
		child_order.setSubMoney(DoubleUtil.toDecimalString(child_order.getSubMoney(), 2));
		// 设置首次支付金额、未退款金额、第二次支付金额、第二次未退款金额
		child_order.setOnePayMoney(DoubleUtil.toDecimalString(child_order.getPayMoney(), 1));
		child_order.setOneReturnMoney(DoubleUtil.toDecimalString(child_order.getPayMoney(), 1));
		child_order.setOnePayType(order_parent.getOnePayType());
		child_order.setTwoPayMoney("0.0");
		child_order.setTwoReturnMoney("0.0");
		return child_order;
	}

	/**
	 *
	 * <P>
	 * 线上订单支付成功回调
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月14日
	 * @param orderId
	 * @param cashierUserId
	 * @param cashierCode
	 * @param payType
	 * @param customerId
	 * @param customerPayCode
	 * @param payCode
	 * @param isOnline
	 * @param getMoney
	 * @return
	 * @throws Exception
	 *             AjaxJson
	 */
	public AjaxJson inlineOrderPaySuccess(String orderId, String cashierUserId, String cashierCode, String payType,
			String customerId, String customerPayCode, String payCode, boolean isOnline) throws Exception {
		AjaxJson ajaxJson = new AjaxJson();
		if (isOnline) {
			if (StringUtils.isBlank(orderId)) {
				throw new Exception("确认支付传入订单号为空，不与确认，请检查微信端代码实现~");
			}
		}

		Order order = this.getOrderById(orderId);
		if (StringUtils.isBlank(order.getPayType())) {
			if (StringUtils.isBlank(payType)) {
				throw new Exception("待确认订单为收银指定支付方式订单，但客户端未回传支付方式，不与确认，请检查客户端代码实现");
			} else {
				if (Order.PAYTYPE_FIVE.equals(payType)) {
					if (StringUtils.isBlank(customerId) || StringUtils.isBlank(customerPayCode)) {
						throw new Exception("待确认订单为收银指定支付方式，接收到使用天和钱包支付，但未回传消费者ID或天和支付动态密码，不与确认，请检查客户端代码实现~");
					}
				}
			}
		}

		Order order_to_update = new Order(orderId);
		order_to_update.setType(order.getType());
		order_to_update.setCustomer(new Customer(customerId));
		order_to_update.setOnePayCode(payCode);
		order_to_update.setPayType(payType);
		order_to_update.setPayTime(new Date());

		if (0 >= orderDAO.orderPaySuccess(order_to_update)) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("确认支付失败，请重试~");
			throw new Error("订单确认支付失败，影响记录条数为0");
		} else {
			this.sendPromotionAndEticket(order);
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 线上订单待评价变完成
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月14日
	 * @param id
	 * @return int
	 */
	public int updateStateFiveToSix(String id) {
		return orderDAO.updateStateFiveToSix(id);
	}

	/**
	 *
	 * <P>
	 * 线上订单已出库变已发货
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月14日
	 * @param id
	 * @return int
	 */
	public int updateStateThreeToFour(Order order) {
		return orderDAO.updateStateThreeToFour(order);
	}

	/**
	 *
	 * <P>
	 * 线上订单未发货变已出库
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月14日
	 * @param id
	 * @return int
	 */
	public int updateStateTwoToThree(String id) {
		return orderDAO.updateStateTwoToThree(id);
	}

	/**
	 *
	 * <P>
	 * 根据优惠劵更新邮费
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月14日
	 * @param orderId
	 * @param eticketOutCode
	 * @return
	 * @throws Exception
	 *             int
	 */
	public AjaxJson updatePostageByBatchCode(String orderId, String eticketOutCode) throws Exception {
		AjaxJson ajaxJson = new AjaxJson();
		if (StringUtils.isNotBlank(orderId) && StringUtils.isNotBlank(eticketOutCode)) {
			String startMoney = "0";
			String proportion = "0";
			if (null != postageBonusService.getAll() && 0 < postageBonusService.getAll().size()) {
				startMoney = postageBonusService.getAll().get(0).getStartMoney();
				proportion = postageBonusService.getAll().get(0).getProportion();
			}
			Order order = this.getOrderById(orderId);
			EticketOutRecord eticketOutRecord = eticketOutRecordService.getEticketOutRecordByCode(eticketOutCode);
			List<Order> orderList = this.getOrderByBatchCode(order.getBatchCode());

			if (0 > DoubleUtil.sub(
					DoubleUtil.sub(orderList.get(0).getInLinePayMoney(), eticketOutRecord.getEticket().getPrice())
							.toString(), startMoney)) {
				if (0 >= DoubleUtil.compareTo(StringUtils.isNotBlank(orderList.get(0).getPostage()) ? orderList.get(0)
						.getPostage() : "0.0", "0.0")) {
					for (Order order2 : orderList) {
						order2.setPostage(proportion);
						order2.setInLinePayMoney(DoubleUtil.add(order2.getInLinePayMoney(), order2.getPostage(), 2)
								.toString());
						if (0 >= orderDAO.update(order2)) {
							ajaxJson.setSuccess(false);
							ajaxJson.setMsg("绑定失败，请稍后重试~");
							throw new Error("绑定电子卷前判定邮费失败");
						} else {
							Map<String, Object> map = new HashMap<String, Object>();
							map.put("postage", proportion);
							ajaxJson.setAttributes(map);
						}
					}
				} else {
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("postage", StringUtils.isNotBlank(orderList.get(0).getPostage()) ? orderList.get(0)
							.getPostage() : "0.0");
					ajaxJson.setAttributes(map);
				}
			} else {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("postage", "0");
				ajaxJson.setAttributes(map);
			}
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 0元支付
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月12日
	 * @param id
	 * @param state
	 * @return int
	 */
	public AjaxJson zeroPay(List<Order> orderList, Customer customer) {
		AjaxJson ajaxJson = new AjaxJson();
		if (null != customer && StringUtils.isNotBlank(customer.getId()) && null != orderList && 0 < orderList.size()) {
			if (null != customer.getMoney()
					&& 0 < DoubleUtil.sub(customer.getMoney(), orderList.get(0).getInLinePayMoney())) {
				int i = 0;
				String payMoney = "0";
				String postage = "0";
				String inLinePayMoney = "0";
				for (Order order : orderList) {
					postage = order.getPostage();
					inLinePayMoney = order.getInLinePayMoney();
					if (0 >= orderDAO.updateStateOneToTwo(order.getId())) {
						i = 0;
						throw new Error("支付失败，回滚数据");
					} else {
						payMoney = DoubleUtil.add(payMoney, order.getPayMoney()).toString();
						i = 1;
					}
				}
				if (0 >= i) {
					throw new Error("支付失败，回滚数据");
				} else {
					payMoney = DoubleUtil.add(payMoney, postage).toString();
					if (0 >= DoubleUtil.compareTo(payMoney, "0") || 0 >= DoubleUtil.compareTo(inLinePayMoney, "0")) {
						Consume consume = new Consume(UUID.getUUID(), customer, null, null, Consume.TYPE_THREE_UP,
								payMoney, "线上消费" + payMoney + "元", new Date());
						if (0 >= consumeDAO.save(consume)) {
							throw new Error("支付失败,保存流水失败!");
						} else {
							for (Order order : orderList) {
								this.sendPromotionAndEticket(order);
							}
							final Customer customer1 = customer;
							final List<Order> orderList1 = orderList;
							ThreadPoolUtil.getPool().execute(new Runnable() {
								@Override
								public void run() {
									try {
										WeChatUtil.sendCustomerOrderSuccess(customer1, orderList1, weChatService
												.getWeChatList().get(0));
									} catch (Exception e) {
										logger_orderService.error("订单支付成功的通知(线上)出错，具体错误如下："
												+ ExceptionUtil
														.getExceptionAllinformation(e, this.getClass().getName()));
									}
								}
							});
							ajaxJson.setSuccess(true);
							ajaxJson.setMsg("支付成功!");
							ajaxJson.setObj("zeroPay");
						}
					} else {
						throw new Error("支付失败,inLinePayMoney与所有订单payMoney和不等!");
					}
				}
			} else {
				ajaxJson.setObj("payMoney");
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("余额不足,请充值!");
			}
		} else {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("传参错误,请重试!");
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 获取支付完成的订单
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 25, 2017
	 * @param orderCode
	 * @return Object
	 */
	public Order getPaySuccessOrderByOrderCode(String orderCode) {
		return StringUtils.isBlank(orderCode) ? null : orderDAO.getPaySuccessOrderByOrderCode(orderCode);
	}

	/**
	 *
	 * <P>
	 * 15天自动收货
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月18日 void
	 */
	public void FourStateOrderByFifteenTask() {
		List<Order> orderList = orderDAO.getFourStateOrderByFifteen();

		DataSourceTransactionManager transactionManager = SpringContextHolder
				.getBean(org.springframework.jdbc.datasource.DataSourceTransactionManager.class);
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		// 事物隔离级别，开启新事务，这样会比较安全些。
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
		// 获得事务状态
		TransactionStatus status = null;

		for (final Order order : orderList) {
			try {
				status = transactionManager.getTransaction(def);// 开启事物
				orderDAO.updateStateFourToSix(order.getId());
				transactionManager.commit(status);
			} catch (Error e) {
				transactionManager.rollback(status);
				logger_orderService.error("自动收货--出错，具体错误如下：" + e.getMessage());
			} catch (Exception e) {
				transactionManager.rollback(status);
				logger_orderService.error("自动收货--出错，具体错误如下："
						+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			}
		}

	}

	/**
	 *
	 * 根据qrcodeId获取赔偿
	 *
	 * @author 徐昊
	 * @date 2017年6月29日
	 * @param order
	 * @return int
	 */
	public String getEightOrderCountByQrcodeId(String qrcodeId) {
		return orderDAO.getEightOrderCountByQrcodeId(qrcodeId);
	}

	/**
	 *
	 * 根据qrcodeId获取换够
	 *
	 * @author 徐昊
	 * @date 2017年6月29日
	 * @param order
	 * @return int
	 */
	public String getThreeOrderCountByQrcodeId(String qrcodeId) {
		return orderDAO.getThreeOrderCountByQrcodeId(qrcodeId);
	}

	/**
	 *
	 * <P>
	 * 根据Id获取订单
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月2日
	 * @param customerId
	 * @return List<Consume>
	 */
	public List<Order> getThreeOrderByOrderId(String orderId) {
		return orderDAO.getThreeOrderByOrderId(orderId);
	}

	/**
	 *
	 * <P>
	 * 订单放定时任务
	 * </p>
	 *
	 * @author 闫枫
	 * @date Apr 3, 2018 void
	 */
	public void giveUpOrder() {
		List<String> orderIdString = orderDAO.getNoPayChildOrderIdList();

		DataSourceTransactionManager transactionManager = SpringContextHolder
				.getBean(org.springframework.jdbc.datasource.DataSourceTransactionManager.class);
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		// 事物隔离级别，开启新事务，这样会比较安全些。
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
		// 获得事务状态
		TransactionStatus status = null;

		for (String orderId : orderIdString) {
			try {
				status = transactionManager.getTransaction(def);// 开启事物
				this.updateOrderStateBySeven(orderId);
				transactionManager.commit(status);
			} catch (Error e) {
				transactionManager.rollback(status);
				logger_orderService.error("订单放定时任务--出错，具体错误如下：" + e.getMessage());
			} catch (Exception e) {
				transactionManager.rollback(status);
				logger_orderService.error(
						"订单放定时任务--出错，具体错误如下：" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			}
		}

	}
}
