package com.unitever.module.area.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.area.model.Area;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class AreaDAO extends BaseDAO<Area, String> {

	/**
	 * <p>
	 * 根据Area条件查询Area
	 * </p>
	 * 
	 * @param Area
	 * @return List<Area>
	 */
	public List<Area> getAreaByArea(Area area) {
		return this.getList("getAreaByArea", area);
	}

	/**
	 *
	 * <P>
	 * 获取某个市下未选中区域
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 27, 2016
	 * @param area
	 *            市的Area对象
	 * @return
	 */
	public List<Area> noChangeArea(Area area, String areas_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		String[] area_ids = areas_id.split(",");
		map.put("cityArea_id", area.getId());
		map.put("area_ids", area_ids);
		return this.getList("noChangeArea", map);
	}

	/**
	 *
	 * <P>
	 * 获取所有已选中的区域
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 29, 2016
	 * @param area_id
	 *            已选中的所有区域ID字符串
	 * @return
	 */
	public List<Area> changeArea(String area_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		String[] area_ids = area_id.split(",");
		map.put("area_ids", area_ids);
		return this.getList("changeArea", map);
	}

}