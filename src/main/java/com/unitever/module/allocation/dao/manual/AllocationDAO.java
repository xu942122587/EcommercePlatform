package com.unitever.module.allocation.dao.manual;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.unitever.module.allocation.model.Allocation;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class AllocationDAO extends BaseDAO<Allocation, String> {

	/**
	 *
	 * <P>根据Object获取</p>
	 *
	 * @author 徐昊
	 * @date 2017年7月14日
	 * @param allocation
	 * @return List<Allocation>
	 */
	public List<Allocation> getAllocationByAllocation(Allocation allocation) {
		return this.getList("getAllocationByAllocation", allocation);
	}

	/**
	 *
	 * <P>获取符合当前条件的Allocation数量</p>
	 *
	 * @author 徐昊
	 * @date 2017年7月14日
	 * @param allocation
	 * @return int
	 */
	public int getCountByAllocation(Allocation allocation) {
		return this.get("getCountByAllocation", allocation);
	}

}
