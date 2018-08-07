package com.unitever.module.consumeBonusDetail.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.unitever.auth.user.model.User;
import com.unitever.auth.user.service.UserService;
import com.unitever.module.consumeBonus.model.ConsumeBonus;
import com.unitever.module.consumeBonus.service.ConsumeBonusService;
import com.unitever.module.consumeBonusDetail.dao.manual.ConsumeBonusDetailDAO;
import com.unitever.module.consumeBonusDetail.model.ConsumeBonusDetail;
import com.unitever.module.customer.dao.manual.CustomerDAO;
import com.unitever.module.rechargeRecord.service.RechargeRecordService;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.spring.SpringContextHolder;
import com.unitever.platform.util.DateUtil;
import com.unitever.platform.util.DoubleUtil;
import com.unitever.platform.util.ExceptionUtil;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.consumeBonusDetail.service->
 * ConsumeBonusDetailService.java
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
public class ConsumeBonusDetailService {

	@Autowired
	private ConsumeBonusDetailDAO consumeBonusDetailDAO;
	@Autowired
	private CustomerDAO customerDAO;
	@Autowired
	private UserService userService;
	@Autowired
	private RechargeRecordService rechargeRecordService;
	@Autowired
	private ConsumeBonusService consumeBonusService;

	private Logger logger_consumeBonusDetailService = LoggerFactory.getLogger("ConsumeBonusDetailService");

	/**
	 *
	 * <P>
	 * 保存新信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param consumeBonusDetail
	 * @return int
	 */
	public int save(ConsumeBonusDetail consumeBonusDetail) {
		if (consumeBonusDetail != null) {
			consumeBonusDetail.setId(UUID.getUUID());
			consumeBonusDetail.setCreateTime(new Date());
			int i = consumeBonusDetailDAO.save(consumeBonusDetail);
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
	 * @param consumeBonusDetail
	 * @return int
	 */
	public int update(ConsumeBonusDetail consumeBonusDetail) {
		if (null != consumeBonusDetail) {
			if (StringUtils.isNotBlank(consumeBonusDetail.getId())) {
				int i = consumeBonusDetailDAO.update(consumeBonusDetail);
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
	 * @return ConsumeBonusDetail
	 */
	public ConsumeBonusDetail getConsumeBonusDetailById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return consumeBonusDetailDAO.get(id);
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
	 * @param consumeBonusDetail
	 * @return List<ConsumeBonusDetail>
	 */
	public List<ConsumeBonusDetail> getConsumeBonusDetailByConsumeBonusDetail(ConsumeBonusDetail consumeBonusDetail) {
		return consumeBonusDetailDAO.getConsumeBonusDetailByConsumeBonusDetail(consumeBonusDetail);
	}

	/**
	 *
	 * <P>
	 * 获取符合当前条件的ConsumeBonusDetail数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param consumeBonusDetail
	 * @return int
	 */
	public int getCountByConsumeBonusDetail(ConsumeBonusDetail consumeBonusDetail) {
		return consumeBonusDetailDAO.getCountByObject(consumeBonusDetail);
	}

	/**
	 *
	 * <P>
	 * 获取所有提成比例
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @return List<ConsumeBonusDetail>
	 */
	public List<ConsumeBonusDetail> getAll() {
		return consumeBonusDetailDAO.getAll();
	}

	/**
	 *
	 * <P>
	 * 获取ConsumeBonusDetail分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月9日
	 * @param page
	 * @param consumeBonusDetail
	 * @return Page<ConsumeBonusDetail>
	 */
	public Page<ConsumeBonusDetail> getPage(Page<ConsumeBonusDetail> page, ConsumeBonusDetail consumeBonusDetail) {
		page.setTotalRecord(consumeBonusDetailDAO.getCountByObject(consumeBonusDetail));
		consumeBonusDetail.setStartOfPage(page.getStartOfPage());
		consumeBonusDetail.setPageSize(page.getPageSize());
		page.setResults(consumeBonusDetailDAO.getConsumeBonusDetailByConsumeBonusDetail(consumeBonusDetail));
		return page;
	}

	/**
	 *
	 * <P>
	 * 根据用户分组获取充值提成记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param consumeBonusDetail
	 * @return List<ConsumeBonusDetail>
	 */
	public List<ConsumeBonusDetail> getConsumeBonusDetailGroupByGuideUser(ConsumeBonusDetail consumeBonusDetail) {
		return consumeBonusDetailDAO.getConsumeBonusDetailGroupByGuideUser(consumeBonusDetail);
	}

	/**
	 *
	 * <P>
	 * 根据GuideUserId获取提成记录详情
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param consumeBonusDetail
	 * @return List<ConsumeBonusDetail>
	 */
	public List<ConsumeBonusDetail> getConsumeBonusDetailByGuideUserId(String guideUserId) {
		return consumeBonusDetailDAO.getConsumeBonusDetailByGuideUserId(guideUserId);
	}

	/**
	 *
	 * <P>
	 * 保存上月充值提成记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月18日 void
	 */
	public void consumeBonusDetailTask() {

		List<User> userList = userService.getGuideUserList();

		DataSourceTransactionManager transactionManager = SpringContextHolder
				.getBean(org.springframework.jdbc.datasource.DataSourceTransactionManager.class);
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		// 事物隔离级别，开启新事务，这样会比较安全些。
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
		// 获得事务状态
		TransactionStatus status = null;

		for (final User user : userList) {
			try {
				status = transactionManager.getTransaction(def);// 开启事物
				// 上月总金额
				String targetMoney = rechargeRecordService.getRechargeRecordByGuideUserInLastMonth(user.getId());
				if (0 < DoubleUtil.compareTo(StringUtils.isNotBlank(targetMoney) ? targetMoney : "0.0", "0")) {
					// 提成比例
					ConsumeBonus consumeBonus = consumeBonusService.getProportionByStartMoney(targetMoney);
					String proportion = "0";
					if (null != consumeBonus && StringUtils.isNotBlank(consumeBonus.getId())) {
						proportion = consumeBonus.getProportion();
					}
					// 提成金额
					String money = DoubleUtil.mul(targetMoney, DoubleUtil.div(proportion, "100").toString()).toString();
					ConsumeBonusDetail consumeBonusDetail = new ConsumeBonusDetail(UUID.getUUID(), user, targetMoney,
							money, DateUtil.getDateString(DateUtil.getDate(
									DateUtil.getDateString(DateUtil.getYestoday(new Date())), "yyyy-MM")),
							ConsumeBonusDetail.ISPAYMONEY_FALSE, new Date());
					consumeBonusDetailDAO.save(consumeBonusDetail);
				}
				transactionManager.commit(status);
			} catch (Error e) {
				transactionManager.rollback(status);
				logger_consumeBonusDetailService.error("充值提成--出错，具体错误如下：" + e.getMessage());
			} catch (Exception e) {
				transactionManager.rollback(status);
				logger_consumeBonusDetailService.error("充值提成--出错，具体错误如下："
						+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			}
		}

	}
}
