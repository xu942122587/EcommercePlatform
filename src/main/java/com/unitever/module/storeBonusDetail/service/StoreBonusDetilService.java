package com.unitever.module.storeBonusDetail.service;

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

import com.unitever.module.consumeBonusDetail.model.ConsumeBonusDetail;
import com.unitever.module.customer.dao.manual.CustomerDAO;
import com.unitever.module.order.dao.manual.OrderDAO;
import com.unitever.module.store.model.Store;
import com.unitever.module.store.service.StoreService;
import com.unitever.module.storeBonus.model.StoreBonus;
import com.unitever.module.storeBonus.service.StoreBonusService;
import com.unitever.module.storeBonusDetail.dao.manual.StoreBonusDetailDAO;
import com.unitever.module.storeBonusDetail.model.StoreBonusDetail;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.core.spring.SpringContextHolder;
import com.unitever.platform.util.DateUtil;
import com.unitever.platform.util.DoubleUtil;
import com.unitever.platform.util.ExceptionUtil;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.storeBonusDetail.service->
 * StoreBonusDetailService.java
 * </p>
 * <P>
 * 商家店服务费记录
 * </p>
 *
 * @author 徐昊
 * @date 2017年8月5日
 */
@Service
@Transactional
public class StoreBonusDetilService {

	@Autowired
	private StoreBonusDetailDAO storeBonusDetailDAO;
	@Autowired
	private CustomerDAO customerDAO;
	@Autowired
	private StoreService storeService;
	@Autowired
	private OrderDAO orderDAO;
	@Autowired
	private StoreBonusService storeBonusService;

	private Logger logger_storeBonusDetilService = LoggerFactory.getLogger("StoreBonusDetilService");

	/**
	 *
	 * <P>
	 * 保存新信息
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param storeBonusDetail
	 * @return int
	 */
	public int save(StoreBonusDetail storeBonusDetail) {
		if (storeBonusDetail != null) {
			storeBonusDetail.setId(UUID.getUUID());
			storeBonusDetail.setCreateTime(new Date());
			int i = storeBonusDetailDAO.save(storeBonusDetail);
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
	 * @param storeBonusDetail
	 * @return int
	 */
	public int update(StoreBonusDetail storeBonusDetail) {
		if (null != storeBonusDetail) {
			if (StringUtils.isNotBlank(storeBonusDetail.getId())) {
				int i = storeBonusDetailDAO.update(storeBonusDetail);
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
	 * @return StoreBonusDetail
	 */
	public StoreBonusDetail getStoreBonusDetailById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return storeBonusDetailDAO.get(id);
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
	 * @param storeBonusDetail
	 * @return List<StoreBonusDetail>
	 */
	public List<StoreBonusDetail> getStoreBonusDetailByStoreBonusDetail(StoreBonusDetail storeBonusDetail) {
		return storeBonusDetailDAO.getStoreBonusDetailByStoreBonusDetail(storeBonusDetail);
	}

	/**
	 *
	 * <P>
	 * 获取符合当前条件的StoreBonusDetail数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param storeBonusDetail
	 * @return int
	 */
	public int getCountByStoreBonusDetail(StoreBonusDetail storeBonusDetail) {
		return storeBonusDetailDAO.getCountByStoreBonusDetail(storeBonusDetail);
	}

	/**
	 *
	 * <P>
	 * 获取所有提成比例
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @return List<StoreBonusDetail>
	 */
	public List<StoreBonusDetail> getAll() {
		return storeBonusDetailDAO.getAll();
	}

	/**
	 *
	 * <P>
	 * 获取StoreBonusDetail分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月9日
	 * @param page
	 * @param storeBonusDetail
	 * @return Page<StoreBonusDetail>
	 */
	public Page<StoreBonusDetail> getPage(Page<StoreBonusDetail> page, StoreBonusDetail storeBonusDetail) {
		page.setTotalRecord(storeBonusDetailDAO.getCountByObject(storeBonusDetail));
		storeBonusDetail.setStartOfPage(page.getStartOfPage());
		storeBonusDetail.setPageSize(page.getPageSize());
		page.setResults(storeBonusDetailDAO.getStoreBonusDetailByStoreBonusDetail(storeBonusDetail));
		return page;
	}

	/**
	 *
	 * <P>
	 * 根据商家店分组获取销售服务费记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param storeBonusDetail
	 * @return List<StoreBonusDetail>
	 */
	public List<StoreBonusDetail> getStoreBonusDetailGroupByStore(StoreBonusDetail storeBonusDetail) {
		return storeBonusDetailDAO.getStoreBonusDetailGroupByStore(storeBonusDetail);
	}

	/**
	 *
	 * <P>
	 * 根据StoreId获取服务费记录详情
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月5日
	 * @param storeBonusDetail
	 * @return List<StoreBonusDetail>
	 */
	public List<StoreBonusDetail> getStoreBonusDetailByStoreId(String storeId) {
		return storeBonusDetailDAO.getStoreBonusDetailByStoreId(storeId);
	}

	/**
	 *
	 * <P>
	 * 保存上月商家店服务费记录
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月18日 void
	 */
	public void storeBonusDetailTask() {

		List<Store> storeList = storeService.getAllNoTianheStore();

		DataSourceTransactionManager transactionManager = SpringContextHolder
				.getBean(org.springframework.jdbc.datasource.DataSourceTransactionManager.class);
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		// 事物隔离级别，开启新事务，这样会比较安全些。
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
		// 获得事务状态
		TransactionStatus status = null;

		for (final Store store : storeList) {
			try {
				status = transactionManager.getTransaction(def);// 开启事物
				// 上月总金额
				String targetMoney = orderDAO.getOneOrderMoneyByStoreInLastMonth(store.getId());
				if (0 < DoubleUtil.compareTo(targetMoney, "0")) {
					// 提成比例
					StoreBonus storeBonus = storeBonusService.getProportionByStartMoney(targetMoney);
					String proportion = "0";
					if (null != storeBonus && StringUtils.isNotBlank(storeBonus.getId())) {
						proportion = storeBonus.getProportion();
					}
					// 提成金额
					String money = DoubleUtil.mul(targetMoney, DoubleUtil.div(proportion, "100").toString()).toString();
					StoreBonusDetail storeBonusDetail = new StoreBonusDetail(UUID.getUUID(), store, targetMoney, money,
							DateUtil.getDateString(DateUtil.getDate(
									DateUtil.getDateString(DateUtil.getYestoday(new Date())), "yyyy-MM")),
							ConsumeBonusDetail.ISPAYMONEY_FALSE, new Date());
					storeBonusDetailDAO.save(storeBonusDetail);
				}
				transactionManager.commit(status);
			} catch (Error e) {
				transactionManager.rollback(status);
				logger_storeBonusDetilService.error("商家店服务费定时--出错，具体错误如下：" + e.getMessage());
			} catch (Exception e) {
				transactionManager.rollback(status);
				logger_storeBonusDetilService.error("商家店服务费定时--出错，具体错误如下："
						+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
			}
		}

	}
}
