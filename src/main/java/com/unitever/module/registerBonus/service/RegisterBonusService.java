package com.unitever.module.registerBonus.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.registerBonus.dao.manual.RegisterBonusDAO;
import com.unitever.module.registerBonus.model.RegisterBonus;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.registerBonus.service->
 * RegisterBonusService.java
 * </p>
 * <P>
 * 充值返现比例
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月5日
 */
@Service
@Transactional
public class RegisterBonusService {

	@Autowired
	private RegisterBonusDAO registerBonusDAO;

	/**
	 *
	 * <P>
	 * 保存新信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param registerBonus
	 * @return int
	 */
	public int save(RegisterBonus registerBonus) {
		if (registerBonus != null) {
			registerBonus.setId(UUID.getUUID());
			registerBonus.setCreateTime(new Date());
			int i = registerBonusDAO.save(registerBonus);
			if (0 < i) {
				return i;
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 更新数据
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param registerBonus
	 * @return int
	 */
	public int update(RegisterBonus registerBonus) {
		if (null != registerBonus) {
			if (StringUtils.isNotBlank(registerBonus.getId())) {
				int i = registerBonusDAO.update(registerBonus);
				if (0 < i) {
					return i;
				}
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 根据Id获取
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param id
	 * @return RegisterBonus
	 */
	public RegisterBonus getRegisterBonusById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return registerBonusDAO.get(id);
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
	 * @date 2017年8月5日
	 * @param registerBonus
	 * @return List<RegisterBonus>
	 */
	public List<RegisterBonus> getRegisterBonusByRegisterBonus(RegisterBonus registerBonus) {
		return registerBonusDAO.getRegisterBonusByRegisterBonus(registerBonus);
	}

	/**
	 *
	 * <P>
	 * 获取符合当前条件的RegisterBonus数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param registerBonus
	 * @return int
	 */
	public int getCountByRegisterBonus(RegisterBonus registerBonus) {
		return registerBonusDAO.getCountByRegisterBonus(registerBonus);
	}

	/**
	 *
	 * <P>
	 * 获取所有提成比例
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @return List<RegisterBonus>
	 */
	public List<RegisterBonus> getAll() {
		return registerBonusDAO.getAll();
	}

	/**
	 *
	 * <P>
	 * 获取余额流水记录分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param page
	 * @param registerBonus
	 * @return Page<RegisterBonus>
	 */
	public Page<RegisterBonus> getPage(Page<RegisterBonus> page, RegisterBonus registerBonus) {
		if (StringUtils.isNotBlank(registerBonus.getEndDate())) {
			registerBonus.setEndDate(registerBonus.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(registerBonusDAO.getCountByObject(registerBonus));
		registerBonus.setStartOfPage(page.getStartOfPage());
		registerBonus.setPageSize(page.getPageSize());
		page.setResults(registerBonusDAO.getRegisterBonusByRegisterBonus(registerBonus));
		if (StringUtils.isNotBlank(registerBonus.getEndDate())) {
			registerBonus.setEndDate(registerBonus.getEndDate().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 删除余额流水记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param id
	 * @return int
	 */
	public int deleteRegisterBonus(String id) {
		if (StringUtils.isNotBlank(id)) {
			return registerBonusDAO.delete(id);
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 获取充值比例(第一条)
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 19, 2017
	 * @return Object
	 */
	public RegisterBonus getFirstRegisterBonus() {
		return registerBonusDAO.getFirstRegisterBonus();
	}

}
