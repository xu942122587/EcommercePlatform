package com.unitever.module.allocation.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.allocation.dao.manual.AllocationDAO;
import com.unitever.module.allocation.model.Allocation;
import com.unitever.module.allocationQrcode.service.AllocationQrcodeService;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.OrderCodeID;
import com.unitever.platform.util.UUID;

@Service
@Transactional
public class AllocationService {

	@Autowired
	private AllocationDAO allocationDAO;
	@Autowired
	private AllocationQrcodeService allocationQrcodeService;

	/**
	 *
	 * <P>
	 * 保存新库存调拨
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param allocation
	 * @return int
	 */
	public String save(Allocation allocation) {
		if (allocation != null) {
			allocation.setId(UUID.getUUID());
			allocation.setIsDelete(Allocation.ISDELETE_NO);
			allocation.setState(Allocation.STATE_FALSE);
			allocation.setAllocationCode(OrderCodeID.nextCode());
			allocation.setCreateTime(new Date());
			allocationDAO.save(allocation);
			return allocation.getId();
		}
		return null;
	}

	/**
	 *
	 * <P>
	 * 更新库存调拨
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param allocation
	 * @return int
	 */
	public int update(Allocation allocation) {
		if (null != allocation) {
			if (StringUtils.isNotBlank(allocation.getId())) {
				int i = allocationDAO.update(allocation);
				return i;
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 根据Id获取库存调拨
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param id
	 * @return allocation
	 */
	public Allocation getAllocationById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return allocationDAO.get(id);
		}
		return null;
	}

	/**
	 *
	 * <P>
	 * 根据库存调拨获取库存调拨列表
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param allocation
	 * @return List<allocation>
	 */
	public List<Allocation> getAllocationByAllocation(Allocation allocation) {
		return allocationDAO.getAllocationByAllocation(allocation);
	}

	/**
	 *
	 * <P>
	 * 获取符合当前条件的库存调拨数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param allocation
	 * @return int
	 */
	public int getCountByAllocation(Allocation allocation) {
		return allocationDAO.getCountByObject(allocation);
	}

	/**
	 *
	 * <P>
	 * 获取库存调拨分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param page
	 * @param allocation
	 * @return Page<allocation>
	 */
	public Page<Allocation> getPage(Page<Allocation> page, Allocation allocation) {
		if (StringUtils.isNotBlank(allocation.getEndDate())) {
			allocation.setEndDate(allocation.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(allocationDAO.getCountByObject(allocation));
		allocation.setStartOfPage(page.getStartOfPage());
		allocation.setPageSize(page.getPageSize());
		page.setResults(allocationDAO.getAllocationByAllocation(allocation));
		if (StringUtils.isNotBlank(allocation.getEndDate())) {
			allocation.setEndDate(allocation.getEndDate().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 删除库存调拨
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param id
	 * @return int
	 */
	public int deleteAllocation(String id) {
		if (StringUtils.isNotBlank(id)) {
			Allocation allocation = new Allocation(id);
			allocation.setIsDelete(Allocation.ISDELETE_YES);
			return allocationDAO.update(allocation);
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 获取所有库存调拨
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @return List<allocation>
	 */
	public List<Allocation> getAllAllocation() {
		return allocationDAO.getAll();
	}

}
