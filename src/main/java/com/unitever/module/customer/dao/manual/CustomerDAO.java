package com.unitever.module.customer.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.unitever.auth.user.dao.manual.UserDAO;
import com.unitever.module.customer.model.Customer;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class CustomerDAO extends BaseDAO<Customer, String> {

	@Autowired
	private UserDAO userDAO;

	/**
	 * 根据Object获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param customer
	 * @return List<Customer>
	 */
	public List<Customer> getCustomerByCustomer(Customer customer) {
		return this.getList("getCustomerByCustomer", customer);
	}

	/**
	 * 获取符合当前条件的Customer数量
	 * 
	 * @author XiaoYu
	 * @date 2016年12月28日
	 * @param customer
	 * @return int
	 */
	public int getCountByCustomer(Customer customer) {
		return this.get("getCountByCustomer", customer);
	}

	/**
	 *
	 * <P>
	 * 获取符合当前条件的注册Customer数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年10月16日
	 * @param customer
	 * @return int
	 */
	public int getCountByCustomerForRegist(Customer customer) {
		return this.get("getCountByCustomerForRegist", customer);
	}

	/**
	 *
	 * <P>
	 * 根据导购获取上月的注册总人数
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月18日
	 * @param guideUserId
	 * @return String
	 */
	public String getCountCustomerByGuideUserInLastMonth(String guideUserId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("guideUserId", guideUserId);
		return this.get("getCountCustomerByGuideUserInLastMonth", params);
	}

	/**
	 *
	 * <P>
	 * 登出,删除employee
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月31日
	 * @param customer
	 * @return int
	 */
	public int doLogout(Customer customer) {
		return this.update("doLogout", customer);
	}

	/**
	 *
	 * <P>
	 * 通过微信用户ID获取系统中注册的客户ID（客户绑定的微信号即微信用户ID）
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jan 9, 2017
	 * @param employeeId
	 * @return Customer
	 */
	public Customer getCustomerByEmployeeId(String employeeId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("employeeId", employeeId);
		return this.get("getCustomerByEmployeeId", map);
	}

	/**
	 *
	 * <P>
	 * 获取有推荐人的用户并根据推荐人分组
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月9日
	 * @return List<Customer>
	 */
	public List<Customer> getHaveGuideUserCustomer(String username) {
		String guideUserId;
		if (StringUtils.isNotBlank(username)) {
			guideUserId = userDAO.getUserWithLoginName(username).getId();
		} else {
			guideUserId = null;
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("guideUserId", guideUserId);
		return this.getList("getHaveGuideUserCustomer", map);
	}

	/**
	 *
	 * <P>
	 * 获取有推荐人的用户并根据推荐人分组
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月9日
	 * @return List<Customer>
	 */
	public List<Customer> getCustomerByguideUserId(String username) {
		String guideUserId;
		if (StringUtils.isNotBlank(username)) {
			guideUserId = userDAO.getUserWithLoginName(username).getId();
		} else {
			guideUserId = null;
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("guideUserId", guideUserId);
		return this.getList("getCustomerByguideUserId", guideUserId);
	}

	/**
	 *
	 * <P>
	 * 通过手机号获取会员信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 10, 2017
	 * @param phone
	 * @return Object
	 */
	public Customer getCustomerByPhone(String phone) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("phone", phone);
		return this.get("getCustomerByPhone", map);
	}

	/**
	 *
	 * <P>
	 * 消费者天和钱包增加
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 26, 2017
	 * @param id
	 * @param promotionMoney
	 *            void
	 */
	public int addTianheMoney(String customerId, String promotionMoney) {
		Map<String, String> map = new HashMap<>();
		map.put("customerId", customerId);
		map.put("promotionMoney", promotionMoney);
		return this.update("addTianheMoney", map);
	}

	/**
	 *
	 * <P>
	 * 消费者天和钱包减少
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 29, 2017
	 * @param customerId
	 * @param subMoney
	 * @return int
	 */
	public int subTianheMoney(String customerId, String subMoney) {
		Map<String, String> map = new HashMap<>();
		map.put("customerId", customerId);
		map.put("subMoney", subMoney);
		return this.update("subTianheMoney", map);
	}

	/**
	 *
	 * <P>
	 * 保存支付动态密码
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 30, 2017
	 * @param customerPhone
	 * @param payCode
	 * @return int
	 */
	public int sendCustomerPayCode(String customerPhone, String payCode) {
		Map<String, String> map = new HashMap<>();
		map.put("customerPhone", customerPhone);
		map.put("payCode", payCode);
		return this.update("sendCustomerPayCode", map);
	}

	/**
	 *
	 * <P>
	 * 清空客户天和钱包支付动态密码
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 30, 2017
	 * @param id
	 * @return int
	 */
	public int clearPayCode(String customerId) {
		Map<String, String> map = new HashMap<>();
		map.put("customerId", customerId);
		return this.update("clearPayCode", map);
	}

	/**
	 *
	 * <P>
	 * 获取所有没被拉黑的客户列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 6, 2017
	 * @return List<Customer>
	 */
	public List<Customer> getAllNoBlankCustomer() {
		return this.getList("getAllNoBlankCustomer");
	}

	/**
	 *
	 * <P>
	 * 获取本月过生日的所有会员列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 7, 2017
	 * @return List<Customer>
	 */
	public List<Customer> getThisMonthBirthdayCustomerList() {
		return this.getList("getThisMonthBirthdayCustomerList");
	}

	/**
	 *
	 * <P>
	 * 根据时间拿取用户数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月5日
	 * @param startDate
	 * @param endDate
	 * @return String
	 */
	public String getCountCustomerByTime(String startDate, String endDate) {
		Map<String, String> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		return this.get("getCountCustomerByTime", map);
	}

	/**
	 *
	 * <P>
	 * 拿取所有注册用户数量
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2018年2月5日
	 * @return String
	 */
	public String getCountCustomer() {
		return this.get("getCountCustomer", null);
	}
}
