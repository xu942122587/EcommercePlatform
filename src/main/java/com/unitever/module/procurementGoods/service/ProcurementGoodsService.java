package com.unitever.module.procurementGoods.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.procurement.model.Procurement;
import com.unitever.module.procurementGoods.dao.manual.ProcurementGoodsDAO;
import com.unitever.module.procurementGoods.model.ProcurementGoods;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.procurementGoods.service->
 * CustomerService. java
 * </p>
 * <P>
 * 采购单商品明细Services
 * </p>
 *
 * @author 闫枫
 * @date Jun 29, 2017
 */
@Service
@Transactional
public class ProcurementGoodsService {

	@Autowired
	private ProcurementGoodsDAO procurementGoodsDAO;

	/**
	 * 保存新信息
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param procurementGoods
	 *            void
	 */
	public int save(ProcurementGoods procurementGoods) {
		if (procurementGoods != null) {
			procurementGoods.setId(UUID.getUUID());
			procurementGoods.setCreateTime(new Date());
			int i = procurementGoodsDAO.save(procurementGoods);
			return i;
		}
		return 0;
	}

	/**
	 * 更新数据
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param procurementGoods
	 * @return int
	 */
	public int update(ProcurementGoods procurementGoods) {
		if (null != procurementGoods) {
			if (StringUtils.isNotBlank(procurementGoods.getId())) {
				int i = procurementGoodsDAO.update(procurementGoods);
				return i;
			}
		}
		return 0;
	}

	/**
	 * 根据Id获取
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return ProcurementGoods
	 */
	public ProcurementGoods getProcurementGoodsById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return procurementGoodsDAO.get(id);
		}
		return null;
	}

	/**
	 * 根据Object获取
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param procurementGoods
	 * @return List<ProcurementGoods>
	 */
	public List<ProcurementGoods> getProcurementGoodsByProcurementGoods(ProcurementGoods procurementGoods) {
		return procurementGoodsDAO.getProcurementGoodsByProcurementGoods(procurementGoods);
	}

	/**
	 * 获取符合当前条件的ProcurementGoods数量
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param procurementGoods
	 * @return int
	 */
	public int getCountByProcurementGoods(ProcurementGoods procurementGoods) {
		return procurementGoodsDAO.getCountByProcurementGoods(procurementGoods);
	}

	/**
	 *
	 * <P>
	 * 获取procurementGoods分页对象
	 * </p>
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param page
	 * @param procurementGoods
	 * @return Page<ProcurementGoods>
	 */
	public Page<ProcurementGoods> getPage(Page<ProcurementGoods> page, ProcurementGoods procurementGoods) {
		if (StringUtils.isNotBlank(procurementGoods.getEndDate())) {
			procurementGoods.setEndDate(procurementGoods.getEndDate() + " 23:59:59");
		}
		List<ProcurementGoods> procurementGoodshandList = procurementGoodsDAO
				.getProcurementGoodsByProcurementGoods(procurementGoods);
		if (StringUtils.isNotBlank(procurementGoods.getEndDate())) {
			procurementGoods.setEndDate(procurementGoods.getEndDate().split(" ")[0]);
		}
		page.setTotalRecord(procurementGoodshandList.size());
		if (procurementGoodshandList.size() >= (page.getStartOfPage() + page.getPageSize())) {
			page.setResults(procurementGoodshandList.subList(page.getStartOfPage(),
					page.getStartOfPage() + page.getPageSize()));
		} else {
			page.setResults(procurementGoodshandList.subList(page.getStartOfPage(), procurementGoodshandList.size()));
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 依据采购单ID获取采购单商品明细list
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @return List<ProcurementGoods>
	 */
	public List<ProcurementGoods> getAllByProcurementId(String procurementId) {
		return StringUtils.isNotBlank(procurementId) ? procurementGoodsDAO.getAllByProcurementId(procurementId) : null;
	}

	/**
	 *
	 * <P>
	 * 批量保存
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param list
	 *            待保存的list
	 * @param procurementId
	 *            采购单ID，新建的采购单必须传入，其他情况可传入null
	 * @return int
	 */
	public int batchInsert(List<ProcurementGoods> list, String procurementId) {
		if (null != list) {
			if (!list.isEmpty()) {
				List<ProcurementGoods> list_to_save = new ArrayList<ProcurementGoods>();
				for (ProcurementGoods procurementGoods : list) {
					if (StringUtils.isNotBlank(procurementGoods.getBuyPrice())) {
						if (null == procurementGoods.getProcurement()
								|| StringUtils.isBlank(procurementGoods.getProcurement().getId())) {
							if (StringUtils.isNotBlank(procurementId)) {
								procurementGoods.setProcurement(new Procurement(procurementId));
							}
						}
						list_to_save.add(procurementGoods);
					}
				}
				list.clear();
				return procurementGoodsDAO.batchInsert(list_to_save);
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 批量更新
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param list
	 * @return int
	 */
	public int batchUpdate(List<ProcurementGoods> list) {
		if (null != list) {
			if (!list.isEmpty()) {
				return procurementGoodsDAO.batchUpdate(list);
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 批量删除
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param list
	 * @return int
	 */
	public int batchDelete(List<ProcurementGoods> list) {
		if (null != list) {
			if (!list.isEmpty()) {
				return procurementGoodsDAO.batchDelete(list);
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 更改已打印数量
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 17, 2017
	 * @param id
	 * @param number
	 * @param printUserId
	 * @return int
	 */
	public int updatePrintNumber(String id, int number, String printUserId) {
		if (StringUtils.isNotBlank(id) && 0 < number) {
			return procurementGoodsDAO.updatePrintNumber(id, number, printUserId);
		}
		return 0;
	}
}
