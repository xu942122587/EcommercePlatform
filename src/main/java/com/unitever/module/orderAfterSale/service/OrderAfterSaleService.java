package com.unitever.module.orderAfterSale.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.orderAfterSale.dao.manual.OrderAfterSaleDAO;
import com.unitever.module.orderAfterSale.model.OrderAfterSale;
import com.unitever.module.qrcode.dao.manual.QrcodeDAO;
import com.unitever.platform.component.attachment.util.AttachmentUtil;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.external.UserUtil;
import com.unitever.platform.util.StringReplace;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.orderAfterSale.service->
 * OrderAfterSaleService. java
 * </p>
 * <P>
 * 售后管理
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月7日
 */
@Service
@Transactional
public class OrderAfterSaleService {

	@Autowired
	private OrderAfterSaleDAO orderAfterSaleDAO;
	@Autowired
	private QrcodeDAO qrcodeDAO;

	/**
	 *
	 * <P>
	 * 保存新售后管理
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param orderAfterSale
	 * @return int
	 */
	public int save(OrderAfterSale orderAfterSale) {
		if (orderAfterSale != null) {
			orderAfterSale.setId(UUID.getUUID());
			if (null != UserUtil.getCurrUser() && StringUtils.isNotBlank(UserUtil.getCurrUser().getId())) {
				orderAfterSale.setUser(UserUtil.getCurrUser());
			}
			orderAfterSale.setRemark(StringReplace.replaceHtmlToOther(orderAfterSale.getRemark()));
			orderAfterSale.setCreateTime(new Date());
			orderAfterSale.setIsDelete(OrderAfterSale.ISDELETE_NO);
			int i = orderAfterSaleDAO.save(orderAfterSale);
			if (0 < i) {
				AttachmentUtil.bindAttachment(orderAfterSale);
				return i;
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 更新售后管理
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param orderAfterSale
	 * @return int
	 */
	public int update(OrderAfterSale orderAfterSale) {
		if (null != orderAfterSale) {
			if (StringUtils.isNotBlank(orderAfterSale.getId())) {
				int i = orderAfterSaleDAO.update(orderAfterSale);
				return i;
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 根据Id获取售后管理
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param id
	 * @return OrderAfterSale
	 */
	public OrderAfterSale getOrderAfterSaleById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return orderAfterSaleDAO.get(id);
		}
		return null;
	}

	/**
	 *
	 * <P>
	 * 根据售后管理获取售后管理列表
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param orderAfterSale
	 * @return List<OrderAfterSale>
	 */
	public List<OrderAfterSale> getOrderAfterSaleByOrderAfterSale(OrderAfterSale orderAfterSale) {
		return orderAfterSaleDAO.getOrderAfterSaleByOrderAfterSale(orderAfterSale);
	}

	/**
	 *
	 * <P>
	 * 获取符合当前条件的售后管理数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param orderAfterSale
	 * @return int
	 */
	public int getCountByOrderAfterSale(OrderAfterSale orderAfterSale) {
		return orderAfterSaleDAO.getCountByOrderAfterSale(orderAfterSale);
	}

	/**
	 *
	 * <P>
	 * 获取售后管理分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param page
	 * @param orderAfterSale
	 * @return Page<OrderAfterSale>
	 */
	public Page<OrderAfterSale> getPage(Page<OrderAfterSale> page, OrderAfterSale orderAfterSale) {
		if (StringUtils.isNotBlank(orderAfterSale.getEndDate())) {
			orderAfterSale.setEndDate(orderAfterSale.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(orderAfterSaleDAO.getCountByObject(orderAfterSale));
		orderAfterSale.setStartOfPage(page.getStartOfPage());
		orderAfterSale.setPageSize(page.getPageSize());
		page.setResults(orderAfterSaleDAO.getOrderAfterSaleByOrderAfterSale(orderAfterSale));
		if (StringUtils.isNotBlank(orderAfterSale.getEndDate())) {
			orderAfterSale.setEndDate(orderAfterSale.getEndDate().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 删除售后管理(假删除)
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月3日
	 * @param id
	 * @return int
	 */
	public int deleteOrderAfterSale(String id) {
		if (StringUtils.isNotBlank(id)) {
			OrderAfterSale orderAfterSale = new OrderAfterSale(id);
			orderAfterSale.setIsDelete(OrderAfterSale.ISDELETE_YES);
			return orderAfterSaleDAO.update(orderAfterSale);
		}
		return 0;
	}

}
