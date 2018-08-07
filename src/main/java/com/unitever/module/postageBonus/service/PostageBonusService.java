package com.unitever.module.postageBonus.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.postageBonus.dao.manual.PostageBonusDAO;
import com.unitever.module.postageBonus.model.PostageBonus;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.postageBonus.service->
 * PostageBonusService.java
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
public class PostageBonusService {

	@Autowired
	private PostageBonusDAO postageBonusDAO;

	/**
	 *
	 * <P>
	 * 保存新信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param postageBonus
	 * @return int
	 */
	public int save(PostageBonus postageBonus) {
		if (postageBonus != null) {
			postageBonus.setId(UUID.getUUID());
			postageBonus.setCreateTime(new Date());
			int i = postageBonusDAO.save(postageBonus);
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
	 * @param postageBonus
	 * @return int
	 */
	public int update(PostageBonus postageBonus) {
		if (null != postageBonus) {
			if (StringUtils.isNotBlank(postageBonus.getId())) {
				int i = postageBonusDAO.update(postageBonus);
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
	 * @return PostageBonus
	 */
	public PostageBonus getPostageBonusById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return postageBonusDAO.get(id);
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
	 * @param postageBonus
	 * @return List<PostageBonus>
	 */
	public List<PostageBonus> getPostageBonusByPostageBonus(PostageBonus postageBonus) {
		return postageBonusDAO.getPostageBonusByPostageBonus(postageBonus);
	}

	/**
	 *
	 * <P>
	 * 获取符合当前条件的PostageBonus数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param postageBonus
	 * @return int
	 */
	public int getCountByPostageBonus(PostageBonus postageBonus) {
		return postageBonusDAO.getCountByPostageBonus(postageBonus);
	}

	/**
	 *
	 * <P>
	 * 获取所有提成比例
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @return List<PostageBonus>
	 */
	public List<PostageBonus> getAll() {
		return postageBonusDAO.getAll();
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
	 * @param postageBonus
	 * @return Page<PostageBonus>
	 */
	public Page<PostageBonus> getPage(Page<PostageBonus> page, PostageBonus postageBonus) {
		page.setTotalRecord(postageBonusDAO.getCountByObject(postageBonus));
		postageBonus.setStartOfPage(page.getStartOfPage());
		postageBonus.setPageSize(page.getPageSize());
		page.setResults(postageBonusDAO.getPostageBonusByPostageBonus(postageBonus));
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
	public int deletePostageBonus(String id) {
		if (StringUtils.isNotBlank(id)) {
			return postageBonusDAO.delete(id);
		}
		return 0;
	}

}
