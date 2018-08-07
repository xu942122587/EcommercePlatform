package com.unitever.module.rechargeRecord.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.joda.time.DateTime;
import org.joda.time.Minutes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.auth.user.model.User;
import com.unitever.module.backCash.model.BackCash;
import com.unitever.module.backCash.service.BackCashService;
import com.unitever.module.consume.dao.manual.ConsumeDAO;
import com.unitever.module.consume.model.Consume;
import com.unitever.module.consume.service.ConsumeService;
import com.unitever.module.customer.dao.manual.CustomerDAO;
import com.unitever.module.customer.model.Customer;
import com.unitever.module.rechargeRecord.dao.manual.RechargeRecordDAO;
import com.unitever.module.rechargeRecord.model.RechargeRecord;
import com.unitever.module.weChat.service.WeChatService;
import com.unitever.module.weChat.util.WeChatUtil;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.DoubleUtil;
import com.unitever.platform.util.ExceptionUtil;
import com.unitever.platform.util.ThreadPoolUtil;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.rechargeRecord.service->
 * RechargeRecordService.java
 * </p>
 * <P>
 * 充值返现比例
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月5日
 */
@Service
@Transactional
public class RechargeRecordService {

	@Autowired
	private RechargeRecordDAO rechargeRecordDAO;
	@Autowired
	private CustomerDAO customerDAO;
	@Autowired
	private ConsumeDAO consumeDAO;
	@Autowired
	private BackCashService backCashService;
	@Autowired
	private WeChatService weChatService;
	@Autowired
	private ConsumeService consumeService;

	private Logger logger_rechargeRecordService = LoggerFactory.getLogger("RechargeRecordService");

	/**
	 *
	 * <P>
	 * 保存新信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param rechargeRecord
	 * @return int
	 */
	public int save(RechargeRecord rechargeRecord) {
		if (rechargeRecord != null) {
			rechargeRecord.setId(UUID.getUUID());
			rechargeRecord.setCreateTime(new Date());
			int i = rechargeRecordDAO.save(rechargeRecord);
			if (0 < i) {
				return i;
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 更新数据
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param rechargeRecord
	 * @return int
	 */
	public int update(RechargeRecord rechargeRecord) {
		if (null != rechargeRecord) {
			if (StringUtils.isNotBlank(rechargeRecord.getId())) {
				int i = rechargeRecordDAO.update(rechargeRecord);
				if (0 < i) {
					return i;
				}
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 根据Id获取
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return RechargeRecord
	 */
	public RechargeRecord getRechargeRecordById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return rechargeRecordDAO.get(id);
		}
		return null;
	}

	/**
	 *
	 * <P>
	 * 根据Object获取
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param rechargeRecord
	 * @return List<RechargeRecord>
	 */
	public List<RechargeRecord> getRechargeRecordByRechargeRecord(RechargeRecord rechargeRecord) {
		return rechargeRecordDAO.getRechargeRecordByRechargeRecord(rechargeRecord);
	}

	/**
	 *
	 * <P>
	 * 获取符合当前条件的RechargeRecord数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param rechargeRecord
	 * @return int
	 */
	public int getCountByRechargeRecord(RechargeRecord rechargeRecord) {
		return rechargeRecordDAO.getCountByRechargeRecord(rechargeRecord);
	}

	/**
	 *
	 * <P>
	 * 获取所有提成比例
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @return List<RechargeRecord>
	 */
	public List<RechargeRecord> getAll() {
		return rechargeRecordDAO.getAll();
	}

	/**
	 *
	 * <P>
	 * 创建未完成充值记录对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @return RechargeRecord
	 */
	public RechargeRecord creatRechargeRecord(Customer customer, String rechargeMoney, User guideUser, String payType) {
		if (null != customer && StringUtils.isNotBlank(customer.getId()) && StringUtils.isNotBlank(rechargeMoney)
				&& 0 < DoubleUtil.compareTo(rechargeMoney, "0")) {
			String backCashValue = "0";
			BackCash backCash = backCashService.getBackCashByMoney(rechargeMoney);
			if (null != backCash && StringUtils.isNotBlank(backCash.getId())) {
				backCashValue = DoubleUtil.mul(DoubleUtil.div(backCash.getProportion(), "100").toString(),
						rechargeMoney, 2).toString();
			} else {
				backCashValue = "0";
			}
			RechargeRecord rechargeRecord = new RechargeRecord(UUID.getUUID(), guideUser, customer,
					RechargeRecord.STATE_TWO, rechargeMoney, backCashValue, payType, null, null, new Date());
			return rechargeRecord;
		} else {
			return null;
		}

	}

	/**
	 *
	 * <P>
	 * 获取RechargeRecord分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月9日
	 * @param page
	 * @param rechargeRecord
	 * @return Page<RechargeRecord>
	 */
	public Page<RechargeRecord> getPage(Page<RechargeRecord> page, RechargeRecord rechargeRecord) {
		if (StringUtils.isNotBlank(rechargeRecord.getEndDate())) {
			rechargeRecord.setEndDate(rechargeRecord.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(rechargeRecordDAO.getCountByObject(rechargeRecord));
		rechargeRecord.setStartOfPage(page.getStartOfPage());
		rechargeRecord.setPageSize(page.getPageSize());
		page.setResults(rechargeRecordDAO.getRechargeRecordByRechargeRecord(rechargeRecord));
		if (StringUtils.isNotBlank(rechargeRecord.getEndDate())) {
			rechargeRecord.setEndDate(rechargeRecord.getEndDate().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 充值完成更新
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param rechargeRecord
	 * @return int
	 */
	public int updatePay(RechargeRecord rechargeRecord) {
		return rechargeRecordDAO.updatePay(rechargeRecord);
	}

	/**
	 *
	 * <P>
	 * 充值单支付成功
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月9日
	 * @param id
	 * @param cashierUserId
	 * @param cashierCode
	 * @param payType
	 * @param payCode
	 *            void
	 */
	public void rechargePaySuccess(String id, String cashierUserId, String cashierCode, String payType, String payCode) {
		RechargeRecord rechargeRecord = this.getRechargeRecordById(id);
		rechargeRecord.setPayType(payType);
		rechargeRecord.setPayCode(payCode);
		if (0 >= rechargeRecordDAO.updatePay(rechargeRecord)) {
			throw new Error("充值已到帐,但保存失败!");
		} else {
			Consume rechargeConsume = new Consume(UUID.getUUID(), rechargeRecord.getCustomer(), null, null,
					Consume.TYPE_ONE_UP, rechargeRecord.getMoney(), "线上充值" + rechargeRecord.getMoney() + "元",
					new Date());
			if (StringUtils.isNotBlank(cashierUserId) || StringUtils.isNotBlank(rechargeRecord.getCashierCode())) {
				rechargeConsume.setType(Consume.TYPE_ONE_DOWN);
				rechargeConsume.setRemark("线下充值" + rechargeRecord.getMoney() + "元");
			}
			if (0 < DoubleUtil.compareTo(rechargeRecord.getBackCash(), "0")) {
				Consume backCashConsume = new Consume(UUID.getUUID(), rechargeRecord.getCustomer(), null, null,
						Consume.TYPE_TWO_IN, rechargeRecord.getBackCash(), "线上返现" + rechargeRecord.getBackCash() + "元",
						new Date());
				if (StringUtils.isNotBlank(cashierUserId) || StringUtils.isNotBlank(rechargeRecord.getCashierCode())) {
					backCashConsume.setRemark("线下返现" + rechargeRecord.getBackCash() + "元");
				}
				if (0 >= consumeDAO.save(rechargeConsume) || 0 >= consumeDAO.save(backCashConsume)) {
					throw new Error("充值已到帐,但保存失败!");
				} else {
					if (0 >= customerDAO
							.addTianheMoney(rechargeRecord.getCustomer().getId(), rechargeRecord.getMoney())
							|| 0 >= customerDAO.addTianheMoney(rechargeRecord.getCustomer().getId(),
									rechargeRecord.getBackCash())) {
						throw new Error("充值已到帐,但保存失败!");
					} else {
						final Customer customer1 = rechargeRecord.getCustomer();
						final RechargeRecord rechargeRecord1 = rechargeRecord;
						ThreadPoolUtil.getPool().execute(new Runnable() {
							@Override
							public void run() {
								try {
									WeChatUtil.sendCustomerWalletRecharge(customer1, rechargeRecord1, weChatService
											.getWeChatList().get(0));
								} catch (Exception e) {
									logger_rechargeRecordService.error("充值成功通知模板消息出错，具体错误如下："
											+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
								}
							}
						});
						if (0 < DoubleUtil.compareTo(rechargeRecord.getBackCash(), "0")) {
							final Customer customer2 = rechargeRecord.getCustomer();
							final RechargeRecord rechargeRecord2 = rechargeRecord;
							ThreadPoolUtil.getPool().execute(new Runnable() {
								@Override
								public void run() {
									try {
										WeChatUtil.sendCustomerBackCash(customer2, rechargeRecord2.getBackCash(),
												rechargeRecord2.getCreateTime(), weChatService.getWeChatList().get(0));
									} catch (Exception e) {
										logger_rechargeRecordService.error("充值返现成功通知模板消息出错，具体错误如下："
												+ ExceptionUtil
														.getExceptionAllinformation(e, this.getClass().getName()));
									}
								}
							});
						}
					}
				}
			} else {
				if (0 >= consumeDAO.save(rechargeConsume)) {
					throw new Error("充值已到帐,但保存失败!");
				} else {
					if (0 >= customerDAO
							.addTianheMoney(rechargeRecord.getCustomer().getId(), rechargeRecord.getMoney())) {
						throw new Error("充值已到帐,但保存失败!");
					} else {
						final Customer customer1 = rechargeRecord.getCustomer();
						final RechargeRecord rechargeRecord1 = rechargeRecord;
						ThreadPoolUtil.getPool().execute(new Runnable() {

							@Override
							public void run() {
								try {
									WeChatUtil.sendCustomerWalletRecharge(customer1, rechargeRecord1, weChatService
											.getWeChatList().get(0));
								} catch (Exception e) {
									logger_rechargeRecordService.error("充值成功通知模板消息出错，具体错误如下："
											+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
								}
							}

						});
					}
				}
			}
		}
	}

	/**
	 *
	 * <P>
	 * 创建线下充值预定单
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 10, 2017
	 * @param customerId
	 *            充值客户ID
	 * @param money
	 *            充值金额
	 * @param cashierUserId
	 *            收银ID
	 * @param cashierCode
	 *            款台号
	 * @param rechargeCode
	 *            充值动态密码
	 * @param payType
	 *            支付方式
	 * @return AjaxJson
	 */
	public AjaxJson createOffLineRechargeRecord(String customerId, String money, String cashierUserId,
			String cashierCode, String rechargeCode, String payType) {
		AjaxJson ajaxJson = new AjaxJson();
		Customer customer = customerDAO.get(customerId);
		if (null == customer || StringUtils.isBlank(customer.getId())) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("客户信息不存在，请重试~");
			return ajaxJson;
		}

		if (!rechargeCode.equals(customer.getPayCode())) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("支付动态密码错误，请重试！");
			return ajaxJson;
		}
		DateTime before = new DateTime(customer.getPayCodeCreateTime().getTime());
		DateTime now = new DateTime(new Date().getTime());
		int minute = Minutes.minutesBetween(before, now).getMinutes();
		if (minute > 10) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("支付动态密码过期失效，请重新获取！");
			return ajaxJson;
		}

		RechargeRecord rechargeRecord = this.creatRechargeRecord(customer, money, null, payType);
		rechargeRecord.setCashierCode(cashierCode);
		rechargeRecord.setCashierUser(new User(cashierUserId));
		if (0 < rechargeRecordDAO.save(rechargeRecord)) {
			if (RechargeRecord.PAYTYPE_ONE.equals(payType) || RechargeRecord.PAYTYPE_TWO.equals(payType)) {
				this.rechargePaySuccess(rechargeRecord.getId(), cashierUserId, cashierCode, payType, null);
			}
			ajaxJson.setSuccess(true);
			ajaxJson.setObj(rechargeRecord.getId());
		} else {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("生成充值预定单失败~");
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 根据导购获取上月的充值总金额
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param rechargeRecord
	 * @return List<RechargeRecord>
	 */
	public String getRechargeRecordByGuideUserInLastMonth(String guideUserId) {
		return rechargeRecordDAO.getRechargeRecordByGuideUserInLastMonth(guideUserId);
	}

}
