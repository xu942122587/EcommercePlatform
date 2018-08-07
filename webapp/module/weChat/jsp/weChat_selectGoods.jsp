<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>

	<head>
		<meta charset="UTF-8">
		<title>天和商城</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<!--微信不缓存东西  start-->
		<meta http-equiv="Pragma" content="no-cache" />
		<meta http-equiv="Expires" content="0" />
		<!--微信不缓存东西  end-->

		<link rel="stylesheet" href="${path}/module/weChat/css/all.css">
		<script type="text/javascript" src="${path}/module/weChat/js/jquery-3.1.1.min.js"></script>
		<style>
			.recommend_list:nth-child(odd) {
				margin: 6px 1% 6px 2.2%;
			}
			
			.recommend_list:nth-child(even) {
				margin: 6px 2.2% 6px 1%;
			}
		</style>
		
		<!-- 分段 -->
		<script type="text/javascript">
			var isHave;
			$(document).ready(function() {
				var voIsHave = $(".recommend_lists").attr('data_voHave');
				console.log();
				if(voIsHave == 'yes'){
					isHave = true;
					$("#loadData").html("上划加载更多");
				}else{
					isHave = false;
					$("#loadData").html("更多商品，敬请期待");
				}
			});
		
			$(window).scroll(function() {
				var scrollTop = $(this).scrollTop();
				var scrollHeight = $(document).height();
				var windowHeight = $(this).height();
				if (scrollTop + windowHeight == scrollHeight) {
					var page = $(".recommend_lists").attr('data_voNo');
					getData(page);
				}
			});
			
			function getData(page) {
				
				var classList=$(".recommend_lists").attr('pageClassId');
				if (isHave) {
					$("#loadingDiv").addClass("loaded");
					$("body").css("overflow","hidden");
					$("#loadData").html("加载中....");
					$.ajax({
						type : "POST",
						url : "${path}/weChat/getGoodsListData?storeId=${store.id}&classList="+classList+"&page="
								+ (parseInt(page) + 1),
						processData : true,
						dataType : "json",
						async : false,
						success : function(data) {
							if(data.success){
								$("#loadingDiv").removeClass("loaded");
								if (data.obj.isHave == 'no') {
									isHave = false;
								}
								$(".recommend_lists").attr('data_voNo',data.obj.pageNo);
								$(".recommend_lists").attr('data_voHave',data.obj.isHave);
								page = data.obj.pageNo;
								var jsonData = eval(data.obj.goodsList);
								if(data.obj.goodsList.length<10){
									$("#loadData").html("更多商品，敬请期待");
								}
								for ( var o in jsonData) {
										var id="'" + jsonData[o].id + "'";
										$(".recommend_lists").append( 
												"<li class='recommend_list bg-white' >"
												+"<img class='recommend_img' goodsId='"+jsonData[o].id+"' onclick=\"window.location="+"'${path}/weChat/goGoodsDetail?employeeId=${employeeId}&goodsId="+jsonData[o].id+"'\" src='${path}/platform/images/"+jsonData[o].imgUrl[0]+"' />"
												+"<p class='recommend_name'>"+jsonData[o].name+" </p>"
												+"<p class='recommend_price pl6 color-red'>&yen;"+jsonData[o].salesPrice+"</p>"
												+"<img class='brand_buy' onclick=\"window.location='${path}/weChat/goCreatOrder?goodsId="+jsonData[o].id+"&goType=icon&employeeId=${employeeId}'\" src='${path}/module/weChat/img/index_buy.png' />"
												+"</li>");
								}
								$("body").css("overflow","scroll");
								$(".recommend_img").height($(".recommend_img").width());
							}else{
								displayTip(data.msg);
							}
						}
					});
				}
			}
			
			function selectGoods(){
				$("#selectGoods_input").blur();
				if("" != $("#selectGoods_input").val().trim()){
					var goodsName = $("#selectGoods_input").val().trim();
					window.location = "${path}/weChat/selectGoods?employeeId=${employeeId}&storeId=${store.id}&goodsName="+goodsName;
				}else{
					displayTip("请输入搜索内容");
				}
			}
		</script>
	</head>

	<body>
		<!--品牌页-搜索-->
		<div class="search">
			<div class="search_input_content">
				<div class="search_icon"></div>
				<form action="" onsubmit="return false;">
					<input class="search_input" type="search" name="selectGoods_input" id="selectGoods_input" value="${goodsName }" placeholder="搜索" onsearch="selectGoods()"/>
				</form>
			</div>
			<div class="index_search_btn" onclick="selectGoods()">搜索</div>
		</div>
		<div style="height: 50px;clear: both;"></div>
		<div class="bg-white overflow" style="padding: 6px 8px 0;">
			<span class="right lineh31">共${goodsPageVo.totalRecord}商品</span>
		</div>
		<!--列表为空-->
		<c:if test="${empty goodsPageVo.goodsList && empty goodsRecommedList}">
			<div class="list-none" style="display: block;">
				<img src="${path}/module/weChat/img/list_none.png" class="imgs">
				<div class="fonts">暂无商品</div>
			</div>
		</c:if>
		<ul class="recommend_lists" data_voHave="${goodsPageVo.isHave }" data_voNo="${goodsPageVo.pageNo }" pageClassId="" style="width: 100%;">
			<c:forEach items="${goodsPageVo.goodsList }" var="storeGoods" varStatus="i">
				<li class="recommend_list bg-white" >
					<img class="recommend_img" goodsId="${storeGoods.id}" onclick="window.location='${path}/weChat/goGoodsDetail?employeeId=${employeeId}&goodsId=${storeGoods.id}'" src="${path}/platform/images/${storeGoods.imgUrl[0]}" />
					<p class="recommend_name"">${storeGoods.name} </p>
					<p class="recommend_price pl6 color-red" >&yen;${storeGoods.salesPrice}</p>
					<img class="brand_buy" onclick="window.location='${path}/weChat/goCreatOrder?goodsId=${storeGoods.id}&goType=icon&employeeId=${employeeId}'" src="${path}/module/weChat/img/index_buy.png" />
				</li>
			</c:forEach>
		</ul>
		
		<c:if test="${not empty goodsPageVo.goodsList }">
			<div class="loadData">
				<p id="loadData">正在加载中...</p>
			</div>
		</c:if>
		
		<div style="height: 50px;clear: both;"></div>
		
		<!--底部菜单开始-->
		<nav class="nav-bar nav-bar-tab">
			<a onclick="window.location='${path}/weChat/weChatIndex?employeeId=${employeeId}'">
				<img src="${path}/module/weChat/img/nav-icon-indexactive.png" class="nav-icon">
				<div class="nav_font active">首页</div>
			</a>
			<!--<a href="weChat_classify.html">
				<img src="img/nav-icon-classify.png" class="nav-icon">
				<div class="nav_font">分类</div>
			</a>-->
			<a onclick="window.location='${path}/weChat/goShoppingcart?employeeId=${employeeId}'">
				<img src="${path}/module/weChat/img/nav-icon-shoppingCart.png" class="nav-icon">
				<div class="nav_font">购物袋</div>
			</a>
			<a href="${path}/weChat/goPersonalCenter?employeeId=${employeeId}">
				<img src="${path}/module/weChat/img/nav-icon-personal.png" class="nav-icon">
				<div class="nav_font">我的</div>
			</a>
		</nav>
		<!--底部菜单结束-->

		<script>
			$(".recommend_img").height($(".recommend_img").width());
			//点击跳转至商品详情
			$(".recommend_list :not('.brand_buy')").click(function() {
				var goodsId = $(this).attr("goodsId");
				window.location = "${path}/weChat/goGoodsDetail?employeeId=${employeeId}&goodsId="+goodsId;
			});
			/* $(".recommend_lists").height(window.screen.availHeight - 150); */
		</script>
		<%@ include file="/platform/common/jsp/weChat_jsSdk.jsp"%>
	</body>

</html>