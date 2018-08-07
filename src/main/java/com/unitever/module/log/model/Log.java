package com.unitever.module.log.model;

import java.util.Date;

import com.unitever.auth.user.model.User;
import com.unitever.module.customer.model.Customer;
import com.unitever.module.store.model.Store;

/**
 *
 * * 订单
 * </p>
 *
 */
public class Log {


	/** Id */
	private String id;
	/** 操作人 */
	private String operatorName;
	/** 操作记录 */
	private String content;
	/** 是否是管理员 */
	private String isAdmin;
	/** 操作人ID */
	private String operatorId;
	/** 类型 */
	private String logType;
	/** 对象id */
	private String objectId;
	/** 操作编码 */
	private Integer operate;
	/** 创建时间 */
	private Date createTime;

	private String ft;
	private String lt;
	private String fu;
	private String lu;

	private String startDate; // 查询用
	private String endDate; // 查询用

	public Log() {
		super();
	}

	public Log(String id) {
		super();
		this.id = id;
	}

	public Log(String id, String operatorName, String content, String isAdmin,
			String operatorId, String logType, String objectId,
			Integer operate, Date createTime) {
		super();
		this.id = id;
		this.operatorName = operatorName;
		this.content = content;
		this.isAdmin = isAdmin;
		this.operatorId = operatorId;
		this.logType = logType;
		this.objectId = objectId;
		this.operate = operate;
		this.createTime = createTime;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getOperatorName() {
		return operatorName;
	}

	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(String isAdmin) {
		this.isAdmin = isAdmin;
	}

	public String getOperatorId() {
		return operatorId;
	}

	public void setOperatorId(String operatorId) {
		this.operatorId = operatorId;
	}

	public String getLogType() {
		return logType;
	}

	public void setLogType(String logType) {
		this.logType = logType;
	}

	public String getObjectId() {
		return objectId;
	}

	public void setObjectId(String objectId) {
		this.objectId = objectId;
	}

	public Integer getOperate() {
		return operate;
	}

	public void setOperate(Integer operate) {
		this.operate = operate;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
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

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	@Override
	public String toString() {
		return "Log [id=" + id + ", operatorName=" + operatorName
				+ ", content=" + content + ", isAdmin=" + isAdmin
				+ ", operatorId=" + operatorId + ", logType=" + logType
				+ ", objectId=" + objectId + ", operate=" + operate
				+ ", createTime=" + createTime + ", ft=" + ft + ", lt=" + lt
				+ ", fu=" + fu + ", lu=" + lu + "]";
	}


}
