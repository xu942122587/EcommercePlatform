package com.unitever.module.allocationQrcode.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.allocation.model.Allocation;
import com.unitever.module.allocationQrcode.dao.manual.AllocationQrcodeDAO;
import com.unitever.module.allocationQrcode.model.AllocationQrcode;
import com.unitever.module.inventory.dao.manual.InventoryDAO;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.allocationQrcode.service->
 * AllocationQrcodeService.java
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
public class AllocationQrcodeService {

	@Autowired
	private AllocationQrcodeDAO allocationQrcodeDAO;
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
	 * @param allocationQrcode
	 * @return int
	 */
	public String save(AllocationQrcode allocationQrcode) {
		if (allocationQrcode != null) {
			allocationQrcode.setId(UUID.getUUID());
			allocationQrcode.setCreateTime(new Date());
			allocationQrcodeDAO.save(allocationQrcode);
			String allocationQrcodeId = allocationQrcode.getId();
			return allocationQrcodeId;
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
	 * @return AllocationQrcode
	 */
	public AllocationQrcode getAllocationQrcodeById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return allocationQrcodeDAO.get(id);
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
	 * @param allocationQrcode
	 * @return List<AllocationQrcode>
	 */
	public List<AllocationQrcode> getAllocationQrcodeByAllocationQrcode(AllocationQrcode allocationQrcode) {
		return allocationQrcodeDAO.getAllocationQrcodeByAllocationQrcode(allocationQrcode);
	}

	/**
	 *
	 * <P>
	 * 根据调拨单Id,按照商品排序,获得信息和商品数量(QrcodeCount)
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月14日
	 * @param id
	 * @return List<AllocationQrcode>
	 */
	public List<AllocationQrcode> getQrcodeCountByAllocationId(String id) {
		List<AllocationQrcode> qrcodeCountList = allocationQrcodeDAO.getQrcodeCountByAllocationId(id);
		for (AllocationQrcode allocationQrcode : qrcodeCountList) {
			allocationQrcode.setOutStorageCount(inventoryDAO.getInventoryCountByGoodsIdAndStorageId(allocationQrcode
					.getGoods().getId(), allocationQrcode.getAllocation().getOutStorage().getId()));
			allocationQrcode.setInStorageCount(inventoryDAO.getInventoryCountByGoodsIdAndStorageId(allocationQrcode
					.getGoods().getId(), allocationQrcode.getAllocation().getInStorage().getId()));
		}
		return qrcodeCountList;
	}

	/**
	 * 获取符合当前条件的AllocationQrcode数量
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param ProcurementQrcode
	 * @return int
	 */
	public int getCountByAllocationQrcode(AllocationQrcode allocationQrcode) {
		return allocationQrcodeDAO.getCountByObject(allocationQrcode);
	}

	/**
	 *
	 * <P>
	 * 获取AllocationQrcode分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月14日
	 * @param page
	 * @param allocationQrcode
	 * @return Page<AllocationQrcode>
	 */
	public Page<AllocationQrcode> getPage(Page<AllocationQrcode> page, AllocationQrcode allocationQrcode) {
		if (StringUtils.isNotBlank(allocationQrcode.getEndDate())) {
			allocationQrcode.setEndDate(allocationQrcode.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(allocationQrcodeDAO.getCountByObject(allocationQrcode));
		allocationQrcode.setStartOfPage(page.getStartOfPage());
		allocationQrcode.setPageSize(page.getPageSize());
		page.setResults(allocationQrcodeDAO.getAllocationQrcodeByAllocationQrcode(allocationQrcode));
		if (StringUtils.isNotBlank(allocationQrcode.getEndDate())) {
			allocationQrcode.setEndDate(allocationQrcode.getEndDate().split(" ")[0]);
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
	public int batchInsert(List<AllocationQrcode> list, String allocationId) {
		if (null != list) {
			if (!list.isEmpty()) {
				if (StringUtils.isNotBlank(allocationId)) {
					if (null == list.get(0).getAllocation() || StringUtils.isBlank(list.get(0).getAllocation().getId())) {
						List<AllocationQrcode> list_to_save = new ArrayList<AllocationQrcode>();
						for (AllocationQrcode allocationQrcode : list) {
							allocationQrcode.setAllocation(new Allocation(allocationId));
							list_to_save.add(allocationQrcode);
						}
						list.clear();
						return allocationQrcodeDAO.batchInsert(list_to_save);
					} else {
						return allocationQrcodeDAO.batchInsert(list);
					}
				} else {
					if (null == list.get(0).getAllocation() || StringUtils.isBlank(list.get(0).getAllocation().getId())) {
						return 0;
					}
					return allocationQrcodeDAO.batchInsert(list);
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
	public int deleteAllocationQrcode(String id) {
		if (StringUtils.isNotBlank(id)) {
			return allocationQrcodeDAO.delete(id);
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
	 * @return List<AllocationQrcode>
	 */
	public List<AllocationQrcode> getAllocationQrcodeListByAllocationId(String id) {
		return allocationQrcodeDAO.getAllocationQrcodeListByAllocationId(id);
	}
}
