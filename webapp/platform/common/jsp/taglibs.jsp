<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%-- 标签库声明 --%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="fn" uri="/WEB-INF/tld/fn.tld" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld" %>
<%@ taglib prefix="uc" uri="/WEB-INF/tld/UC.tld" %>
<%@ taglib prefix="pager" uri="/WEB-INF/tld/pager.tld" %>
<%-- 全局Java变量声明 --%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String basePath_no_port = request.getScheme()+"://"+request.getServerName()+path+"/";
String domainName = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/";
%>
<%-- 页面变量声明 --%>
<c:set var="path" 	value="<%=path%>"/>
<c:set var="basePath" 	value="<%=basePath%>"/>
<c:set var="basePath_no_port" 	value="<%=basePath_no_port%>"/>
<c:set var="domainName" 	value="<%=domainName%>"/>