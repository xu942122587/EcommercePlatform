package com.unitever.auth.user.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.unitever.auth.function.model.Function;
import com.unitever.auth.operation.model.Operation;
import com.unitever.auth.role.model.Role;
import com.unitever.module.store.model.Store;
import com.unitever.platform.core.dao.BaseModel;

public class User extends BaseModel {

	private String id;
	private String username;
	private String password;
	private String name;
	/**
	 * 职位
	 */
	private String job;
	/**
	 * 入职时间
	 */
	private Date joinTime;
	/**
	 * 员工编号
	 */
	private String userCode;
	/**
	 * 身份证号
	 */
	private String idCard;
	private Role role;

	/**
	 * 归属门店
	 */
	private Store store;
	private String openId;

	private String ft;
	private String lt;
	private String fu;
	private String lu;
	private String state = USER_STATE_NORMAL;
	private String phone;

	private List<Operation> operationsList;

	/** 已删除 **/
	public static final String USER_STATE_REMOVE = "0";
	/** 正常 **/
	public static final String USER_STATE_NORMAL = "1";

	/** 默认密码 */
	public static final String DEFAULT_PASSWORD = "000000";

	public static final String PRODUCTTITLE = "固阳天和商城";

	public User() {
		super();
	}

	public User(String id) {
		super();
		this.id = id;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getFt() {
		return ft;
	}

	public void setFt(String ft) {
		this.ft = ft;
	}

	public String getLt() {
		return lt;
	}

	public void setLt(String lt) {
		this.lt = lt;
	}

	public String getFu() {
		return fu;
	}

	public void setFu(String fu) {
		this.fu = fu;
	}

	public String getLu() {
		return lu;
	}

	public void setLu(String lu) {
		this.lu = lu;
	}

	public List<Operation> getOperationsList() {
		List<Operation> operationList = new ArrayList<Operation>();
		if (null != role)
			if (StringUtils.isNotBlank(role.getId()))
				if (role.getFunctions() != null)
					if (!role.getFunctions().isEmpty()) {
						for (Function function : role.getFunctions()) {
							// 检查是否是二级菜单
							if (Function.FUNCTION_LEVEL2.equals(function.getLevel())) {
								// 检查子操作是否为空
								if (!function.getOperations().isEmpty()) {
									operationList.addAll(function.getOperations());
								}
							}
						}
					}
		return operationList;
	}

	public void setOperationsList(List<Operation> operationsList) {
		this.operationsList = operationsList;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getOpenId() {
		return openId;
	}

	public void setOpenId(String openId) {
		this.openId = openId;
	}

	/**
	 * @return the store
	 */
	public Store getStore() {
		return store;
	}

	/**
	 * @param store
	 *            the store to set
	 */
	public void setStore(Store store) {
		this.store = store;
	}

	/**
	 * @return the userCode 员工编号
	 */
	public String getUserCode() {
		return userCode;
	}

	/**
	 * @param userCode
	 *            the userCode（员工编号） to set
	 */
	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}

	/**
	 * @return the job 职位
	 */
	public String getJob() {
		return job;
	}

	/**
	 * @param job
	 *            the job（职位） to set
	 */
	public void setJob(String job) {
		this.job = job;
	}

	/**
	 * @return the joinTime 入职时间
	 */
	public Date getJoinTime() {
		return joinTime;
	}

	/**
	 * @param joinTime
	 *            the joinTime（入职时间） to set
	 */
	public void setJoinTime(Date joinTime) {
		this.joinTime = joinTime;
	}

	/**
	 * @return the idCard 身份证号
	 */
	public String getIdCard() {
		return idCard;
	}

	/**
	 * @param idCard
	 *            the idCard(身份证号) to set
	 */
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

}