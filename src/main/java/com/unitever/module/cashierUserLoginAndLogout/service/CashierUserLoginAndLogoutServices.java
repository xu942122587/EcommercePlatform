/**
 *
 * <P> CashierUserLoginAndLogoutServices.java </p>
 *
 * @author 闫枫
 * @date Sep 17, 2017
 */
package com.unitever.module.cashierUserLoginAndLogout.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.cashierUserLoginAndLogout.dao.manual.CashierUserLoginAndLogoutDAO;
import com.unitever.module.cashierUserLoginAndLogout.model.CashierUserLoginAndLogout;
import com.unitever.module.order.dao.manual.OrderDAO;
import com.unitever.module.rechargeRecord.dao.manual.RechargeRecordDAO;
import com.unitever.module.rechargeRecord.model.RechargeRecord;
import com.unitever.module.store.model.Store;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.DateUtil;
import com.unitever.platform.util.DoubleUtil;
import com.unitever.platform.util.ExceptionUtil;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.cashierUserLoginAndLogout.service->
 * CashierUserLoginAndLogoutServices.java
 * </p>
 * <P>
 * 获取交接班信息
 * </p>
 *
 * @author 闫枫
 * @date Sep 17, 2017
 */
@Service
@Transactional
public class CashierUserLoginAndLogoutServices {
	private Logger logger_cashierUserLoginAndLogoutServices = LoggerFactory
			.getLogger("CashierUserLoginAndLogoutServices");
	@Autowired
	private OrderDAO orderDAO;
	@Autowired
	private RechargeRecordDAO rechargeRecordDAO;
	@Autowired
	private CashierUserLoginAndLogoutDAO cashierUserLoginAndLogoutDAO;

	/**
	 *
	 * <P>
	 * 保存交接班-登录信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 18, 2017
	 * @param cashierUserLoginAndLogout
	 * @return int
	 */
	public int save(CashierUserLoginAndLogout cashierUserLoginAndLogout) {
		if (null == cashierUserLoginAndLogout)
			return 0;
		cashierUserLoginAndLogout.setId(UUID.getUUID());
		cashierUserLoginAndLogout.setCreateTime(new Date());
		cashierUserLoginAndLogout.setLoginTime(new Date());
		cashierUserLoginAndLogout.setState(CashierUserLoginAndLogout.STATE_ONE);
		return cashierUserLoginAndLogoutDAO.save(cashierUserLoginAndLogout);
	}

	/**
	 *
	 * <P>
	 * 依据收银ID获取未交班记录
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 18, 2017
	 * @param cashierUser_id
	 * @return CashierUserLoginAndLogout
	 */
	public CashierUserLoginAndLogout getNoLogoutMsgByCashierUserId(String cashierUser_id) {
		return StringUtils.isBlank(cashierUser_id) ? null
				: cashierUserLoginAndLogoutDAO.getNoLogoutMsgByCashierUserId(cashierUser_id);
	}

	/**
	 *
	 * <P>
	 * 获取交接班信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 17, 2017
	 * @param cashierUser_id
	 * @param loginTime
	 * @return AjaxJson
	 */
	public AjaxJson getSubmitMoneyMsg(String cashierUser_id) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			if (StringUtils.isBlank(cashierUser_id)) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("拉取交接班数据失败，请联系技术人员");
				return ajaxJson;
			}
			CashierUserLoginAndLogout cashierUserLoginAndLogout = this.getNoLogoutMsgByCashierUserId(cashierUser_id);
			if (null != cashierUserLoginAndLogout && StringUtils.isNotBlank(cashierUserLoginAndLogout.getId())) {
				Date logoutTime = new Date();
				Map<String, Object> map_to_return = this.getSubmitMoneyMsgMap(cashierUser_id,
						cashierUserLoginAndLogout.getLoginTime(), logoutTime);

				if (null == map_to_return) {
					map_to_return = new HashMap<>();
					map_to_return.put("loginTime",
							DateUtil.getDateSecondString(cashierUserLoginAndLogout.getLoginTime()));
					map_to_return.put("logoutTime", DateUtil.getDateSecondString(logoutTime));
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("NoGetMoney");
					ajaxJson.setObj(map_to_return);
				} else {
					map_to_return.put("loginTime",
							DateUtil.getDateSecondString(cashierUserLoginAndLogout.getLoginTime()));
					map_to_return.put("logoutTime", DateUtil.getDateSecondString(logoutTime));
					ajaxJson.setSuccess(true);
					ajaxJson.setMsg("HaveGetMoney");
					ajaxJson.setObj(map_to_return);
				}
				cashierUserLoginAndLogout.setLogoutTime(logoutTime);
				cashierUserLoginAndLogout.setState(CashierUserLoginAndLogout.STATE_TWO);
				if (0 >= cashierUserLoginAndLogoutDAO.update(cashierUserLoginAndLogout)) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("交接班失败，请稍后重试~");
				}
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("当前无可交班信息或交班已完成~");
			}
		} catch (Exception e) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("拉取交班数据失败，请重试");
			logger_cashierUserLoginAndLogoutServices
					.error("拉取交班数据出错，具体错误如下：" + ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 获取交接班明细数据
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 17, 2017
	 * @param cashierUser_id
	 *            收银用户ID
	 * @param loginTime
	 *            登录时间
	 * @param logoutTime
	 *            退出时间
	 * @return Object
	 */
	public Map<String, Object> getSubmitMoneyMsgMap(String cashierUser_id, Date loginTime, Date logoutTime) {

		if (StringUtils.isBlank(cashierUser_id) || null == loginTime || null == logoutTime) {
			return null;
		}

		Map<String, Map<String, Object>> rechargeCountMap = rechargeRecordDAO.getRechargeCountMap(cashierUser_id,
				DateUtil.getDateSecondString(loginTime), DateUtil.getDateSecondString(logoutTime));
		Map<String, Map<String, Object>> moneyPayOnyCountMap = orderDAO.getMoneyPayOnyCountMap(cashierUser_id,
				DateUtil.getDateSecondString(loginTime), DateUtil.getDateSecondString(logoutTime));
		Map<String, Map<String, Object>> moneyPayTwoCountMap = orderDAO.getMoneyPayTwoCountMap(cashierUser_id,
				DateUtil.getDateSecondString(loginTime), DateUtil.getDateSecondString(logoutTime));
		Map<String, Map<String, Object>> cardPayOnyCountMap = orderDAO.getCardPayOnyCountMap(cashierUser_id,
				DateUtil.getDateSecondString(loginTime), DateUtil.getDateSecondString(logoutTime));
		Map<String, Map<String, Object>> cardPayTwoCountMap = orderDAO.getCardPayTwoCountMap(cashierUser_id,
				DateUtil.getDateSecondString(loginTime), DateUtil.getDateSecondString(logoutTime));
		Map<String, Map<String, Object>> weChatPayOnyCountMap = orderDAO.getWeChatPayOnyCountMap(cashierUser_id,
				DateUtil.getDateSecondString(loginTime), DateUtil.getDateSecondString(logoutTime));
		Map<String, Map<String, Object>> weChatPayTwoCountMap = orderDAO.getWeChatPayTwoCountMap(cashierUser_id,
				DateUtil.getDateSecondString(loginTime), DateUtil.getDateSecondString(logoutTime));
		Map<String, Map<String, Object>> aliPayOnyCountMap = orderDAO.getAliPayOnyCountMap(cashierUser_id,
				DateUtil.getDateSecondString(loginTime), DateUtil.getDateSecondString(logoutTime));
		Map<String, Map<String, Object>> aliPayTwoCountMap = orderDAO.getAliPayTwoCountMap(cashierUser_id,
				DateUtil.getDateSecondString(loginTime), DateUtil.getDateSecondString(logoutTime));
		Map<String, Map<String, Object>> tianhePayOnyCountMap = orderDAO.getTianhePayOnyCountMap(cashierUser_id,
				DateUtil.getDateSecondString(loginTime), DateUtil.getDateSecondString(logoutTime));
		Map<String, Map<String, Object>> tianhePayTwoCountMap = orderDAO.getTianhePayTwoCountMap(cashierUser_id,
				DateUtil.getDateSecondString(loginTime), DateUtil.getDateSecondString(logoutTime));
		Map<String, Map<String, Object>> dingjinCountMap = orderDAO.getDingjinCountMap(cashierUser_id,
				DateUtil.getDateSecondString(loginTime), DateUtil.getDateSecondString(logoutTime));
		Map<String, Map<String, Object>> weikuanCountMap = orderDAO.getWeikuanCountMap(cashierUser_id,
				DateUtil.getDateSecondString(loginTime), DateUtil.getDateSecondString(logoutTime));
		Map<String, Map<String, Object>> returnMoneyCountMap = orderDAO.getReturnMoneyCountMap(cashierUser_id,
				DateUtil.getDateSecondString(loginTime), DateUtil.getDateSecondString(logoutTime));
		List<String> storeCodeList = orderDAO.getStoreCodeList(cashierUser_id, DateUtil.getDateSecondString(loginTime),
				DateUtil.getDateSecondString(logoutTime));

		Map<String, String> map_recharge = new HashMap<>();
		List<Map<String, String>> map_tianheStore = new ArrayList<>();
		List<Map<String, String>> map_noTianheStore = new ArrayList<>();
		List<Map<String, String>> map_otherStore = new ArrayList<>();
		Map<String, String> huizongMap = new HashMap<>();

		String submitMoneyMsg_sumMoney = "0.0", // 总金额
				all_money = "0.0", // 现金收入总和
				all_card = "0.0", // 银行卡收入总和
				all_weChat = "0.0", // 微信支付收入总和
				all_aliPay = "0.0", // 支付宝支付收入总和
				all_tianhe = "0.0", // 余额支付收入总和
				all_recharge = "0.0", // 充值收入总和
				all_otherGoods = "0.0", // 小商品收入总和
				all_returnMoney = "0.0";// 退款金额总和
		int submitMoneyMsg_Number = 0, // 总单数
				all_money_number = 0, // 现金结算单数（正常订单）
				all_card_number = 0, // 银行卡结算单数（正常订单）
				all_weChat_number = 0, // 微信结算单数（正常订单）
				all_aliPay_number = 0, // 支付宝结算单数（正常订单）
				all_tianhe_number = 0, // 余额结算单数（正常订单）
				all_recharge_number = 0, // 充值单数
				all_otherGoods_number = 0, // 小商品单数
				all_returnMoney_number = 0;// 退款单数

		if ((null == storeCodeList || storeCodeList.isEmpty())
				&& (null == rechargeCountMap || rechargeCountMap.isEmpty())) {
			return null;
		} else {
			// 门店订单明细及统计整合--start
			if (null != storeCodeList && !storeCodeList.isEmpty()) {
				for (String storeCode : storeCodeList) {
					String storeType = null, storeName = null, storeMoneyAll = "0.0", storeMoneyPay = "0.0",
							storeCardPay = "0.0", storeWeChatPay = "0.0", storeAliPay = "0.0", storeTianhePay = "0.0",
							storeDingjin = "0.0", storeWeikuan = "0.0", storeReturnMoney = "0.0";
					int storeNumber = 0, storeReturnNumber = 0;
					Map<String, String> storeMap = new HashMap<>();
					if (moneyPayOnyCountMap.containsKey(storeCode)) {// 首次现金
						int orderNumber = Integer
								.parseInt(String.valueOf(moneyPayOnyCountMap.get(storeCode).get("orderNumber")));
						String orderMoney = String.valueOf(moneyPayOnyCountMap.get(storeCode).get("oneGetMonet"));

						storeType = String.valueOf(moneyPayOnyCountMap.get(storeCode).get("storeType"));
						storeName = String.valueOf(moneyPayOnyCountMap.get(storeCode).get("storeName"));

						submitMoneyMsg_Number += orderNumber;
						submitMoneyMsg_sumMoney = DoubleUtil.add(submitMoneyMsg_sumMoney, orderMoney).toString();

						if (Store.TYPE_THREE.equals(storeType)) {
							all_otherGoods_number += orderNumber;
							all_otherGoods = DoubleUtil.add(all_otherGoods, orderMoney).toString();
						} else {
							all_money_number += orderNumber;
							all_money = DoubleUtil.add(all_money, orderMoney).toString();
						}

						storeNumber += orderNumber;
						storeMoneyAll = DoubleUtil.add(storeMoneyAll, orderMoney).toString();
						storeMoneyPay = DoubleUtil.add(storeMoneyPay, orderMoney).toString();
					}
					if (moneyPayTwoCountMap.containsKey(storeCode)) {// 二次现金
						int orderNumber = Integer
								.parseInt(String.valueOf(moneyPayTwoCountMap.get(storeCode).get("orderNumber")));
						String orderMoney = String.valueOf(moneyPayTwoCountMap.get(storeCode).get("twoGetMoney"));

						storeType = String.valueOf(moneyPayTwoCountMap.get(storeCode).get("storeType"));
						storeName = String.valueOf(moneyPayTwoCountMap.get(storeCode).get("storeName"));

						submitMoneyMsg_Number += orderNumber;
						submitMoneyMsg_sumMoney = DoubleUtil.add(submitMoneyMsg_sumMoney, orderMoney).toString();

						if (Store.TYPE_THREE.equals(storeType)) {
							all_otherGoods_number += orderNumber;
							all_otherGoods = DoubleUtil.add(all_otherGoods, orderMoney).toString();
						} else {
							all_money_number += orderNumber;
							all_money = DoubleUtil.add(all_money, orderMoney).toString();
						}

						storeNumber += orderNumber;
						storeMoneyAll = DoubleUtil.add(storeMoneyAll, orderMoney).toString();
						storeMoneyPay = DoubleUtil.add(storeMoneyPay, orderMoney).toString();
					}

					if (cardPayOnyCountMap.containsKey(storeCode)) {// 首次银行卡
						int orderNumber = Integer
								.parseInt(String.valueOf(cardPayOnyCountMap.get(storeCode).get("orderNumber")));
						String orderMoney = String.valueOf(cardPayOnyCountMap.get(storeCode).get("oneGetMonet"));

						storeType = String.valueOf(cardPayOnyCountMap.get(storeCode).get("storeType"));
						storeName = String.valueOf(cardPayOnyCountMap.get(storeCode).get("storeName"));

						submitMoneyMsg_Number += orderNumber;
						submitMoneyMsg_sumMoney = DoubleUtil.add(submitMoneyMsg_sumMoney, orderMoney).toString();

						if (Store.TYPE_THREE.equals(storeType)) {
							all_otherGoods_number += orderNumber;
							all_otherGoods = DoubleUtil.add(all_otherGoods, orderMoney).toString();
						} else {
							all_card_number += orderNumber;
							all_card = DoubleUtil.add(all_card, orderMoney).toString();
						}

						storeNumber += orderNumber;
						storeMoneyAll = DoubleUtil.add(storeMoneyAll, orderMoney).toString();
						storeCardPay = DoubleUtil.add(storeCardPay, orderMoney).toString();
					}
					if (cardPayTwoCountMap.containsKey(storeCode)) {// 二次银行卡
						int orderNumber = Integer
								.parseInt(String.valueOf(cardPayTwoCountMap.get(storeCode).get("orderNumber")));
						String orderMoney = String.valueOf(cardPayTwoCountMap.get(storeCode).get("twoGetMoney"));

						storeType = String.valueOf(cardPayTwoCountMap.get(storeCode).get("storeType"));
						storeName = String.valueOf(cardPayTwoCountMap.get(storeCode).get("storeName"));

						submitMoneyMsg_Number += orderNumber;
						submitMoneyMsg_sumMoney = DoubleUtil.add(submitMoneyMsg_sumMoney, orderMoney).toString();

						if (Store.TYPE_THREE.equals(storeType)) {
							all_otherGoods_number += orderNumber;
							all_otherGoods = DoubleUtil.add(all_otherGoods, orderMoney).toString();
						} else {
							all_card_number += orderNumber;
							all_card = DoubleUtil.add(all_card, orderMoney).toString();
						}

						storeNumber += orderNumber;
						storeMoneyAll = DoubleUtil.add(storeMoneyAll, orderMoney).toString();
						storeCardPay = DoubleUtil.add(storeCardPay, orderMoney).toString();
					}

					if (weChatPayOnyCountMap.containsKey(storeCode)) {// 首次微信
						int orderNumber = Integer
								.parseInt(String.valueOf(weChatPayOnyCountMap.get(storeCode).get("orderNumber")));
						String orderMoney = String.valueOf(weChatPayOnyCountMap.get(storeCode).get("onePayMoney"));

						storeType = String.valueOf(weChatPayOnyCountMap.get(storeCode).get("storeType"));
						storeName = String.valueOf(weChatPayOnyCountMap.get(storeCode).get("storeName"));

						submitMoneyMsg_Number += orderNumber;
						submitMoneyMsg_sumMoney = DoubleUtil.add(submitMoneyMsg_sumMoney, orderMoney).toString();

						if (Store.TYPE_THREE.equals(storeType)) {
							all_otherGoods_number += orderNumber;
							all_otherGoods = DoubleUtil.add(all_otherGoods, orderMoney).toString();
						} else {
							all_weChat_number += orderNumber;
							all_weChat = DoubleUtil.add(all_weChat, orderMoney).toString();
						}

						storeNumber += orderNumber;
						storeMoneyAll = DoubleUtil.add(storeMoneyAll, orderMoney).toString();
						storeWeChatPay = DoubleUtil.add(storeWeChatPay, orderMoney).toString();
					}
					if (weChatPayTwoCountMap.containsKey(storeCode)) {// 二次微信
						int orderNumber = Integer
								.parseInt(String.valueOf(weChatPayTwoCountMap.get(storeCode).get("orderNumber")));
						String orderMoney = String.valueOf(weChatPayTwoCountMap.get(storeCode).get("twoPayMoney"));

						storeType = String.valueOf(weChatPayTwoCountMap.get(storeCode).get("storeType"));
						storeName = String.valueOf(weChatPayTwoCountMap.get(storeCode).get("storeName"));

						submitMoneyMsg_Number += orderNumber;
						submitMoneyMsg_sumMoney = DoubleUtil.add(submitMoneyMsg_sumMoney, orderMoney).toString();

						if (Store.TYPE_THREE.equals(storeType)) {
							all_otherGoods_number += orderNumber;
							all_otherGoods = DoubleUtil.add(all_otherGoods, orderMoney).toString();
						} else {
							all_weChat_number += orderNumber;
							all_weChat = DoubleUtil.add(all_weChat, orderMoney).toString();
						}

						storeNumber += orderNumber;
						storeMoneyAll = DoubleUtil.add(storeMoneyAll, orderMoney).toString();
						storeWeChatPay = DoubleUtil.add(storeWeChatPay, orderMoney).toString();
					}

					if (aliPayOnyCountMap.containsKey(storeCode)) {// 首次支付宝
						int orderNumber = Integer
								.parseInt(String.valueOf(aliPayOnyCountMap.get(storeCode).get("orderNumber")));
						String orderMoney = String.valueOf(aliPayOnyCountMap.get(storeCode).get("onePayMoney"));

						storeType = String.valueOf(aliPayOnyCountMap.get(storeCode).get("storeType"));
						storeName = String.valueOf(aliPayOnyCountMap.get(storeCode).get("storeName"));

						submitMoneyMsg_Number += orderNumber;
						submitMoneyMsg_sumMoney = DoubleUtil.add(submitMoneyMsg_sumMoney, orderMoney).toString();

						if (Store.TYPE_THREE.equals(storeType)) {
							all_otherGoods_number += orderNumber;
							all_otherGoods = DoubleUtil.add(all_otherGoods, orderMoney).toString();
						} else {
							all_aliPay_number += orderNumber;
							all_aliPay = DoubleUtil.add(all_aliPay, orderMoney).toString();
						}

						storeNumber += orderNumber;
						storeMoneyAll = DoubleUtil.add(storeMoneyAll, orderMoney).toString();
						storeAliPay = DoubleUtil.add(storeAliPay, orderMoney).toString();
					}
					if (aliPayTwoCountMap.containsKey(storeCode)) {// 二次支付宝
						int orderNumber = Integer
								.parseInt(String.valueOf(aliPayTwoCountMap.get(storeCode).get("orderNumber")));
						String orderMoney = String.valueOf(aliPayTwoCountMap.get(storeCode).get("twoPayMoney"));

						storeType = String.valueOf(aliPayTwoCountMap.get(storeCode).get("storeType"));
						storeName = String.valueOf(aliPayTwoCountMap.get(storeCode).get("storeName"));

						submitMoneyMsg_Number += orderNumber;
						submitMoneyMsg_sumMoney = DoubleUtil.add(submitMoneyMsg_sumMoney, orderMoney).toString();

						if (Store.TYPE_THREE.equals(storeType)) {
							all_otherGoods_number += orderNumber;
							all_otherGoods = DoubleUtil.add(all_otherGoods, orderMoney).toString();
						} else {
							all_aliPay_number += orderNumber;
							all_aliPay = DoubleUtil.add(all_aliPay, orderMoney).toString();
						}

						storeNumber += orderNumber;
						storeMoneyAll = DoubleUtil.add(storeMoneyAll, orderMoney).toString();
						storeAliPay = DoubleUtil.add(storeAliPay, orderMoney).toString();
					}

					if (tianhePayOnyCountMap.containsKey(storeCode)) {// 首次天和钱包
						int orderNumber = Integer
								.parseInt(String.valueOf(tianhePayOnyCountMap.get(storeCode).get("orderNumber")));
						String orderMoney = String.valueOf(tianhePayOnyCountMap.get(storeCode).get("onePayMoney"));

						storeType = String.valueOf(tianhePayOnyCountMap.get(storeCode).get("storeType"));
						storeName = String.valueOf(tianhePayOnyCountMap.get(storeCode).get("storeName"));

						submitMoneyMsg_Number += orderNumber;
						submitMoneyMsg_sumMoney = DoubleUtil.add(submitMoneyMsg_sumMoney, orderMoney).toString();

						if (Store.TYPE_THREE.equals(storeType)) {
							all_otherGoods_number += orderNumber;
							all_otherGoods = DoubleUtil.add(all_otherGoods, orderMoney).toString();
						} else {
							all_tianhe_number += orderNumber;
							all_tianhe = DoubleUtil.add(all_tianhe, orderMoney).toString();
						}

						storeNumber += orderNumber;
						storeMoneyAll = DoubleUtil.add(storeMoneyAll, orderMoney).toString();
						storeTianhePay = DoubleUtil.add(storeTianhePay, orderMoney).toString();
					}
					if (tianhePayTwoCountMap.containsKey(storeCode)) {// 二次天和钱包
						int orderNumber = Integer
								.parseInt(String.valueOf(tianhePayTwoCountMap.get(storeCode).get("orderNumber")));
						String orderMoney = String.valueOf(tianhePayTwoCountMap.get(storeCode).get("twoPayMoney"));

						storeType = String.valueOf(tianhePayTwoCountMap.get(storeCode).get("storeType"));
						storeName = String.valueOf(tianhePayTwoCountMap.get(storeCode).get("storeName"));

						submitMoneyMsg_Number += orderNumber;
						submitMoneyMsg_sumMoney = DoubleUtil.add(submitMoneyMsg_sumMoney, orderMoney).toString();

						if (Store.TYPE_THREE.equals(storeType)) {
							all_otherGoods_number += orderNumber;
							all_otherGoods = DoubleUtil.add(all_otherGoods, orderMoney).toString();
						} else {
							all_tianhe_number += orderNumber;
							all_tianhe = DoubleUtil.add(all_tianhe, orderMoney).toString();
						}

						storeNumber += orderNumber;
						storeMoneyAll = DoubleUtil.add(storeMoneyAll, orderMoney).toString();
						storeTianhePay = DoubleUtil.add(storeTianhePay, orderMoney).toString();
					}

					if (dingjinCountMap.containsKey(storeCode)) {// 定金
						String orderMoney = String.valueOf(dingjinCountMap.get(storeCode).get("onePayMoney"));

						storeType = String.valueOf(dingjinCountMap.get(storeCode).get("storeType"));
						storeName = String.valueOf(dingjinCountMap.get(storeCode).get("storeName"));

						storeDingjin = DoubleUtil.add(storeDingjin, orderMoney).toString();
					}

					if (weikuanCountMap.containsKey(storeCode)) {// 尾款
						String orderMoney = String.valueOf(weikuanCountMap.get(storeCode).get("twoPayMoney"));

						storeType = String.valueOf(weikuanCountMap.get(storeCode).get("storeType"));
						storeName = String.valueOf(weikuanCountMap.get(storeCode).get("storeName"));

						storeWeikuan = DoubleUtil.add(storeWeikuan, orderMoney).toString();
					}

					if (returnMoneyCountMap.containsKey(storeCode)) {// 退款
						int orderNumber = Integer
								.parseInt(String.valueOf(returnMoneyCountMap.get(storeCode).get("orderNumber")));
						String orderMoney = String.valueOf(returnMoneyCountMap.get(storeCode).get("onePayMoney"));

						storeType = String.valueOf(returnMoneyCountMap.get(storeCode).get("storeType"));
						storeName = String.valueOf(returnMoneyCountMap.get(storeCode).get("storeName"));

						submitMoneyMsg_Number += orderNumber;
						submitMoneyMsg_sumMoney = DoubleUtil.add(submitMoneyMsg_sumMoney, orderMoney).toString();

						all_returnMoney_number += orderNumber;
						all_returnMoney = DoubleUtil.add(all_returnMoney, orderMoney).toString();

						storeNumber += orderNumber;
						storeReturnNumber += orderNumber;
						storeMoneyAll = DoubleUtil.add(storeMoneyAll, orderMoney).toString();
						storeReturnMoney = DoubleUtil.add(storeReturnMoney, orderMoney).toString();
					}

					if (StringUtils.isNotBlank(storeType)) {
						storeMap.put("storeCode", storeCode);
						storeMap.put("storeName", storeName);
						storeMap.put("storeMoneyAll", storeMoneyAll);
						storeMap.put("storeMoneyPay", storeMoneyPay);
						storeMap.put("storeCardPay", storeCardPay);
						storeMap.put("storeWeChatPay", storeWeChatPay);
						storeMap.put("storeAliPay", storeAliPay);
						storeMap.put("storeTianhePay", storeTianhePay);
						storeMap.put("storeDingjin", storeDingjin);
						storeMap.put("storeWeikuan", storeWeikuan);
						storeMap.put("storeReturnMoney", storeReturnMoney);
						storeMap.put("storeNumber", storeNumber + "");
						storeMap.put("storeReturnNumber", storeReturnNumber + "");
						switch (storeType) {
						case Store.TYPE_ONE:
							map_tianheStore.add(storeMap);
							break;
						case Store.TYPE_TWO:
							map_noTianheStore.add(storeMap);
							break;
						case Store.TYPE_THREE:
							map_otherStore.add(storeMap);
							break;
						default:
							break;
						}
					}
				}
			}
			// 门店订单明细及统计整合--end

			// 充值明细和统计整合--start
			if (null != rechargeCountMap && !rechargeCountMap.isEmpty()) {
				for (Map.Entry<String, Map<String, Object>> empty : rechargeCountMap.entrySet()) {
					submitMoneyMsg_Number += Integer.parseInt(String.valueOf(empty.getValue().get("number")));
					submitMoneyMsg_sumMoney = DoubleUtil
							.add(submitMoneyMsg_sumMoney, String.valueOf(empty.getValue().get("money"))).toString();
					all_recharge_number += Integer.parseInt(String.valueOf(empty.getValue().get("number")));
					all_recharge = DoubleUtil.add(all_recharge, String.valueOf(empty.getValue().get("money")))
							.toString();

					if (map_recharge.containsKey("number")) {
						map_recharge
								.put("number",
										(Integer.parseInt(map_recharge.get("number"))
												+ Integer.parseInt(String.valueOf(empty.getValue().get("number"))))
												+ "");
					} else {
						map_recharge.put("number", String.valueOf(empty.getValue().get("number")));
					}

					if (map_recharge.containsKey("sumMoney")) {
						map_recharge.put("sumMoney", DoubleUtil
								.add(map_recharge.get("sumMoney"), String.valueOf(empty.getValue().get("money")))
								.toString());
					} else {
						map_recharge.put("sumMoney", String.valueOf(empty.getValue().get("money")));
					}

					switch (empty.getKey()) {
					case (RechargeRecord.PAYTYPE_ONE):
						if (map_recharge.containsKey("money")) {
							map_recharge.put("money", DoubleUtil
									.add(map_recharge.get("money"), String.valueOf(empty.getValue().get("money")))
									.toString());
						} else {
							map_recharge.put("money", String.valueOf(empty.getValue().get("money")));
						}
						break;
					case (RechargeRecord.PAYTYPE_TWO):
						if (map_recharge.containsKey("card")) {
							map_recharge.put("card", DoubleUtil
									.add(map_recharge.get("card"), String.valueOf(empty.getValue().get("money")))
									.toString());
						} else {
							map_recharge.put("card", String.valueOf(empty.getValue().get("money")));
						}
						break;
					case (RechargeRecord.PAYTYPE_THREE):
						if (map_recharge.containsKey("weChatPay")) {
							map_recharge.put("weChatPay", DoubleUtil
									.add(map_recharge.get("weChatPay"), String.valueOf(empty.getValue().get("money")))
									.toString());
						} else {
							map_recharge.put("weChatPay", String.valueOf(empty.getValue().get("money")));
						}
						break;
					case (RechargeRecord.PAYTYPE_FOUR):
						if (map_recharge.containsKey("aliPay")) {
							map_recharge.put("aliPay", DoubleUtil
									.add(map_recharge.get("aliPay"), String.valueOf(empty.getValue().get("money")))
									.toString());
						} else {
							map_recharge.put("aliPay", String.valueOf(empty.getValue().get("money")));
						}
						break;
					default:
						break;
					}
				}
			}
			// 充值明细和统计整合--end

			huizongMap.put("submitMoneyMsg_sumMoney", DoubleUtil.toDecimalString(submitMoneyMsg_sumMoney, 2));
			huizongMap.put("all_money", DoubleUtil.toDecimalString(all_money, 2));
			huizongMap.put("all_card", DoubleUtil.toDecimalString(all_card, 2));
			huizongMap.put("all_weChat", DoubleUtil.toDecimalString(all_weChat, 2));
			huizongMap.put("all_aliPay", DoubleUtil.toDecimalString(all_aliPay, 2));
			huizongMap.put("all_tianhe", DoubleUtil.toDecimalString(all_tianhe, 2));
			huizongMap.put("all_recharge", DoubleUtil.toDecimalString(all_recharge, 2));
			huizongMap.put("all_otherGoods", DoubleUtil.toDecimalString(all_otherGoods, 2));
			huizongMap.put("all_returnMoney", DoubleUtil.toDecimalString(all_returnMoney, 2));
			huizongMap.put("submitMoneyMsg_Number", submitMoneyMsg_Number + "");
			huizongMap.put("all_money_number", all_money_number + "");
			huizongMap.put("all_card_number", all_card_number + "");
			huizongMap.put("all_weChat_number", all_weChat_number + "");
			huizongMap.put("all_aliPay_number", all_aliPay_number + "");
			huizongMap.put("all_tianhe_number", all_tianhe_number + "");
			huizongMap.put("all_recharge_number", all_recharge_number + "");
			huizongMap.put("all_otherGoods_number", all_otherGoods_number + "");
			huizongMap.put("all_returnMoney_number", all_returnMoney_number + "");

			Map<String, Object> map_toReturn = new HashMap<>();
			map_toReturn.put("map_recharge", map_recharge);
			map_toReturn.put("map_tianheStore", map_tianheStore);
			map_toReturn.put("map_noTianheStore", map_noTianheStore);
			map_toReturn.put("map_otherStore", map_otherStore);
			map_toReturn.put("huizongMap", huizongMap);
			return map_toReturn;
		}
	}

	/**
	 *
	 * <P>
	 * 依据交接班ID获取交接班数据
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 18, 2017
	 * @param id
	 * @return Object
	 */
	public CashierUserLoginAndLogout getLogoutById(String id) {
		return StringUtils.isBlank(id) ? null : cashierUserLoginAndLogoutDAO.get(id);
	}

	/**
	 *
	 * <P>
	 * 获取cashierUserLoginAndLogout分页对象
	 * </p>
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param page
	 * @param store
	 * @return Page<CashierUserLoginAndLogout>
	 */
	public Page<CashierUserLoginAndLogout> getPage(Page<CashierUserLoginAndLogout> page,
			CashierUserLoginAndLogout cashierUserLoginAndLogout) {
		if (StringUtils.isNotBlank(cashierUserLoginAndLogout.getEndDate())) {
			cashierUserLoginAndLogout.setEndDate(cashierUserLoginAndLogout.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(cashierUserLoginAndLogoutDAO.getCountByObject(cashierUserLoginAndLogout));
		cashierUserLoginAndLogout.setStartOfPage(page.getStartOfPage());
		cashierUserLoginAndLogout.setPageSize(page.getPageSize());
		page.setResults(cashierUserLoginAndLogoutDAO
				.getCashierUserLoginAndLogoutByCashierUserLoginAndLogout(cashierUserLoginAndLogout));
		if (StringUtils.isNotBlank(cashierUserLoginAndLogout.getEndDate())) {
			cashierUserLoginAndLogout.setEndDate(cashierUserLoginAndLogout.getEndDate().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 结算
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 18, 2017
	 * @param id
	 * @return int
	 */
	public int doFinish(String id) {
		return StringUtils.isBlank(id) ? 0 : cashierUserLoginAndLogoutDAO.doFinish(id);
	}
}
