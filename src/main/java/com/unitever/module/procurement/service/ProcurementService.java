package com.unitever.module.procurement.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.procurement.dao.manual.ProcurementDAO;
import com.unitever.module.procurement.model.Procurement;
import com.unitever.module.procurementGoods.service.ProcurementGoodsService;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.DateUtil;
import com.unitever.platform.util.OrderCodeID;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.procurement.service->ProcurementService.
 * java
 * </p>
 * <P>
 * 采购订单（退货单）
 * </p>
 *
 * @author 闫枫
 * @date Jul 6, 2017
 */
@Service
@Transactional
public class ProcurementService {

	@Autowired
	private ProcurementDAO procurementDAO;
	@Autowired
	private ProcurementGoodsService procurementGoodsService;

	/**
	 * 保存新采购订单（退货单）
	 * 
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param procurement
	 *            void
	 */
	public int save(Procurement procurement) {
		if (procurement != null) {
			procurement.setId(UUID.getUUID());
			procurement.setCreateTime(new Date());
			procurement.setIsDelete(Procurement.ISDELETE_NO);
			procurement.setProcurementCode(OrderCodeID.nextCode());
			procurement.setState(Procurement.STATE_ONE);
			int i = procurementDAO.save(procurement);
			if (0 < i) {
				procurementGoodsService.batchInsert(procurement.getProcurementGoodsListNew(), procurement.getId());
				return i;
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 保存采购退货
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param allocation
	 * @return int
	 */
	public String returnSave(Procurement procurement) {
		if (procurement != null) {
			procurement.setId(UUID.getUUID());
			procurement.setState(Procurement.STATE_SEVEN);
			procurement.setType(Procurement.TYPE_TWO);
			procurement.setCount("0");
			procurement.setSumMoney("0");
			procurement.setProcurementCode(OrderCodeID.nextCode());
			procurement.setCreateTime(new Date());
			procurement.setIsDelete(Procurement.ISDELETE_NO);
			if (0 >= procurementDAO.save(procurement)) {
				return null;
			} else {
				return procurement.getId();
			}

		}
		return null;
	}

	/**
	 * 更新采购订单（退货单）
	 * 
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param procurement
	 * @return int
	 */
	public int update(Procurement procurement) {
		if (null != procurement) {
			if (StringUtils.isNotBlank(procurement.getId())) {
				if (StringUtils.isNotBlank(procurement.getCheckRemark())) {
					procurement.setCheckRemark(DateUtil.getCurrDateString() + ":" + procurement.getCheckRemark());
				}
				int i = procurementDAO.update(procurement);
				if (0 < i) {
					procurementGoodsService.batchInsert(procurement.getProcurementGoodsListNew(), null);
					procurementGoodsService.batchUpdate(procurement.getProcurementGoodsList());
					procurementGoodsService.batchDelete(procurement.getProcurementGoodsListDel());
					return i;
				}
			}
		}
		return 0;
	}

	/**
	 * 根据Id获取采购订单（退货单）
	 * 
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param id
	 * @return Procurement
	 */
	public Procurement getProcurementById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return procurementDAO.get(id);
		}
		return null;
	}

	/**
	 * 根据采购订单（退货单）获取采购订单（退货单）
	 * 
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param procurement
	 * @return List<Procurement>
	 */
	public List<Procurement> getProcurementByProcurement(Procurement procurement) {
		return procurementDAO.getProcurementByProcurement(procurement);
	}

	/**
	 * 获取符合当前条件的采购订单（退货单）数量
	 * 
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param procurement
	 * @return int
	 */
	public int getCountByProcurement(Procurement procurement) {
		return procurementDAO.getCountByProcurement(procurement);
	}

	/**
	 *
	 * <P>
	 * 获取所有采购订单（退货单）
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 1, 2017
	 * @return Object
	 */
	public List<Procurement> getAll() {
		return procurementDAO.getAll();
	}

	/**
	 *
	 * <P>
	 * 获取采购订单（退货单）分页对象
	 * </p>
	 * 
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param page
	 * @param procurement
	 * @return Page<Procurement>
	 */
	public Page<Procurement> getPage(Page<Procurement> page, Procurement procurement) {
		if (StringUtils.isNotBlank(procurement.getEndDate())) {
			procurement.setEndDate(procurement.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(procurementDAO.getCountByObject(procurement));
		procurement.setStartOfPage(page.getStartOfPage());
		procurement.setPageSize(page.getPageSize());
		page.setResults(procurementDAO.getProcurementByProcurement(procurement));
		if (StringUtils.isNotBlank(procurement.getEndDate())) {
			procurement.setEndDate(procurement.getEndDate().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 删除采购订单（退货单）--假删除
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 3, 2017
	 * @param id
	 * @return int
	 */
	public int deleteProcurement(String id) {
		if (StringUtils.isNotBlank(id)) {
			Procurement procurement = new Procurement(id);
			procurement.setIsDelete(Procurement.ISDELETE_YES);
			return procurementDAO.update(procurement);
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 审核
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 11, 2017
	 * @param procurement
	 * @return int
	 */
	public int check(Procurement procurement) {
		if (null != procurement)
			if (StringUtils.isNotBlank(procurement.getId()))
				return procurementDAO.update(procurement);
		return 0;
	}

	/**
	 *
	 * <P>
	 * 采购到货
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 12, 2017
	 * @param procurement
	 * @return int
	 */
	public int proGoodsGoHome(Procurement procurement) {
		if (null != procurement) {
			if (StringUtils.isNotBlank(procurement.getId())) {
				procurement.setState(Procurement.STATE_SIX);
				return procurementDAO.update(procurement);
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 依据订单Code获取采购单
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 13, 2017
	 * @param proCode
	 * @return Object
	 */
	public Procurement getProcurementByProCode(String proCode) {
		return procurementDAO.getProcurementByProCode(proCode);
	}

}
