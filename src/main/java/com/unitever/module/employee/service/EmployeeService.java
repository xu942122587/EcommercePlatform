package com.unitever.module.employee.service;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unitever.module.employee.dao.manual.EmployeeDAO;
import com.unitever.module.employee.model.Employee;
import com.unitever.module.weChat.model.WeChat;
import com.unitever.module.weChat.util.EmojiFilter;
import com.unitever.module.weChat.util.WeChatUtil;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.ExceptionUtil;
import com.unitever.platform.util.UUID;

@Service
@Transactional
public class EmployeeService {

	@Autowired
	private EmployeeDAO employeeDAO;

	private Logger logger_employeeService = LoggerFactory.getLogger("EmployeeService");

	/**
	 * <p>
	 * 根据ID获取Employee信息
	 * </p>
	 * 
	 * @param id
	 *            ：Employee的id
	 * @return Employee
	 */
	public Employee getEmployeeById(String id) {
		if (StringUtils.isBlank(id)) {
			return null;
		}
		return employeeDAO.get(id);
	}

	/**
	 * <p>
	 * 保存员工记录
	 * </p>
	 * 
	 * @param Employee
	 *            ：Employee对象
	 */
	public void save(Employee employee) {
		if (employee != null) {
			employee.setId(UUID.getUUID());
			employeeDAO.save(employee);
		}
	}

	/**
	 * <p>
	 * 更新员工信息记录
	 * </p>
	 * 
	 */
	public void update(Employee employee) {
		if (employee != null) {
			employeeDAO.update(employee);
		}
	}

	/**
	 * <p>
	 * 删除员工信息记录(设置员工信息为离职)
	 * </p>
	 * 
	 */
	public void delete(String id) {
		if (StringUtils.isNotBlank(id)) {
			employeeDAO.delete(id);
		}
	}

	/**
	 * <p>
	 * 获取Employee分页对象
	 * </p>
	 * 
	 * @param page
	 * @param Employee
	 * @return
	 */
	public Page<Employee> getPage(Page<Employee> page, Employee employee) {
		page.setTotalRecord(employeeDAO.getCountByObject(employee));
		employee.setStartOfPage(page.getStartOfPage());
		employee.setPageSize(page.getPageSize());
		page.setResults(employeeDAO.getEmployeeByEmployee(employee));
		return page;
	}

	public Employee getEmployeeWithCodeWeChat(String code, WeChat weChat) {
		Employee employee = new Employee();
		if (StringUtils.isNotBlank(code)) {
			weixin.popular.bean.User wpUser = WeChatUtil.getUserFromOauth2(code, weChat);
			if (StringUtils.isBlank(wpUser.getOpenid())) {
				// 微信未拿到openid，返回null，避免拿到数据库第一条记录的bug
				logger_employeeService.warn("微信授权链未能获取到用户openID，请检查获取频率或者是否存在运营商流量劫持等~微信返回数据对象如下：" + wpUser);
				return null;
			}
			Employee employeeByGet = getEmployeeWithOpenId(wpUser.getOpenid());
			if (null == employeeByGet) {
				employee.setName(EmojiFilter.filterEmoji(wpUser.getNickname()));
				employee.setHeadimgurl(wpUser.getHeadimgurl());
				employee.setOpenid(wpUser.getOpenid());
				try {
					this.save(employee);
				} catch (Exception e) {
					employee.setName("*");
					this.save(employee);
					logger_employeeService.warn("保存微信信息时出错，已将微信昵称更改为 “ * ” 保存，微信返回数据对象如下:" + wpUser + "/n-->具体错误如下："
							+ e.toString());
				}
			} else {
				employee = employeeByGet;
				employee.setName(EmojiFilter.filterEmoji(wpUser.getNickname()));
				employee.setHeadimgurl(wpUser.getHeadimgurl());
				try {
					this.update(employee);
				} catch (Exception e) {
					employee.setName("*");
					this.update(employee);
					logger_employeeService.warn("更新微信信息时出错，已将微信昵称更改为 “ * ” 保存，微信返回数据对象如下:" + wpUser + "/n-->具体错误如下："
							+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
				}
			}
		}
		return employee;
	}

	public Employee getEmployeeWithOpenId(String openId) {
		if (StringUtils.isNotBlank(openId))
			return employeeDAO.getEmployeeByOpenId(openId);
		return null;
	}

	/**
	 *
	 * <P>
	 * 获取所有微信用户
	 * </p>
	 *
	 * @author 闫枫
	 * @date Dec 29, 2016
	 * @return List<Employee>
	 */
	public List<Employee> getEmployeeAll() {
		return employeeDAO.getAll();
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
		return StringUtils.isBlank(openId) ? 0 : employeeDAO.kefuStart(openId);
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
		return StringUtils.isBlank(openId) ? 0 : employeeDAO.kefuEnd(openId);
	}
}