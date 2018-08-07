package com.unitever.auth.function.model;

import java.util.List;

public class FunctionTree {
	
	private String id;
	private String level;
	private String text;
	private String parentId;
	//private boolean checked=true;
	private List<FunctionTree> nodes;
	private State state=new State(false);
	
	public State getState() {
		return state;
	}
	public void setState(State state) {
		this.state = state;
	}
	/*public boolean isChecked() {
		return checked;
	}
	public void setChecked(boolean checked) {
		this.checked = checked;
	}*/
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public List<FunctionTree> getNodes() {
		return nodes;
	}
	public void setNodes(List<FunctionTree> nodes) {
		this.nodes = nodes;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	
	
	
	

}
