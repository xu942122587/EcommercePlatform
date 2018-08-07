package com.unitever.module.address.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.address.dao.manual.AddressDAO;
import com.unitever.module.address.model.Address;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.UUID;

@Service
@Transactional
public class AddressService {

	@Autowired
	private AddressDAO addressDAO;

	/**
	 *
	 * <P>
	 * 保存新收获地址
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param address
	 * @return int
	 */
	public int save(Address address) {
		if (address != null) {
			address.setId(UUID.getUUID());
			address.setIsDelete(Address.ISDELETE_FALSE);
			address.setCreateTime(new Date());
			int i = addressDAO.save(address);
			return i;
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 更新收获地址
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param address
	 * @return int
	 */
	public int update(Address address) {
		if (null != address) {
			if (StringUtils.isNotBlank(address.getId())) {
				int i = addressDAO.update(address);
				return i;
			}
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 根据Id获取收获地址
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param id
	 * @return Address
	 */
	public Address getAddressById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return addressDAO.get(id);
		}
		return null;
	}

	/**
	 *
	 * <P>
	 * 根据收获地址获取收获地址列表
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param address
	 * @return List<Address>
	 */
	public List<Address> getAddressByAddress(Address address) {
		return addressDAO.getAddressByAddress(address);
	}

	/**
	 *
	 * <P>
	 * 获取符合当前条件的收获地址数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param address
	 * @return int
	 */
	public int getCountByAddress(Address address) {
		return addressDAO.getCountByObject(address);
	}

	/**
	 *
	 * <P>
	 * 获取收获地址分页对象
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param page
	 * @param address
	 * @return Page<Address>
	 */
	public Page<Address> getPage(Page<Address> page, Address address) {
		if (StringUtils.isNotBlank(address.getEndDate())) {
			address.setEndDate(address.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(addressDAO.getCountByObject(address));
		address.setStartOfPage(page.getStartOfPage());
		address.setPageSize(page.getPageSize());
		page.setResults(addressDAO.getAddressByAddress(address));
		if (StringUtils.isNotBlank(address.getEndDate())) {
			address.setEndDate(address.getEndDate().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 删除收获地址
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param id
	 * @return int
	 */
	public int deleteAddress(Address address) {
		if (null != address && StringUtils.isNotBlank(address.getId())) {
			address.setIsDefault(Address.ISDEFAULT_FALSE);
			address.setIsDelete(Address.ISDELETE_TRUE);
			return addressDAO.update(address);
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 获取所有收获地址
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @return List<Address>
	 */
	public List<Address> getAllAddress() {
		return addressDAO.getAll();
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
		return addressDAO.getAddressByCustomerId(customerId);
	}

	/**
	 *
	 * <P>
	 * 更新默认地址
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月2日
	 * @param address
	 * @return int
	 */
	public int selectIsDefault(String addressId, String isDefault) {
		return addressDAO.selectIsDefault(addressId, isDefault);
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
		return addressDAO.getDefaultAddressByCustomerId(customerId);
	}
}
