<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>

	<head>
		<meta charset="UTF-8">
		<title>购物袋</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<!--微信不缓存东西  start-->
		<meta http-equiv="Pragma" content="no-cache" />
		<meta http-equiv="Expires" content="0" />
		<!--微信不缓存东西  end-->

		<link rel="stylesheet" href="${path}/module/weChat/css/all.css">
		<style>
			.shoppingcart-goodslist{
				position: relative;
				padding: 8px 48px 8px 0;
			}
			.trash{
				position: absolute;
				right: 12px;
				top:12px;
				z-index: 2;
				width: 26px;
			}
		</style>
		<script src="${path}/module/weChat/js/jquery-3.1.1.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="${path}/platform/common/js/NumberUtil.js" type="text/javascript" charset="utf-8"></script>
	</head>

	<body>
		<!--列表为空-->
		<c:if test="${empty shoppingcartList}">
			<div class="list-none" style="display: block;">
				<img src="${path}/module/weChat/img/shoppingcart_none.png" class="imgs">
				<div class="fonts">购物车里什么都没有哦...<br />去挑选几件商品吧</div>
				<button onclick="window.location='${path}/weChat/weChatIndex?employeeId=${employeeId}'" class="goindex_btn">去首页逛逛</button>
			</div>
		</c:if>
		<c:if test="${not empty shoppingcartList}">
			<!--<div class="remind">商品数量有限，请尽快结算</div>-->
			<div class="shoppingcart-goodslists">
				<!--购物车--品牌店-->
				<c:forEach items="${storeList}" var="store">
					<c:if test="${'1' eq store.isDelete && '1' eq store.state}">
						<div class="shoppingcart_box bg-white pb16" storeSelect="">
							<div class="shoppingcart_store">
								<!--店铺选择-->
								<img class="address_nocheck store_nocheck" id="store_nocheck" src="${path}/module/weChat/img/address_nocheck.png" />
								<img class="address_checked store_checked" id="store_checked" src="${path}/module/weChat/img/address_checked.png" />
								<span>${store.name}</span>
							</div>
							
							<!--购物车商品-->
							<c:forEach items="${shoppingcartList}" var="shoppingcart">
								<c:if test="${'2' eq shoppingcart.goods.goods.isAbnormal && '1' eq shoppingcart.goods.goods.isDelete}">
									<c:if test="${ store.id eq shoppingcart.goods.store.id}">
										<div class="shoppingcart-goodslist" goodsSelect="">
											<!--商品选择-->
											<input type="hidden" name="model.id" id="shoppingcart_id" disabled="disabled" value="${shoppingcart.id }">
											<img class="address_nocheck goods_nocheck" src="${path}/module/weChat/img/address_nocheck.png" />
											<img class="address_checked goods_checked" src="${path}/module/weChat/img/address_checked.png" />
						
											<img 
											<c:if test="${empty shoppingcart.goods.name}">
												onclick="window.location='${path}/weChat/goGoodsDetail?employeeId=${employeeId}&goodsId=${shoppingcart.goods.goods.id}'"
											</c:if>
											<c:if test="${not empty shoppingcart.goods.name}">
												onclick="window.location='${path}/weChat/goGoodsDetail?employeeId=${employeeId}&goodsId=${shoppingcart.goods.id}'"
											</c:if>
											<c:if test="${empty shoppingcart.goods.name}">
												src="${path}/platform/images/${shoppingcart.goods.goods.imgUrl[0]}" 
											</c:if>
											<c:if test="${not empty shoppingcart.goods.name}">
												src="${path}/platform/images/${shoppingcart.goods.imgUrl[0]}" 
											</c:if>
											class="shoppingcart-goodsimg">
											<div class="shoppingcart-goodsinfomation">
												<c:if test="${empty shoppingcart.goods.name}">
													<div class="goods-name">${shoppingcart.goods.goods.name}</div>
												</c:if>
												<c:if test="${not empty shoppingcart.goods.name}">
													<div class="goods-name">${shoppingcart.goods.name}</div>
												</c:if>
											</div>
											<div class="font_small color-grey format_">${shoppingcart.goods.other_attr_value}</div>
											<div class="shoppingcart-goodsinfomation">
												<div class="right num_border">
													<input type="hidden" value="${shoppingcart.goods.id}">
													<img class="buynum-sub" src="${path}/module/weChat/img/num-sub.png" />
													<span class="buynum-input">${shoppingcart.count}</span>
													<img class="buynum-add" src="${path}/module/weChat/img/num-add.png" />
												</div>
												
												<div class="left shoppingcart_price">&yen;<span class="salePrice">${shoppingcart.goods.salesPrice}</span></div>
											</div>
											<img src="${path}/module/weChat/img/all-trash.png" onclick="deleteShoppingcart('${shoppingcart.goods.id}')" class="trash"/>
										</div>
									</c:if>
								</c:if>
							</c:forEach>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</c:if>
		
		<c:if test="${not empty shoppingcartList}">
			<!--继续浏览购物-->
			<p class="Continue_to_browse bg-white" onclick="window.location='${path}/weChat/weChatIndex?employeeId=${employeeId}'">
				<span>继续浏览购物</span><br />
				<img src="${path}/module/weChat/img/more90.png" />
			</p>
		</c:if>
		<div style="height: 96px"></div>
		<!--底部栏-->
		<div class="shoppingcart_foot">
			<span class="total_num" id="total_num"></span>
			<button class="btn-cart">总计：&yen;<span id="sumPrice"></span></button>
			<a class="btn-buy" onclick="goCreatOrder()">提交订单</a>
			<!--返回顶部-->
			<div class="gotop_box">
				<div class="gotop"></div>
			</div>
		</div>
		<!--底部菜单开始-->
		<nav class="nav-bar nav-bar-tab">
			<a onclick="window.location='${path}/weChat/weChatIndex?employeeId=${employeeId}'">
				<img src="${path}/module/weChat/img/nav-icon-index.png" class="nav-icon">
				<div class="nav_font">首页</div>
			</a>
			<a onclick="window.location='${path}/weChat/goShoppingcart?employeeId=${employeeId}'">
				<img src="${path}/module/weChat/img/nav-icon-shoppingCartactive.png"  class="nav-icon">
				<div class="nav_font active">购物袋</div>
			</a>
			<a onclick="window.location='${path}/weChat/goPersonalCenter?employeeId=${employeeId}'">
				<img src="${path}/module/weChat/img/nav-icon-personal.png" class="nav-icon">
				<div class="nav_font">我的</div>
			</a>
		</nav>
		<!--底部菜单结束-->

		<!-- 提示弹窗 -->
		<div id="successTip" class="toast">msg</div>
		
		<!-- loading -->
		<div id="loadingDiv" class="loaded" style="display:none">
			<div class="loading">
				<img src="${path }/module/weChat/img/ball-triangle.svg" alt="">
				<p class="loading-text">加载中</p>
			</div>
		</div>
		
		<script>
			
			function goCreatOrder(){
				var count = $(".shoppingcart-goodslists .shoppingcart-goodslist[goodsSelect='select']").length - 0;
				if(0 >= count){
					displayTip("请先选中商品!");
				}else{
					var shoppingcartList = new Array();
					$(".shoppingcart-goodslists .shoppingcart-goodslist[goodsSelect='select']").each(function(){
						shoppingcartList.push($(this).find("#shoppingcart_id").val());
					});
					window.location='${path}/weChat/goCreatOrder?employeeId=${employeeId}&goType=sc&shoppingcartList='+shoppingcartList;
				}
			}
		
			$(document).ready(function() {
				$(".shoppingcart-goodsimg").height($(".shoppingcart-goodsimg").width());
				$(".shoppingcart-goodslists").height($("body").height() - 140);
				
				// 店铺点击不选中
				$(".store_checked").click(function() {
					$(this).hide();
					$(this).parent().parent().attr("storeSelect","");
					$(this).prev().show();
					$(this).parent().parent().find(".goods_checked").each(function(){
						$(this).hide();
						$(this).parent().attr("goodsSelect","");
						$(this).parent().find("#shoppingcart_id").attr("disabled","disabled");
					});
					$(this).parent().parent().find(".goods_nocheck").each(function(){
						$(this).show();
					});
					sumAndPrice();
				});
				// 店铺点击选中
				$(".store_nocheck").click(function() {
					$(this).hide();
					$(this).parent().parent().attr("storeSelect","select");
					$(this).next().show();
					$(this).parent().parent().find(".goods_nocheck").each(function(){
						$(this).hide();
						$(this).parent().attr("goodsSelect","select");
						$(this).parent().find("#shoppingcart_id").removeAttr("disabled");
					});
					$(this).parent().parent().find(".goods_checked").each(function(){
						$(this).show();
					});
					sumAndPrice();
				});
				
				// 商品点击不选中
				$(".goods_checked").click(function() {
					$(this).hide();
					$(this).parent().attr("goodsSelect","");
					$(this).parent().find("#shoppingcart_id").attr("disabled","disabled");
					$(this).prev().show();
					sumAndPrice();
					$(this).parent().parent().find(".store_nocheck").next().hide();
					$(this).parent().parent().find(".store_nocheck").show();
					$(this).parent().parent().attr("storeSelect","");
				});
				// 商品点击选中
				$(".goods_nocheck").click(function() {
					$(this).hide();
					$(this).parent().attr("goodsSelect","select");
					$(this).parent().find("#shoppingcart_id").removeAttr("disabled");
					$(this).next().show();
					sumAndPrice();
					var store_check=true;
					$(this).parent().parent().find(".goods_nocheck").each(function(){
						if("" == $(this).parent().attr("goodsSelect")){
							store_check=false;
						}
					});
					if(store_check){
						$(this).parent().parent().find(".store_nocheck").next().show();
						$(this).parent().parent().find(".store_nocheck").hide();
						$(this).parent().parent().attr("storeSelect","select");
					}
				});
				
				//购买数量加减
				$('.buynum-sub').click(function() {
					if(parseInt($(this).siblings('.buynum-input').html()) > 1) {
						var goodsId = $(this).parent().find("input").val().trim();
						var salePrice = $(this).parent().parent().find(".salePrice").html().trim() - 0;
						var value = parseInt($(this).siblings('.buynum-input').html()) - 1;
						$(this).siblings('.buynum-input').html(value);
						if("select" == $(this).parent().parent().parent().attr("goodsSelect")){
							updateShoppingcart(goodsId,-1,-salePrice,"select");
						}else{
							updateShoppingcart(goodsId,-1,-salePrice,"noSelect");
						}
					} else if(parseInt($(this).siblings('.buynum-input').html()) < 2) {
						$(this).attr('src', '${path}/module/weChat/img/num-sub-disable.png');
					} else {
						var goodsId = $(this).parent().find("input").val().trim();
						var salePrice = $(this).parent().parent().find(".salePrice").html().trim() - 0;
						var value = parseInt($(this).siblings('.buynum-input').html()) - 1;
						$(this).siblings('.buynum-input').html(value);
						$(this).attr('src', '${path}/module/weChat/img/num-sub-disable.png');
						if("select" == $(this).parent().parent().parent().attr("goodsSelect")){
							updateShoppingcart(goodsId,-1,-salePrice,"select");
						}else{
							updateShoppingcart(goodsId,-1,-salePrice,"noSelect");
						}
					}
				});

				$('.buynum-add').click(function() {
					var goodsId = $(this).parent().find("input").val().trim();
					var salePrice = $(this).parent().parent().find(".salePrice").html().trim() - 0;
					$(this).siblings('.buynum-sub').attr('src', '${path }/module/weChat/img/num-sub.png')
					var value = parseInt($(this).siblings('.buynum-input').html()) + 1;
					$(this).siblings('.buynum-input').html(value);
					if("select" == $(this).parent().parent().parent().attr("goodsSelect")){
						updateShoppingcart(goodsId,1,salePrice,"select");
					}else{
						updateShoppingcart(goodsId,1,salePrice,"noSelect");
					}
				});
				
				sumAndPrice();
			});
			//回到顶部
			$(".gotop_box").click(function() {
				$('body,html').animate({
					scrollTop: 0
				}, 500);
			});
			//下滑继续浏览
			$(".Continue_to_browse").on("touchstart", function(e) {
				//				e.preventDefault();
				startX = e.originalEvent.changedTouches[0].pageX, startY = e.originalEvent.changedTouches[0].pageY;
			});
			$(".Continue_to_browse").on("touchmove", function(e) {
				moveEndX = e.originalEvent.changedTouches[0].pageX, moveEndY = e.originalEvent.changedTouches[0].pageY, X = moveEndX - startX, Y = moveEndY - startY;
				if(Math.abs(Y) > Math.abs(X) && Y < 0) {
					e.preventDefault();
					window.location = "weChat_index.html";
				}
				else if(Math.abs(X) > Math.abs(Y) && X > 0) {
					//					alert("left 2 right");
				}
				else if(Math.abs(Y) > Math.abs(X) && Y > 0) {
					//					alert("top 2 bottom");
				}
				else if(Math.abs(X) > Math.abs(Y) && X < 0) {
					}
				else {
					//					alert("just touch");
				}
			});
			
			function displayTip(message){
				$("#successTip").html(message);
				$("#successTip").fadeToggle(500, function() {
					setTimeout(function() {
						$("#successTip").fadeToggle(1000);
					}, 2000);
				});
			}
			
			function hiddenLodding(){
				$("#loadingDiv").hide();
			}
			
			function showLodding(){
				$("#loadingDiv").show();
			}
			
			var isSuccess = true
			function updateShoppingcart(goodsId,goodsCount,salePrice,isSelect){
				if(isSuccess){
					isSuccess = false;
					$.ajax({
						url : "${path}/weChat/saveOrUpdateShoppingcart?goodsId="+goodsId+"&employeeId=${employeeId}&goodsAttr=&goodsCount="+goodsCount,
						data : null,
						type : "POST",
						async : false,
						dataType : "json",
						success : function(data) {
							if (data.success) {
								isSuccess = true;
								if("select" == isSelect){
									var sum = 0;
									var sumPrice = 0;
									$(".shoppingcart-goodslist[goodsSelect=select]").each(function(){
										var this_sum = $(this).find(".buynum-input").html().trim() - 0;
										var this_sumPrice = $(this).find(".salePrice").html().trim() - 0;
										sumPrice = accAdd(sumPrice,(accMul(this_sumPrice, this_sum)));
										sum += this_sum;
									});
									$("#total_num").html(sum);
									$("#sumPrice").html(sumPrice);
								}
							} else {
								isSuccess = true;
							}
						},
						error : function(xhr, type, exception) {
							displayTip("请检查网络设置");
							isSuccess = true;
						}
					});
				}
			}
			function sumAndPrice(){
				var sum = 0;
				var sumPrice = 0;
				$(".shoppingcart-goodslist[goodsSelect=select]").each(function(){
					var this_sum =$(this).find(".buynum-input").html().trim() - 0;
					var this_sumPrice =$(this).find(".salePrice").html().trim() - 0;
					sumPrice = accAdd(sumPrice,(accMul(this_sumPrice, this_sum)));
					sum += this_sum;
				});
				$("#total_num").html(sum);
				$("#sumPrice").html(sumPrice);
			}
			
			function deleteShoppingcart(goodsId){
				if(isSuccess){
					isSuccess = false;
					$.ajax({
						url : "${path}/weChat/deleteShoppingcart?goodsId="+goodsId+"&employeeId=${employeeId}",
						data : null,
						type : "POST",
						async : false,
						dataType : "json",
						success : function(data) {
							if (data.success) {
								isSuccess = true;
								window.location='${path}/weChat/goShoppingcart?employeeId=${employeeId}';
							} else {
								isSuccess = true;
								window.location='${path}/weChat/goShoppingcart?employeeId=${employeeId}';
							}
						},
						error : function(xhr, type, exception) {
							displayTip("请检查网络设置");
							isSuccess = true;
							window.location='${path}/weChat/goShoppingcart?employeeId=${employeeId}';
						}
					});
				}
			}
		</script>
		<%@ include file="/platform/common/jsp/weChat_jsSdk.jsp"%>
	</body>

</html>