package com.unitever.module.cashierUserLoginAndLogout.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.cashierUserLoginAndLogout.model.CashierUserLoginAndLogout;
import com.unitever.platform.core.dao.BaseDAO;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.cashierUserLoginAndLogout.dao.manual->
 * CashierUserLoginAndLogoutDAO.java
 * </p>
 * <P>
 * 收银交接班DAO
 * </p>
 *
 * @author 闫枫
 * @date Sep 18, 2017
 */
@Repository
public class CashierUserLoginAndLogoutDAO extends BaseDAO<CashierUserLoginAndLogout, String> {

	/**
	 *
	 * <P>
	 * 通过交接班对象获取list
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 18, 2017
	 * @param cashierUserLoginAndLogout
	 * @return List<CashierUserLoginAndLogout>
	 */
	public List<CashierUserLoginAndLogout> getCashierUserLoginAndLogoutByCashierUserLoginAndLogout(
			CashierUserLoginAndLogout cashierUserLoginAndLogout) {
		return this.getList("getCashierUserLoginAndLogoutByCashierUserLoginAndLogout", cashierUserLoginAndLogout);
	}

	/**
	 *
	 * <P>
	 * 通过收银ID获取本收银员未交班记录
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 18, 2017
	 * @param cashierUser_id
	 * @return CashierUserLoginAndLogout
	 */
	public CashierUserLoginAndLogout getNoLogoutMsgByCashierUserId(String cashierUser_id) {
		Map<String, String> map = new HashMap<>();
		map.put("cashierUser_id", cashierUser_id);
		return this.get("getNoLogoutMsgByCashierUserId", map);
	}

	/**
	 *
	 * <P>
	 * 结算
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 18, 2017
	 * @param id
	 * @return int
	 */
	public int doFinish(String id) {
		Map<String, String> map = new HashMap<>();
		map.put("id", id);
		return this.update("doFinish", map);
	}
}
