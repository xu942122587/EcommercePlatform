/**
 *
 * <P> BaseModel.java </p>
 *
 * @author 闫枫
 * @date Nov 23, 2017
 */
package com.unitever.platform.core.dao;

/**
 *
 * <P>
 * platform-yihaoV2.0->com.unitever.platform.core.dao->BaseModel.java
 * </p>
 * <P>
 * 实体类基类
 * </p>
 *
 * @author 闫枫
 * @date Nov 23, 2017
 */
public class BaseModel {
	private int startOfPage = -1;// 查询用--开始条数
	private int pageSize = 10;// 查询用--截取条数(默认10条)

	/**
	 * @return the startOfPage 查询用--开始条数
	 */
	public int getStartOfPage() {
		return startOfPage;
	}

	/**
	 * @param startOfPage
	 *            the startOfPage（查询用--开始条数） to set
	 */
	public void setStartOfPage(int startOfPage) {
		this.startOfPage = startOfPage;
	}

	/**
	 * @return the pageSize 查询用--截取条数
	 */
	public int getPageSize() {
		return pageSize;
	}

	/**
	 * @param pageSize
	 *            the pageSize（查询用--截取条数） to set
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
}
