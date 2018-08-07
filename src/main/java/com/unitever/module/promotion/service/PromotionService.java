package com.unitever.module.promotion.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.promotion.dao.manual.PromotionDAO;
import com.unitever.module.promotion.model.Promotion;
import com.unitever.module.promotionGroup.model.PromotionGroup;
import com.unitever.module.promotionLadder.service.PromotionLadderService;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

@Service
@Transactional
public class PromotionService {

	@Autowired
	private PromotionDAO promotionDAO;
	@Autowired
	private PromotionLadderService promotionLadderService;

	/**
	 * 保存新信息
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param promotion
	 *            void
	 */
	public int save(Promotion promotion) {
		if (promotion != null) {
			promotion.setId(UUID.getUUID());
			promotion.setCreateTime(new Date());
			promotion.setIsDelete(Promotion.ISDELETE_NO);
			int i = promotionDAO.save(promotion);
			if (0 < i) {
				promotionLadderService.batchInsert(promotion.getPromotionLadderListNew(), promotion.getId());
			}
			return i;
		}
		return 0;
	}

	/**
	 * 更新数据
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param promotion
	 * @return int
	 */
	public int update(Promotion promotion) {
		if (null != promotion) {
			if (StringUtils.isNotBlank(promotion.getId())) {
				int i = promotionDAO.update(promotion);
				if (0 < i) {
					promotionLadderService.batchInsert(promotion.getPromotionLadderListNew(), promotion.getId());
					promotionLadderService.batchUpdate(promotion.getPromotionLadderList());
					promotionLadderService.batchDelete(promotion.getPromotionLadderListDel());
				}
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
	 * @return Promotion
	 */
	public Promotion getPromotionById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return promotionDAO.get(id);
		}
		return null;
	}

	/**
	 * 获取符合当前条件的促销活动列表
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param promotion
	 * @return List<Promotion>
	 */
	public List<Promotion> getPromotionByPromotion(Promotion promotion) {
		return promotionDAO.getPromotionByPromotion(promotion);
	}

	/**
	 * 获取符合当前条件的促销活动数量
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param promotion
	 * @return int
	 */
	public int getCountByPromotion(Promotion promotion) {
		return promotionDAO.getCountByPromotion(promotion);
	}

	/**
	 *
	 * <P>
	 * 获取promotion分页对象
	 * </p>
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param page
	 * @param promotion
	 * @return Page<Promotion>
	 */
	public Page<Promotion> getPage(Page<Promotion> page, Promotion promotion) {
		if (StringUtils.isNotBlank(promotion.getEndDate())) {
			promotion.setEndDate(promotion.getEndDate() + " 23:59:59");
		}
		List<Promotion> promotionhandList = promotionDAO.getPromotionByPromotion(promotion);
		if (StringUtils.isNotBlank(promotion.getEndDate())) {
			promotion.setEndDate(promotion.getEndDate().split(" ")[0]);
		}
		page.setTotalRecord(promotionhandList.size());
		if (promotionhandList.size() >= (page.getStartOfPage() + page.getPageSize())) {
			page.setResults(
					promotionhandList.subList(page.getStartOfPage(), page.getStartOfPage() + page.getPageSize()));
		} else {
			page.setResults(promotionhandList.subList(page.getStartOfPage(), promotionhandList.size()));
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 保存所有的活动信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 7, 2017
	 * @param promotionListNew
	 *            待保存的活动信息列表
	 * @param promotionGroup
	 *            活动组对象
	 */
	public void saveAll(List<Promotion> promotionListNew, PromotionGroup promotionGroup) {
		if (null != promotionListNew) {
			if (!promotionListNew.isEmpty()) {
				for (Promotion promotion : promotionListNew) {
					if (StringUtils.isNotBlank(promotion.getSorting())) {
						promotion.setPromotionGroup(promotionGroup);
						this.save(promotion);
					}
				}
			}
		}
	}

	/**
	 *
	 * <P>
	 * 更新所有的活动信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 7, 2017
	 * @param promotionListNew
	 *            待更新的活动信息列表
	 */
	public void updateAll(List<Promotion> promotionListNew) {
		if (null != promotionListNew) {
			if (!promotionListNew.isEmpty()) {
				for (Promotion promotion : promotionListNew) {
					this.update(promotion);
				}
			}
		}
	}

	/**
	 *
	 * <P>
	 * 删除活动
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 7, 2017
	 * @param promotionListDel
	 *            void
	 */
	public void deleteAll(List<Promotion> promotionListDel) {
		if (null != promotionListDel) {
			if (!promotionListDel.isEmpty()) {
				promotionDAO.batchDelete(promotionListDel);
			}
		}
	}

}
