package com.unitever.module.eticket.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.eticket.dao.manual.EticketDAO;
import com.unitever.module.eticket.model.Eticket;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.DateUtil;
import com.unitever.platform.util.UUID;

@Service
@Transactional
public class EticketService {

	@Autowired
	private EticketDAO eticketDAO;

	public Eticket getEticketById(String id) {
		return eticketDAO.get(id);
	}

	public List<Eticket> getEticketByEticket(Eticket eticket) {
		return eticketDAO.getEticketByEticket(eticket);
	}

	/**
	 *
	 * <P>
	 * 保存电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 6, 2017
	 * @param eticket
	 * @return int
	 */
	public int saveEticket(Eticket eticket) {
		if (null != eticket) {
			eticket.setId(UUID.getUUID());
			eticket.setCreateTime(new Date());
			eticket.setIsDelete(Eticket.ISDELETE_NO);
			eticket.setStopSendTime(DateUtil.getDate(eticket.getStopSendTimeString(), "yyyy-MM-dd HH:mm"));
			if (null == eticket.getOutStore() || StringUtils.isBlank(eticket.getOutStore().getId()))
				eticket.setOutStore(null);
			if (null == eticket.getUseStore() || StringUtils.isBlank(eticket.getUseStore().getId()))
				eticket.setUseStore(null);
			return eticketDAO.save(eticket);
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 获取所有电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 6, 2017
	 * @return List<Eticket>
	 */
	public List<Eticket> getAllEticketDAO() {
		return eticketDAO.getAll();
	}

	/**
	 *
	 * <P>
	 * 更新电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 6, 2017
	 * @param eticket
	 * @return int
	 */
	public int updateEticket(Eticket eticket) {
		if (null != eticket && StringUtils.isNotBlank(eticket.getId())) {
			eticket.setStopSendTime(DateUtil.getDate(eticket.getStopSendTimeString(), "yyyy-MM-dd HH:mm"));
			return eticketDAO.update(eticket);
		}
		return 0;
	}

	/**
	 * 分页
	 * 
	 * @author XiaoYu
	 * @date 2016年11月17日
	 * @param page
	 * @param eticket
	 * @return
	 */
	public Page<Eticket> getPage(Page<Eticket> page, Eticket eticket) {
		page.setTotalRecord(eticketDAO.getCountByObject(eticket));
		eticket.setStartOfPage(page.getStartOfPage());
		eticket.setPageSize(page.getPageSize());
		page.setResults(eticketDAO.getEticketByEticket(eticket));
		return page;
	}

	/**
	 *
	 * <P>
	 * 依据ID删除(真删除)
	 * </p>
	 *
	 * @author 闫枫
	 * @date Nov 19, 2016
	 * @param id
	 */
	public int delete(String id) {
		return StringUtils.isNotBlank(id) ? eticketDAO.delete(id) : 0;
	}

	/**
	 *
	 * <P>
	 * 依据ID删除(假删除)
	 * </p>
	 *
	 * @author 闫枫
	 * @date Nov 19, 2016
	 * @param id
	 */
	public int deleteEticketById(String id) {
		return StringUtils.isNotBlank(id) ? eticketDAO.deleteEticket(new Eticket(id)) : 0;
	}

	/**
	 *
	 * <P>
	 * 获取所有手动发放的电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Nov 26, 2016
	 * @return
	 */
	public List<Eticket> getAllManualEticket() {
		return eticketDAO.getAllManualEticket();
	}

	/**
	 *
	 * <P>
	 * 获取购物发放的发放电子券列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Nov 26, 2016
	 * @return
	 */
	public Eticket getAllAutoBuyEticket(String payMoney, String storeId) {
		return eticketDAO.getAllAutoBuyEticket(payMoney, storeId);
	}

	/**
	 *
	 * <P>
	 * 获取注册发放的发放电子券列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Nov 26, 2016
	 * @return
	 */
	public Eticket getAllAutoRegisterEticket() {
		return eticketDAO.getAllAutoRegisterEticket();
	}

	/**
	 *
	 * <P>
	 * 获取充值发放的发放电子券列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Nov 26, 2016
	 * @return
	 */
	public Eticket getAllAutoRechargeEticket() {
		return eticketDAO.getAllAutoRechargeEticket();
	}

	/**
	 *
	 * <P>
	 * 获取生日发放的发放电子券列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Nov 26, 2016
	 * @return
	 */
	public Eticket getAllAutoBirthdayEticket() {
		return eticketDAO.getAllAutoBirthdayEticket();
	}

}
