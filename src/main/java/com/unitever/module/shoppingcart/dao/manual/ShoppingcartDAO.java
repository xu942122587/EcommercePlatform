package com.unitever.module.shoppingcart.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.shoppingcart.model.Shoppingcart;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class ShoppingcartDAO extends BaseDAO<Shoppingcart, String> {

	/**
	 * 根据Object获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param Goods
	 * @return List<Shoppingcart>
	 */
	public List<Shoppingcart> getShoppingcartByShoppingcart(Shoppingcart shoppingcart) {
		return this.getList("getShoppingcartByShoppingcart", shoppingcart);
	}

	/**
	 * 获取符合当前条件的Shoppingcart数量
	 * 
	 * @author XiaoYu
	 * @date 2016年12月28日
	 * @param Goodss
	 * @return int
	 */
	public int getCountByShoppingcart(Shoppingcart shoppingcart) {
		return this.get("getCountByShoppingcart", shoppingcart);
	}

	/**
	 * 获取用户某商品购物车
	 * 
	 * @author xuhao
	 * @param customerId
	 * @return int
	 */
	public Shoppingcart getShoppingcartByCustomerIdAndGoodsId(String customerId, String goodsId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("customerId", customerId);
		map.put("goodsId", goodsId);
		return this.get("getShoppingcartByCustomerIdAndGoodsId", map);
	}

	/**
	 *
	 * <P>
	 * 获取用户购物车
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月28日
	 * @param customerId
	 * @return Shoppingcart
	 */
	public List<Shoppingcart> getShoppingcartByCustomerId(String customerId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("customerId", customerId);
		return this.getList("getShoppingcartByCustomerId", map);
	}

	/**
	 *
	 * <P>
	 * 获取购物车ByList
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月4日
	 * @param shoppingcartList
	 * @return List<Shoppingcart>
	 */
	public List<Shoppingcart> getShoppingcartByShoppingcartList(String shoppingcartList) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("shoppingcartList", shoppingcartList);
		return this.getList("getShoppingcartByShoppingcartList", map);
	}

	/**
	 *
	 * <P>
	 * 依据门店ID删除会员购物车商品
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jan 31, 2018
	 * @param storeId
	 * @return int
	 */
	public int deleteByStoreId(String storeId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("storeId", storeId);
		return this.delete("deleteByStoreId", map);
	}
}
