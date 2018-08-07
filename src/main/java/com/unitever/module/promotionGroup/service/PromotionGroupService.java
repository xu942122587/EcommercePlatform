package com.unitever.module.promotionGroup.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.promotion.service.PromotionService;
import com.unitever.module.promotionGroup.dao.manual.PromotionGroupDAO;
import com.unitever.module.promotionGroup.model.PromotionGroup;
import com.unitever.module.promotionLadder.service.PromotionLadderService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.DateUtil;
import com.unitever.platform.util.UUID;

@Service
@Transactional
public class PromotionGroupService {

	@Autowired
	private PromotionGroupDAO promotionGroupDAO;
	@Autowired
	private PromotionService promotionService;
	@Autowired
	private PromotionLadderService promotionLadderService;

	/**
	 * 保存新信息
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param promotionGroup
	 *            void
	 */
	public int save(PromotionGroup promotionGroup) {
		if (promotionGroup != null) {
			promotionGroup.setId(UUID.getUUID());
			promotionGroup.setCreateTime(new Date());
			promotionGroup.setIsDelete(PromotionGroup.ISDELETE_NO);
			int i = promotionGroupDAO.save(promotionGroup);
			if (0 < i) {
				promotionService.saveAll(promotionGroup.getPromotionListNew(), promotionGroup);
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
	 * @param promotionGroup
	 * @return int
	 */
	public int update(PromotionGroup promotionGroup) {
		if (null != promotionGroup) {
			if (StringUtils.isNotBlank(promotionGroup.getId())) {
				int i = promotionGroupDAO.update(promotionGroup);
				if (0 < i) {
					promotionService.updateAll(promotionGroup.getPromotionList());
					promotionService.saveAll(promotionGroup.getPromotionListNew(), promotionGroup);
					promotionService.deleteAll(promotionGroup.getPromotionListDel());
					promotionLadderService.batchDelete(promotionGroup.getPromotionLadderListDel());
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
	 * @return PromotionGroup
	 */
	public PromotionGroup getPromotionGroupById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return promotionGroupDAO.get(id);
		}
		return null;
	}

	/**
	 * 根据Object获取
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param promotionGroup
	 * @return List<PromotionGroup>
	 */
	public List<PromotionGroup> getPromotionGroupByPromotionGroup(PromotionGroup promotionGroup) {
		return promotionGroupDAO.getPromotionGroupByPromotionGroup(promotionGroup);
	}

	/**
	 * 获取符合当前条件的PromotionGroup数量
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param promotionGroup
	 * @return int
	 */
	public int getCountByPromotionGroup(PromotionGroup promotionGroup) {
		return promotionGroupDAO.getCountByPromotionGroup(promotionGroup);
	}

	/**
	 *
	 * <P>
	 * 获取promotionGroup分页对象
	 * </p>
	 * 
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param page
	 * @param promotionGroup
	 * @return Page<PromotionGroup>
	 */
	public Page<PromotionGroup> getPage(Page<PromotionGroup> page, PromotionGroup promotionGroup) {
		if (StringUtils.isNotBlank(promotionGroup.getEndDate())) {
			promotionGroup.setEndDate(promotionGroup.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(promotionGroupDAO.getCountByObject(promotionGroup));
		promotionGroup.setStartOfPage(page.getStartOfPage());
		promotionGroup.setPageSize(page.getPageSize());
		page.setResults(promotionGroupDAO.getPromotionGroupByPromotionGroup(promotionGroup));
		if (StringUtils.isNotBlank(promotionGroup.getEndDate())) {
			promotionGroup.setEndDate(promotionGroup.getEndDate().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 删除门店--假删除
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jun 29, 2017
	 * @param id
	 * @return int
	 */
	public int deletePromotionGroup(String id) {
		if (StringUtils.isNotBlank(id)) {
			PromotionGroup promotionGroup = new PromotionGroup(id);
			promotionGroup.setIsDelete(PromotionGroup.ISDELETE_YES);
			return promotionGroupDAO.update(promotionGroup);
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 检查活动组是否可保存
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 8, 2017
	 * @param promotionGroup
	 * @return AjaxJson
	 */
	public AjaxJson checkGroupIsNeedSave(PromotionGroup promotionGroup) {
		AjaxJson ajaxJson = new AjaxJson();
		if (StringUtils.isNotBlank(promotionGroup.getProStartDateString())
				&& StringUtils.isNotBlank(promotionGroup.getProEndDateString())) {
			if (DateUtil.compareTime(promotionGroup.getProStartDateString() + ":00",
					promotionGroup.getProEndDateString() + ":00")) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("活动的开始时间必须小于结束时间哦~");
				return ajaxJson;
			}
		} else {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("活动开始或结束时间必须选择~");
			return ajaxJson;
		}
		if (0 < promotionGroupDAO.getIsOnlineCount(promotionGroup)) {
			if (PromotionGroup.ISONLINE_ALL.equals(promotionGroup.getIsOline())) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("选中时间范围内已存在线上或线下活动，不可新建不限制线上线下的活动");
				return ajaxJson;
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("选中时间范围内已存在不限线上线下的活动，不可新建线上或线下的活动");
				return ajaxJson;
			}
		}
		if (0 < promotionGroupDAO.getPayTypeCount(promotionGroup)) {
			if (PromotionGroup.PAYTYPE_ALL.equals(promotionGroup.getPayType())) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("选中时间范围内已存在针对某种支付方式的活动，不可新建不限制支付方式的活动");
				return ajaxJson;
			} else {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("选中时间范围内已存在不限支付方式的活动，不可新建针对某种支付方式的活动");
				return ajaxJson;
			}
		}
		if (0 >= promotionGroupDAO.checkGroupIsNeedSave(promotionGroup)) {
			ajaxJson.setSuccess(true);
		} else {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("亲，所选时间范围内存在相同活动组，请仔细检查后再提交哦~");
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 依据门店ID获取活动分组信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 10, 2017
	 * @param storeId
	 *            门店ID
	 * @param payType
	 *            支付方式
	 * @param isOnline
	 *            线上线下
	 * @return List<PromotionGroup>
	 */
	public List<PromotionGroup> getAllPromotionGroupByStoreId(String storeId, String payType, String isOnline) {
		return StringUtils.isNotBlank(storeId) ? promotionGroupDAO.getAllPromotionGroupByStoreId(storeId, payType,
				isOnline) : null;
	}

	/**
	 *
	 * <P>
	 * 依据商家店门店ID获取活动分组信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 10, 2017
	 * @param storeId
	 *            门店ID
	 * @param payType
	 *            支付方式
	 * @param isOnline
	 *            线上线下
	 * @return List<PromotionGroup>
	 */
	public List<PromotionGroup> getAllPromotionGroupByNoTianheStoreId(String storeId, String payType, String isOnline) {
		return StringUtils.isNotBlank(storeId) ? promotionGroupDAO.getAllPromotionGroupByNoTianheStoreId(storeId,
				payType, isOnline) : null;
	}

	/**
	 *
	 * <P>
	 * 获取叠加活动组
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 19, 2017
	 * @return List<PromotionGroup>
	 */
	public List<PromotionGroup> getNoScopeGroup() {
		return this.promotionGroupDAO.getNoScopeGroup();
	}

	/**
	 *
	 * <P>
	 * 线下：依据门店ID获取活动分组信息中支付方式列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 19, 2017
	 * @return List<String>
	 */
	public String getProGroupPayTypesByStoreId(String storeId) {
		return StringUtils.isNotBlank(storeId) ? promotionGroupDAO.getProGroupPayTypesByStoreId(storeId) : null;
	}

	/**
	 *
	 * <P>
	 * 线下：依据商家店门店ID获取活动分组信息中支付方式列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 19, 2017
	 * @return List<String>
	 */
	public String getProGroupPayTypesByNoTianheStoreId(String storeId) {
		return StringUtils.isNotBlank(storeId) ? promotionGroupDAO.getProGroupPayTypesByNoTianheStoreId(storeId) : null;
	}
}
