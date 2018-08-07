package com.unitever.module.checkstorageGoods.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.checkstorageGoods.dao.manual.CheckstorageGoodsDAO;
import com.unitever.module.checkstorageGoods.model.CheckstorageGoods;
import com.unitever.module.checkstorageGoods.vo.CheckstorageGoodsVO;
import com.unitever.module.inventory.dao.manual.InventoryDAO;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.checkstorageGoods.service->
 * checkstorageGoodsService.java
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
public class CheckstorageGoodsService {

	@Autowired
	private CheckstorageGoodsDAO checkstorageGoodsDAO;
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
	 * @param checkstorageGoods
	 * @return int
	 */
	public String save(CheckstorageGoods checkstorageGoods) {
		if (checkstorageGoods != null) {
			checkstorageGoods.setId(UUID.getUUID());
			checkstorageGoods.setCreateTime(new Date());
			checkstorageGoods.setState(CheckstorageGoods.STATE_TWO);
			checkstorageGoodsDAO.save(checkstorageGoods);
			String checkstorageGoodsId = checkstorageGoods.getId();
			return checkstorageGoodsId;
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
	 * @return checkstorageGoods
	 */
	public CheckstorageGoods getCheckstorageGoodsById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return checkstorageGoodsDAO.get(id);
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
	 * @param checkstorageGoods
	 * @return List<checkstorageGoods>
	 */
	public List<CheckstorageGoods> getCheckstorageGoodsByCheckstorageGoods(CheckstorageGoods checkstorageGoods) {
		return checkstorageGoodsDAO.getCheckstorageGoodsByCheckstorageGoods(checkstorageGoods);
	}

	/**
	 * 获取符合当前条件的checkstorageGoods数量
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param checkstorageGoods
	 * @return int
	 */
	public int getCountByCheckstorageGoods(CheckstorageGoods checkstorageGoods) {
		return checkstorageGoodsDAO.getCountByObject(checkstorageGoods);
	}

	/**
	 *
	 * <P>
	 * 获取checkstorageGoods分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月14日
	 * @param page
	 * @param checkstorageGoods
	 * @return Page<checkstorageGoods>
	 */
	public Page<CheckstorageGoods> getPage(Page<CheckstorageGoods> page, CheckstorageGoods checkstorageGoods) {
		if (StringUtils.isNotBlank(checkstorageGoods.getEndDate())) {
			checkstorageGoods.setEndDate(checkstorageGoods.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(checkstorageGoodsDAO.getCountByObject(checkstorageGoods));
		checkstorageGoods.setStartOfPage(page.getStartOfPage());
		checkstorageGoods.setPageSize(page.getPageSize());
		page.setResults(checkstorageGoodsDAO.getCheckstorageGoodsByCheckstorageGoods(checkstorageGoods));
		if (StringUtils.isNotBlank(checkstorageGoods.getEndDate())) {
			checkstorageGoods.setEndDate(checkstorageGoods.getEndDate().split(" ")[0]);
		}
		return page;
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
	public int deleteCheckstorageGoods(String id) {
		if (StringUtils.isNotBlank(id)) {
			return checkstorageGoodsDAO.delete(id);
		}
		return 0;
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
	public List<CheckstorageGoods> getCheckstorageGoodsListByCheckstorageId(String id) {
		return checkstorageGoodsDAO.getCheckstorageGoodsListByCheckstorageId(id);
	}

	/**
	 *
	 * <P>
	 * 根据盘库单生成VO
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月18日
	 * @param qrcode
	 * @return CheckstorageGoodsVO
	 */
	public CheckstorageGoodsVO getCheckstorageGoodsVOByCheckstorageGoods(CheckstorageGoods checkstorageGoods) {
		CheckstorageGoodsVO checkstorageGoodsVO = new CheckstorageGoodsVO();
		checkstorageGoodsVO.setId(checkstorageGoods.getId());
		checkstorageGoodsVO.setCheckstorageId(checkstorageGoods.getCheckstorage().getId());
		checkstorageGoodsVO.setStorageName(checkstorageGoods.getCheckstorage().getStorage().getName());
		checkstorageGoodsVO.setStoreName(checkstorageGoods.getCheckstorage().getStore().getName());
		checkstorageGoodsVO.setGoodsId(checkstorageGoods.getGoods().getId());
		checkstorageGoodsVO.setCheckNumber(checkstorageGoods.getCheckNumber());
		checkstorageGoodsVO.setInventoryNumber(checkstorageGoods.getInventoryNumber());
		checkstorageGoodsVO.setProfitNumber(checkstorageGoods.getProfitNumber());
		checkstorageGoodsVO.setState(checkstorageGoods.getState());
		if (StringUtils.isNotBlank(checkstorageGoods.getGoods().getName())) {
			checkstorageGoodsVO.setGoodsName(checkstorageGoods.getGoods().getName());
			checkstorageGoodsVO.setGoodsCode(checkstorageGoods.getGoods().getGoodsCode());
			checkstorageGoodsVO.setOther_attr_value("无");
		} else {
			checkstorageGoodsVO.setGoodsName(checkstorageGoods.getGoods().getGoods().getName());
			checkstorageGoodsVO.setGoodsCode(checkstorageGoods.getGoods().getGoods().getGoodsCode());
			checkstorageGoodsVO.setOther_attr_value(checkstorageGoods.getGoods().getOther_attr_value());
		}
		return checkstorageGoodsVO;
	}
}
