package com.unitever.module.orderGoodsQrcode.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.orderGoodsQrcode.model.OrderGoodsQrcode;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class OrderGoodsQrcodeDAO extends BaseDAO<OrderGoodsQrcode, String> {

	/**
	 * 根据Object获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param Goods
	 * @return List<OrderGoodsQrcoede>
	 */
	public List<OrderGoodsQrcode> getOrderGoodsQrcodeByOrderGoodsQrcode(OrderGoodsQrcode orderGoodsQrcoede) {
		return this.getList("getOrderGoodsQrcodeByOrderGoodsQrcode", orderGoodsQrcoede);
	}

	/**
	 * 依据qrcodeId获取对应的二维码关联关系记录
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param Goods
	 * @return List<OrderGoodsQrcoede>
	 */
	public OrderGoodsQrcode getAllByQrcodeId(String qrcodeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("qrcodeId", qrcodeId);
		return this.get("getAllByQrcodeId", map);
	}

	/**
	 *
	 * <P>
	 * 订单保存发货qrcode
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 1, 2017
	 * @param orderGoodsQrcode
	 * @return int
	 */
	public int saveOGQ(OrderGoodsQrcode orderGoodsQrcode) {
		return this.save("saveOGQ", orderGoodsQrcode);
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
	 * @return int
	 */
	public int orderDeleteQrcode(String orderId, String qRCodeID) {
		Map<String, String> map = new HashMap<>();
		map.put("orderId", orderId);
		map.put("qRCodeID", qRCodeID);
		return this.delete("orderDeleteQrcode", map);
	}

}
