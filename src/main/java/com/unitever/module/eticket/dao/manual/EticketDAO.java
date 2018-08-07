package com.unitever.module.eticket.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.eticket.model.Eticket;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class EticketDAO extends BaseDAO<Eticket, String> {

	public List<Eticket> getEticketByEticket(Eticket eticket) {
		return this.getList("getEticketByEticket", eticket);
	}

	/**
	 *
	 * <P>
	 * 获取所有手动发放的电子券
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 6, 2017
	 * @return List<Eticket>
	 */
	public List<Eticket> getAllManualEticket() {
		return this.getList("getAllManualEticket");
	}

	/**
	 *
	 * <P>
	 * 获取购物发放的发放电子券列表
	 * </p>
	 *
	 * @author 闫枫
	 * @param storeId
	 * @date Sep 6, 2017
	 * @return List<Eticket>
	 */
	public Eticket getAllAutoBuyEticket(String payMoney, String storeId) {
		Map<String, String> map = new HashMap<>();
		map.put("payMoney", payMoney);
		map.put("storeId", storeId);
		return this.get("getAllAutoBuyEticket", map);
	}

	/**
	 *
	 * <P>
	 * 获取注册发放的发放电子券列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 6, 2017
	 * @return List<Eticket>
	 */
	public Eticket getAllAutoRegisterEticket() {
		return this.get("getAllAutoRegisterEticket", null);
	}

	/**
	 *
	 * <P>
	 * 获取充值发放的发放电子券列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 6, 2017
	 * @return List<Eticket>
	 */
	public Eticket getAllAutoRechargeEticket() {
		return this.get("getAllAutoRechargeEticket", null);
	}

	/**
	 *
	 * <P>
	 * 获取生日发放的发放电子券列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 6, 2017
	 * @return List<Eticket>
	 */
	public Eticket getAllAutoBirthdayEticket() {
		return this.get("getAllAutoBirthdayEticket", null);
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
	public int deleteEticket(Eticket eticket) {
		return this.update("deleteEticket", eticket);
	}
}
