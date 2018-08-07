package com.unitever.module.promotionLadder.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.promotion.model.Promotion;
import com.unitever.module.promotionLadder.dao.manual.PromotionLadderDAO;
import com.unitever.module.promotionLadder.model.PromotionLadder;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

@Service
@Transactional
public class PromotionLadderService {

	@Autowired
	private PromotionLadderDAO promotionLadderDAO;

	/**
	 * 保存新信息
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param promotionLadder
	 *            void
	 */
	public int save(PromotionLadder promotionLadder) {
		if (promotionLadder != null) {
			promotionLadder.setId(UUID.getUUID());
			promotionLadder.setCreateTime(new Date());
			int i = promotionLadderDAO.save(promotionLadder);
			return i;
		}
		return 0;
	}

	/**
	 * 更新数据
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param promotionLadder
	 * @return int
	 */
	public int update(PromotionLadder promotionLadder) {
		if (null != promotionLadder) {
			if (StringUtils.isNotBlank(promotionLadder.getId())) {
				int i = promotionLadderDAO.update(promotionLadder);
				return i;
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
	 * @return PromotionLadder
	 */
	public PromotionLadder getPromotionLadderById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return promotionLadderDAO.get(id);
		}
		return null;
	}

	/**
	 * 获取符合当前条件的活动阶梯条件列表
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param promotionLadder
	 * @return List<PromotionLadder>
	 */
	public List<PromotionLadder> getPromotionLadderByPromotionLadder(PromotionLadder promotionLadder) {
		return promotionLadderDAO.getPromotionLadderByPromotionLadder(promotionLadder);
	}

	/**
	 * 获取符合当前条件的活动阶梯条件数量
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param promotionLadder
	 * @return int
	 */
	public int getCountByPromotionLadder(PromotionLadder promotionLadder) {
		return promotionLadderDAO.getCountByPromotionLadder(promotionLadder);
	}

	/**
	 *
	 * <P>
	 * 获取活动阶梯条件分页对象
	 * </p>
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param page
	 * @param promotionLadder
	 * @return Page<PromotionLadder>
	 */
	public Page<PromotionLadder> getPage(Page<PromotionLadder> page, PromotionLadder promotionLadder) {
		if (StringUtils.isNotBlank(promotionLadder.getEndDate())) {
			promotionLadder.setEndDate(promotionLadder.getEndDate() + " 23:59:59");
		}
		List<PromotionLadder> promotionLadderhandList = promotionLadderDAO
				.getPromotionLadderByPromotionLadder(promotionLadder);
		if (StringUtils.isNotBlank(promotionLadder.getEndDate())) {
			promotionLadder.setEndDate(promotionLadder.getEndDate().split(" ")[0]);
		}
		page.setTotalRecord(promotionLadderhandList.size());
		if (promotionLadderhandList.size() >= (page.getStartOfPage() + page.getPageSize())) {
			page.setResults(
					promotionLadderhandList.subList(page.getStartOfPage(), page.getStartOfPage() + page.getPageSize()));
		} else {
			page.setResults(promotionLadderhandList.subList(page.getStartOfPage(), promotionLadderhandList.size()));
		}
		return page;
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
	 * @param promotionId
	 *            促销活动ID，新建的促销活动必须传入，其他情况可传入null
	 * @return int
	 */
	public int batchInsert(List<PromotionLadder> list, String promotionId) {
		if (null != list) {
			if (!list.isEmpty()) {
				List<PromotionLadder> list_to_save = new ArrayList<PromotionLadder>();
				for (PromotionLadder promotionLadder : list) {
					if (StringUtils.isNotBlank(promotionLadder.getLadderStart())
							|| StringUtils.isNotBlank(promotionLadder.getGoodsNumberBuy())) {
						if (null == promotionLadder.getPromotion()
								|| StringUtils.isBlank(promotionLadder.getPromotion().getId())) {
							if (StringUtils.isNotBlank(promotionId)) {
								promotionLadder.setPromotion(new Promotion(promotionId));
							}
						}
						list_to_save.add(promotionLadder);
					}
				}
				list.clear();
				return promotionLadderDAO.batchInsert(list_to_save);
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
	public int batchUpdate(List<PromotionLadder> list) {
		if (null != list) {
			if (!list.isEmpty()) {
				return promotionLadderDAO.batchUpdate(list);
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
	public int batchDelete(List<PromotionLadder> list) {
		if (null != list) {
			if (!list.isEmpty()) {
				return promotionLadderDAO.batchDelete(list);
			}
		}
		return 0;
	}
}
