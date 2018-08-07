package com.unitever.module.checkstorageGoods.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.checkstorageGoods.model.CheckstorageGoods;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class CheckstorageGoodsDAO extends BaseDAO<CheckstorageGoods, String> {

	/**
	 * 根据Object获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param Goods
	 * @return List<CheckstorageGoods>
	 */
	public List<CheckstorageGoods> getCheckstorageGoodsByCheckstorageGoods(CheckstorageGoods checkstorageGoods) {
		return this.getList("getCheckstorageGoodsByCheckstorageGoods", checkstorageGoods);
	}

	/**
	 * 获取符合当前条件的CheckstorageGoods数量
	 * 
	 * @author XiaoYu
	 * @date 2016年12月28日
	 * @param Goods
	 * @return int
	 */
	public int getCountByCheckstorageGoods(CheckstorageGoods checkstorageGoods) {
		return this.get("getCountByCheckstorageGoods", checkstorageGoods);
	}

	/**
	 *
	 * <P>
	 * 依据盘库单Id获取盘库记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月19日
	 * @param id
	 * @return List<AllocationQrcode>
	 */
	public List<CheckstorageGoods> getCheckstorageGoodsListByCheckstorageId(String checkstorageId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("checkstorageId", checkstorageId);
		return this.getList("getCheckstorageGoodsListByCheckstorageId", map);
	}
}
