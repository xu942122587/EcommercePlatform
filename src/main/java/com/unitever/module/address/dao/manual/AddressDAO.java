package com.unitever.module.address.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.address.model.Address;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class AddressDAO extends BaseDAO<Address, String> {

	/**
	 * 根据Object获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param Goods
	 * @return List<Address>
	 */
	public List<Address> getAddressByAddress(Address address) {
		return this.getList("getAddressByAddress", address);
	}

	/**
	 * 获取符合当前条件的Address数量
	 * 
	 * @author XiaoYu
	 * @date 2016年12月28日
	 * @param Goods
	 * @return int
	 */
	public int getCountByAddress(Address address) {
		return this.get("getCountByAddress", address);
	}

	/**
	 *
	 * <P>
	 * 获取用户的收获地址
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月2日
	 * @param customerId
	 * @return List<Address>
	 */
	public List<Address> getAddressByCustomerId(String customerId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("customerId", customerId);
		return this.getList("getAddressByCustomerId", map);
	}

	/**
	 *
	 * <P>
	 * 获取用户的收获地址
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月2日
	 * @param customerId
	 * @return List<Address>
	 */
	public Address getDefaultAddressByCustomerId(String customerId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("customerId", customerId);
		return this.get("getDefaultAddressByCustomerId", map);
	}

	/**
	 *
	 * <P>
	 * 更新默认地址
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月3日
	 * @param addressId
	 * @param isDefault
	 * @return int
	 */
	public int selectIsDefault(String addressId, String isDefault) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("addressId", addressId);
		map.put("isDefault", isDefault);
		return this.update("selectIsDefault", map);
	}
}
