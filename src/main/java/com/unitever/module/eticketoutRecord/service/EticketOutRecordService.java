package com.unitever.module.eticketoutRecord.service;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.google.zxing.WriterException;
import com.unitever.module.customer.model.Customer;
import com.unitever.module.customer.service.CustomerService;
import com.unitever.module.eticket.model.Eticket;
import com.unitever.module.eticket.service.EticketService;
import com.unitever.module.eticketoutRecord.dao.manual.EticketOutRecordDAO;
import com.unitever.module.eticketoutRecord.model.EticketOutRecord;
import com.unitever.module.order.model.Order;
import com.unitever.module.order.service.OrderService;
import com.unitever.module.weChat.service.WeChatService;
import com.unitever.module.weChat.util.WeChatUtil;
import com.unitever.platform.component.attachment.service.AttachmentConfigService;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.spring.SpringContextHolder;
import com.unitever.platform.util.DateUtil;
import com.unitever.platform.util.EticketCodeID;
import com.unitever.platform.util.ExceptionUtil;
import com.unitever.platform.util.QRCodeUtil;
import com.unitever.platform.util.ThreadPoolUtil;
import com.unitever.platform.util.UUID;

@Service
@Transactional
public class EticketOutRecordService {

	private Logger logger_eticketOutRecordService = LoggerFactory.getLogger("EticketOutRecordService");

	@Autowired
	private EticketOutRecordDAO eticketOutRecordDAO;
	@Autowired
	private EticketService eticketService;
	@Autowired
	private WeChatService weChatService;
	@Autowired
	private CustomerService customerService;
	@Autowired
	private AttachmentConfigService attachmentConfigService;
	@Autowired
	private OrderService orderService;

	/**
	 *
	 * <P>
	 * 保存电子券发放记录
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 6, 2017
	 * @param eticketOutRecord
	 * @return int
	 */
	public int saveEticketOutRecord(EticketOutRecord eticketOutRecord) {
		if (null != eticketOutRecord) {
			eticketOutRecord.setId(UUID.getUUID());
			eticketOutRecord.setCode(EticketCodeID.nextCode());
			eticketOutRecord.setCreateDate(new Date());
			saveEticketOutQRCodeImgFile(eticketOutRecord.getCode());
			return eticketOutRecordDAO.save(eticketOutRecord);
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 通过id获取电子券发放信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 7, 2017
	 * @param id
	 * @return EticketOutRecord
	 */
	public EticketOutRecord getEticketOutRecordById(String id) {
		return eticketOutRecordDAO.get(id);
	}

	/**
	 *
	 * <P>
	 * 获取所有电子券发放记录
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 7, 2017
	 * @return List<EticketOutRecord>
	 */
	public List<EticketOutRecord> getAllEticketOutRecord() {
		return eticketOutRecordDAO.getAll();
	}

	/**
	 *
	 * <P>
	 * 更新电子券发放信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 7, 2017
	 * @param eticketOutRecord
	 * @return int
	 */
	public int updateEticketOutRecord(EticketOutRecord eticketOutRecord) {
		if (null != eticketOutRecord)
			if (StringUtils.isNotBlank(eticketOutRecord.getId()))
				return eticketOutRecordDAO.update(eticketOutRecord);
		return 0;
	}

	/**
	 *
	 * <P>
	 * 通过电子券发放对象获取电子券发放列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 7, 2017
	 * @param eticketOutRecord
	 * @return List<EticketOutRecord>
	 */
	public List<EticketOutRecord> getOutRecordByOutRecord(EticketOutRecord eticketOutRecord) {
		return eticketOutRecordDAO.getOutRecordByOutRecord(eticketOutRecord);
	}

	/**
	 *
	 * <P>
	 * 回收过期电子券，并发送提醒消息（即将到期消息也在这里发送）
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 7, 2017 void
	 */
	public void recycleEticketTask() {
		List<EticketOutRecord> eticketOutRecordList = this.getAllNoUseEticketOutRecord();

		DataSourceTransactionManager transactionManager = SpringContextHolder
				.getBean(org.springframework.jdbc.datasource.DataSourceTransactionManager.class);
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		// 事物隔离级别，开启新事务，这样会比较安全些。
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
		// 获得事务状态
		TransactionStatus status = null;

		for (final EticketOutRecord eticketOutRecord : eticketOutRecordList) {
			try {
				status = transactionManager.getTransaction(def);// 开启事物
				if (EticketOutRecord.STATUS_NORMAL.equals(eticketOutRecord.getState())) {
					if (!DateUtil.compareDay(DateUtil.getDateString(eticketOutRecord.getEndDate()),
							DateUtil.getCurrDateString())) {
						// 电子券过期回收
						eticketOutRecord.setState(EticketOutRecord.STATUS_FAIL);
						if (0 < this.eticketOutRecordFail(eticketOutRecord.getId())) {
							ThreadPoolUtil.getPool().execute(new Runnable() {
								@Override
								public void run() {
									try {
										WeChatUtil.recycleEticket(eticketOutRecord, weChatService.getWeChatList()
												.get(0));
									} catch (Exception e) {
										logger_eticketOutRecordService.error("发放电子券到期提醒模板消息出错，具体错误如下："
												+ ExceptionUtil
														.getExceptionAllinformation(e, this.getClass().getName()));
									}
								}
							});
						}
					} else {
						if (Long.compare(
								DateUtil.getIntervalDays(DateUtil.getCurrDateString(),
										DateUtil.getDateString(eticketOutRecord.getEndDate())), 1L) == 0) {
							ThreadPoolUtil.getPool().execute(new Runnable() {
								@Override
								public void run() {
									try {
										WeChatUtil.recycleEticket(eticketOutRecord, weChatService.getWeChatList()
												.get(0));
									} catch (Exception e) {
										logger_eticketOutRecordService.error("发放电子券到期提醒模板消息出错，具体错误如下："
												+ ExceptionUtil
														.getExceptionAllinformation(e, this.getClass().getName()));
									}
								}
							});
						}
					}
				}
				transactionManager.commit(status);
			} catch (Error e) {
				transactionManager.rollback(status);
				logger_eticketOutRecordService.error("电子券过期回收--出错，具体错误如下：" + e.getMessage());
			} catch (Exception e) {
				transactionManager.rollback(status);
				logger_eticketOutRecordService.error("电子券过期回收--出错，具体错误如下："
						+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			}
		}

	}

	/**
	 *
	 * <P>
	 * 获取所有未使用电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 7, 2017
	 * @return List<EticketOutRecord>
	 */
	public List<EticketOutRecord> getAllNoUseEticketOutRecord() {
		return eticketOutRecordDAO.getAllNoUseEticketOutRecord();
	}

	/**
	 *
	 * <P>
	 * 设置电子券过期失效
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 7, 2017
	 * @param eticketOutRecord
	 * @return int
	 */
	public int eticketOutRecordFail(String eticketOutRecordId) {
		return StringUtils.isBlank(eticketOutRecordId) ? 0 : eticketOutRecordDAO
				.eticketOutRecordFail(eticketOutRecordId);
	}

	/**
	 *
	 * <P>
	 * 电子券发放记录分页page
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 7, 2017
	 * @param page
	 * @param eticketOutRecord
	 * @return Page<EticketOutRecord>
	 */
	public Page<EticketOutRecord> getPage(Page<EticketOutRecord> page, EticketOutRecord eticketOutRecord) {
		if (StringUtils.isNotBlank(eticketOutRecord.getEndDate_select())) {
			eticketOutRecord.setEndDate_select(eticketOutRecord.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(eticketOutRecordDAO.getCountByObject(eticketOutRecord));
		eticketOutRecord.setStartOfPage(page.getStartOfPage());
		eticketOutRecord.setPageSize(page.getPageSize());
		page.setResults(eticketOutRecordDAO.getOutRecordByOutRecord(eticketOutRecord));
		if (StringUtils.isNotBlank(eticketOutRecord.getEndDate_select())) {
			eticketOutRecord.setEndDate_select(eticketOutRecord.getEndDate_select().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 依据电子券发放ID设置电子券为已用
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 8, 2017
	 * @param eticketOutRecordId
	 * @return int
	 */
	public int setEticketUsedByEticketOutRecordId(String eticketOutRecordId) {
		return StringUtils.isBlank(eticketOutRecordId) ? 0 : eticketOutRecordDAO
				.setEticketUsedByEticketOutRecordId(eticketOutRecordId);
	}

	/**
	 *
	 * <P>
	 * 自动发放交易类型电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 7, 2017
	 * @param payMoney
	 *            订单活动外支付金额
	 * @param storeId
	 *            下单门店
	 * @param customerId
	 *            客户Id
	 */
	public int sendEticketBuy(String payMoney, String storeId, String customerId) {
		if (StringUtils.isBlank(customerId))
			return 0;
		Eticket eticket = eticketService.getAllAutoBuyEticket(payMoney, storeId);
		if (null != eticket && StringUtils.isNotBlank(eticket.getId())) {
			final String eticket_out_id = UUID.getUUID(), eticketOutCode = EticketCodeID.nextCode();
			this.saveEticketOutQRCodeImgFile(eticketOutCode);
			EticketOutRecord eticketOutRecord = new EticketOutRecord(eticket_out_id, new Date(), eticket,
					EticketOutRecord.STATUS_NORMAL, "购买成功自动发送", eticketOutCode,
					customerService.getCustomerById(customerId));
			if (0 < eticketOutRecordDAO.save(eticketOutRecord)) {
				final EticketOutRecord eticketOutRecord_sendMsg = eticketOutRecord;
				ThreadPoolUtil.getPool().execute(new Runnable() {
					@Override
					public void run() {
						try {
							WeChatUtil.getNewEticket(eticketOutRecord_sendMsg, weChatService.getWeChatList().get(0));
						} catch (Exception e) {
							logger_eticketOutRecordService.error("发送获得电子券模板消息出错，具体错误如下："
									+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
						}
					}
				});
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 自动发放注册类型电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 7, 2017
	 * @param customerId
	 *            客户Id
	 */
	public int sendEticketRegister(String customerId) {
		if (StringUtils.isBlank(customerId))
			return 0;
		Eticket eticket = eticketService.getAllAutoRegisterEticket();
		if (null != eticket && StringUtils.isNotBlank(eticket.getId())) {
			final String eticket_out_id = UUID.getUUID(), eticketOutCode = EticketCodeID.nextCode();
			this.saveEticketOutQRCodeImgFile(eticketOutCode);
			EticketOutRecord eticketOutRecord = new EticketOutRecord(eticket_out_id, new Date(), eticket,
					EticketOutRecord.STATUS_NORMAL, "注册成功自动发送", eticketOutCode,
					customerService.getCustomerById(customerId));
			if (0 < eticketOutRecordDAO.save(eticketOutRecord)) {
				final EticketOutRecord eticketOutRecord_sendMsg = eticketOutRecord;
				ThreadPoolUtil.getPool().execute(new Runnable() {
					@Override
					public void run() {
						try {
							WeChatUtil.getNewEticket(eticketOutRecord_sendMsg, weChatService.getWeChatList().get(0));
						} catch (Exception e) {
							logger_eticketOutRecordService.error("发送获得电子券模板消息出错，具体错误如下："
									+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
						}
					}
				});
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 自动发放生日类型电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 7, 2017
	 * @param customerId
	 *            客户Id
	 */
	public int sendEticketBirthday(String customerId) {
		if (StringUtils.isBlank(customerId))
			return 0;
		Eticket eticket = eticketService.getAllAutoBirthdayEticket();
		if (null != eticket && StringUtils.isNotBlank(eticket.getId())) {
			final String eticket_out_id = UUID.getUUID(), eticketOutCode = EticketCodeID.nextCode();
			this.saveEticketOutQRCodeImgFile(eticketOutCode);
			EticketOutRecord eticketOutRecord = new EticketOutRecord(eticket_out_id, new Date(), eticket,
					EticketOutRecord.STATUS_NORMAL, "生日当月自动发送", eticketOutCode,
					customerService.getCustomerById(customerId));
			if (0 < eticketOutRecordDAO.save(eticketOutRecord)) {
				final EticketOutRecord eticketOutRecord_sendMsg = eticketOutRecord;
				ThreadPoolUtil.getPool().execute(new Runnable() {
					@Override
					public void run() {
						try {
							WeChatUtil.getNewEticket(eticketOutRecord_sendMsg, weChatService.getWeChatList().get(0));
						} catch (Exception e) {
							logger_eticketOutRecordService.error("发送获得电子券模板消息出错，具体错误如下："
									+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
						}
					}
				});
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 自动发放充值类型电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 7, 2017
	 * @param customerId
	 *            客户Id
	 */
	public int sendEticketRecharge(String customerId) {
		if (StringUtils.isBlank(customerId))
			return 0;
		Eticket eticket = eticketService.getAllAutoRechargeEticket();
		if (null != eticket && StringUtils.isNotBlank(eticket.getId())) {
			final String eticket_out_id = UUID.getUUID(), eticketOutCode = EticketCodeID.nextCode();
			this.saveEticketOutQRCodeImgFile(eticketOutCode);
			EticketOutRecord eticketOutRecord = new EticketOutRecord(eticket_out_id, new Date(), eticket,
					EticketOutRecord.STATUS_NORMAL, "充值成功自动发送", eticketOutCode,
					customerService.getCustomerById(customerId));
			if (0 < eticketOutRecordDAO.save(eticketOutRecord)) {
				final EticketOutRecord eticketOutRecord_sendMsg = eticketOutRecord;
				ThreadPoolUtil.getPool().execute(new Runnable() {
					@Override
					public void run() {
						try {
							WeChatUtil.getNewEticket(eticketOutRecord_sendMsg, weChatService.getWeChatList().get(0));
						} catch (Exception e) {
							logger_eticketOutRecordService.error("发送获得电子券模板消息出错，具体错误如下："
									+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
						}
					}
				});
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 给所有未被拉黑的会员发送生日电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 7, 2017 void
	 */
	public void sendAllCustomerEticketBirthday() {
		List<Customer> customerList = customerService.getThisMonthBirthdayCustomerList();
		if (null != customerList && !customerList.isEmpty()) {
			for (Customer customer : customerList) {
				this.sendEticketBirthday(customer.getId());
			}
		}
	}

	/**
	 *
	 * <P>
	 * 保存电子券二维码图片
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 8, 2017
	 * @param etickrtOutCode
	 *            void
	 */
	private void saveEticketOutQRCodeImgFile(String etickrtOutCode) {
		String qrcodeSavePath = attachmentConfigService.getAttachmentConfigWithCode("qrcodeImg").getSaveDir()
				.replaceAll("\\\\", "/");
		if (!qrcodeSavePath.endsWith("/")) {
			qrcodeSavePath += "/";
		}
		qrcodeSavePath += "eticket/";
		File file = new File(qrcodeSavePath);
		if (!file.exists()) {
			file.mkdirs();
		}
		qrcodeSavePath += etickrtOutCode;
		try {
			QRCodeUtil.saveQRCode(etickrtOutCode, 100, 100, qrcodeSavePath);
		} catch (WriterException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 *
	 * <P>
	 * 依据电子券发放记录code获取电子券发放记录
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 8, 2017
	 * @param eticketOutCode
	 * @return EticketOutRecord
	 */
	public EticketOutRecord getEticketOutRecordByCode(String eticketOutCode) {
		return StringUtils.isNotBlank(eticketOutCode) ? eticketOutRecordDAO.getEticketOutRecordByCode(eticketOutCode)
				: null;
	}

	/**
	 *
	 * <P>
	 * 依据主订单ID获取可用电子券列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 8, 2017
	 * @param orderId
	 *            传入主订单ID
	 * @return List<EticketOutRecord>
	 */
	public List<EticketOutRecord> getEticketOutListWithOrderId(String orderId) {
		Order order = orderService.getOrderById(orderId);
		if (null == order.getOrder() || StringUtils.isBlank(order.getOrder().getId())) {
			if (null != order.getCustomer() && StringUtils.isNotBlank(order.getCustomer().getId())) {
				Order otherOrder = null;
				boolean isNeedGetEticketList = false;
				for (Order order_ : order.getOrderList()) {
					if ("otherOrder".equals(order_.getProType())) {
						isNeedGetEticketList = true;
						otherOrder = order_;
						break;
					}
				}
				if (isNeedGetEticketList) {
					List<EticketOutRecord> eticketOutRecordList = eticketOutRecordDAO.getCustomerToUseEticketList(order
							.getStore().getId(), otherOrder.getPayMoney(), order.getCustomer().getId());
					for (EticketOutRecord eticketOutRecord : eticketOutRecordList) {
						eticketOutRecord.setCustomer(null);
						Eticket eticket = new Eticket(eticketOutRecord.getEticket().getId());
						eticket.setUseLimit(eticketOutRecord.getEticket().getUseLimit());
						eticket.setPrice(eticketOutRecord.getEticket().getPrice());
						eticket.setType(eticketOutRecord.getEticket().getType());
						eticket.setOutType(eticketOutRecord.getEticket().getOutType());
						eticket.setOutStore(null);
						eticket.setUseStore(null);
						eticketOutRecord.setEticket(eticket);
					}

					return eticketOutRecordList;
				}
			}
		}
		return null;
	}

	/**
	 *
	 * <P>
	 * 取用户某种电子卷
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年1月29日
	 * @param customerId
	 * @param state
	 * @return int
	 */
	public List<EticketOutRecord> getAllByStateAndCustomerId(String customerId, String state) {
		return eticketOutRecordDAO.getAllByStateAndCustomerId(customerId, state);
	}
}
