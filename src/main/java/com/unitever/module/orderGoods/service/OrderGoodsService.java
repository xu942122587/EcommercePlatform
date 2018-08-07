package com.unitever.module.orderGoods.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.orderGoods.dao.manual.OrderGoodsDAO;
import com.unitever.module.orderGoods.model.OrderGoods;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

@Service
@Transactional
public class OrderGoodsService {

	@Autowired
	private OrderGoodsDAO orderGoodsDAO;

	/**
	 *
	 * <P>
	 * 保存新订单商品关联
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param orderGoods
	 * @return int
	 */
	public int save(OrderGoods orderGoods) {
		if (orderGoods != null) {
			orderGoods.setId(UUID.getUUID());
			orderGoods.setCreateTime(new Date());
			int i = orderGoodsDAO.save(orderGoods);
			return i;
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 更新订单商品关联
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param orderGoods
	 * @return int
	 */
	public int update(OrderGoods orderGoods) {
		if (null != orderGoods) {
			if (StringUtils.isNotBlank(orderGoods.getId())) {
				int i = orderGoodsDAO.update(orderGoods);
				return i;
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 根据Id获取订单商品关联
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param id
	 * @return OrderGoods
	 */
	public OrderGoods getOrderGoodsById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return orderGoodsDAO.get(id);
		}
		return null;
	}

	/**
	 *
	 * <P>
	 * 根据订单商品关联获取订单商品关联列表
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param orderGoods
	 * @return List<OrderGoods>
	 */
	public List<OrderGoods> getOrderGoodsByOrderGoods(OrderGoods orderGoods) {
		return orderGoodsDAO.getOrderGoodsByOrderGoods(orderGoods);
	}

	/**
	 *
	 * <P>
	 * 获取符合当前条件的订单商品关联数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param orderGoods
	 * @return int
	 */
	public int getCountByOrderGoods(OrderGoods orderGoods) {
		return orderGoodsDAO.getCountByOrderGoods(orderGoods);
	}

	/**
	 *
	 * <P>
	 * 获取订单商品关联分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param page
	 * @param orderGoods
	 * @return Page<OrderGoods>
	 */
	public Page<OrderGoods> getPage(Page<OrderGoods> page, OrderGoods orderGoods) {
		if (StringUtils.isNotBlank(orderGoods.getEndDate())) {
			orderGoods.setEndDate(orderGoods.getEndDate() + " 23:59:59");
		}
		List<OrderGoods> orderGoodshandList = orderGoodsDAO.getOrderGoodsByOrderGoods(orderGoods);
		if (StringUtils.isNotBlank(orderGoods.getEndDate())) {
			orderGoods.setEndDate(orderGoods.getEndDate().split(" ")[0]);
		}
		page.setTotalRecord(orderGoodshandList.size());
		if (orderGoodshandList.size() >= (page.getStartOfPage() + page.getPageSize())) {
			page.setResults(orderGoodshandList.subList(page.getStartOfPage(),
					page.getStartOfPage() + page.getPageSize()));
		} else {
			page.setResults(orderGoodshandList.subList(page.getStartOfPage(), orderGoodshandList.size()));
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 删除订单商品关联
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param id
	 * @return int
	 */
	public int deleteOrderGoods(String id) {
		if (StringUtils.isNotBlank(id)) {
			return orderGoodsDAO.delete(id);
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 获取所有订单商品关联
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @return List<OrderGoods>
	 */
	public List<OrderGoods> getAllOrderGoods() {
		return orderGoodsDAO.getAll();
	}

	/**
	 *
	 * <P>
	 * 根据orderId获取OrderGoods集合
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月17日
	 * @param orderId
	 * @return List<OrderGoods>
	 */
	public List<OrderGoods> getAllByOrderId(String orderId) {
		return orderGoodsDAO.getAllByOrderId(orderId);
	}

	/**
	 *
	 * <P>
	 * 根据qrcodeId获取卖出OrderGoodsList(根据时间倒叙,取0拿最新一次)
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月18日
	 * @param qrcodeId
	 * @return List<OrderGoods>
	 */
	public List<OrderGoods> getOrderGoodsByQrcodeId(String qrcodeId) {
		return orderGoodsDAO.getOrderGoodsByQrcodeId(qrcodeId);
	}

	/**
	 *
	 * <P>
	 * 根据主订单Id获取OrderGoods集合
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月17日
	 * @param orderId
	 * @return List<OrderGoods>
	 */
	public List<OrderGoods> getAllByParentOrderId(String orderId) {
		return orderGoodsDAO.getAllByParentOrderId(orderId);
	}
}
