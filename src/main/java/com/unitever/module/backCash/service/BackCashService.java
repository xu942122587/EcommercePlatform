package com.unitever.module.backCash.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.backCash.dao.manual.BackCashDAO;
import com.unitever.module.backCash.model.BackCash;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.backCash.service->BackCashService.java
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
public class BackCashService {

	@Autowired
	private BackCashDAO backCashDAO;

	/**
	 *
	 * <P>
	 * 保存新信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param backCash
	 * @return int
	 */
	public int save(BackCash backCash) {
		if (backCash != null) {
			backCash.setId(UUID.getUUID());
			backCash.setCreateTime(new Date());
			int i = backCashDAO.save(backCash);
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
	 * @param backCash
	 * @return int
	 */
	public int update(BackCash backCash) {
		if (null != backCash) {
			if (StringUtils.isNotBlank(backCash.getId())) {
				int i = backCashDAO.update(backCash);
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
	 * @return BackCash
	 */
	public BackCash getBackCashById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return backCashDAO.get(id);
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
	 * @param backCash
	 * @return List<BackCash>
	 */
	public List<BackCash> getBackCashByBackCash(BackCash backCash) {
		return backCashDAO.getBackCashByBackCash(backCash);
	}

	/**
	 *
	 * <P>
	 * 获取符合当前条件的BackCash数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param backCash
	 * @return int
	 */
	public int getCountByBackCash(BackCash backCash) {
		return backCashDAO.getCountByObject(backCash);
	}

	/**
	 *
	 * <P>
	 * 获取所有提成比例
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @return List<BackCash>
	 */
	public List<BackCash> getAll() {
		return backCashDAO.getAll();
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
	 * @param backCash
	 * @return Page<BackCash>
	 */
	public Page<BackCash> getPage(Page<BackCash> page, BackCash backCash) {
		if (StringUtils.isNotBlank(backCash.getEndDate())) {
			backCash.setEndDate(backCash.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(backCashDAO.getCountByObject(backCash));
		backCash.setStartOfPage(page.getStartOfPage());
		backCash.setPageSize(page.getPageSize());
		page.setResults(backCashDAO.getBackCashByBackCash(backCash));
		if (StringUtils.isNotBlank(backCash.getEndDate())) {
			backCash.setEndDate(backCash.getEndDate().split(" ")[0]);
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
	public int deleteBackCash(String id) {
		if (StringUtils.isNotBlank(id)) {
			return backCashDAO.delete(id);
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 根据金额获取阶梯
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月9日
	 * @param money
	 * @return BackCash
	 */
	public BackCash getBackCashByMoney(String money) {
		return backCashDAO.getBackCashByMoney(money);
	}
}
