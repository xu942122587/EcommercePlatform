package com.unitever.module.client.dao.manual;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.client.model.ClientShoppingcart;
import com.unitever.platform.core.dao.BaseDAO;

/**
 *
 * <P>
 * platform-tianhe->com.unitever.module.client.dao.manual->ClientShoppingcartDAO
 * .java
 * </p>
 * <P>
 * 收银购物车DAO层
 * </p>
 *
 * @author 闫枫
 * @date Jul 22, 2017
 */
@Repository
public class ClientShoppingcartDAO extends BaseDAO<ClientShoppingcart, String> {

	/**
	 *
	 * <P>
	 * 客户端登录时，初始化收银员购物车
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jul 22, 2017
	 * @param userId
	 * @return int
	 */
	public int initWithUserLogin(String userId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		return this.delete("initWithUserLogin", params);
	}

}
