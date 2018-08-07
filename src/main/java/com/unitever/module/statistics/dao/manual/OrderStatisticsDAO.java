package com.unitever.module.statistics.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.order.model.Order;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class OrderStatisticsDAO extends BaseDAO<Order, String> {

	/**
	 *
	 * <P>
	 * 线下-现金首次支付统计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月2日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return String
	 */
	public String getMoneyPayOneSumMoney(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.get("getMoneyPayOneSumMoney", map);
	}

	/**
	 *
	 * <P>
	 * 线下-银行卡首次支付统计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月2日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return String
	 */
	public String getCardPayOneSumMoney(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.get("getCardPayOneSumMoney", map);
	}

	/**
	 *
	 * <P>
	 * 线下-微信首次支付统计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月2日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return String
	 */
	public String getWeChatPayOneSumMoney(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.get("getWeChatPayOneSumMoney", map);
	}

	/**
	 *
	 * <P>
	 * 线下-支付宝首次支付统计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月2日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return String
	 */
	public String getAliPayOneSumMoney(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.get("getAliPayOneSumMoney", map);
	}

	/**
	 *
	 * <P>
	 * 线下-余额首次支付统计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月2日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return String
	 */
	public String getTianhePayOneSumMoney(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.get("getTianhePayOneSumMoney", map);
	}

	/**
	 *
	 * <P>
	 * 线下-预约定金总计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月2日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return String
	 */
	public String getDingjinSumMoney(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.get("getDingjinSumMoney", map);
	}

	/**
	 *
	 * <P>
	 * 线下-预约尾款总计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月2日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return String
	 */
	public String getWeikuanSumMoney(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.get("getWeikuanSumMoney", map);
	}

	/**
	 *
	 * <P>
	 * 线上-微信首次支付统计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月2日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return String
	 */
	public String getWeChatPayOneSumMoneyInLine(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.get("getWeChatPayOneSumMoneyInLine", map);
	}

	/**
	 *
	 * <P>
	 * 线上-支付宝首次支付统计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月2日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return String
	 */
	public String getAliPayOneSumMoneyInLine(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.get("getAliPayOneSumMoneyInLine", map);
	}

	/**
	 *
	 * <P>
	 * 线上-余额首次支付统计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月2日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return String
	 */
	public String getTianhePayOneSumMoneyInLine(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.get("getTianhePayOneSumMoneyInLine", map);
	}

	/**
	 *
	 * <P>
	 * 退款总计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月2日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return String
	 */
	public String getReturnSumMoney(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.get("getReturnSumMoney", map);
	}

	/**
	 *
	 * <P>
	 * 门店销售额
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月3日
	 * @param startDate
	 * @param endDate
	 * @return Map<String,Map<String,Object>>
	 */
	public Map<String, Map<String, Object>> getSumMoneyOneMap(String startDate, String endDate) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		return this.getSqlSession().selectMap("getSumMoneyOneMap", map, "storeCode");
	}

	/**
	 *
	 * <P>
	 * 线下-销售数量总计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月2日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return String
	 */
	public String getSaleSumNumber(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.get("getSaleSumNumber", map);
	}
	
	/**
	 *
	 * <P>
	 * 线下-预约销售数量总计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月2日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return String
	 */
	public String getForTypeSaleSumNumber(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.get("getForTypeSaleSumNumber", map);
	}

	/**
	 *
	 * <P>
	 * 线上-销售数量总计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月2日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return String
	 */
	public String getSaleSumNumberInLine(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.get("getSaleSumNumberInLine", map);
	}

	/**
	 *
	 * <P>
	 * 退货数量总计
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月2日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return String
	 */
	public String getReturnSumNumber(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.get("getReturnSumNumber", map);
	}

	/**
	 *
	 * <P>
	 * 商品实际销量排名
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月6日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return Map<String,Map<String,Object>>
	 */
	public Map<String, Map<String, Object>> getGoodsGroupOrderBySumCount(String startDate, String endDate,
			String storeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.getSqlSession().selectMap("getGoodsGroupOrderBySumCount", map, "goodsCode");
	}

	/**
	 *
	 * <P>
	 * 预约商品实际销量排名
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月6日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return Map<String,Map<String,Object>>
	 */
	public Map<String, Map<String, Object>> getGoodsGroupOrderBySumCountForTypeFour(String startDate, String endDate,
			String storeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.getSqlSession().selectMap("getGoodsGroupOrderBySumCountForTypeFour", map, "goodsCode");
	}

	/**
	 *
	 * <P>
	 * 商品实际销量排名
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月6日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return Map<String,Map<String,Object>>
	 */
	public List<String> getGoodsGroupOrderBySumCountList(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.getList("getGoodsGroupOrderBySumCountList", map);
	}

	/**
	 *
	 * <P>
	 * 预约商品实际销量排名
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月6日
	 * @param startDate
	 * @param endDate
	 * @param storeId
	 * @return Map<String,Map<String,Object>>
	 */
	public List<String> getGoodsGroupOrderBySumCountForTypeFourList(String startDate, String endDate, String storeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("storeId", storeId);
		return this.getList("getGoodsGroupOrderBySumCountForTypeFourList", map);
	}

	/**
	 *
	 * <P>
	 * 门店销售额排序
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年3月28日
	 * @param startDate
	 * @param endDate
	 * @return List<String>
	 */
	public List<String> getSumMoneyOneList(String startDate, String endDate) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		return this.getList("getSumMoneyOneList", map);
	}
}
