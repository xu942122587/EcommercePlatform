package com.unitever.module.consume.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.consume.dao.manual.ConsumeDAO;
import com.unitever.module.consume.model.Consume;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.OrderCodeID;
import com.unitever.platform.util.UUID;

@Service
@Transactional
public class ConsumeService {

	@Autowired
	private ConsumeDAO consumeDAO;

	/**
	 *
	 * <P>
	 * 保存新余额流水记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param consume
	 * @return int
	 */
	public int save(Consume consume) {
		if (consume != null) {
			consume.setId(UUID.getUUID());
			consume.setCreateTime(new Date());
			consume.setConsumeCode(OrderCodeID.nextCode());
			int i = consumeDAO.save(consume);
			return i;
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 更新余额流水记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param consume
	 * @return int
	 */
	public int update(Consume consume) {
		if (null != consume) {
			if (StringUtils.isNotBlank(consume.getId())) {
				int i = consumeDAO.update(consume);
				return i;
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 根据Id获取余额流水记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param id
	 * @return Consume
	 */
	public Consume getConsumeById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return consumeDAO.get(id);
		}
		return null;
	}

	/**
	 *
	 * <P>
	 * 根据余额流水记录获取余额流水记录列表
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param consume
	 * @return List<Consume>
	 */
	public List<Consume> getConsumeByConsume(Consume consume) {
		return consumeDAO.getConsumeByConsume(consume);
	}

	/**
	 *
	 * <P>
	 * 获取符合当前条件的余额流水记录数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param consume
	 * @return int
	 */
	public int getCountByConsume(Consume consume) {
		return consumeDAO.getCountByObject(consume);
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
	 * @param consume
	 * @return Page<Consume>
	 */
	public Page<Consume> getPage(Page<Consume> page, Consume consume) {
		if (StringUtils.isNotBlank(consume.getEndDate())) {
			consume.setEndDate(consume.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(consumeDAO.getCountByObject(consume));
		consume.setStartOfPage(page.getStartOfPage());
		consume.setPageSize(page.getPageSize());
		page.setResults(consumeDAO.getConsumeByConsume(consume));
		if (StringUtils.isNotBlank(consume.getEndDate())) {
			consume.setEndDate(consume.getEndDate().split(" ")[0]);
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
	public int deleteConsume(String id) {
		if (StringUtils.isNotBlank(id)) {
			return consumeDAO.delete(id);
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 获取所有余额流水记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @return List<Consume>
	 */
	public List<Consume> getAllConsume() {
		return consumeDAO.getAll();
	}

	/**
	 *
	 * <P>
	 * 根据用户获取交易流水记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月2日
	 * @param customerId
	 * @return List<Consume>
	 */
	public List<Consume> getConsumeByCustomerId(String customerId) {
		return consumeDAO.getConsumeByCustomerId(customerId);
	}

	/**
	 *
	 * <P>
	 * 获取type为1,2的Consume数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月14日
	 * @param consume
	 * @return List<Consume>
	 */
	public List<Consume> getConsumeByConsumeForType(Consume consume) {
		return consumeDAO.getConsumeByConsumeForType(consume);
	}
}
