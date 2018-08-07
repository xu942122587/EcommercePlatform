package com.unitever.module.consumeBonus.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.consumeBonus.dao.manual.ConsumeBonusDAO;
import com.unitever.module.consumeBonus.model.ConsumeBonus;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.consumeBonus.service->
 * ConsumeBonusService.java
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
public class ConsumeBonusService {

	@Autowired
	private ConsumeBonusDAO consumeBonusDAO;

	/**
	 *
	 * <P>
	 * 保存新信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param consumeBonus
	 * @return int
	 */
	public int save(ConsumeBonus consumeBonus) {
		if (consumeBonus != null) {
			consumeBonus.setId(UUID.getUUID());
			consumeBonus.setCreateTime(new Date());
			int i = consumeBonusDAO.save(consumeBonus);
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
	 * @param consumeBonus
	 * @return int
	 */
	public int update(ConsumeBonus consumeBonus) {
		if (null != consumeBonus) {
			if (StringUtils.isNotBlank(consumeBonus.getId())) {
				int i = consumeBonusDAO.update(consumeBonus);
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
	 * @return ConsumeBonus
	 */
	public ConsumeBonus getConsumeBonusById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return consumeBonusDAO.get(id);
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
	 * @param consumeBonus
	 * @return List<ConsumeBonus>
	 */
	public List<ConsumeBonus> getConsumeBonusByConsumeBonus(ConsumeBonus consumeBonus) {
		return consumeBonusDAO.getConsumeBonusByConsumeBonus(consumeBonus);
	}

	/**
	 *
	 * <P>
	 * 获取符合当前条件的ConsumeBonus数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param consumeBonus
	 * @return int
	 */
	public int getCountByConsumeBonus(ConsumeBonus consumeBonus) {
		return consumeBonusDAO.getCountByObject(consumeBonus);
	}

	/**
	 *
	 * <P>
	 * 获取所有提成比例
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @return List<ConsumeBonus>
	 */
	public List<ConsumeBonus> getAll() {
		return consumeBonusDAO.getAll();
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
	 * @param consumeBonus
	 * @return Page<ConsumeBonus>
	 */
	public Page<ConsumeBonus> getPage(Page<ConsumeBonus> page, ConsumeBonus consumeBonus) {
		page.setTotalRecord(consumeBonusDAO.getCountByObject(consumeBonus));
		consumeBonus.setStartOfPage(page.getStartOfPage());
		consumeBonus.setPageSize(page.getPageSize());
		page.setResults(consumeBonusDAO.getConsumeBonusByConsumeBonus(consumeBonus));
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
	public int deleteConsumeBonus(String id) {
		if (StringUtils.isNotBlank(id)) {
			return consumeBonusDAO.delete(id);
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 根据金额获取提成档位
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月18日
	 * @param startMoney
	 * @return ConsumeBonus
	 */
	public ConsumeBonus getProportionByStartMoney(String startMoney) {
		return consumeBonusDAO.getProportionByStartMoney(startMoney);
	}
}
