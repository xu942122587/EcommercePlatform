package com.unitever.module.registerBonusDetil.service;

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
import com.unitever.module.customer.dao.manual.CustomerDAO;
import com.unitever.module.registerBonus.service.RegisterBonusService;
import com.unitever.module.registerBonusDetil.dao.manual.RegisterBonusDetilDAO;
import com.unitever.module.registerBonusDetil.model.RegisterBonusDetil;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.spring.SpringContextHolder;
import com.unitever.platform.util.DateUtil;
import com.unitever.platform.util.DoubleUtil;
import com.unitever.platform.util.ExceptionUtil;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.registerBonusDetil.service->
 * RegisterBonusDetilService.java
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
public class RegisterBonusDetilService {

	@Autowired
	private RegisterBonusDetilDAO registerBonusDetilDAO;
	@Autowired
	private CustomerDAO customerDAO;
	@Autowired
	private UserService userService;
	@Autowired
	private RegisterBonusService registerBonusService;

	private Logger logger_registerBonusDetilService = LoggerFactory.getLogger("RegisterBonusDetilService");

	/**
	 *
	 * <P>
	 * 保存新信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param registerBonusDetil
	 * @return int
	 */
	public int save(RegisterBonusDetil registerBonusDetil) {
		if (registerBonusDetil != null) {
			registerBonusDetil.setId(UUID.getUUID());
			registerBonusDetil.setCreateTime(new Date());
			int i = registerBonusDetilDAO.save(registerBonusDetil);
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
	 * @param registerBonusDetil
	 * @return int
	 */
	public int update(RegisterBonusDetil registerBonusDetil) {
		if (null != registerBonusDetil) {
			if (StringUtils.isNotBlank(registerBonusDetil.getId())) {
				int i = registerBonusDetilDAO.update(registerBonusDetil);
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
	 * @return RegisterBonusDetil
	 */
	public RegisterBonusDetil getRegisterBonusDetilById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return registerBonusDetilDAO.get(id);
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
	 * @param registerBonusDetil
	 * @return List<RegisterBonusDetil>
	 */
	public List<RegisterBonusDetil> getRegisterBonusDetilByRegisterBonusDetil(RegisterBonusDetil registerBonusDetil) {
		return registerBonusDetilDAO.getRegisterBonusDetilByRegisterBonusDetil(registerBonusDetil);
	}

	/**
	 *
	 * <P>
	 * 获取符合当前条件的RegisterBonusDetil数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param registerBonusDetil
	 * @return int
	 */
	public int getCountByRegisterBonusDetil(RegisterBonusDetil registerBonusDetil) {
		return registerBonusDetilDAO.getCountByRegisterBonusDetil(registerBonusDetil);
	}

	/**
	 *
	 * <P>
	 * 获取所有提成比例
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @return List<RegisterBonusDetil>
	 */
	public List<RegisterBonusDetil> getAll() {
		return registerBonusDetilDAO.getAll();
	}

	/**
	 *
	 * <P>
	 * 获取RegisterBonusDetil分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月9日
	 * @param page
	 * @param registerBonusDetil
	 * @return Page<RegisterBonusDetil>
	 */
	public Page<RegisterBonusDetil> getPage(Page<RegisterBonusDetil> page, RegisterBonusDetil registerBonusDetil) {
		if (StringUtils.isNotBlank(registerBonusDetil.getEndDate())) {
			registerBonusDetil.setEndDate(registerBonusDetil.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(registerBonusDetilDAO.getCountByObject(registerBonusDetil));
		registerBonusDetil.setStartOfPage(page.getStartOfPage());
		registerBonusDetil.setPageSize(page.getPageSize());
		page.setResults(registerBonusDetilDAO.getRegisterBonusDetilByRegisterBonusDetil(registerBonusDetil));
		if (StringUtils.isNotBlank(registerBonusDetil.getEndDate())) {
			registerBonusDetil.setEndDate(registerBonusDetil.getEndDate().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 根据用户分组获取注册提成记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param registerBonusDetil
	 * @return List<RegisterBonusDetil>
	 */
	public List<RegisterBonusDetil> getRegisterBonusDetilGroupByGuideUser(RegisterBonusDetil registerBonusDetil) {
		return registerBonusDetilDAO.getRegisterBonusDetilGroupByGuideUser(registerBonusDetil);
	}

	/**
	 *
	 * <P>
	 * 根据用户分组获取注册提成记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param registerBonusDetil
	 * @return List<RegisterBonusDetil>
	 */
	public List<RegisterBonusDetil> getRegisterBonusDetilByGuideUserId(String guideUserId) {
		return registerBonusDetilDAO.getRegisterBonusDetilByGuideUserId(guideUserId);
	}

	/**
	 *
	 * <P>
	 * 保存上月注册提成记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月18日 void
	 */
	public void registerBonusDetilTask() {

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
				String count = customerDAO.getCountCustomerByGuideUserInLastMonth(user.getId());
				if (0 < DoubleUtil.compareTo(count, "0")) {
					// 提成比例
					String proportion = "0";
					if (null != registerBonusService.getAll() && 0 < registerBonusService.getAll().size()) {
						proportion = registerBonusService.getAll().get(0).getStartMoney();
					}
					// 提成金额
					String money = DoubleUtil.mul(count, proportion).toString();
					RegisterBonusDetil registerBonusDetil = new RegisterBonusDetil(UUID.getUUID(), user, money,
							DateUtil.getDateString(DateUtil.getDate(
									DateUtil.getDateString(DateUtil.getYestoday(new Date())), "yyyy-MM")), count,
							RegisterBonusDetil.ISPAYMONEY_FALSE, new Date());
					registerBonusDetilDAO.save(registerBonusDetil);
				}
				transactionManager.commit(status);
			} catch (Error e) {
				transactionManager.rollback(status);
				logger_registerBonusDetilService.error("注册提成--出错，具体错误如下：" + e.getMessage());
			} catch (Exception e) {
				transactionManager.rollback(status);
				logger_registerBonusDetilService.error("注册提成--出错，具体错误如下："
						+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			}
		}

	}
}
