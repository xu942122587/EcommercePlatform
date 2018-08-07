package com.unitever.module.allocationQrcode.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.allocationQrcode.model.AllocationQrcode;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class AllocationQrcodeDAO extends BaseDAO<AllocationQrcode, String> {

	/**
	 * 根据Object获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param Goods
	 * @return List<AllocationQrcode>
	 */
	public List<AllocationQrcode> getAllocationQrcodeByAllocationQrcode(AllocationQrcode allocationQrcode) {
		return this.getList("getAllocationQrcodeByAllocationQrcode", allocationQrcode);
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
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		return this.getList("getAllocationQrcodeListByAllocationId", map);
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
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		return this.getList("getQrcodeCountByAllocationId", map);
	}

	/**
	 * 获取符合当前条件的AllocationQrcode数量
	 * 
	 * @author XiaoYu
	 * @date 2016年12月28日
	 * @param Goods
	 * @return int
	 */
	public int getCountByAllocationQrcode(AllocationQrcode allocationQrcode) {
		return this.get("getCountByAllocationQrcode", allocationQrcode);
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
	 * @return int
	 */
	public int batchInsert(List<AllocationQrcode> list) {
		return this.batchInsert("save", list);
	}

}
