package com.unitever.module.employee.dao.manual;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.unitever.module.employee.model.Employee;
import com.unitever.platform.core.dao.BaseDAO;

@Repository
public class EmployeeDAO extends BaseDAO<Employee, String> {

	/**
	 * <p>
	 * 根据Employee条件查询Employee
	 * </p>
	 * 
	 * @param Employee
	 * @return List<Employee>
	 */
	public List<Employee> getEmployeeByEmployee(Employee employee) {
		return this.getList("getEmployeeByEmployee", employee);
	}

	/**
	 * <p>
	 * 根据Employee条件查询Employee
	 * </p>
	 * 
	 * @param openId
	 * @return Employee
	 */
	public Employee getEmployeeByOpenId(String openId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("openId", openId);
		return this.get("getEmployeeByOpenId", map);
	}

	/**
	 *
	 * <P>
	 * 客服开始
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 20, 2017
	 * @param openId
	 * @return int
	 */
	public int kefuStart(String openId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("openId", openId);
		return this.update("kefuStart", map);
	}

	/**
	 *
	 * <P>
	 * 客服结束
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 20, 2017
	 * @param openId
	 * @return int
	 */
	public int kefuEnd(String openId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("openId", openId);
		return this.update("kefuEnd", map);
	}

}