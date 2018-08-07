<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>

	<head>
		<meta charset="utf-8">
		<title>商品详情</title>

		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<!--微信不缓存东西  start-->
		<meta http-equiv="Pragma" content="no-cache" />
		<meta http-equiv="Expires" content="0" />
		<!--微信不缓存东西  end-->
		
		<link rel="stylesheet" href="${path}/module/weChat/css/all.css">
		<link rel="stylesheet" href="${path}/module/weChat/css/swiper3.07.min.css" />
		<style>
			.bigimg_overflow {
				max-height: 340px;
				overflow-y: auto;
			}
			
			.bigimg_content {
				display: block;
			}
		</style>
		<script src="${path}/module/weChat/js/jquery-3.1.1.min.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" src="${path}/module/weChat/js/swiper-3.4.0.jquery.min.js"></script>
		<script type="text/javascript" charset="utf-8">
			$(document).ready(function() {
				var mySwiper = new Swiper('#slide', {
					//					autoplay: 3500,
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
		</script>
	</head>

	<body>
		<div id="successTip" class="toast">msg</div>
		<!--轮播开始-->
		<div id="slide">
			<div class="swiper-wrapper">
				<c:forEach begin="1" end="4" items="${goods.imgUrl}" var="imgUrl" varStatus="i">
					<div class="swiper-slide">
						<img src="${path}/platform/images/${imgUrl}" />
					</div>
				</c:forEach>
			</div>
			<div class="pagination"></div>
		</div>
		<!--轮播结束-->

		<!--商品基本信息-->
		<div class="goodsdetail_goods" id="goodsDetail">
			<p class="goodsdetail-name">${goods.name}</p>
			<p class="left goodsdetail-price price"><span>&yen;</span><span class="price_fontbig">${goods.salesPrice}</span></p>
			<div class="right pt16" style="display: none">快递：0.00元</div>
			<div class="goodsdetail_sales">
			</div>
			<c:forEach items="${classStringList}" var="classString" varStatus="j">
				<div class="gd_choose pl12">
					<div class="choose_title">${classString.attr}</div>
					<ul class="color_choose ${classString.attrCode }">
						<c:forEach items="${goods.childGoodsAttrMap[classString.attrCode]}" var="childGoodsAttr">
							<li onclick="selectGoods(this)" isSelect="">
								${childGoodsAttr}
								<input type="hidden" id="goodsAttr" value='"${classString.attrCode}":"${childGoodsAttr}"'>
							</li>
						</c:forEach>
					</ul>
				</div>
			</c:forEach>
			
			<%-- <div class="gd_choose pl12">
				<div class="choose_title">数量</div>
				<div class="size_choose num_border" style="display: inline-block;">
					<img class="buynum-sub" src="${path}/module/weChat/img/num-sub.png" />
					<!--<input class="buynum-input" type="number" value="0" />-->
					<span class="buynum-input" id="goodsCount">0</span>
					<img class="buynum-add" src="${path}/module/weChat/img/num-add.png" />
				</div>
			</div> --%>
		</div>
		<!--商品详情，用户评论title ${evaluationList.size()}-->
		<div class="box_title">
			<p class="goodsdetail-title title_active">商品详情</p>
			<p class="evalute_title">用户评论(${evaluationList.size()})</p>
		</div>

		<!--商品详情-->
		<div class="goodsdetail-img">
			<c:forEach begin="4" items="${goods.imgUrl}" var="imgUrl" varStatus="i">
				<img src="${path}/platform/images/${imgUrl}" />
			</c:forEach>
		</div>
		<!--详情结束-->
		
		<!--商品评价-->
		<div class="evalute" style="display: none;">
			<ul class="evalute_lists">
				<c:forEach items="${evaluationList}" var="evaluation">
					<li class="evalute_list">
						<c:if test="${empty customer.employee.headimgurl }">
							<img class="evalute_list_headimg" src="${path}/module/weChat/img/personal-headimg.png" />
						</c:if>
						<c:if test="${not empty customer.employee.headimgurl }">
							<img class="evalute_list_headimg" src="${evaluation.customer.employee.headimgurl }" />
						</c:if>
						<div class="userinfor_box">
							<span class="username">${evaluation.customer.name}</span>
							<span class="data color-grey font_small">
								<fmt:formatDate value="${evaluation.createTime}" pattern="yyyy-MM-dd"/>
							</span>
						</div>
						<div class="userinfor_box">
							<span class="pl6"></span>
							<span class="right pr12">${evaluation.goods.other_attr_value}</span>
						</div>
						<div class="clear_both pl6">评价详情</div>
						<div class="content">${evaluation.content}</div>
						<c:forEach items="${evaluation.imgName}" var="imgUrl">
							<img class="evalute_user_img" src="${path}/platform/images/${imgUrl}" />
						</c:forEach>
					</li>
				</c:forEach>
			</ul>
		</div>

		<!--底部栏-->
		<div class="fixed-foot" style="bottom: 0;">
			<!--返回首页-->
			<div class="gohome_box" onclick="window.location='${path}/weChat/weChatIndex?employeeId=${employeeId}'">
				<div class="gohome"></div>
			</div>
			<!--购物袋-->
			<div class="hoverCart_box" onclick="window.location='${path}/weChat/goShoppingcart?employeeId=${employeeId}'">
				<div class="hoverCart"></div>
			</div>
			<!--返回顶部-->
			<!-- <div class="gotop_box">
				<div class="gotop"></div>
			</div> -->
			<button class="btn btn-info btn-cart" onclick="addShoppingcart()">加入购物袋</button>
			<button class="btn btn-danger btn-buy" onclick="window.location='${path}/weChat/goCreatOrder?goodsId=${goods.id}&goType=icon&employeeId=${employeeId}'">立即购买</button>
		</div>
		<!--详情结束-->
		<!--floatCart悬浮购物车开始-->
		<img class="gootop_goodsdetail" src="${path}/module/weChat/img/fixed_gotop.png" />
		<div style="height: 54px;"></div>
		<div style="height: 44px;background: #fff;position: fixed;bottom: 0;left: 0;width: 100%;"></div>
		<!--图片放大-->
		<div class="box_null">
			<div class="bigimg_box" style="padding: 30px;">
				<div class="bigimg_overflow">
					<img class="bigimg_content" src="" />
				</div>
				<img class="bigimg_close" src="${path}/module/weChat/img/register-close.png" />
				<a href="javascript:void(0)" class="btn btn_prev left" data-control="prev">&lt;</a>
				<a href="javascript:void(0)" class="btn btn_next right" data-control="next">&gt;</a>
			</div>
		</div>
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
			$(".evalute_title").click(function() {
				$(".evalute_title").addClass("title_active");
				$(".goodsdetail-title").removeClass("title_active");
				$(".evalute").show();
				$(".goodsdetail-img").hide();
				$(".evalute_user_img").height($(".evalute_user_img").width());
			});
			$(".goodsdetail-title").click(function() {
				$(".goodsdetail-title").addClass("title_active");
				$(".evalute_title").removeClass("title_active");
				$(".evalute").hide();
				$(".goodsdetail-img").show();
			});
			
			//选择子商品
			function selectGoods(this_){
				$(this_).parent().find("li").css("backgroundColor", "#fff");
				$(this_).parent().find("li").attr("isSelect","");
				$(this_).css("backgroundColor", "#fee3ec");
				$(this_).attr("isSelect","select");
				
			}
			var isSuccess = true
			function addShoppingcart(){
				var goodsAttr = new Array();
				var index = 0;
				var goodsCount = 1;
				var selectNum = ${classStringList.size()} - 0;
				$('#goodsDetail li[isSelect="select"]').each(function(){
					goodsAttr[index]=$(this).find("input").val();
					index++;
				});
				if(index == selectNum){
					showLodding();
					if(isSuccess){
						isSuccess = false;
						$.ajax({
							url : "${path}/weChat/saveOrUpdateShoppingcart?goodsId=${goods.id}&employeeId=${employeeId}&goodsAttr="+goodsAttr+"&goodsCount="+goodsCount,
							data : null,
							type : "POST",
							dataType : "json",
							success : function(data) {
								if (data.success) {
									isSuccess = true;
									displayTip(data.msg);
									hiddenLodding();
								} else {
									isSuccess = true;
									displayTip(data.msg);
									hiddenLodding();
									if("noLogin" == data.obj){
										setTimeout(function() {
											window.location='${path}/weChat/goLogin?employeeId=${employeeId}'
										}, 1500);
									}
								}
							},
							error : function(xhr, type, exception) {
								hiddenLodding();
								displayTip("请检查网络设置");
								isSuccess = true;
							}
						});
					}
				}else{
					displayTip("商品属性不能为空,请选择!");
				}
			}
			

			//回到顶部
			$(".gootop_goodsdetail").click(function() {
				$('body,html').animate({
					scrollTop: 0
				}, 500);
			});
			//评价图片放大
			$(".evalute_user_img").click(function() {
				var index = $(this).index() - 5,
					len = $(this).siblings(".evalute_user_img").length + 1,
					count = 0;
				if(index == 0) {
					$(".btn_prev").css("color", "#a9a9a9");
					$(".btn_next").css("color", "#ff1b71");
				} else if(index == len - 1) {
					$(".btn_prev").css("color", "#ff1b71");
					$(".btn_next").css("color", "#a9a9a9");
				} else {
					$(".btn_prev").css("color", "#ff1b71");
					$(".btn_next").css("color", "#ff1b71");
				}
				$(".box_null").show().css('display','flex');
				$(".bigimg_box").show();
				$(".bigimg_box .bigimg_content").attr("src", $(this).attr('src'));
				//当前评价中图片
				var imgs = [];
				$(this).parent().children(".evalute_user_img").each(function() {
					imgs.push($(this).attr("src"));
				});
				//切换图片
				$(".btn").on('click', function() {
					if('prev' === $(this).data('control')) { //上一张
						index = Math.max(0, --index);
					} else {
						index = Math.min(len - 1, ++index);
					}
					$(".bigimg_box .bigimg_content").attr('src', imgs[index]);
					if(index == 0) {
						$(".btn_prev").css("color", "#a9a9a9");
						$(".btn_next").css("color", "#ff1b71");
					} else if(index == len - 1) {
						$(".btn_prev").css("color", "#ff1b71");
						$(".btn_next").css("color", "#a9a9a9");
					} else {
						$(".btn_prev").css("color", "#ff1b71");
						$(".btn_next").css("color", "#ff1b71");
					}
				});
			});
			$(".box_null,.bigimg_close").click(function() {
				$(".box_null").hide();
				$(".bigimg_box").hide();
			});
			$(".bigimg_box").click(function(){
				return false;
			});
			//购买数量加减
			$('.buynum-sub').click(function() {
				if(parseInt($(this).siblings('.buynum-input').html()) > 1) {
					var value = parseInt($(this).siblings('.buynum-input').html()) - 1;
					$(this).siblings('.buynum-input').html(value);
				} else if(parseInt($(this).siblings('.buynum-input').html()) < 1) {
					$(this).attr('src', '${path}/module/weChat/img/num-sub-disable.png')
				} else {
					var value = parseInt($(this).siblings('.buynum-input').html()) - 1;
					$(this).siblings('.buynum-input').html(value);
					$(this).attr('src', '${path}/module/weChat/img/num-sub-disable.png')
				}
			});

			$('.buynum-add').click(function() {
				$(this).siblings('.buynum-sub').attr('src', '${path}/module/weChat/img/num-sub.png')
				var value = parseInt($(this).siblings('.buynum-input').html()) + 1;
				$(this).siblings('.buynum-input').html(value);
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
		</script>
		<%@ include file="/platform/common/jsp/weChat_jsSdk.jsp"%>
	</body>

	
</html>