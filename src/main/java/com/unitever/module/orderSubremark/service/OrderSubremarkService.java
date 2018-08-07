package com.unitever.module.orderSubremark.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.orderSubremark.dao.manual.OrderSubremarkDAO;
import com.unitever.module.orderSubremark.model.OrderSubremark;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

@Service
@Transactional
public class OrderSubremarkService {

	@Autowired
	private OrderSubremarkDAO orderSubremarkDAO;

	/**
	 *
	 * <P>
	 * 保存新订单减免记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param orderSubremark
	 * @return int
	 */
	public int save(OrderSubremark orderSubremark) {
		if (orderSubremark != null) {
			orderSubremark.setId(UUID.getUUID());
			orderSubremark.setCreateTime(new Date());
			int i = orderSubremarkDAO.save(orderSubremark);
			return i;
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 更新订单减免记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param orderSubremark
	 * @return int
	 */
	public int update(OrderSubremark orderSubremark) {
		if (null != orderSubremark) {
			if (StringUtils.isNotBlank(orderSubremark.getId())) {
				int i = orderSubremarkDAO.update(orderSubremark);
				return i;
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 根据Id获取订单减免记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param id
	 * @return OrderSubremark
	 */
	public OrderSubremark getOrderSubremarkById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return orderSubremarkDAO.get(id);
		}
		return null;
	}

	/**
	 *
	 * <P>
	 * 根据订单减免记录获取订单减免记录列表
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param orderSubremark
	 * @return List<OrderSubremark>
	 */
	public List<OrderSubremark> getOrderSubremarkByOrderSubremark(OrderSubremark orderSubremark) {
		return orderSubremarkDAO.getOrderSubremarkByOrderSubremark(orderSubremark);
	}

	/**
	 *
	 * <P>
	 * 获取符合当前条件的订单减免记录数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param orderSubremark
	 * @return int
	 */
	public int getCountByOrderSubremark(OrderSubremark orderSubremark) {
		return orderSubremarkDAO.getCountByOrderSubremark(orderSubremark);
	}

	/**
	 *
	 * <P>
	 * 获取订单减免记录分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param page
	 * @param orderSubremark
	 * @return Page<OrderSubremark>
	 */
	public Page<OrderSubremark> getPage(Page<OrderSubremark> page, OrderSubremark orderSubremark) {
		if (StringUtils.isNotBlank(orderSubremark.getEndDate())) {
			orderSubremark.setEndDate(orderSubremark.getEndDate() + " 23:59:59");
		}
		List<OrderSubremark> orderSubremarkhandList = orderSubremarkDAO
				.getOrderSubremarkByOrderSubremark(orderSubremark);
		if (StringUtils.isNotBlank(orderSubremark.getEndDate())) {
			orderSubremark.setEndDate(orderSubremark.getEndDate().split(" ")[0]);
		}
		page.setTotalRecord(orderSubremarkhandList.size());
		if (orderSubremarkhandList.size() >= (page.getStartOfPage() + page.getPageSize())) {
			page.setResults(orderSubremarkhandList.subList(page.getStartOfPage(),
					page.getStartOfPage() + page.getPageSize()));
		} else {
			page.setResults(orderSubremarkhandList.subList(page.getStartOfPage(), orderSubremarkhandList.size()));
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 删除订单减免记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param id
	 * @return int
	 */
	public int deleteOrderSubremark(String id) {
		if (StringUtils.isNotBlank(id)) {
			return orderSubremarkDAO.delete(id);
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 获取所有订单减免记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @return List<OrderSubremark>
	 */
	public List<OrderSubremark> getAllOrderSubremark() {
		return orderSubremarkDAO.getAll();
	}

}
