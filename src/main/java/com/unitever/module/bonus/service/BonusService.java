package com.unitever.module.bonus.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.bonus.dao.manual.BonusDAO;
import com.unitever.module.bonus.model.Bonus;
import com.unitever.module.bonus.model.BonusVo;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.bonus.service->BonusService.java
 * </p>
 * <P>
 * 导购提成比例serivices
 * </p>
 *
 * @author 闫枫
 * @date Jul 1, 2017
 */
@Service
@Transactional
public class BonusService {

	@Autowired
	private BonusDAO bonusDAO;

	/**
	 * 保存新信息
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param bonus
	 *            void
	 */
	public int save(Bonus bonus) {
		if (bonus != null) {
			bonus.setId(UUID.getUUID());
			bonus.setCreateTime(new Date());
			int i = bonusDAO.save(bonus);
			if (0 < i) {
				return i;
			}
		}
		return 0;
	}

	/**
	 * 更新数据
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param bonus
	 * @return int
	 */
	public int update(Bonus bonus) {
		if (null != bonus) {
			if (StringUtils.isNotBlank(bonus.getId())) {
				int i = bonusDAO.update(bonus);
				if (0 < i) {
					return i;
				}
			}
		}
		return 0;
	}

	/**
	 * 根据Id获取
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return Bonus
	 */
	public Bonus getBonusById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return bonusDAO.get(id);
		}
		return null;
	}

	/**
	 * 根据Object获取
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param bonus
	 * @return List<Bonus>
	 */
	public List<Bonus> getBonusByBonus(Bonus bonus) {
		return bonusDAO.getBonusByBonus(bonus);
	}

	/**
	 * 获取符合当前条件的Bonus数量
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param bonus
	 * @return int
	 */
	public int getCountByBonus(Bonus bonus) {
		return bonusDAO.getCountByObject(bonus);
	}

	/**
	 *
	 * <P>
	 * 获取所有提成比例
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 1, 2017
	 * @return Object
	 */
	public List<Bonus> getAll() {
		return bonusDAO.getAll();
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
	 *            待保存的list
	 * @return int
	 */
	public int batchInsert(List<Bonus> list) {
		if (null != list) {
			if (!list.isEmpty()) {
				return bonusDAO.batchInsert(list);
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 批量更新
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param list
	 * @return int
	 */
	public int batchUpdate(List<Bonus> list) {
		if (null != list) {
			if (!list.isEmpty()) {
				return bonusDAO.batchUpdate(list);
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 批量删除
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param list
	 * @return int
	 */
	public int batchDelete(List<Bonus> list) {
		if (null != list) {
			if (!list.isEmpty()) {
				return bonusDAO.batchDelete(list);
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 保存导购提成比例信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 1, 2017
	 * @param bonusVo
	 *            void
	 */
	public void saveBonusWithBonusVo(BonusVo bonusVo) {
		this.batchInsert(bonusVo.getBonuNewList());
		this.batchUpdate(bonusVo.getBonuOldList());
		this.batchDelete(bonusVo.getBonuDeleteList());
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
	 * @return Bonus
	 */
	public Bonus getProportionByStartMoney(String startMoney) {
		return bonusDAO.getProportionByStartMoney(startMoney);
	}
}
