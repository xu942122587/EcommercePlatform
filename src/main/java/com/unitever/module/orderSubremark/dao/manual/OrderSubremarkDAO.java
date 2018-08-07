package com.unitever.module.orderSubremark.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.orderSubremark.model.OrderSubremark;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class OrderSubremarkDAO extends BaseDAO<OrderSubremark, String> {

	/**
	 * 根据Object获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param Goods
	 * @return List<OrderSubremark>
	 */
	public List<OrderSubremark> getOrderSubremarkByOrderSubremark(OrderSubremark orderSubremark) {
		return this.getList("getOrderSubremarkByOrderSubremark", orderSubremark);
	}

	/**
	 * 获取符合当前条件的OrderSubremark数量
	 * 
	 * @author XiaoYu
	 * @date 2016年12月28日
	 * @param Goods
	 * @return int
	 */
	public int getCountByOrderSubremark(OrderSubremark orderSubremark) {
		return this.get("getCountByOrderSubremark", orderSubremark);
	}

	/**
	 *
	 * <P>
	 * 删除赠品
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 3, 2017
	 * @param id
	 * @param qRCodeID
	 * @return int
	 */
	public int deletePutOutQrcode(String orderSubremarkId, String qRCodeID) {
		Map<String, String> map = new HashMap<>();
		map.put("orderSubremarkId", orderSubremarkId);
		map.put("qRCodeID", qRCodeID);
		return this.update("deletePutOutQrcode", map);
	}

	/**
	 *
	 * <P>
	 * 活动优惠更新为已发放--换购类
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 4, 2017
	 * @param id
	 *            主订单Id
	 * @param goods_id_string
	 *            参与活动的产品ID字符串
	 * @return int
	 */
	@Deprecated
	public int setFinishByGoodsIdsAndParentOrderId(String parentOrderId, String goods_id_string) {
		Map<String, String> map = new HashMap<>();
		map.put("parentOrderId", parentOrderId);
		map.put("goods_id_string", goods_id_string);
		return this.update("setFinishByGoodsIdsAndParentOrderId", map);
	}

	/**
	 *
	 * <P>
	 * 活动优惠更新为未发放--换购类
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 4, 2017
	 * @param id
	 *            主订单Id
	 * @param goods_id_string
	 *            参与活动的产品ID字符串
	 * @return int
	 */
	@Deprecated
	public int setNoFinishByGoodsIdsAndParentOrderId(String parentOrderId, String goods_id_string) {
		Map<String, String> map = new HashMap<>();
		map.put("parentOrderId", parentOrderId);
		map.put("goods_id_string", goods_id_string);
		return this.update("setNoFinishByGoodsIdsAndParentOrderId", map);
	}

	/**
	 *
	 * <P>
	 * 依据优惠记录ID字符串更新优惠记录为已发放
	 * </p>
	 *
	 * @author 闫枫
	 * @date May 11, 2018
	 * @param oSM_ID
	 *            发放记录ID字符串
	 * @return int
	 */
	public int setFinishByOSM_ID(String oSM_ID) {
		Map<String, String> map = new HashMap<>();
		map.put("oSM_ID", oSM_ID);
		return this.update("setFinishByOSM_ID", map);
	}

	/**
	 *
	 * <P>
	 * 依据优惠记录ID字符串更新优惠记录为未发放
	 * </p>
	 *
	 * @author 闫枫
	 * @date May 11, 2018
	 * @param oSM_ID
	 *            发放记录ID字符串
	 * @return int
	 */
	public int setNoFinishByOSM_ID(String oSM_ID) {
		Map<String, String> map = new HashMap<>();
		map.put("oSM_ID", oSM_ID);
		return this.update("setNoFinishByOSM_ID", map);
	}

}
