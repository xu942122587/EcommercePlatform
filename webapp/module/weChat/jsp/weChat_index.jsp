<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>

	<head>
		<meta charset="utf-8" />
		<title>商城首页</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<!--微信不缓存东西  start-->
		<meta http-equiv="Pragma" content="no-cache" />
		<meta http-equiv="Expires" content="0" />
		<!--微信不缓存东西  end-->
		<script src="${path}/module/weChat/js/jquery-3.1.1.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="${path}/module/weChat/js/swiper-3.4.0.jquery.min.js" type="text/javascript"></script>
		<link rel="stylesheet" href="${path}/module/weChat/css/all.css">
		<link rel="stylesheet" href="${path}/module/weChat/css/swiper3.07.min.css" />
		<style>
			.recommend_list {
				display: none;
			}
			
			.recommend_list:nth-child(1),
			.recommend_list:nth-child(2),
			.recommend_list:nth-child(3),
			.recommend_list:nth-child(4) {
				display: block;
			}
			
			.recommend_list {
				margin: 6px 1.2% 6px 2%;
			}
			<c:if test="${4 gt isRecommedGoodsList.size()|| 4 eq isRecommedGoodsList.size()}">
				.overflowx{
					width:100%;
				}
			</c:if>
			<c:if test="${4 lt isRecommedGoodsList.size()}">
				.overflowx{
					width:88% !important;
				}
			</c:if>
		</style>

		<script type="text/javascript" charset="utf-8">
			//轮播
			$(document).ready(function() {
				var mySwiper = new Swiper('#slide', {
					autoplay: 3500,
					autoplayDisableOnInteraction: false,
					visibilityFullFit: true,
					loop: true,
					pagination: '.pagination',
					onSlideChangeStart: function() {
						var h = $(".swiper-slide-active").children().height() * $(".swiper-slide-active").children().length;
						$(".swiper-wrapper").css("height", h);
						$(".swiper-slide").css('height', h);
					}
				});
			});
			
			function selectGoods(){
				$("#selectGoods_input").blur();
				if("" != $("#selectGoods_input").val().trim()){
					var goodsName = $("#selectGoods_input").val().trim();
					window.location = "${path}/weChat/selectGoods?employeeId=${employeeId}&goodsName="+goodsName;
				}else{
					displayTip("请输入搜索内容");
				}
			}
		</script>
	</head>

	<body>
	
		<input type="hidden" id="dataInput" value="${customer.id }">
		
		<!--首页搜索-->
		<div class="search">
			<div class="search_input_content">
				<div class="search_icon"></div>
				<form action="" onsubmit="return false;">
					<input class="search_input" type="search" name="selectGoods_input" id="selectGoods_input" value="" placeholder="搜索商品" onsearch="selectGoods()"/>
				</form>
			</div>
			<div class="index_search_btn" onclick="selectGoods()">搜索</div>
		</div>
		<div style="height: 44px"></div>
		
		<!--banner轮播开始-->
		<div id="slide">
			<div class="swiper-wrapper">
				<c:forEach items="${banner.imgUrl}" var="imgUrl">
					<div class="swiper-slide">
						<img src="${path}/platform/images/${imgUrl}" />
					</div>
				</c:forEach>
			</div>
			<div class="pagination"></div>
		</div>
		<!--轮播结束-->
		<c:if test="${not empty isRecommedGoodsList}">
			<!--每日推荐-->
			<div class="recommend mt2 bg-white " style="overflow: hidden;">
				<p class="index_title recommend_title font-large">每日推荐</p>
				<div class="overflowx" style="float: left;">
					<ul class="recommend_lists" style="width: 100%;">
						<c:forEach items="${isRecommedGoodsList}" var="isRecommedGoods">
							<li class="recommend_list">
								<img class="recommend_img" isRecommedGoodsId="${isRecommedGoods.id}" onclick="window.location='${path}/weChat/goGoodsDetail?employeeId=${employeeId}&goodsId=${isRecommedGoods.id}'" src="${path}/platform/images/${isRecommedGoods.imgUrl[0]}" />
								<p class="recommend_name">${isRecommedGoods.name} </p>
								<p class="recommend_price pl6 color-red">&yen;${isRecommedGoods.salesPrice}</p>
								<img class="index_buy" onclick="window.location='${path}/weChat/goCreatOrder?goodsId=${isRecommedGoods.id}&goType=icon&employeeId=${employeeId}'" src="${path}/module/weChat/img/index_buy.png" />
								<button class="btn_gostore" onclick="window.location='${path}/weChat/goStore?storeId=${isRecommedGoods.store.id}&employeeId=${employeeId}'">进店查看更多</button>
							</li>
						</c:forEach>
					</ul>
				</div>
				<c:if test="${4 lt isRecommedGoodsList.size()}">
					<!--滑动查看更多  -->
					<div class="look_whole" >
						<span>滑动查看更多</span>
						<img class="look_icon" src="${path}/module/weChat/img/index_look_icon.png" />
					</div>
				</c:if>
			</div>
		</c:if>
		
		<!--品牌热卖(门店)-->
		<div class="recommend mt6 bg-white">
			<p class="index_title hot_title font-large">品牌热卖</p>
			<ul class="hot_lists">
				<c:forEach items="${storeList}" var="store">
					<li class="hot_list" onclick="window.location='${path}/weChat/goStore?storeId=${store.id}&employeeId=${employeeId}'">
						<img class="index_hot_img" src="${path}/platform/images/${store.imgUrl[0]}" />
						<!--<button class="btn_gobrand btn_gobrand_02">前往品牌专区</button>-->
					</li>
				</c:forEach>
			</ul>
		</div>

		<div style="height: 50px"></div>
		
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
			<a onclick="window.location='${path}/weChat/goPersonalCenter?employeeId=${employeeId}'">
				<img src="${path}/module/weChat/img/nav-icon-personal.png" class="nav-icon">
				<div class="nav_font">我的</div>
			</a>
		</nav>
		<!--底部菜单结束-->
		<div id="successTip" class="toast"></div>
		
		<!-- loading -->
		<div id="loadingDiv" class="loaded" style="display:none">
			<div class="loading">
				<img src="${path }/module/weChat/img/ball-triangle.svg" alt="">
				<p class="loading-text">加载中</p>
			</div>
		</div>
		
		<!-- 提示弹窗 -->
		<div id="successTip" class="toast">msg</div>
		
		<script>
			function displayTip(message){
				$("#successTip").html(message);
				$("#successTip").fadeToggle(500, function() {
					setTimeout(function() {
						$("#successTip").fadeToggle(1000);
					}, 2000);
				});
			}
		
			$(".recommend_img").height($(".recommend_img").width());

			<c:if test="${4 lt isRecommedGoodsList.size()}">
				//首页滚动
				var movetime = 0;
				var movetime1 = 0;
				var max_movetime = Math.ceil($(".recommend_list").length / 4);
				if(movetime < max_movetime) {
					var new_recommend_list_width_containmargin = $(window).width() * 0.88 * 0.492 * 2;
					var new_recommend_list_width = $(window).width() * 0.88 * 0.46;
					var new_recommend_list_marginleft = $(window).width() * 0.88 * 0.02;
					var new_recommend_list_marginright = $(window).width() * 0.88 * 0.012;
					$(".recommend_lists").css("width", (max_movetime * new_recommend_list_width_containmargin + 10) + "px");
					$(".recommend_list").css({
						'width': new_recommend_list_width,
						'margin-left': new_recommend_list_marginleft,
						"margin-right": new_recommend_list_marginright
					});
				} else {
					movetime = max_movetime;
				}
				$(".recommend_list").show();
				var moveLenth = $('.overflowx').width();
				$(".recommend").on("touchstart", function(e) {
	
					$("body").unbind("touchmove");
					startX = e.originalEvent.changedTouches[0].pageX,
						startY = e.originalEvent.changedTouches[0].pageY;
				});
	
				$(".recommend").on("touchend", function(e) {
	
					moveEndX = e.originalEvent.changedTouches[0].pageX,
						moveEndY = e.originalEvent.changedTouches[0].pageY,
						X = moveEndX - startX,
						Y = moveEndY - startY;
					//左滑
					if(X > 20) {
						movetime1--;
						if(movetime1 < 1) {
							movetime1 = 0;
						}
						$('.overflowx').scrollLeft(moveLenth * movetime1);
					} else if(X < -20) {
						if(movetime1 < max_movetime - 1) {
							movetime1++;
						}
						$('.overflowx').scrollLeft(moveLenth * movetime1);
					}
				});
			</c:if>
			
			//品牌图片
			$('.index_hot_img').height($('.index_hot_img').width()*0.38);
			
			function hiddenLodding(){
				$("#loadingDiv").hide();
			}
			function showLodding(){
				$("#loadingDiv").show();
			}
			
			function displayTip(message){
				$("#successTip").html(message);
				$("#successTip").fadeToggle(500, function() {
					setTimeout(function() {
						$("#successTip").fadeToggle(1000);
					}, 2000);
				});
			}
		</script>
		<%@ include file="/platform/common/jsp/weChat_jsSdk.jsp"%>
	</body>

</html>