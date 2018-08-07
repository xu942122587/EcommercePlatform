package com.unitever.module.area.model;

import java.util.Date;

public class Area {
	private String id;
	private String content;
	private Date createTime;
	private String state;
	private Area area;
	private String grade;

	private String stateValue;

	/** 当前区域状态：正常 **/
	public static final String STATE_DELETE_NO = "1";
	/** 当前区域状态：已删除 **/
	public static final String STATE_DELETE_YES = "2";

	public Area() {
		super();
	}

	public Area(String id) {
		super();
		this.id = id;
	}

	public Area(String id, String content, Date createTime, String state, Area area, String grade) {
		super();
		this.id = id;
		this.content = content;
		this.createTime = createTime;
		this.state = state;
		this.area = area;
		this.grade = grade;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getStateValue() {
		if (STATE_DELETE_NO.equals(state)) {
			return "正常";
		} else if (STATE_DELETE_YES.equals(state)) {
			return "已删除";
		}
		return stateValue;
	}

	public void setStateValue(String stateValue) {
		this.stateValue = stateValue;
	}

	@Override
	public String toString() {
		return "Area [id=" + id + ", content=" + content + ", createTime=" + createTime + ", state=" + state + ", area="
				+ area + ", stateValue=" + stateValue + "]";
	}

}
