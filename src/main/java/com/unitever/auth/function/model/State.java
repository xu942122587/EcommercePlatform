package com.unitever.auth.function.model;

public class State {
	
	private boolean checked=true;
	
	

	public State(boolean checked) {
		super();
		this.checked = checked;
	}
	
	

	public State() {
		super();
	}



	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	
	

}
