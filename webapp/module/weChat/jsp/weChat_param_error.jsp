<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>
	<head>
		<meta charset="utf-8">
		<title>网络错误</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<script type="text/javascript" src="${path}/module/weChat/js/jquery-3.1.1.min.js"></script>
		<link rel="stylesheet" href="${path}/module/weChat/css/all.css">
	</head>
	<body class="bg-white">
		<!--404-->
		<div class="list-none" style="display: block;">
			<img src="${path}/module/weChat/img/error.png" class="imgs">
			<div class="fonts" style="color: #f093aa;">非法参数，拒绝访问，建议重试或更换网络环境~</div>
		</div>
	<%@ include file="/platform/common/jsp/weChat_jsSdk.jsp"%>
	</body>
</html>
