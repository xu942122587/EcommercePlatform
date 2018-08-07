<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html >
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" href="${path}/module/weChat/css/all.css">
    <script type="text/javascript" src="${path}/module/weChat/js/jquery-3.1.1.min.js"></script>
	<title>error</title>
</head>
<body class="bg-white" style="height:100%;">
	<div style="width:100%;height:100%;text-align:center;font-size:14px;padding-top:30%;">
		<img src="${path}/module/weChat/img/404.png" style="width:70%;">
		<p style="color:#4c4c4c;font-size:16px">加载失败…</p>
		<button onclick="window.location=location.href" class="goindex_btn">重试</button>
	</div>
	<%@ include file="/platform/common/jsp/weChat_jsSdk.jsp"%>
</body>
</html>