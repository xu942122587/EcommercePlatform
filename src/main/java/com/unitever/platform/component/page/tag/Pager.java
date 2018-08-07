package com.unitever.platform.component.page.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang.StringUtils;

/***
 * 分页控件
 * 
 * @author 花非花雾非雾
 */
public class Pager extends TagSupport {

	private static final long serialVersionUID = 1L;

	private Integer curPage;
	private Integer totalPage;
	private Integer pageSize = 10;
	private Integer totalCount = 0;
	private String formId;
	private String pageName;
	private String loadFunction;

	public void setCurPage(Integer curPage) {
		this.curPage = curPage;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}

	public void setFormId(String formId) {
		this.formId = formId;
	}

	public Integer getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}

	public String getPageName() {
		return pageName;
	}

	public void setPageName(String pageName) {
		this.pageName = pageName;
	}

	public String getLoadFunction() {
		return loadFunction;
	}

	public void setLoadFunction(String loadFunction) {
		this.loadFunction = loadFunction;
	}

	public int doStartTag() throws JspException {

		JspWriter out = pageContext.getOut();

		int pageNumber = 0;
		if (totalPage % pageSize == 0) {
			pageNumber = totalPage / pageSize;
		} else {
			pageNumber = (totalPage / pageSize) + 1;
		}
		if (curPage < 1) {
			curPage = 1;
		}

		try {
			if (pageNumber > 0) {
				StringBuffer outStr = new StringBuffer();
				outStr.append("<script type='text/javascript'>");
				outStr.append("function " + formId + "go(pageNum){");
				outStr.append("var form=document.getElementById('" + formId + "');");
				outStr.append("var dataUrl=form.action;");
				outStr.append("var urlSplit = dataUrl.indexOf('?')==-1?'?':'&';");
				outStr.append("var url = dataUrl+urlSplit+'page.pageSize=" + pageSize + "&page.pageNo='+pageNum;");
				outStr.append(pageName);
				if (StringUtils.isNotBlank(loadFunction)) {
					outStr.append("." + loadFunction + "(url);");
				} else {
					outStr.append(".load(url,menuIndexTemp,submenuIndexTemp);");
				}
				outStr.append("}");
				outStr.append("function " + formId + "changePageSize(size){");
				outStr.append("$('#" + formId + " .page-size').html(size);");
				outStr.append("var form=document.getElementById('" + formId + "');");
				outStr.append("var dataUrl=form.action;");
				outStr.append("var urlSplit = dataUrl.indexOf('?')==-1?'?':'&';");
				outStr.append("var url = dataUrl+urlSplit+'page.pageSize='+size;");
				outStr.append(pageName);
				if (StringUtils.isNotBlank(loadFunction)) {
					outStr.append("." + loadFunction + "(url);");
				} else {
					outStr.append(".load(url,menuIndexTemp,submenuIndexTemp);");
				}
				outStr.append("}");
				outStr.append("</script>");
				outStr.append("<div class='fixed-table-pagination'>");
				outStr.append("<div class='pull-left pagination-detail' style='padding-left:10px' >");
				outStr.append("<span class='pagination-info'>共" + totalPage + " 页，" + totalCount + " 条记录</span>");
				if (pageSize.intValue() == 5) {
					outStr.append(
							"<span class='page-list'>每页显示 <span class='btn-group dropup'> <button type='button' class='btn btn-default  dropdown-toggle' data-toggle='dropdown'> <span class='page-size'>5</span> <span class='caret'></span> </button> <ul class='dropdown-menu' role='menu'> <li class='active'><a href='javascript:void(0)' >5</a></li> <li><a href='javascript:void(0)' onclick='"
									+ formId
									+ "changePageSize(10)'  >10</a></li> <li><a href='javascript:void(0)' onclick='"
									+ formId + "changePageSize(20)'  >20</a></li> </ul> </span> 条记录 </span>");
				} else if (pageSize.intValue() == 10) {
					outStr.append(
							"<span class='page-list'>每页显示 <span class='btn-group dropup'> <button type='button' class='btn btn-default  dropdown-toggle' data-toggle='dropdown'> <span class='page-size'>10</span> <span class='caret'></span> </button> <ul class='dropdown-menu' role='menu'> <li><a href='javascript:void(0)' onclick='"
									+ formId
									+ "changePageSize(5)'>5</a></li> <li class='active'><a href='javascript:void(0)'>10</a></li> <li><a href='javascript:void(0)' onclick='"
									+ formId + "changePageSize(20)'>20</a></li> </ul> </span> 条记录 </span>");
				} else if (pageSize.intValue() == 20) {
					outStr.append(
							"<span class='page-list'>每页显示 <span class='btn-group dropup'> <button type='button' class='btn btn-default  dropdown-toggle' data-toggle='dropdown'> <span class='page-size'>20</span> <span class='caret'></span> </button> <ul class='dropdown-menu' role='menu'> <li><a href='javascript:void(0)' onclick='"
									+ formId
									+ "changePageSize(5)'>5</a></li> <li> <a href='javascript:void(0)' onclick='"
									+ formId
									+ "changePageSize(10)'>10</a></li> <li  class='active'><a href='javascript:void(0)'>20</a></li> </ul> </span> 条记录 </span>");
				}
				outStr.append("</div>");
				outStr.append("<div class='pull-right pagination' style='padding-right:10px' >");
				outStr.append("<ul class='pagination'>");

				// 规律5-3=2
				int start = 1;
				int end = totalPage;
				for (int i = 2; i >= 1; i--) {
					if ((curPage - i) >= 1) {
						start = curPage - i;
						break;
					}
				}
				for (int i = 2; i >= 1; i--) {
					if ((curPage + i) <= totalPage) {
						end = curPage + i;
						break;
					}
				}
				// 如果小于5则右侧补齐
				if (end - start + 1 <= 5) {
					Integer padLen = 5 - (end - start + 1);
					for (int i = padLen; i >= 1; i--) {
						if ((end + i) <= totalPage) {
							end = end + i;
							break;
						}
					}
				}

				// 如果还小于5左侧补齐
				if (end - start + 1 <= 5) {
					Integer padLen = 5 - (end - start + 1);
					for (int i = padLen; i >= 1; i--) {
						if ((start - i) >= 1) {
							start = start - i;
							break;
						}
					}
				}

				if (curPage > 1) {
					if (start > 1) {
						outStr.append("<li class='page-first'><a href='javascript:void(0)' onclick='" + formId
								+ "go(1)' >首页</a></li>");
					}
					outStr.append("<li class='page-pre'><a href='javascript:void(0)' onclick='" + formId + "go("
							+ (curPage.intValue() - 1) + ")' >上一页</a></li>");
				}

				for (int i = start; i <= end; i++) {
					if (i == curPage) {
						outStr.append("<li class='page-number active'><a href='javascript:void(0)' onclick='" + formId
								+ "go(" + i + ")' >" + i + "</a></li>");
					} else {
						outStr.append("<li class='page-number'><a href='javascript:void(0)' onclick='" + formId + "go("
								+ i + ")' >" + i + "</a></li>");
					}
				}
				if (curPage < totalPage) {
					outStr.append("<li class='page-next'><a href='javascript:void(0)' onclick='" + formId + "go("
							+ (curPage.intValue() + 1) + ")' >下一页</a></li>");
					if (end < totalPage) {
						outStr.append("<li class='page-last'><a href='javascript:void(0)' onclick='" + formId + "go("
								+ totalPage + ")' >尾页</a></li>");
					}
				}
				outStr.append("</ul>");
				outStr.append("</div>");
				outStr.append("</div>");
				out.print(outStr.toString());
			}

		} catch (IOException e) {
			e.printStackTrace();
		}

		return super.doStartTag();

	}

	public static Integer getStartIndex(Integer pageNum, Integer pageSize) {
		Integer res = 0;
		if (pageNum > 0) {
			res = (pageNum - 1) * pageSize;
		}
		return res;
	}

}