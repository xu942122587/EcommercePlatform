package com.unitever.module.classification.model;

import java.util.List;

import org.apache.commons.lang.StringUtils;

public class ClassificationTree {

	private String id;
	private String level;
	private String text;
	private String parentId;
	private String isVisible;
	private String isBlank;
	private Integer isHaveGoods;
	private String isHaveAttr;
	private List<String> tags;
	private List<ClassificationTree> nodes;

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

	public List<ClassificationTree> getNodes() {
		return nodes;
	}

	public void setNodes(List<ClassificationTree> nodes) {
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

	public List<String> getTags() {
		return tags;
	}

	public void setTags(List<String> tags) {
		this.tags = tags;
	}

	public String getIsVisible() {
		return isVisible;
	}

	public void setIsVisible(String isVisible) {
		this.isVisible = isVisible;
	}

	/**
	 * @return the isBlank
	 */
	public String getIsBlank() {
		if(null != nodes){
			if(!nodes.isEmpty()){
				return "2";
			}
		}
		return "1";
	}

	/**
	 * @return the isHaveGoods
	 */
	public Integer getIsHaveGoods() {
		return isHaveGoods;
	}

	/**
	 * @param isHaveGoods the isHaveGoods to set
	 */
	public void setIsHaveGoods(Integer isHaveGoods) {
		this.isHaveGoods = isHaveGoods;
	}

	/**
	 * @return the isHaveAttr
	 */
	public String getIsHaveAttr() {
		return isHaveAttr;
	}

	/**
	 * @param isHaveAttr the isHaveAttr to set
	 */
	public void setIsHaveAttr(String isHaveAttr) {
		this.isHaveAttr = isHaveAttr;
	}

	@Override
	public String toString() {
		return "ClassificationTree [id=" + id + ", level=" + level + ", text=" + text + ", parentId=" + parentId
				+ ", tags=" + tags.size() + ", isVisible=" + isVisible + ", nodes=" + nodes + "]";
	}

}
