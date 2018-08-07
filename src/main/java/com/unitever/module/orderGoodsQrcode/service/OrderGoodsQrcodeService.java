package com.unitever.module.orderGoodsQrcode.service;

import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.orderGoodsQrcode.dao.manual.OrderGoodsQrcodeDAO;
import com.unitever.module.orderGoodsQrcode.model.OrderGoodsQrcode;
import com.unitever.platform.util.UUID;

@Service
@Transactional
public class OrderGoodsQrcodeService {

	@Autowired
	private OrderGoodsQrcodeDAO orderGoodsQrcodeDAO;

	public int save(OrderGoodsQrcode orderGoodsQrcoede) {
		if (orderGoodsQrcoede != null) {
			orderGoodsQrcoede.setId(UUID.getUUID());
			orderGoodsQrcoede.setCreateTime(new Date());
			int i = orderGoodsQrcodeDAO.save(orderGoodsQrcoede);
			return i;
		}
		return 0;
	}

	public int update(OrderGoodsQrcode orderGoodsQrcoede) {
		if (null != orderGoodsQrcoede) {
			if (StringUtils.isNotBlank(orderGoodsQrcoede.getId())) {
				int i = orderGoodsQrcodeDAO.update(orderGoodsQrcoede);
				return i;
			}
		}
		return 0;
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
		return orderGoodsQrcodeDAO.getAllByQrcodeId(qrcodeId);
	}
}
