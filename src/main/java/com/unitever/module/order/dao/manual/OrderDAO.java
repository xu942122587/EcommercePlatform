package com.unitever.module.order.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.order.model.Order;
import com.unitever.module.order.model.OrderVo;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class OrderDAO extends BaseDAO<Order, String> {

	/**
	 *
	 * 根据Order获取
	 *
	 * @author 徐昊
	 * @date 2017年6月29日
	 * @param order
	 * @return List<Order>
	 */
	public List<Order> getOrderByOrder(Order order) {
		return this.getList("getOrderByOrder", order);
	}

	/**
	 *
	 * 15天自动发货订单
	 *
	 * @author 徐昊
	 * @date 2017年6月29日
	 * @param order
	 * @return List<Order>
	 */
	public List<Order> getFourStateOrderByFifteen() {
		return this.getList("getFourStateOrderByFifteen", null);
	}

	/**
	 *
	 * 根据支付方式(微信/支付宝)获取订单
	 *
	 * @author 徐昊
	 * @date 2017年6月29日
	 * @param order
	 * @return List<Order>
	 */
	public List<Order> getOrderByPayType(Order order) {
		return this.getList("getOrderByPayType", order);
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
		return this.getList("getParentOrderByParentOrder", order);
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
		Map<String, String> map = new HashMap<>();
		map.put("qrcodeId", qrcodeId);
		return this.get("getEightOrderCountByQrcodeId", map);
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
		Map<String, String> map = new HashMap<>();
		map.put("qrcodeId", qrcodeId);
		return this.get("getThreeOrderCountByQrcodeId", map);
	}

	/**
	 *
	 * 获取符合当前条件的Order数量
	 *
	 * @author 徐昊
	 * @date 2017年6月29日
	 * @param order
	 * @return int
	 */
	public int getCountByOrder(Order order) {
		return this.get("getCountByOrder", order);
	}

	/**
	 *
	 * 获取符合当前条件的Order数量
	 *
	 * @author 徐昊
	 * @date 2017年6月29日
	 * @param order
	 * @return int
	 */
	public int getCountOrderByPayType(Order order) {
		return this.get("getCountOrderByPayType", order);
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
	 * @return List<Consume>
	 */
	public List<Order> getOrderByCustomerId(String customerId) {
		Map<String, String> map = new HashMap<>();
		map.put("customerId", customerId);
		return this.getList("getOrderByCustomerId", map);
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
		Map<String, String> map = new HashMap<>();
		map.put("orderId", orderId);
		return this.getList("getThreeOrderByOrderId", map);
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
		Map<String, String> map = new HashMap<>();
		map.put("customerId", customerId);
		map.put("state", state);
		return this.getList("getOrderByCustomerIdAndState", map);
	}

	/**
	 *
	 * <P>
	 * 依据orderCode和qrcodeID获取换购订单信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月2日
	 * @param customerId
	 * @return List<Consume>
	 */
	public Order getThreeOrderByOrderCodeAndQrcodeId(String orderCode, String qrcodeId) {
		Map<String, String> map = new HashMap<>();
		map.put("orderCode", orderCode);
		map.put("qrcodeId", qrcodeId);
		return this.get("getThreeOrderByOrderCodeAndQrcodeId", map);
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
		Map<String, String> map = new HashMap<>();
		map.put("qrcodeId", qrcodeId);
		return this.get("getOrderByQrcodeId", map);
	}

	/**
	 *
	 * <P>
	 * 依据orderCode获取订单信息--未支付订单
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 23, 2017
	 * @param orderCode
	 * @return Order
	 */
	public Order getNoPayOrderByOrderCode(String orderCode) {
		Map<String, String> map = new HashMap<>();
		map.put("orderCode", orderCode);
		return this.get("getNoPayOrderByOrderCode", map);
	}

	/**
	 *
	 * <P>
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 26, 2017
	 * @param order_to_update
	 * @return int
	 */
	public int orderPaySuccess(Order order_to_update) {
		return this.update("orderPaySuccess", order_to_update);
	}

	/**
	 *
	 * <P>
	 * 根据batchCode修改inLinePayMoney
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月14日
	 * @param batchCode
	 * @param inLinePayMoney
	 * @return int
	 */
	public int updateInLinePayMoneyByBatchCode(String batchCode, String inLinePayMoney) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("batchCode", batchCode);
		map.put("inLinePayMoney", inLinePayMoney);
		return this.update("updateInLinePayMoneyByBatchCode", map);
	}

	/**
	 *
	 * <P>
	 * 线上订单未支付变未发货
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月14日
	 * @param id
	 * @return int
	 */
	public int updateStateOneToTwo(String id) {
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		return this.update("updateStateOneToTwo", map);
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
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		return this.update("updateStateTwoToThree", map);
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
		return this.update("updateStateThreeToFour", order);
	}

	/**
	 *
	 * <P>
	 * 线上订单已发货变待评价
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月14日
	 * @param id
	 * @return int
	 */
	public int updateStateFourToFive(String id) {
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		return this.update("updateStateFourToFive", map);
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
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		return this.update("updateStateFiveToSix", map);
	}

	/**
	 *
	 * <P>
	 * 线上订单已发货变完成
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月14日
	 * @param id
	 * @return int
	 */
	public int updateStateFourToSix(String id) {
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		return this.update("updateStateFourToSix", map);
	}

	/**
	 *
	 * <P>
	 * 依据订单Code获取订单信息--完成的订单
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 3, 2017
	 * @param orderCode
	 * @return Object
	 */
	public Order getFinishOrderByOrderCode(String orderCode) {
		Map<String, String> map = new HashMap<>();
		map.put("orderCode", orderCode);
		return this.get("getFinishOrderByOrderCode", map);
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
	 * @return Object
	 */
	public List<Order> getOrderByIdString(String orderIdString) {
		Map<String, String> map = new HashMap<>();
		map.put("orderIdString", orderIdString);
		return this.getList("getOrderByIdString", map);
	}

	/**
	 *
	 * <P>
	 * 通过BatchCode获取订单IdList
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月11日
	 * @param batchCode
	 * @return List<String>
	 */
	public List<String> getOrderIdListByBatchCode(String batchCode) {
		Map<String, String> map = new HashMap<>();
		map.put("batchCode", batchCode);
		return this.getList("getOrderIdListByBatchCode", map);
	}

	/**
	 *
	 * <P>
	 * 通过BatchCode获取订单List
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月11日
	 * @param batchCode
	 * @return List<String>
	 */
	public List<Order> getOrderByBatchCode(String batchCode) {
		Map<String, String> map = new HashMap<>();
		map.put("batchCode", batchCode);
		return this.getList("getOrderByBatchCode", map);
	}

	/**
	 *
	 * <P>
	 * 根据根据商家店Id获取上月销售额
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月11日
	 * @param batchCode
	 * @return List<String>
	 */
	public String getOneOrderMoneyByStoreInLastMonth(String storeId) {
		Map<String, String> map = new HashMap<>();
		map.put("storeId", storeId);
		return this.get("getOneOrderMoneyByStoreInLastMonth", map);
	}

	/**
	 *
	 * <P>
	 * 根据导购获取上月的销售总金额
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月11日
	 * @param batchCode
	 * @return List<String>
	 */
	public String getOneOrderMoneyByGuideUserInLastMonth(String guideUserId) {
		Map<String, String> map = new HashMap<>();
		map.put("guideUserId", guideUserId);
		return this.get("getOneOrderMoneyByGuideUserInLastMonth", map);
	}

	/**
	 *
	 * <P>
	 * 根据导购获取上月的销售总金额
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月11日
	 * @param batchCode
	 * @return List<String>
	 */
	public String getTwoOrderMoneyByGuideUserInLastMonth(String guideUserId) {
		Map<String, String> map = new HashMap<>();
		map.put("guideUserId", guideUserId);
		return this.get("getTwoOrderMoneyByGuideUserInLastMonth", map);
	}

	/**
	 *
	 * <P>
	 * 交接班-现金首次支付统计
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 17, 2017
	 * @param cashierUser_id
	 *            收银ID
	 * @param start_time
	 * @return Map<String,Map<String,Object>>
	 */
	public Map<String, Map<String, Object>> getMoneyPayOnyCountMap(String cashierUser_id, String start_time,
			String end_time) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("cashierUser_id", cashierUser_id);
		map.put("start_time", start_time);
		map.put("end_time", end_time);
		return this.getSqlSession().selectMap("getMoneyPayOnyCountMap", map, "storeCode");
	}

	/**
	 *
	 * <P>
	 * 交接班-现金二次支付统计
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 17, 2017
	 * @param cashierUser_id
	 *            收银ID
	 * @param start_time
	 * @return Map<String,Map<String,Object>>
	 */
	public Map<String, Map<String, Object>> getMoneyPayTwoCountMap(String cashierUser_id, String start_time,
			String end_time) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("cashierUser_id", cashierUser_id);
		map.put("start_time", start_time);
		map.put("end_time", end_time);
		return this.getSqlSession().selectMap("getMoneyPayTwoCountMap", map, "storeCode");
	}

	/**
	 *
	 * <P>
	 * 交接班-银行卡首次支付统计
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 17, 2017
	 * @param cashierUser_id
	 *            收银ID
	 * @param start_time
	 * @return Map<String,Map<String,Object>>
	 */
	public Map<String, Map<String, Object>> getCardPayOnyCountMap(String cashierUser_id, String start_time,
			String end_time) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("cashierUser_id", cashierUser_id);
		map.put("start_time", start_time);
		map.put("end_time", end_time);
		return this.getSqlSession().selectMap("getCardPayOnyCountMap", map, "storeCode");
	}

	/**
	 *
	 * <P>
	 * 交接班-银行卡二次支付统计
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 17, 2017
	 * @param cashierUser_id
	 *            收银ID
	 * @param start_time
	 * @return Map<String,Map<String,Object>>
	 */
	public Map<String, Map<String, Object>> getCardPayTwoCountMap(String cashierUser_id, String start_time,
			String end_time) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("cashierUser_id", cashierUser_id);
		map.put("start_time", start_time);
		map.put("end_time", end_time);
		return this.getSqlSession().selectMap("getCardPayTwoCountMap", map, "storeCode");
	}

	/**
	 *
	 * <P>
	 * 交接班-微信支付首次支付统计
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 17, 2017
	 * @param cashierUser_id
	 *            收银ID
	 * @param start_time
	 * @return Map<String,Map<String,Object>>
	 */
	public Map<String, Map<String, Object>> getWeChatPayOnyCountMap(String cashierUser_id, String start_time,
			String end_time) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("cashierUser_id", cashierUser_id);
		map.put("start_time", start_time);
		map.put("end_time", end_time);
		return this.getSqlSession().selectMap("getWeChatPayOnyCountMap", map, "storeCode");
	}

	/**
	 *
	 * <P>
	 * 交接班-微信支付二次支付统计
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 17, 2017
	 * @param cashierUser_id
	 *            收银ID
	 * @param start_time
	 * @return Map<String,Map<String,Object>>
	 */
	public Map<String, Map<String, Object>> getWeChatPayTwoCountMap(String cashierUser_id, String start_time,
			String end_time) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("cashierUser_id", cashierUser_id);
		map.put("start_time", start_time);
		map.put("end_time", end_time);
		return this.getSqlSession().selectMap("getWeChatPayTwoCountMap", map, "storeCode");
	}

	/**
	 *
	 * <P>
	 * 交接班-支付宝支付首次支付统计
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 17, 2017
	 * @param cashierUser_id
	 *            收银ID
	 * @param start_time
	 * @return Map<String,Map<String,Object>>
	 */
	public Map<String, Map<String, Object>> getAliPayOnyCountMap(String cashierUser_id, String start_time,
			String end_time) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("cashierUser_id", cashierUser_id);
		map.put("start_time", start_time);
		map.put("end_time", end_time);
		return this.getSqlSession().selectMap("getAliPayOnyCountMap", map, "storeCode");
	}

	/**
	 *
	 * <P>
	 * 交接班-支付宝支付二次支付统计
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 17, 2017
	 * @param cashierUser_id
	 *            收银ID
	 * @param start_time
	 * @return Map<String,Map<String,Object>>
	 */
	public Map<String, Map<String, Object>> getAliPayTwoCountMap(String cashierUser_id, String start_time,
			String end_time) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("cashierUser_id", cashierUser_id);
		map.put("start_time", start_time);
		map.put("end_time", end_time);
		return this.getSqlSession().selectMap("getAliPayTwoCountMap", map, "storeCode");
	}

	/**
	 *
	 * <P>
	 * 交接班-天和会员余额支付首次支付统计
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 17, 2017
	 * @param cashierUser_id
	 *            收银ID
	 * @param start_time
	 * @return Map<String,Map<String,Object>>
	 */
	public Map<String, Map<String, Object>> getTianhePayOnyCountMap(String cashierUser_id, String start_time,
			String end_time) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("cashierUser_id", cashierUser_id);
		map.put("start_time", start_time);
		map.put("end_time", end_time);
		return this.getSqlSession().selectMap("getTianhePayOnyCountMap", map, "storeCode");
	}

	/**
	 *
	 * <P>
	 * 交接班-天和会员余额支付二次支付统计
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 17, 2017
	 * @param cashierUser_id
	 *            收银ID
	 * @param start_time
	 * @return Map<String,Map<String,Object>>
	 */
	public Map<String, Map<String, Object>> getTianhePayTwoCountMap(String cashierUser_id, String start_time,
			String end_time) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("cashierUser_id", cashierUser_id);
		map.put("start_time", start_time);
		map.put("end_time", end_time);
		return this.getSqlSession().selectMap("getTianhePayTwoCountMap", map, "storeCode");
	}

	/**
	 *
	 * <P>
	 * 交接班-定金统计
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 17, 2017
	 * @param cashierUser_id
	 *            收银ID
	 * @param start_time
	 * @return Map<String,Map<String,Object>>
	 */
	public Map<String, Map<String, Object>> getDingjinCountMap(String cashierUser_id, String start_time,
			String end_time) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("cashierUser_id", cashierUser_id);
		map.put("start_time", start_time);
		map.put("end_time", end_time);
		return this.getSqlSession().selectMap("getDingjinCountMap", map, "storeCode");
	}

	/**
	 *
	 * <P>
	 * 交接班-尾款统计
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 17, 2017
	 * @param cashierUser_id
	 *            收银ID
	 * @param start_time
	 * @return Map<String,Map<String,Object>>
	 */
	public Map<String, Map<String, Object>> getWeikuanCountMap(String cashierUser_id, String start_time,
			String end_time) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("cashierUser_id", cashierUser_id);
		map.put("start_time", start_time);
		map.put("end_time", end_time);
		return this.getSqlSession().selectMap("getWeikuanCountMap", map, "storeCode");
	}

	/**
	 *
	 * <P>
	 * 交接班-退款总计
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 17, 2017
	 * @param cashierUser_id
	 *            收银ID
	 * @param start_time
	 * @return Map<String,Map<String,Object>>
	 */
	public Map<String, Map<String, Object>> getReturnMoneyCountMap(String cashierUser_id, String start_time,
			String end_time) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("cashierUser_id", cashierUser_id);
		map.put("start_time", start_time);
		map.put("end_time", end_time);
		return this.getSqlSession().selectMap("getReturnMoneyCountMap", map, "storeCode");
	}

	/**
	 *
	 * <P>
	 * 获取交接班时间段内，在本收银台结算过得门店编号
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 17, 2017
	 * @param cashierUser_id
	 * @param start_time
	 * @param end_time
	 * @return List<String>
	 */
	public List<String> getStoreCodeList(String cashierUser_id, String start_time, String end_time) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("cashierUser_id", cashierUser_id);
		map.put("start_time", start_time);
		map.put("end_time", end_time);
		return this.getList("getStoreCodeList", map);
	}

	/**
	 *
	 * <P>
	 * 订单ID标识预约到货模板消息已发送
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 18, 2017
	 * @param id
	 *            订单ID（预约单订单ID）
	 * @param goodsId
	 *            产品ID
	 * @return int
	 */
	public int setMsgSendYes(String id, String goodsId) {
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		map.put("goodsId", goodsId);
		return this.update("setMsgSendYes", map);
	}

	/**
	 *
	 * <P>
	 * 获取包含指定产品的，预约单（已支付定金的、未发送过预约到货消息的）
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 18, 2017
	 * @param goodsId
	 *            产品ID
	 * @return List<Order>
	 */
	public List<Order> getReserveOrderListByGoodsId(String goodsId) {
		Map<String, String> map = new HashMap<>();
		map.put("goodsId", goodsId);
		return this.getList("getReserveOrderListByGoodsId", map);
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
		Map<String, String> map = new HashMap<>();
		map.put("orderCode", orderCode);
		return this.get("getPaySuccessOrderByOrderCode", map);
	}

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
		Map<String, String> map = new HashMap<>();
		map.put("customerId", customerId);
		map.put("state", state);
		return this.getList("getOrderGroupByBatchCodeByCustomerIdAndState", map);
	}

	/**
	 *
	 * <P>
	 * 获取所有未支付子订单（换货、同商品换货、退货、换够、赔偿）
	 * </p>
	 *
	 * @author 闫枫
	 * @date Apr 3, 2018
	 * @return List<String>
	 */
	public List<String> getNoPayChildOrderIdList() {
		return this.getList("getNoPayChildOrderIdList", null);
	}
}
