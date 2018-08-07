package com.unitever.module.bonusDetail.service;

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
import com.unitever.module.bonus.model.Bonus;
import com.unitever.module.bonus.service.BonusService;
import com.unitever.module.bonusDetail.dao.manual.BonusDetailDAO;
import com.unitever.module.bonusDetail.model.BonusDetail;
import com.unitever.module.customer.dao.manual.CustomerDAO;
import com.unitever.module.order.dao.manual.OrderDAO;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.spring.SpringContextHolder;
import com.unitever.platform.util.DateUtil;
import com.unitever.platform.util.DoubleUtil;
import com.unitever.platform.util.ExceptionUtil;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.bonusDetail.service->
 * BonusDetailService.java
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
public class BonusDetailService {

	@Autowired
	private BonusDetailDAO bonusDetailDAO;
	@Autowired
	private CustomerDAO customerDAO;
	@Autowired
	private UserService userService;
	@Autowired
	private OrderDAO orderDAO;
	@Autowired
	private BonusService bonusService;

	private Logger logger_bonusDetailService = LoggerFactory.getLogger("BonusDetailService");

	/**
	 *
	 * <P>
	 * 保存新信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param bonusDetail
	 * @return int
	 */
	public int save(BonusDetail bonusDetail) {
		if (bonusDetail != null) {
			bonusDetail.setId(UUID.getUUID());
			bonusDetail.setCreateTime(new Date());
			int i = bonusDetailDAO.save(bonusDetail);
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
	 * @param bonusDetail
	 * @return int
	 */
	public int update(BonusDetail bonusDetail) {
		if (null != bonusDetail) {
			if (StringUtils.isNotBlank(bonusDetail.getId())) {
				int i = bonusDetailDAO.update(bonusDetail);
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
	 * @return BonusDetail
	 */
	public BonusDetail getBonusDetailById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return bonusDetailDAO.get(id);
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
	 * @param bonusDetail
	 * @return List<BonusDetail>
	 */
	public List<BonusDetail> getBonusDetailByBonusDetail(BonusDetail bonusDetail) {
		return bonusDetailDAO.getBonusDetailByBonusDetail(bonusDetail);
	}

	/**
	 *
	 * <P>
	 * 获取符合当前条件的BonusDetail数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param bonusDetail
	 * @return int
	 */
	public int getCountByBonusDetail(BonusDetail bonusDetail) {
		return bonusDetailDAO.getCountByObject(bonusDetail);
	}

	/**
	 *
	 * <P>
	 * 获取所有提成比例
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @return List<BonusDetail>
	 */
	public List<BonusDetail> getAll() {
		return bonusDetailDAO.getAll();
	}

	/**
	 *
	 * <P>
	 * 获取BonusDetail分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月9日
	 * @param page
	 * @param bonusDetail
	 * @return Page<BonusDetail>
	 */
	public Page<BonusDetail> getPage(Page<BonusDetail> page, BonusDetail bonusDetail) {
		page.setTotalRecord(bonusDetailDAO.getCountByObject(bonusDetail));
		bonusDetail.setStartOfPage(page.getStartOfPage());
		bonusDetail.setPageSize(page.getPageSize());
		page.setResults(bonusDetailDAO.getBonusDetailByBonusDetail(bonusDetail));
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
	 * @param bonusDetail
	 * @return List<BonusDetail>
	 */
	public List<BonusDetail> getBonusDetailGroupByGuideUser(BonusDetail bonusDetail) {
		return bonusDetailDAO.getBonusDetailGroupByGuideUser(bonusDetail);
	}

	/**
	 *
	 * <P>
	 * 根据GuideUserId获取提成记录详情
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param bonusDetail
	 * @return List<BonusDetail>
	 */
	public List<BonusDetail> getBonusDetailByGuideUserId(String guideUserId) {
		return bonusDetailDAO.getBonusDetailByGuideUserId(guideUserId);
	}

	/**
	 *
	 * <P>
	 * 保存上月销售提成记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月18日 void
	 */
	public void bonusDetailTask() {

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
				String targetMoney = DoubleUtil.add(orderDAO.getOneOrderMoneyByGuideUserInLastMonth(user.getId()),
						orderDAO.getTwoOrderMoneyByGuideUserInLastMonth(user.getId())).toString();
				if (0 < DoubleUtil.compareTo(targetMoney, "0")) {
					// 提成比例
					Bonus bonus = bonusService.getProportionByStartMoney(targetMoney);
					String proportion = "0";
					if (null != bonus && StringUtils.isNotBlank(bonus.getId())) {
						proportion = bonus.getProportion();
					}
					// 提成金额
					String money = DoubleUtil.mul(targetMoney, DoubleUtil.div(proportion, "100").toString()).toString();
					BonusDetail bonusDetail = new BonusDetail(UUID.getUUID(), user, targetMoney, money,
							DateUtil.getDateString(DateUtil.getDate(
									DateUtil.getDateString(DateUtil.getYestoday(new Date())), "yyyy-MM")),
							BonusDetail.ISPAYMONEY_FALSE, new Date());
					bonusDetailDAO.save(bonusDetail);
				}
				transactionManager.commit(status);
			} catch (Error e) {
				transactionManager.rollback(status);
				logger_bonusDetailService.error("销售提成--出错，具体错误如下：" + e.getMessage());
			} catch (Exception e) {
				transactionManager.rollback(status);
				logger_bonusDetailService.error("销售提成--出错，具体错误如下："
						+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			}
		}

	}
}
