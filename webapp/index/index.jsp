<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>
<head>
<meta charset="utf-8">
<title>管理中心</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<%@ include file="/platform/common/jsp/baseJs.jsp"%>
<script type="text/javascript">
	 var hrefTemp="";
	 var menuIndexTemp="";
	 var submenuIndexTemp="";
	 var currHref="";
	 Namespace.register("com.yunt.index");
	 com.yunt.index = {
			 /* 加载页面并修改面包屑导航 一，二级**/
		load : function(href,menuIndex,submenuIndex) {
			//加载页面
			$("#content").load(href);
			//修改面包屑导航
			if ($("#level1").length <= 0) {
				$("#level3").before(
						"<li id='level1' >"+$("#menu"+menuIndex).html()+"</li >");
			} else {
				$("#level1").html($("#menu"+menuIndex).html());
			}
			if ($("#level2").length > 0) {
				$("#level2").remove();
			}
			$("#level3").html($("#submenu_"+menuIndex+"_"+submenuIndex).html());
			"com.yunt.index.load('"+href+"','"+menuIndex+"','"+submenuIndex+"')"
			//设置临时属性，保存链接
			$("#level3").attr("temp","com.yunt.index.load('"+href+"','"+menuIndex+"','"+submenuIndex+"')");
			//为了在3级页面跳转回到二级页面
			hrefTemp=href;
			submenuIndexTemp=submenuIndex;
			menuIndexTemp=menuIndex;
		},
		/* 加载页面并修改面包屑导航----3级导航，页面内链接调用**/
		loadInner : function(href, title) {
			//加载页面
			$("#content").load(href);
			//修改面包屑导航
			if ($("#level2").length <= 0) {
				$("#level3").before(
						"<li id='level2' ><a id='a_level2' href='javascript:void(0);'>" + $("#level3").html()
								+ "</a></li >");
				$("#a_level2").attr("onclick",$("#level3").attr("temp"));
			} else {
				$("#level2").children("a").html($("#level3").html());
			}
			currHref=href;
			$("#level3").html(title);
		},
		/**加载单独页面：修改密码，个人信息...*/
		loadSpec : function(href,title) {
			//加载页面
			$("#content").load(href);
			//修改面包屑导航,删除第一二级面包屑导航
			if ($("#level1").length > 0) {
				$("#level1").remove();
			}
			if ($("#level2").length > 0) {
				$("#level2").remove();
			}
			$("#level3").html(title);
		},
		/**到首页*/
		toIndex : function() {
			window.location.href = "${path}/bd/welcome/login";
		},
		/**返回此模块的首页*/
		toPreIndex : function() {
			com.yunt.index.load(hrefTemp,menuIndexTemp,submenuIndexTemp);
		},
		/* 只加载页面（三级页面做查询用，同时不破坏面包屑导航返回2级页面） */
		loadOnly : function(href){
			//加载页面
			$("#content").load(href);
		}
	 }	
</script>
<style type="text/css">
/*定义滚动条高宽及背景 高宽分别对应横竖滚动条的尺寸*/
.bigimg_box::-webkit-scrollbar {
	width: 8px;
	background-color: none;
}
/*定义滚动条轨道 内阴影+圆角*/
.bigimg_box::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 10px;
	background-color: #F5F5F5;
}
/*定义滑块 内阴影+圆角*/
.bigimg_box::-webkit-scrollbar-thumb {
	border-radius: 10px;
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
	background-color: #0AA0D9;
}
.common_pop_up_box {
	position: fixed;
	z-index: 2;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.7);
	display: none;
}
.pop_up_null {
	position: fixed;
	z-index: 2;
	top: 0;
	left: 0;
	height: 100%;
	width: 100%;
	background: none;
}
.bigimg_close {
	position: absolute;
	z-index: 11;
	top: 8%;
	right: 24%;
	width: 22px;
	background: rgba(0, 0, 0, 0.6);
	padding: 8px;
	border-radius: 50%;
    box-sizing: content-box;
}
.bigimg_box {
	position: relative;
	width: 50%;
	top: 10%;
	left: 25%;
	overflow: auto;
	height: 80%;
	background: none;
}
.bigimg {
	position: absolute;
	z-index: 10;
	top: 0;
	left: 0;
	margin-left: 0;
	width: 100%;
}

/*待办事项*/
.common_backlog {
	width:100%;
	margin-top: 40px;
	height: 240px;
	background-color: #337ab7;
	border-radius: 15px;
	color: #FFCC00;
}
.common_backlog_icon {
	width: 50px;
	margin: 96px 20px 36px 40px;
	float: left;
}
.common_backlog_title {
	font-size: 4rem;
	font-weight: bold;
	float: left;
	line-height: 228px;
}
/*滚动展示*/
.common_backlog_content {
	width: 72%;
	height:160px;
	margin: 40px 3%;
	border-left: 1px solid rgba(255, 255, 255, 0.5);
	float: left;
	line-height: 40px;
	padding-left: 16px;
	font-size: 1.3rem;
	overflow: hidden;
	/*这个一定要加，超出的内容部分要隐藏，免得撑高中间部分 */
}
.common_backlog_content ul {
	margin:0 auto;
}
.common_backlog_content ul li{
	list-style: none;
	font-size:2rem;
	overflow: hidden;
white-space: nowrap;
text-overflow: ellipsis;
}
@media only screen and (max-width: 1799px) and (min-width: 800px){
	.common_backlog_content {
	    width: 65%;
	    font-size: 1rem;
	}
}
.tooltip_xmk {
	display: none;
	position: fixed;
	z-index: 1000;
	top: 0;
	left: 0;
	max-width: 600px;
	max-height: 300px;
	overflow: auto;
	line-height: 30px;
	/* border:1px solid red; */
	background: #105a9b;
	color: #fff;
	padding: 6px 12px;
	border-radius: 6px;
	margin: 0 auto;
	min-width: 75px;
	min-height: 40px;
}
.sanjia_3_1 {
	top: 0;
	left: 0;
	width: 0px;
	display: none;
	position: fixed;
	z-index: 1000;
	-webkit-transform: rotate(0deg);
	-moz-transform: rotate(0deg);
	filter: progid: DXImageTransform.Microsoft.BasicImage(rotation=0);
	border-left: 30px solid transparent;
	border-right: 30px solid transparent;
	border-bottom: 30px solid #0f4e8d;
}
</style>
</head>
<body >
	<!--the top nav begin-->
	<div class="navbar navbar-default" role="navigation" style="margin-bottom: 0px;height: 110px;background-color: #fefefe;">
		<div class="navbar-inner">
			<div class="navbar-header" style="padding-top: 20px;">
				<div class="navbar-brand"  style="margin-top:-18px; padding-right:0px; width:110px; height:100px; background:url('${path}/module/weChat/img/logo.jpg') no-repeat;background-size:100px 100px;">
					
				</div>
				<div class="navbar-brand"  style="color: #212121;padding-left:0px; height: 90px; ">
					<span style="font-size: 2em;font-family: 宋体; font-weight: bold;">
						后台管理系统
					</span>
					<br>
					<span style="font-size: 0.76em; font-family: Arial;font-weight: bold;">
						Background management system
					</span>
				</div>
			</div>
			<ul class="nav navbar-nav pull-right">
				<li id="fat-menu" class="dropdown">
					<a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown" 
						style="color: #212121;font-size: 1.25em; padding-top:65px;font-family: 宋体; font-weight: bold; bottom: 0 px;">
						<span class="glyphicon glyphicon-user"></span> 欢迎，${user.name}
						<span class="glyphicon glyphicon-chevron-down"></span>
					</a>
					<ul class="dropdown-menu" role="menu">
						<li role="presentation">
							<a role="menuitem" tabindex="-1" href="javascript:void(0);" style="padding-left: 30px;" 
								onclick="com.yunt.index.loadSpec('${path}/user/userDetail','我的账户')">
								我的账户
							</a>
						</li>
						<li role="presentation">
							<a role="menuitem" tabindex="-1" href="javascript:void(0);" style="padding-left: 30px;"
								onclick="com.yunt.index.loadSpec('${path}/user/toChangePassword','修改密码')">
								修改密码
							</a>
						</li>
						<li role="presentation">
							<a role="menuitem" tabindex="-1" style="padding-left: 30px;"
								href="${path}/bd/welcome/logout">注销
							</a>
						</li>
					</ul>
				</li>
			</ul>
			<ul class="nav navbar-nav pull-right help">
				<li class="dropdown open">
					<a href="javascript:void(0);" role="button" class="dropdown-toggle" style="color: #212121;font-size: 1.25em; padding-top:65px;font-family: 宋体; font-weight: bold; bottom: 0 px;" aria-expanded="true">
						<span class=" glyphicon glyphicon-book"></span>  帮助
						
					</a>
				</li>
			</ul>
		</div>
	</div>
	<!--the top nav end-->
	<!--the sidebar nav begin -->
	<div class="sidebar-nav">
		<a href="" class="nav-header" style="padding-left:15px;"> <span
			class="glyphicon glyphicon-home"></span> 管理中心 首页
		</a>
		<c:forEach items="${parentFunctions}" var="parentFunction" varStatus="parenti">
			<c:if test="${fn:length(parentFunction.childrenFunctions)<1}">
				<a href="${parentFunction.url}" class="nav-header" style="padding-left:15px;">
					<span class="${parentFunction.icon }"></span>
					${parentFunction.name}
				</a>
			</c:if>
			<c:if test="${fn:length(parentFunction.childrenFunctions)>=1}">
				<a href="#dashboard-menu${parenti.index+1 }" class="nav-header collapsed" style="padding-left:15px;" data-toggle="collapse">
					<span class="${parentFunction.icon }"></span>
					<span id="menu${parenti.index+1 }">${parentFunction.name}</span>
				</a>
				<ul id="dashboard-menu${parenti.index+1 }" class="nav nav-list collapse">
					<c:forEach items="${parentFunction.childrenFunctions}" var="childFunction" varStatus="subi">
						<c:if test="${fn:indexOf(functionIds, childFunction.id) > -1 }">
							<li>
								<a href="javascript:void(0)"
										onclick="com.yunt.index.load('${path}'+'${childFunction.url}','${parenti.index+1}','${subi.index+1}')"
										id="submenu_${parenti.index+1 }_${subi.index+1}">
									${childFunction.name}
								</a>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</c:if>
		</c:forEach>
		<a href="${path}/bd/welcome/logout" class="nav-header" style="padding-left:15px;"><span
			class="glyphicon glyphicon-log-out"></span>注销</a>
	</div>

	<div class="content" style="padding-top: 0px;">
		<!--面包屑导航-->
		<ul class="breadcrumb" style="margin-bottom: 0px;">
			<li class="active">当前位置：</li>
			<li id="level3" class="active" id="currentTab">首页</li>
		</ul>
		<!--page title end and the main content begin-->
		<div class="container-fluid" id="content">
		<!--提醒信息  start-->
			<div class="common_backlog" style="background-color: #b73333;">
				<img class="common_backlog_icon" src="${path }/platform/common/images/warnning.png" />
				<h5 class="common_backlog_title">系统预警</h5>
				<div id="common_backlog_content_kucun" class="common_backlog_content">
					<ul id="ulheight_kucun">
						<c:if test="${0 lt abnormaiGoodsCount}">
							<li>
								<span>商品异常:共有${abnormaiGoodsCount}件商品发生异常,请第一时间到商品管理进行修改操作!!!</span>
							</li>
						</c:if>
						<c:set value="" var="goods_up_warning" />
						<c:set value="" var="goods_down_warning" />
						<c:forEach items="${inventoryVOList }" var="inventoryVO">
							<c:if test="${not empty user.store.id}">
								<c:if test="${user.store.id eq inventoryVO.goods.store.id}">
									<c:if test="${'1' eq inventoryVO.warningUpValue}">
										<c:if test="${0 > fn:indexOf(goods_up_warning,inventoryVO.goods.id) }">
											<c:set value="${goods_up_warning.concat(inventoryVO.goods.id) }" var="goods_up_warning"/>
											<li>
												<span>库存上限预警:
													${inventoryVO.goods.goodsCode}---${inventoryVO.goods.name}---${inventoryVO.count}件
												</span>
											</li>
										</c:if>
									</c:if>
									<c:if test="${'1' eq inventoryVO.warningDownValue}">
										<c:if test="${0 > fn:indexOf(goods_down_warning,inventoryVO.goods.id) }">
											<c:set value="${goods_down_warning.concat(inventoryVO.goods.id) }" var="goods_down_warning"/>
											<li>
												<span>库存下限预警:
													${inventoryVO.goods.goodsCode}---${inventoryVO.goods.name}---${inventoryVO.count}件
												</span>
											</li>
										</c:if>
									</c:if>
								</c:if>
							</c:if>
							<c:if test="${empty user.store.id}">
								<c:if test="${'1' eq inventoryVO.warningUpValue}">
									<c:if test="${0 > fn:indexOf(goods_up_warning,inventoryVO.goods.id) }">
										<c:set value="${goods_up_warning.concat(inventoryVO.goods.id) }" var="goods_up_warning"/>
										<li>
											<span>库存上限预警:
												${inventoryVO.goods.goodsCode}---${inventoryVO.goods.name}---${inventoryVO.count}件
											</span>
										</li>
									</c:if>
								</c:if>
								<c:if test="${'1' eq inventoryVO.warningDownValue}">
									<c:if test="${0 > fn:indexOf(goods_down_warning,inventoryVO.goods.id) }">
										<c:set value="${goods_down_warning.concat(inventoryVO.goods.id) }" var="goods_down_warning"/>
										<li>
											<span>库存下限预警:
												${inventoryVO.goods.goodsCode}---${inventoryVO.goods.name}---${inventoryVO.count}件
											</span>
										</li>
									</c:if>
								</c:if>
							</c:if>
						</c:forEach>
					</ul>
				</div>
			</div>
		<!--提醒信息  end-->
		
		<!--通知公告  start-->
			<div class="common_backlog">
				<img class="common_backlog_icon" src="${path }/platform/common/images/warnning.png" />
				<h5 class="common_backlog_title">通知公告</h5>
				<div id="common_backlog_content" class="common_backlog_content">
					<ul id="ulheight">
						<c:forEach items="${noticeList }" var="notice">
							<li onclick="com.yunt.index.loadInner('${path}/notice/view?id=${notice.id }&isIndex=yes','查看公告')" style="cursor: pointer;">
								<span>
									${notice.title}
									---<fmt:formatDate value="${notice.createTime}" pattern="yyyy-MM-dd"/>
								</span>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		<!--通知公告  end-->
		</div>
	</div>

<div id="embed_div"></div>

	<script type="text/javascript">
		$(document).ready(function() {
			//配置toastr（弹出框）
			toastr.options = {
				"closeButton" : false, //是否显示关闭按钮
				"debug" : false, //是否使用debug模式
				"positionClass" : "toast-top-right",//弹出窗的位置
				"showDuration" : "300",//显示的动画时间
				"hideDuration" : "1000",//消失的动画时间
				"timeOut" : "5000", //展现时间
				"extendedTimeOut" : "1000",//加长展示时间
				"showEasing" : "swing",//显示时的动画缓冲方式
				"hideEasing" : "linear",//消失时的动画缓冲方式
				"showMethod" : "fadeIn",//显示时的动画方式
				"hideMethod" : "fadeOut" //消失时的动画方式
			};
		});
		
		//图片放大
		$(document).on("click",".imgList img", function() {
			$("body").css("overflow-y", "hidden");
			$("#imgpreview").show();
			$(".bigimg_box img").attr("src", $(this).attr('src'));
		});
		// 关闭图片弹框
		$(document).on("click",".pop_up_null", function() {
			$(".common_pop_up_box").hide();
			$("body").css("overflow-y", "scroll");
		});
		$(document).on("click",".commom_close", function() {
			$(".common_pop_up_box").hide();
			$("body").css("overflow-y", "scroll");
		});
		if($("#ulheight_kucun").height() > 160) {
			//待办事项	
			var areakucun = document.getElementById('common_backlog_content_kucun');
			var iliHeight = 40; //单行滚动的高度
			var speed = 50; //滚动的速度
			var timekucun;
			var delay = 2000;
			areakucun.scrollTop = 0;
			areakucun.innerHTML += areakucun.innerHTML; //克隆一份一样的内容
			function startScrollkucun() {
				areakucun.scrollTop= areakucun.scrollTop+1;
				timekucun = setInterval("scrollUpkucun()", speed);
			}
		
			function scrollUpkucun() {
				if(areakucun.scrollTop % iliHeight == 0) {
					clearInterval(timekucun);
					setTimeout(startScrollkucun, delay);
				} else {
					areakucun.scrollTop++;
					if(areakucun.scrollTop >= areakucun.scrollHeight / 2) {
						areakucun.scrollTop = 0;
					}
				}
			}
			setTimeout(startScrollkucun, delay);
		}
		if($("#ulheight").height() > 160) {
			//待办事项	
			var area = document.getElementById('common_backlog_content');
			var iliHeight = 40; //单行滚动的高度
			var speed = 50; //滚动的速度
			var time;
			var delay = 2000;
			area.scrollTop = 0;
			area.innerHTML += area.innerHTML; //克隆一份一样的内容
			function startScroll() {
				area.scrollTop=area.scrollTop+1;
				time = setInterval("scrollUp()", speed);
			}

			function scrollUp() {
				if(area.scrollTop % iliHeight == 0) {
					clearInterval(time);
					setTimeout(startScroll, delay);
				} else {
					area.scrollTop++;
					if(area.scrollTop >= area.scrollHeight / 2) {
						area.scrollTop = 0;
					}
				}
			}
			setTimeout(startScroll, delay);
		}

		/**
		 * 播放警告音
		 */
		function setEmbed(){
			$("#embed_div").append("<audio id='embed_audio_mp3' src='${basePath}/module/procurement/2730.mp3' autoplay='true' playcount='1'></audio>");
		}
		/**
		 * 停止播放警告音
		 */
		function delEmbed(){
			$("#embed_audio_mp3").remove();
			$("#embed_div").html();
		}
	</script>
	
	<!--图片放大弹框-->
	<div id="imgpreview" class="common_pop_up_box">
		<div class="pop_up_null"></div>
		<img class="commom_close bigimg_close" src="${path }/platform/common/images/close.png" />
		<div class="common_pop_up bigimg_box ">
			<img class="bigimg" src="" />
		</div>
	</div>

	<!-- 确认删除模态框（Modal） -->
	<div class="modal fade" id="deleteModal" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title" id="myModalLabel">删除</h4>
				</div>
				<div class="modal-body">您确定要删除吗?(请避免在营业时间进行删除操作!!!)</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
					<button id="deleteButton" type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	
	<!-- 确认提交模态框（Modal） -->
	<div class="modal fade" id="submitModal" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title" id="myModalLabel">提交</h4>
				</div>
				<div class="modal-body">您确定要提交吗?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
					<button id="submitButton" type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	
	<!-- 确认发放提成模态框（Modal） -->
	<div class="modal fade" id="sendMoney" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title" id="myModalLabel">删除</h4>
				</div>
				<div class="modal-body">确认已发放提成?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
					<button id="sendMoneyButton" type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	
	<!-- 放弃订单模态框（Modal） -->
	<div class="modal fade" id="update_order_state" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title" id="myModalLabel">放弃订单</h4>
				</div>
				<div class="modal-body">确认放弃订单?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
					<button id="update_order_state_button" type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	
	<!-- /.modal -->
	<!-- 确认删除模态框（Modal） -->
	<!-- 确认印刷模态框（Modal） -->
	<div class="modal fade" id="printQRCodeModal" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title" id="myModalLabel">确认印刷</h4>
				</div>
				<div class="modal-body">您确定要将本批次(批次号：<span id="printQRCodeModal_QRCodeBatch"></span>)二维码设置为已印刷吗？</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
					<button id="deleteButton" type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	<!-- 确认印刷模态框（Modal） -->

	<div id="overlay" class="overlay" style="background:rgba(4, 4, 4, 0.6);filter: alpha(opacity=100);display: none;position: absolute;top: 0px; left: 0px;width: 100%;height: 100%;z-index: 100;display:none;">
		<img src="" style="min-width:20%; max-width:50%; margin: auto 25% 50px 25% ; position: absolute; top:10%; max-height: 80%;"/> 
	</div>
	<!-- 帮助 -->
	<div class="help_content">
		<div class="exit" style="cursor: pointer;">
			<img src="${path }/platform/common/images/exit.png" />
			<span>返回</span>
		</div>
		<!--切换选项-->
		<div class="help_tab">
			<span class="help_tab_type help_tab_type_01 help_tab_type_active">图片尺寸</span>
			<span>|</span>
			<span class="help_tab_type help_tab_type_02">注意事项</span>
			<span>|</span>
			<span class="help_tab_type help_tab_type_03">软件安装</span>
		</div>
		
		<!--图片尺寸-->
		<div class="imgsize_box">
			<p class="hint">*&nbsp;为保证页面美观性，微信商城图片上传请按以下提示操作及尺寸要求上传图片<br />*&nbsp;当鼠标移入下方标签时，右侧图示会切换为标签指示页</p>
			<img class="imgsize_type" src="${path }/platform/common/images/imgsize_type_01.png" />
			<p>
				<span class="imgsize_type_title">微信首页轮播图&nbsp;——</span> 系统设置--微信轮播图设置--图片尺寸为
				<span class="imgsize_val">750px*340px;</span><br />
				<span class="imgsize_type_title">品牌店图&nbsp;——</span> 系统设置--门店设置（每个门店第一张图）--图片尺寸为
				<span class="imgsize_val">704px*250px；</span><br />
				<span class="imgsize_type_title">每日推荐图&nbsp;——</span> 商品管理--商品管理（商品第一张图）--图片尺寸为
				<span class="imgsize_val">322px*322px；</span>
			</p>
			<img class="imgsize_type" src="${path }/platform/common/images/imgsize_type_02.png" />
			<p>
				<span class="imgsize_type_title">店铺logo图&nbsp;——</span> 系统设置--门店设置（每个门店第二张图）--图片尺寸为
				<span class="imgsize_val">200px*48px；</span><br />
				<span class="imgsize_type_title">产品列表图&nbsp;——</span> 商品管理--商品管理（商品第一张图）--图片尺寸为
				<span class="imgsize_val">322px*322px；</span><br />
			</p>
			<img class="imgsize_type" src="${path }/platform/common/images/imgsize_type_03.png" />
			<p>
				<span class="imgsize_type_title">商品详情页轮播图&nbsp;——</span> 商品管理--商品管理（2-5张图）--图片尺寸为
				<span class="imgsize_val">750px*340px；</span><br />
				<span class="imgsize_type_title">商品详情页详情图&nbsp;——</span> 商品管理--商品管理（6-最后一张图）--图片尺寸为
				<span class="imgsize_val">宽750px,高不限；</span><br />
			</p>
			<div class="imgsize_wechat_img_box">
				<img class="imgsize_wechat_img" src="${path }/platform/common/images/help_wechat_01.png" />
			</div>
		</div>



		<!--注意事项-->
		<div class="Details_of_the_introduction">
			<!-- <div class="page_content">
				<div class="sanjiao sanjia_1"></div>
				<div class="question_type">1.文件上传后无法及时查看</div>
				<div class="question1"><b>问题说明：</b>当您完成文件上传后，点击所传文件进行查看，可能会出现如下界面。这是因为文件转码需要一定时间，根据您所传文件大小不同，所需时间也不同。
					<br /><b>解决办法：</b>在文件上传之后，请稍作等待(约1分钟左右)，再行进在线查看或刷新页面。
				</div>
				<img src="img/question1.png" class="question_img1" />
			</div>

			<div class="page_content">
				<div class="sanjiao sanjia_2"></div>
				<div class="question_type">2.office文档无法预览</div>
				<div class="question2"><b>问题说明：</b>当您的文档上传成功后，发现可以下载却无法预览， 这种错误是office版本兼容导致的问题。
					<br /><b>解决办法：</b> 将无法预览的文档内容剪切，粘贴到新建的高版本office文档中，并另存为高版本office格式(docx,pptx,xlsx)，便可以对该文档进行正常的转码和预览。
				</div>
				<img src="img/question2.png" class="question_img2" style="margin-top: -20px;" />
				<img src="img/question3.png" class="question_img2" />
			</div>
			<div class="page_content">
				<div class="sanjiao sanjia_3_1"></div>
				<div class="sanjiao sanjia_3_2"></div>
				<div class="question_type">3.如何快速切换页码</div>
				<img src="img/question4.png" width="30%" />
				<div class="question1"><b>问题说明:</b>本系统充分考虑了便捷的操作与界面的美观，创新设计了扁平风格式跳转。这种方式将常规的跳转指引变为图形化隐藏式风格，让您获得更好的操作体验。
					<br /> <b>解决办法：</b>只需点击(GO)并输入数字，点击回车或空点鼠标左键，即可跳转至所输数字页面。若您输入的数字大于分页总页数，将跳转至最后一页；若小于1，则跳转至第一页。
				</div>
				<img src="img/question5.png" class="question_img3" />
			</div>
			<div class="page_content">
				<div class="sanjiao sanjia_4_1"></div>
				<div class="sanjiao sanjia_4_2"></div>
				<div class="sanjiao sanjia_4_3"></div>
				<div class="question_type">4.设置页新增、编辑类别时上传图标来源</div>
				<div class="question1"><b>问题说明：</b>为了保证界面美观性，建议您在上传图标时尽量统一。
					<br /> <b>解决办法：</b>建议网址：http://www.iconfont.cn/，打开后搜索您需要的图片，点击下载选择颜色和大小（建议200）后点击"png下载"，登录后即可下载图标至本地。
				</div>
				<img src="img/question7.png" class="question_img4" />

				<img src="img/question8.png" class="question_img4" />

				<img src="img/question6.png" class="question_img4" />

			</div> -->
		</div>
		<!--软件安装-->
		<div class="software_installation">
			<p onclick="window.open('${path }/platform/pdfJS/web/viewer.html?file=${path }/platform/file/1.pdf','_blank');">收银客户端安装流程及客户端款台号配置&nbsp;→</p>
			<p onclick="window.open('${path }/platform/pdfJS/web/viewer.html?file=${path }/platform/file/2.pdf','_blank');">58mm小票机驱动安装（收银台使用的小票机）及设置&nbsp;→</p>
			<p onclick="window.open('${path }/platform/pdfJS/web/viewer.html?file=${path }/platform/file/3.pdf','_blank');">80mm门店用小票打印机驱动程序安装流程及注意事项&nbsp;→</p>
		</div>
		
	</div>
	<script type="text/javascript">
		//帮助
		$(".help").click(function(){
			$(".help_content").show();
		});
		$(".exit").click(function(){
			$(".help_content").hide();
		});
		$(".help_tab_type").click(function() {
			$(".help_tab_type").removeClass("help_tab_type_active");
			$(this).addClass("help_tab_type_active");
		});
		$(".help_tab_type_01").click(function() {
			$(".imgsize_box").show();
			$(".Details_of_the_introduction,.software_installation").hide();

		});
		$(".help_tab_type_02").click(function() {
			$(".Details_of_the_introduction").show();
			$(".imgsize_box,.software_installation").hide();
		});
		$(".help_tab_type_03").click(function() {
			$(".software_installation").show();
			$(".imgsize_box,.Details_of_the_introduction").hide();
		});
		//图片尺寸
		$(".imgsize_wechat_img_box").height($(window).height() * 0.8);
		$(".imgsize_type").mouseenter(function(){
			$(".imgsize_wechat_img_box").scrollTop(0)
//			var index=$(this).attr("src").slice(46,48);
			var index=$(this).attr("src").split('_')[2].split(".")[0];
			console.log($(this).attr("src"))
			$(".imgsize_wechat_img").attr("src","${path }/platform/common/images/help_wechat_"+index+".png");
		});

	</script>
</body>
</html>
