package com.unitever.auth.function.model;

import java.util.ArrayList;
import java.util.List;

import com.unitever.auth.operation.model.Operation;

/**
 * @author 作者 : 邓文杰
 * @version 创建时间：2015-12-15 下午3:05:26 类说明
 */
public class Function {

	private String id;
	private String name;
	private String url;
	private String description;// 描述
	private String seq;// 顺序
	private String level;// 级别
	private Function parentFunction;// 父功能点
	private List<Function> childrenFunctions = new ArrayList<Function>(); // 子功能点
	private List<Operation> operations = new ArrayList<Operation>(); // 子操作

	private String icon;

	/** 模块级别: 二级 */
	public static String FUNCTION_LEVEL2 = "1";
	/** 模块级别: 一级 */
	public static String FUNCTION_LEVEL1 = "0";

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public Function getParentFunction() {
		return parentFunction;
	}

	public void setParentFunction(Function parentFunction) {
		this.parentFunction = parentFunction;
	}

	public List<Function> getChildrenFunctions() {
		return childrenFunctions;
	}

	public void setChildrenFunctions(List<Function> childrenFunctions) {
		this.childrenFunctions = childrenFunctions;
	}

	public List<Operation> getOperations() {
		return operations;
	}

	public void setOperations(List<Operation> operations) {
		this.operations = operations;
	}

}
