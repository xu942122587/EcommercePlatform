package com.unitever.module.area.service;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.area.dao.manual.AreaDAO;
import com.unitever.module.area.model.Area;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-channel->com.unitever.module.area.service->AreaService.java
 * </p>
 * <P>
 * TODO
 * </p>
 *
 * @author 闫枫
 * @date Sep 27, 2016
 */
@Service
@Transactional
public class AreaService {

	/**
	 * <p>
	 * 根据ID获取Area信息
	 * </p>
	 * 
	 * @param id：Area的id
	 * @return Area
	 */
	public Area getAreaById(String id) {
		if (StringUtils.isBlank(id)) {
			return null;
		}
		return areaDAO.get(id);
	}

	/**
	 * <p>
	 * 保存区域记录
	 * </p>
	 * 
	 * @param Area：Area对象
	 */
	public void save(Area area) {
		if (area != null) {
			area.setId(UUID.getUUID());
			areaDAO.save(area);
		}
	}

	/**
	 * <p>
	 * 更新区域信息记录
	 * </p>
	 * 
	 */
	public void update(Area area) {
		if (area != null) {
			areaDAO.update(area);
		}
	}

	/**
	 * <p>
	 * 删除区域信息记录
	 * </p>
	 * 
	 */
	public void delete(String id) {
		if (StringUtils.isNotBlank(id)) {
			areaDAO.update(new Area(id, null, null, Area.STATE_DELETE_YES, null, null));
		}
	}

	/**
	 * <p>
	 * 获取Area分页对象
	 * </p>
	 * 
	 * @param page
	 * @param Area
	 * @return
	 */
	public Page<Area> getPage(Page<Area> page, Area area) {
		List<Area> areaList = areaDAO.getAreaByArea(area);
		page.setTotalRecord(areaList.size());
		if (areaList.size() >= (page.getStartOfPage() + page.getPageSize())) {
			page.setResults(areaList.subList(page.getStartOfPage(), page.getStartOfPage() + page.getPageSize()));
		} else {
			page.setResults(areaList.subList(page.getStartOfPage(), areaList.size()));
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 依据 Area 获取 Area
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 26, 2016
	 * @param area
	 * @return
	 */
	public List<Area> getAreaByArea(Area area) {
		return areaDAO.getAreaByArea(area);
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
		return areaDAO.noChangeArea(area, areas_id);
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
		return areaDAO.changeArea(area_id);
	}

	@Autowired
	private AreaDAO areaDAO;

}