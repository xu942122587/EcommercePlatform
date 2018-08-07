package com.unitever.auth.user.model;

import com.unitever.auth.function.model.State;

public class NoHeadUserTree {

	private String id;
	private String level;
	private String text;
	private State state = new State(false);

	public State getState() {
		return state;
	}

	public void setState(State state) {
		this.state = state;
	}

	/*
	 * public boolean isChecked() { return checked; } public void
	 * setChecked(boolean checked) { this.checked = checked; }
	 */
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

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

}
