package com.unitever.module.shoppingcart.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.customer.service.CustomerService;
import com.unitever.module.goods.service.GoodsService;
import com.unitever.module.shoppingcart.dao.manual.ShoppingcartDAO;
import com.unitever.module.shoppingcart.model.Shoppingcart;
import com.unitever.platform.util.UUID;

@Service
@Transactional
public class ShoppingcartService {

	@Autowired
	private ShoppingcartDAO shoppingcartDAO;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private CustomerService customerService;

	/**
	 *
	 * <P>
	 * 根据Id获取
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月25日
	 * @param id
	 * @return Shoppingcart
	 */
	public Shoppingcart getShoppingcartById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return shoppingcartDAO.get(id);
		}
		return null;
	}

	/**
	 *
	 * <P>
	 * 更新购物车
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月25日
	 * @param shoppingCart
	 *            void
	 */
	public int update(Shoppingcart shoppingCart) {
		if (null != shoppingCart) {
			if (StringUtils.isNotBlank(shoppingCart.getId())) {
				int i = shoppingcartDAO.update(shoppingCart);
				return i;
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 根据id删除购物车
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月25日
	 * @param id
	 * @return AjaxJson
	 */
	public int doDelete(String id) {
		if (StringUtils.isNotBlank(id)) {
			int i = shoppingcartDAO.delete(id);
			return i;
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 添加
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月25日
	 * @param goodsId
	 * @param customerId
	 * @param count
	 *            void
	 */
	public int save(String goodsId, String customerId, String count) {
		Shoppingcart shoppingCart = new Shoppingcart();
		if (StringUtils.isNotBlank(goodsId) && StringUtils.isNotBlank(customerId) && StringUtils.isNotBlank(count)) {
			shoppingCart.setId(UUID.getUUID());
			shoppingCart.setCreateTime(new Date());
			shoppingCart.setCustomer(customerService.getCustomerById(customerId));
			shoppingCart.setGoods(goodsService.getGoodsById(goodsId));
			shoppingCart.setCount(count);
			int i = shoppingcartDAO.save(shoppingCart);
			return i;
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 获取用户某商品购物车
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月25日
	 * @param customerId
	 * @param goodsId
	 * @return Shoppingcart
	 */
	public Shoppingcart getShoppingcartByCustomerIdAndGoodsId(String customerId, String goodsId) {
		return shoppingcartDAO.getShoppingcartByCustomerIdAndGoodsId(customerId, goodsId);
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
		return shoppingcartDAO.getShoppingcartByCustomerId(customerId);
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
		return shoppingcartDAO.getShoppingcartByShoppingcartList(shoppingcartList);
	}
}