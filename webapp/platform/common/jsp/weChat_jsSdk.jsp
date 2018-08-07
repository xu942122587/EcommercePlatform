<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>

<%-- <script type="text/javascript" src="${path }/platform/common/js/jquery-1.8.3.min.js"></script> --%>
<%-- <script type="text/javascript" src="${path }/platform/common/js/jquery-3.1.1.min.js"></script> --%>
<script src="${path }/platform/common/js/jquery.sha1.js" type="text/javascript"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js" type="text/javascript"></script>
<script>
	var dataForWeixin = {
		appId : "",
		MsgImg : '${basePath_no_port }module/weChat/img/logo.jpg',//图标
		TLImg : '${basePath_no_port }module/weChat/img/logo.jpg',//图标
		url : '${basePath_no_port }weChat/goCompanyIndex',//分享的链接 
		title : "天和商城",
		desc : '欢迎光临天和商城',
		desc_tl : "",
		fakeid : "",
		callback : function() {
			//$("#fengxiangback").hide();
		}
	}
	$(function() {
		var no_sha1_String = "jsapi_ticket=${ticket}&noncestr=${nonceStr}&timestamp=${timeStamp}&url=" + window.location.href;
		wx.config({
			debug : false, //调式模式，设置为ture后会直接在网页上弹出调试信息，用于排查问题
			appId : '${appId}',// 必填，公众号的唯一标识
			timestamp : '${timeStamp}',// 必填，生成签名的时间戳
			nonceStr : '${nonceStr}',// 必填，生成签名的随机串
			signature : $.sha1(no_sha1_String),// 必填，签名，见附录1
			jsApiList : [ //需要使用的网页服务接口
				'checkJsApi', //判断当前客户端版本是否支持指定JS接口
				'onMenuShareTimeline', //分享到朋友圈
				'onMenuShareAppMessage', //分享给朋友
				'onMenuShareQQ', //分享到QQ
				'onMenuShareWeibo', //分享到腾讯微博
				'onMenuShareQZone', //分享到QQ空间
				'hideMenuItems', // 批量隐藏功能按钮接口
			]
		});
	});
	wx.ready(function() {//监听微信的分享按钮
		wx.onMenuShareTimeline({ //例如分享到朋友圈的API
			title : dataForWeixin.title, // 分享标题
			link : dataForWeixin.url, // 分享链接
			imgUrl : dataForWeixin.MsgImg, // 分享图标
			success : function() {
				dataForWeixin.callback();
				// 用户确认分享后执行的回调函数
			},
			cancel : function() {
				// 用户取消分享后执行的回调函数
			}
		});
		wx.onMenuShareAppMessage({//分享给朋友
			title : dataForWeixin.title, // 分享标题
			desc : dataForWeixin.desc, // 分享描述
			link : dataForWeixin.url, // 分享链接
			imgUrl : dataForWeixin.MsgImg, // 分享图标
			type : 'link', // 分享类型,music、video或link，不填默认为link
			dataUrl : '', // 如果type是music或video，则要提供数据链接，默认为空
			success : function() {
				dataForWeixin.callback();
				// 用户确认分享后执行的回调函数
			},
			cancel : function() {
				// 用户取消分享后执行的回调函数
			}
		});
		wx.onMenuShareQQ({
			title: dataForWeixin.title, // 分享标题
			desc: dataForWeixin.desc, // 分享描述
			link: dataForWeixin.url, // 分享链接
			imgUrl: dataForWeixin.MsgImg, // 分享图标
			success: function () { 
				dataForWeixin.callback();
				// 用户确认分享后执行的回调函数
			},
			cancel: function () { 
				// 用户取消分享后执行的回调函数
			}
		});
		wx.onMenuShareWeibo({
			title: dataForWeixin.title, // 分享标题
			desc: dataForWeixin.desc, // 分享描述
			link: dataForWeixin.url, // 分享链接
			imgUrl: dataForWeixin.MsgImg, // 分享图标
			success: function () { 
				dataForWeixin.callback();
				// 用户确认分享后执行的回调函数
			},
			cancel: function () { 
				// 用户取消分享后执行的回调函数
			}
		});
		wx.onMenuShareQZone({
			title: dataForWeixin.title, // 分享标题
			desc: dataForWeixin.desc, // 分享描述
			link: dataForWeixin.url, // 分享链接
			imgUrl: dataForWeixin.MsgImg, // 分享图标
			success: function () { 
				dataForWeixin.callback();
				// 用户确认分享后执行的回调函数
			},
			cancel: function () { 
				// 用户取消分享后执行的回调函数
			}
		});
		wx.hideMenuItems({
			menuList: ["menuItem:copyUrl",
						"menuItem:readMode",
						"menuItem:openWithSafari",
						"menuItem:openWithQQBrowser",
						"menuItem:favorite",
						"menuItem:share:email"
					] // 要显示的菜单项，所有menu项见附录3
		});
	});
	wx.error(function(res) {
		alert(res.errMsg); //打印错误消息。及把 debug:false,设置为debug:ture就可以直接在网页上看到弹出的错误提示
	}); 
	$(function() {
		hiddenLodding();
	});
	$('input').change(function(){
		$(this).val($(this).val().replace(/^\s+|\s+$/g, ''));
	}).keydown(function(e){
		if(32 == e.keyCode) return false;
	}).keyup(function(e){
		if(32 == e.keyCode) return false;
	}).keypress(function(e){
		if(32 == e.keyCode) return false;
	});
	$('textarea').change(function(){
		$(this).val($(this).val().replace(/^\s+|\s+$/g, ''));
	}).keydown(function(e){
		if(32 == e.keyCode) return false;
	}).keyup(function(e){
		if(32 == e.keyCode) return false;
	}).keypress(function(e){
		if(32 == e.keyCode) return false;
	});
</script>
