package com.unitever.module.procurementQrcode.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.inventory.dao.manual.InventoryDAO;
import com.unitever.module.procurement.model.Procurement;
import com.unitever.module.procurementQrcode.dao.manual.ProcurementQrcodeDAO;
import com.unitever.module.procurementQrcode.model.ProcurementQrcode;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.procurementQrcode.service->
 * ProcurementQrcodeService.java
 * </p>
 * <P>
 * 调拨库存Service
 * </p>
 *
 * @author 徐昊
 * @date 2017年7月14日
 */
@Service
@Transactional
public class ProcurementQrcodeService {

	@Autowired
	private ProcurementQrcodeDAO procurementQrcodeDAO;
	@Autowired
	private InventoryDAO inventoryDAO;

	/**
	 *
	 * <P>
	 * 保存新信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月14日
	 * @param procurementQrcode
	 * @return int
	 */
	public String save(ProcurementQrcode procurementQrcode) {
		if (procurementQrcode != null) {
			procurementQrcode.setId(UUID.getUUID());
			procurementQrcode.setCreateTime(new Date());
			if (0 >= procurementQrcodeDAO.save(procurementQrcode)) {
				return "";
			} else {
				String procurementQrcodeId = procurementQrcode.getId();
				return procurementQrcodeId;
			}
		}
		return "";
	}

	/**
	 *
	 * <P>
	 * 根据Id获取
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月14日
	 * @param id
	 * @return ProcurementQrcode
	 */
	public ProcurementQrcode getProcurementQrcodeById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return procurementQrcodeDAO.get(id);
		}
		return null;
	}

	/**
	 *
	 * <P>
	 * 根据Object获取
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月14日
	 * @param procurementQrcode
	 * @return List<ProcurementQrcode>
	 */
	public List<ProcurementQrcode> getProcurementQrcodeByProcurementQrcode(ProcurementQrcode procurementQrcode) {
		return procurementQrcodeDAO.getProcurementQrcodeByProcurementQrcode(procurementQrcode);
	}

	/**
	 * 获取符合当前条件的ProcurementQrcode数量
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param ProcurementQrcode
	 * @return int
	 */
	public int getCountByProcurementQrcode(ProcurementQrcode procurementQrcode) {
		return procurementQrcodeDAO.getCountByProcurementQrcode(procurementQrcode);
	}

	/**
	 *
	 * <P>
	 * 获取ProcurementQrcode分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月14日
	 * @param page
	 * @param procurementQrcode
	 * @return Page<ProcurementQrcode>
	 */
	public Page<ProcurementQrcode> getPage(Page<ProcurementQrcode> page, ProcurementQrcode procurementQrcode) {
		if (StringUtils.isNotBlank(procurementQrcode.getEndDate())) {
			procurementQrcode.setEndDate(procurementQrcode.getEndDate() + " 23:59:59");
		}
		List<ProcurementQrcode> procurementQrcodehandList = procurementQrcodeDAO
				.getProcurementQrcodeByProcurementQrcode(procurementQrcode);
		if (StringUtils.isNotBlank(procurementQrcode.getEndDate())) {
			procurementQrcode.setEndDate(procurementQrcode.getEndDate().split(" ")[0]);
		}
		page.setTotalRecord(procurementQrcodehandList.size());
		if (procurementQrcodehandList.size() >= (page.getStartOfPage() + page.getPageSize())) {
			page.setResults(procurementQrcodehandList.subList(page.getStartOfPage(),
					page.getStartOfPage() + page.getPageSize()));
		} else {
			page.setResults(procurementQrcodehandList.subList(page.getStartOfPage(), procurementQrcodehandList.size()));
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 批量保存
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月15日
	 * @param list
	 *            调拨库存二维码集合
	 * @param allocationId
	 *            调拨单Id
	 * @return int
	 */
	public int batchInsert(List<ProcurementQrcode> list, String allocationId) {
		if (null != list) {
			if (!list.isEmpty()) {
				if (StringUtils.isNotBlank(allocationId)) {
					if (null == list.get(0).getProcurement()
							|| StringUtils.isBlank(list.get(0).getProcurement().getId())) {
						List<ProcurementQrcode> list_to_save = new ArrayList<ProcurementQrcode>();
						for (ProcurementQrcode procurementQrcode : list) {
							procurementQrcode.setProcurement(new Procurement(allocationId));
							list_to_save.add(procurementQrcode);
						}
						list.clear();
						return procurementQrcodeDAO.batchInsert(list_to_save);
					} else {
						return procurementQrcodeDAO.batchInsert(list);
					}
				} else {
					if (null == list.get(0).getProcurement()
							|| StringUtils.isBlank(list.get(0).getProcurement().getId())) {
						return 0;
					}
					return procurementQrcodeDAO.batchInsert(list);
				}
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 删除调拨记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param id
	 * @return int
	 */
	public int deleteProcurementQrcode(String id) {
		if (StringUtils.isNotBlank(id)) {
			return procurementQrcodeDAO.delete(id);
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 根据调拨单Id获得所有调拨记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月19日
	 * @param id
	 * @return List<ProcurementQrcode>
	 */
	public List<ProcurementQrcode> getProcurementQrcodeListByProcurementId(String id) {
		return procurementQrcodeDAO.getProcurementQrcodeListByProcurementId(id);
	}
}
