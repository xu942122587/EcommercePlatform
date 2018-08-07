package com.unitever.module.statistics.service;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.bonusDetail.dao.manual.BonusDetailDAO;
import com.unitever.module.consumeBonusDetail.dao.manual.ConsumeBonusDetailDAO;
import com.unitever.module.customer.dao.manual.CustomerDAO;
import com.unitever.module.inventory.dao.manual.InventoryDAO;
import com.unitever.module.procurement.dao.manual.ProcurementDAO;
import com.unitever.module.rechargeRecord.dao.manual.RechargeRecordDAO;
import com.unitever.module.registerBonusDetil.dao.manual.RegisterBonusDetilDAO;
import com.unitever.module.statistics.dao.manual.OrderStatisticsDAO;
import com.unitever.module.store.model.Store;
import com.unitever.module.storeBonusDetail.dao.manual.StoreBonusDetailDAO;
import com.unitever.platform.util.DoubleUtil;

@Service
@Transactional
public class StatisticsService {

	@Autowired
	private OrderStatisticsDAO orderStatisticsDAO;
	@Autowired
	private RechargeRecordDAO rechargeRecordDAO;
	@Autowired
	private InventoryDAO inventoryDAO;
	@Autowired
	private ProcurementDAO procurementDAO;
	@Autowired
	private CustomerDAO customerDAO;
	@Autowired
	private StoreBonusDetailDAO storeBonusDetailDAO;
	@Autowired
	private RegisterBonusDetilDAO registerBonusDetilDAO;
	@Autowired
	private ConsumeBonusDetailDAO consumeBonusDetailDAO;
	@Autowired
	private BonusDetailDAO bonusDetailDAO;

	/**
	 *
	 * <P>
	 * 根据时间门店获取营收统计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月1日
	 * @param startDate
	 * @param endDate
	 * @param store
	 * @return Map<String,Object>
	 */
	public Map<String, Object> getSaleStatisticsByDate(String startDate, String endDate, Store store) {
		Map<String, Object> statisticsMap = new HashMap<String, Object>();
		if (null != store && StringUtils.isNotBlank(store.getId())) {
			// 线下-现金首次支付统计
			String moneyPayOne = orderStatisticsDAO.getMoneyPayOneSumMoney(startDate, endDate, store.getId());
			// 线下-银行卡首次支付统计
			String cardPayOne = orderStatisticsDAO.getCardPayOneSumMoney(startDate, endDate, store.getId());
			// 线下-微信首次支付统计
			String weChatPayOne = orderStatisticsDAO.getWeChatPayOneSumMoney(startDate, endDate, store.getId());
			// 线下-支付宝首次支付统计
			String aliPayOne = orderStatisticsDAO.getAliPayOneSumMoney(startDate, endDate, store.getId());
			// 线下-余额首次支付统计
			String tianhePayOne = orderStatisticsDAO.getTianhePayOneSumMoney(startDate, endDate, store.getId());
			// 线下-预约定金总计
			String dingjin = orderStatisticsDAO.getDingjinSumMoney(startDate, endDate, store.getId());
			// 线下-预约尾款总计
			String weikuan = orderStatisticsDAO.getWeikuanSumMoney(startDate, endDate, store.getId());
			// 线上-微信首次支付统计
			String weChatPayOneInLine = orderStatisticsDAO.getWeChatPayOneSumMoneyInLine(startDate, endDate,
					store.getId());
			// 线上-支付宝首次支付统计
			String aliPayOneInLine = orderStatisticsDAO.getAliPayOneSumMoneyInLine(startDate, endDate, store.getId());
			// 线上-余额首次支付统计
			String tianhePayOneInLine = orderStatisticsDAO.getTianhePayOneSumMoneyInLine(startDate, endDate,
					store.getId());
			// 退款总计
			String returnMoney = orderStatisticsDAO.getReturnSumMoney(startDate, endDate, store.getId());
			// 销售总计
			String saleSumMoney = DoubleUtil.add(
					DoubleUtil.add(
							DoubleUtil.add(DoubleUtil.add(moneyPayOne, cardPayOne),
									DoubleUtil.add(weChatPayOne, aliPayOne)),
							DoubleUtil.add(DoubleUtil.add(tianhePayOne, dingjin),
									DoubleUtil.add(weikuan, weChatPayOneInLine))),
					DoubleUtil.add(aliPayOneInLine, tianhePayOneInLine), 2).toString();
			// 线下销售总计
			String saleSumMoneyDown = DoubleUtil.add(
					DoubleUtil.add(DoubleUtil.add(moneyPayOne, cardPayOne), DoubleUtil.add(weChatPayOne, aliPayOne)),
					DoubleUtil.add(DoubleUtil.add(tianhePayOne, dingjin).toString(), weikuan), 2).toString();
			// 线上总计
			String saleSumMoneyInLine = DoubleUtil.add(weChatPayOneInLine,
					DoubleUtil.add(aliPayOneInLine, tianhePayOneInLine).toString(), 2).toString();
			statisticsMap.put("saleSumMoney", saleSumMoney);
			statisticsMap.put("saleSumMoneyDown", saleSumMoneyDown);
			statisticsMap.put("saleSumMoneyInLine", saleSumMoneyInLine);
			statisticsMap.put("returnMoney", returnMoney);

			statisticsMap.put("moneyPayOne", moneyPayOne);
			statisticsMap.put("cardPayOne", cardPayOne);
			statisticsMap.put("weChatPayOne", weChatPayOne);
			statisticsMap.put("aliPayOne", aliPayOne);
			statisticsMap.put("tianhePayOne", tianhePayOne);
			statisticsMap.put("dingjin", dingjin);
			statisticsMap.put("weikuan", weikuan);
			statisticsMap.put("weChatPayOneInLine", weChatPayOneInLine);
			statisticsMap.put("aliPayOneInLine", aliPayOneInLine);
			statisticsMap.put("tianhePayOneInLine", tianhePayOneInLine);

		} else {
			// 线下-现金首次支付统计
			String moneyPayOne = orderStatisticsDAO.getMoneyPayOneSumMoney(startDate, endDate, store.getId());
			// 线下-银行卡首次支付统计
			String cardPayOne = orderStatisticsDAO.getCardPayOneSumMoney(startDate, endDate, store.getId());
			// 线下-微信首次支付统计
			String weChatPayOne = orderStatisticsDAO.getWeChatPayOneSumMoney(startDate, endDate, store.getId());
			// 线下-支付宝首次支付统计
			String aliPayOne = orderStatisticsDAO.getAliPayOneSumMoney(startDate, endDate, store.getId());
			// 线下-余额首次支付统计
			String tianhePayOne = orderStatisticsDAO.getTianhePayOneSumMoney(startDate, endDate, store.getId());
			// 线线下-预约定金总计
			String dingjin = orderStatisticsDAO.getDingjinSumMoney(startDate, endDate, store.getId());
			// 线下-预约尾款总计
			String weikuan = orderStatisticsDAO.getWeikuanSumMoney(startDate, endDate, store.getId());
			// 线上-微信首次支付统计
			String weChatPayOneInLine = orderStatisticsDAO.getWeChatPayOneSumMoneyInLine(startDate, endDate,
					store.getId());
			// 线上-支付宝首次支付统计
			String aliPayOneInLine = orderStatisticsDAO.getAliPayOneSumMoneyInLine(startDate, endDate, store.getId());
			// 线上-余额首次支付统计
			String tianhePayOneInLine = orderStatisticsDAO.getTianhePayOneSumMoneyInLine(startDate, endDate,
					store.getId());
			// 退款总计
			String returnMoney = orderStatisticsDAO.getReturnSumMoney(startDate, endDate, store.getId());
			// 销售总计
			String saleSumMoney = DoubleUtil.add(
					DoubleUtil.add(
							DoubleUtil.add(DoubleUtil.add(moneyPayOne, cardPayOne),
									DoubleUtil.add(weChatPayOne, aliPayOne)),
							DoubleUtil.add(DoubleUtil.add(tianhePayOne, dingjin),
									DoubleUtil.add(weikuan, weChatPayOneInLine))),
					DoubleUtil.add(aliPayOneInLine, tianhePayOneInLine), 2).toString();
			// 线下销售总计
			String saleSumMoneyDown = DoubleUtil.add(
					DoubleUtil.add(DoubleUtil.add(moneyPayOne, cardPayOne), DoubleUtil.add(weChatPayOne, aliPayOne)),
					DoubleUtil.add(DoubleUtil.add(tianhePayOne, dingjin).toString(), weikuan), 2).toString();
			// 线上总计
			String saleSumMoneyInLine = DoubleUtil.add(weChatPayOneInLine,
					DoubleUtil.add(aliPayOneInLine, tianhePayOneInLine).toString(), 2).toString();
			statisticsMap.put("saleSumMoney", saleSumMoney);
			statisticsMap.put("saleSumMoneyDown", saleSumMoneyDown);
			statisticsMap.put("saleSumMoneyInLine", saleSumMoneyInLine);
			statisticsMap.put("returnMoney", returnMoney);

			statisticsMap.put("moneyPayOne", moneyPayOne);
			statisticsMap.put("cardPayOne", cardPayOne);
			statisticsMap.put("weChatPayOne", weChatPayOne);
			statisticsMap.put("aliPayOne", aliPayOne);
			statisticsMap.put("tianhePayOne", tianhePayOne);
			statisticsMap.put("dingjin", dingjin);
			statisticsMap.put("weikuan", weikuan);
			statisticsMap.put("weChatPayOneInLine", weChatPayOneInLine);
			statisticsMap.put("aliPayOneInLine", aliPayOneInLine);
			statisticsMap.put("tianhePayOneInLine", tianhePayOneInLine);

			// 充值金额统计
			String rechargeMoney = rechargeRecordDAO.getRechargeSumMoney(startDate, endDate);
			// 充值返现金额统计
			String rechargeBackCash = rechargeRecordDAO.getRechargeBackCashSumMoney(startDate, endDate);
			statisticsMap.put("rechargeMoney", rechargeMoney);
			statisticsMap.put("rechargeBackCash", rechargeBackCash);

			// 门店销售额
			Map<String, Map<String, Object>> storeSumMoneyOne = orderStatisticsDAO
					.getSumMoneyOneMap(startDate, endDate);
			List<String> storeSumMoneyOneList = orderStatisticsDAO.getSumMoneyOneList(startDate, endDate);
			LinkedHashMap<String, Map<String, Object>> storeSumMoneyOneLink = new LinkedHashMap<>();
			for (String storeCode : storeSumMoneyOneList) {
				for (Entry<String, Map<String, Object>> map : storeSumMoneyOne.entrySet()) {
					if (map.getKey().equals(storeCode)) {
						storeSumMoneyOneLink.put(map.getKey(), map.getValue());
					}
				}
			}
			statisticsMap.put("storeSumMoneyOne", storeSumMoneyOneLink);
			// 单仓库库存总量及总金额统计
			Map<String, Map<String, Object>> storageSumMoneyAndCount = inventoryDAO.getSumMoneyAndCountByStorage();
			statisticsMap.put("storageSumMoneyAndCount", storageSumMoneyAndCount);
			// 门店采购统计
			Map<String, Map<String, Object>> procurementOneType = procurementDAO.getOneTypeSumMoneyAndCountMap(
					startDate, endDate);
			statisticsMap.put("procurementOneType", procurementOneType);
			// 门店采购退货统计
			Map<String, Map<String, Object>> procurementTwoType = procurementDAO.getTwoTypeSumMoneyAndCountMap(
					startDate, endDate);
			statisticsMap.put("procurementTwoType", procurementTwoType);
		}
		return statisticsMap;
	}

	/**
	 *
	 * <P>
	 * 根据时间门店获取销量统计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月1日
	 * @param startDate
	 * @param endDate
	 * @param store
	 * @return Map<String,Object>
	 */
	public Map<String, Object> getAmountStatisticsByDate(String startDate, String endDate, Store store) {
		Map<String, Object> statisticsMap = new HashMap<String, Object>();
		if (null != store && StringUtils.isNotBlank(store.getId())) {
			// 退货数量总计
			String returnSumNumber = orderStatisticsDAO.getReturnSumNumber(startDate, endDate, store.getId());
			statisticsMap.put("returnSumNumber", returnSumNumber);
			// 线下-销售数量总计
			String saleSumNumber = orderStatisticsDAO.getSaleSumNumber(startDate, endDate, store.getId());
			String forTypeSaleSumNumber = orderStatisticsDAO.getForTypeSaleSumNumber(startDate, endDate, store.getId());
			statisticsMap.put("saleSumNumber", String.valueOf(Integer.parseInt(saleSumNumber)+Integer.parseInt(forTypeSaleSumNumber)));
			// 线上-销售数量总计
			String saleSumNumberInLine = orderStatisticsDAO.getSaleSumNumberInLine(startDate, endDate, store.getId());
			statisticsMap.put("saleSumNumberInLine", saleSumNumberInLine);
			// 销售数量总计
			String saleSumNumberSum = String.valueOf(Integer.parseInt(saleSumNumber)+Integer.parseInt(forTypeSaleSumNumber)+Integer.parseInt(saleSumNumberInLine));
			statisticsMap.put("saleSumNumberSum", saleSumNumberSum);
			// 单仓库库存总量及总金额统计
			Map<String, Map<String, Object>> storageSumMoneyAndCount = inventoryDAO.getSumMoneyAndCountByStorage();
			statisticsMap.put("storageSumMoneyAndCount", storageSumMoneyAndCount);

		} else {
			// 线下-销售数量总计
			String saleSumNumber = orderStatisticsDAO.getSaleSumNumber(startDate, endDate, store.getId());
			String forTypeSaleSumNumber = orderStatisticsDAO.getForTypeSaleSumNumber(startDate, endDate, store.getId());
			statisticsMap.put("saleSumNumber", String.valueOf(Integer.parseInt(saleSumNumber)+Integer.parseInt(forTypeSaleSumNumber)));
			// 线上-销售数量总计
			String saleSumNumberInLine = orderStatisticsDAO.getSaleSumNumberInLine(startDate, endDate, store.getId());
			statisticsMap.put("saleSumNumberInLine", saleSumNumberInLine);
			// 退货数量总计
			String returnSumNumber = orderStatisticsDAO.getReturnSumNumber(startDate, endDate, store.getId());
			statisticsMap.put("returnSumNumber", returnSumNumber);
			// 销售数量总计
			String saleSumNumberSum = String.valueOf(Integer.parseInt(saleSumNumber)+Integer.parseInt(forTypeSaleSumNumber)+Integer.parseInt(saleSumNumberInLine));
			statisticsMap.put("saleSumNumberSum", saleSumNumberSum);

			// 单仓库库存总量及总金额统计
			Map<String, Map<String, Object>> storageSumMoneyAndCount = inventoryDAO.getSumMoneyAndCountByStorage();
			statisticsMap.put("storageSumMoneyAndCount", storageSumMoneyAndCount);

			// 根据时间拿取用户数量
			String timeCustomerCount = customerDAO.getCountCustomerByTime(startDate, endDate);
			statisticsMap.put("timeCustomerCount", timeCustomerCount);
			// 拿取所有注册用户数量
			String customerCount = customerDAO.getCountCustomer();
			statisticsMap.put("customerCount", customerCount);

			// 商品实际销量排名
			Map<String, Map<String, Object>> goodsGroupOrderBySumCount = orderStatisticsDAO
					.getGoodsGroupOrderBySumCount(startDate, endDate, store.getId());
			List<String> goodsGroupOrderBySumCountList = orderStatisticsDAO.getGoodsGroupOrderBySumCountList(startDate,
					endDate, store.getId());
			LinkedHashMap<String, Map<String, Object>> goodsGroupOrderBySumCountLink = new LinkedHashMap<>();
			for (String goodsCode : goodsGroupOrderBySumCountList) {
				for (Entry<String, Map<String, Object>> map : goodsGroupOrderBySumCount.entrySet()) {
					if (map.getKey().equals(goodsCode)) {
						goodsGroupOrderBySumCountLink.put(map.getKey(), map.getValue());
					}
				}
			}
			statisticsMap.put("goodsGroupOrderBySumCount", goodsGroupOrderBySumCountLink);
			// 预约商品实际销量排名
			Map<String, Map<String, Object>> typeFourgoodsGroupOrderBySumCount = orderStatisticsDAO
					.getGoodsGroupOrderBySumCountForTypeFour(startDate, endDate, store.getId());
			List<String> typeFourgoodsGroupOrderBySumCountList = orderStatisticsDAO
					.getGoodsGroupOrderBySumCountForTypeFourList(startDate, endDate, store.getId());
			LinkedHashMap<String, Map<String, Object>> typeFourgoodsGroupOrderBySumCountLink = new LinkedHashMap<>();
			for (String goodsCode : typeFourgoodsGroupOrderBySumCountList) {
				for (Entry<String, Map<String, Object>> map : typeFourgoodsGroupOrderBySumCount.entrySet()) {
					if (map.getKey().equals(goodsCode)) {
						typeFourgoodsGroupOrderBySumCountLink.put(map.getKey(), map.getValue());
					}
				}
			}
			statisticsMap.put("typeFourgoodsGroupOrderBySumCount", typeFourgoodsGroupOrderBySumCountLink);
		}
		return statisticsMap;
	}

	/**
	 *
	 * <P>
	 * 根据时间门店获取业绩统计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月1日
	 * @param startDate
	 * @param endDate
	 * @param store
	 * @return Map<String,Object>
	 */
	public Map<String, Object> getAchievementStatisticsByDate(String startDate, String endDate, Store store) {
		Map<String, Object> statisticsMap = new HashMap<String, Object>();
		if (null != store && StringUtils.isNotBlank(store.getId())) {
			// 商家店销售额统计
			String storeTargetMoney = storeBonusDetailDAO.getStoreBonusDetailTargetMoneySumMoney(startDate, endDate,
					store.getId());
			statisticsMap.put("storeTargetMoney", storeTargetMoney);
			// 商家店服务费统计
			String storeSumMoney = storeBonusDetailDAO.getStoreBonusDetailSumMoney(startDate, endDate, store.getId());
			statisticsMap.put("storeSumMoney", storeSumMoney);

			// 推荐注册奖励金
			String registerSumMoney = registerBonusDetilDAO.getRegisterBonusDetailSumMoney(startDate, endDate,
					store.getId());
			statisticsMap.put("registerSumMoney", registerSumMoney);
			// 推荐注册人数
			String registerSumCount = registerBonusDetilDAO.getRegisterBonusDetailSumCount(startDate, endDate,
					store.getId());
			statisticsMap.put("registerSumCount", registerSumCount);

			// 充值总额
			String consumeSumMoney = consumeBonusDetailDAO.getConsumeBonusDetailSumMoney(startDate, endDate,
					store.getId());
			statisticsMap.put("consumeSumMoney", consumeSumMoney);
			// 充值提成
			String consumeTargetMoney = consumeBonusDetailDAO.getConsumeBonusDetailSumTargetMoney(startDate, endDate,
					store.getId());
			statisticsMap.put("consumeTargetMoney", consumeTargetMoney);

			// 导购销售总额
			String bonusSumMoney = bonusDetailDAO.getBonusDetailSumMoney(startDate, endDate, store.getId());
			statisticsMap.put("bonusSumMoney", bonusSumMoney);
			// 导购提成
			String bonusTargetMoney = bonusDetailDAO.getBonusDetailSumTargetMoney(startDate, endDate, store.getId());
			statisticsMap.put("bonusTargetMoney", bonusTargetMoney);

			// 导购销售排行
			Map<String, Map<String, Object>> userBonusSumMoney = bonusDetailDAO.getSumMoneyUserMap(startDate, endDate,
					store.getId());
			statisticsMap.put("userBonusSumMoney", userBonusSumMoney);
		} else {
			// 商家店销售额统计
			String storeTargetMoney = storeBonusDetailDAO.getStoreBonusDetailTargetMoneySumMoney(startDate, endDate,
					store.getId());
			statisticsMap.put("storeTargetMoney", storeTargetMoney);
			// 商家店服务费统计
			String storeSumMoney = storeBonusDetailDAO.getStoreBonusDetailSumMoney(startDate, endDate, store.getId());
			statisticsMap.put("storeSumMoney", storeSumMoney);

			// 推荐注册奖励金
			String registerSumMoney = registerBonusDetilDAO.getRegisterBonusDetailSumMoney(startDate, endDate,
					store.getId());
			statisticsMap.put("registerSumMoney", registerSumMoney);
			// 推荐注册人数
			String registerSumCount = registerBonusDetilDAO.getRegisterBonusDetailSumCount(startDate, endDate,
					store.getId());
			statisticsMap.put("registerSumCount", registerSumCount);

			// 充值总额
			String consumeSumMoney = consumeBonusDetailDAO.getConsumeBonusDetailSumMoney(startDate, endDate,
					store.getId());
			statisticsMap.put("consumeSumMoney", consumeSumMoney);
			// 充值提成
			String consumeTargetMoney = consumeBonusDetailDAO.getConsumeBonusDetailSumTargetMoney(startDate, endDate,
					store.getId());
			statisticsMap.put("consumeTargetMoney", consumeTargetMoney);

			// 导购销售总额
			String bonusSumMoney = bonusDetailDAO.getBonusDetailSumMoney(startDate, endDate, store.getId());
			statisticsMap.put("bonusSumMoney", bonusSumMoney);
			// 导购提成
			String bonusTargetMoney = bonusDetailDAO.getBonusDetailSumTargetMoney(startDate, endDate, store.getId());
			statisticsMap.put("bonusTargetMoney", bonusTargetMoney);

			// 导购销售排行
			Map<String, Map<String, Object>> userBonusSumMoney = bonusDetailDAO.getSumMoneyUserMap(startDate, endDate,
					store.getId());
			List<String> userBonusSumMoneyList = bonusDetailDAO.getSumMoneyUserList(startDate, endDate, store.getId());
			LinkedHashMap<String, Map<String, Object>> userBonusSumMoneyLink = new LinkedHashMap<>();
			for (String userName : userBonusSumMoneyList) {
				for (Entry<String, Map<String, Object>> map : userBonusSumMoney.entrySet()) {
					if (map.getKey().equals(userName)) {
						userBonusSumMoneyLink.put(map.getKey(), map.getValue());
					}
				}
			}
			statisticsMap.put("userBonusSumMoney", userBonusSumMoneyLink);

			// 商家店业绩排行
			Map<String, Map<String, Object>> storeMoneyMap = storeBonusDetailDAO.getGroupByStoreBonusDetailStoreMap(
					startDate, endDate);
			List<String> storeMoneyList = storeBonusDetailDAO.getGroupByStoreBonusDetailStoreList(startDate, endDate);
			LinkedHashMap<String, Map<String, Object>> storeMoneyLink = new LinkedHashMap<>();
			for (String storeCode : storeMoneyList) {
				for (Entry<String, Map<String, Object>> map : storeMoneyMap.entrySet()) {
					if (map.getKey().equals(storeCode)) {
						storeMoneyLink.put(map.getKey(), map.getValue());
					}
				}
			}
			statisticsMap.put("storeMoneyMap", storeMoneyLink);
		}

		return statisticsMap;
	}
}
