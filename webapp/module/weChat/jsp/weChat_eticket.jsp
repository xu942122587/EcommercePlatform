<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>

	<head>
		<meta charset="UTF-8">
		<title>电子券</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<!--微信不缓存东西  start-->
		<meta http-equiv="Pragma" content="no-cache" />
		<meta http-equiv="Expires" content="0" />
		<!--微信不缓存东西  end-->
		<link rel="stylesheet" href="${path}/module/weChat/css/all.css">
		<script src="${path}/module/weChat/js/jquery-3.1.1.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="${path}/module/weChat/js/TouchSlide.js" type="text/javascript" charset="utf-8"></script>
		<style>
			* {
				-webkit-box-sizing: border-box;
				-moz-box-sizing: border-box;
				box-sizing: border-box;
			}
			.bigimg_content{
				transform: scale(1.3);
			}
			/*.first-list {
				margin-top: 30px;
			}
			
			.about {
				width: 100px;
				float: right;
				margin: 4px 15px;
			}*/
		</style>
	</head>

	<body class="bg-white">

		<!--电子券开始-->
		<div class="row gary-bg">
			<div id="goodsContent" class="goods-content white-bg">
				<div class="hd hd_fav">
					<ul>
						<li class="on">未使用(${normalList.size()})</li>
						<li class="">使用记录(${usedList.size()})</li>
						<li class="">已过期(${failList.size()})</li>
					</ul>
				</div>

				<div id="touchslide" style="position: relative; overflow: hidden; padding: 0px; margin: 0px; transition-duration: 200ms; transform: translateX(0px);" class="bd">
					<!--未使用-->
					<ul style="display: table-cell; vertical-align: top; max-width: 768px;width: 100%;" class="property">
						<div class="prop-area" style="min-height:300px;overflow: hidden;">
							<!--<img src="img/about.png" class="about" id="about" />-->
							<c:if test="${empty normalList}">
								<div class="list-none" style="display: block;">
									<img src="${path}/module/weChat/img/list_none.png" class="imgs">
									<div class="fonts">暂无此类优惠券</div>
								</div>
							</c:if>
							<c:forEach items="${normalList }" var="normal">
								<c:if test="${'5' eq normal.eticket.outType }">
									<c:if test="${'2' eq normal.eticket.type }">
										<div class="Electronic_coupons_birthday">
											<div class="Electronic_coupons_code">
												<img class="code_img" src="${path }/platform/qrcode/eticket/${normal.code }.png" />
											</div>
											<img class="Electronic_birthday" src="${path}/module/weChat/img/birthday.png" />
											<div class="store_name"></div>
											<div class="Electronic_coupons_value">
												<span style="font-size: 18px;">&yen;</span><span>${normal.eticket.price }</span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												<span class="Electronic_coupons_type">通用券 </span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												满<span style="color: #ec196b;font-size: 20px;">${normal.eticket.useLimit }</span>
												使用 &nbsp;&nbsp;<fmt:formatDate value="${normal.endDate }" pattern="yyyy-MM-dd"/>前使用
											</div>
										</div>
									</c:if>
									<c:if test="${'1' eq normal.eticket.type }">
										<div class="Electronic_coupons_birthday">
											<div class="Electronic_coupons_code">
												<img class="code_img" src="${path }/platform/qrcode/eticket/${normal.code }.png" />
											</div>
											<img class="Electronic_birthday" src="${path}/module/weChat/img/birthday.png" />
											<div class="store_name">${normal.eticket.useStore.name }</div>
											<div class="Electronic_coupons_value">
												<span style="font-size: 18px;">&yen;</span><span>${normal.eticket.price }</span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												<span class="Electronic_coupons_type">专用券 </span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												满<span style="color: #ec196b;font-size: 20px;">${normal.eticket.useLimit }</span>
												使用 &nbsp;&nbsp;<fmt:formatDate value="${normal.endDate }" pattern="yyyy-MM-dd"/>前使用
											</div>
										</div>
									</c:if>
								</c:if>
								<c:if test="${'5' ne normal.eticket.outType }">
									<c:if test="${'1' eq normal.eticket.type }">
										<div class="Electronic_coupons_able">
											<div class="Electronic_coupons_code">
												<img class="code_img" src="${path }/platform/qrcode/eticket/${normal.code }.png" />
											</div>
											<div class="store_name">${normal.eticket.useStore.name }</div>
											<div class="Electronic_coupons_value">
												<span style="font-size: 18px;">&yen;</span><span>${normal.eticket.price }</span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												<span class="Electronic_coupons_type">专用券 </span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												满<span style="color: #ec196b;font-size: 20px;">${normal.eticket.useLimit }</span>
												使用 &nbsp;&nbsp;<fmt:formatDate value="${normal.endDate }" pattern="yyyy-MM-dd"/>前使用
											</div>
										</div>
									</c:if>
									<c:if test="${'2' eq normal.eticket.type }">
										<div class="Electronic_coupons_able">
											<div class="Electronic_coupons_code">
												<img class="code_img" src="${path }/platform/qrcode/eticket/${normal.code }.png" />
											</div>
											<div class="store_name"></div>
											<div class="Electronic_coupons_value">
												<span style="font-size: 18px;">&yen;</span><span>${normal.eticket.price }</span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												<span class="Electronic_coupons_type">通用券 </span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												满<span style="color: #ec196b;font-size: 20px;">${normal.eticket.useLimit }</span>
												使用 &nbsp;&nbsp;<fmt:formatDate value="${normal.endDate }" pattern="yyyy-MM-dd"/>前使用
											</div>
										</div>
									</c:if>
								</c:if>
							</c:forEach>
						</div>
					</ul>
					<!--已使用-->
					<ul style="display: table-cell; vertical-align: top; max-width: 768px;width: 100%;" class="property">
						<div class="prop-area" style="min-height:300px;overflow: hidden;">
							<!--<img src="img/about.png" class="about" id="about" />-->
							<c:if test="${empty usedList}">
								<div class="list-none" style="display: block;">
									<img src="${path}/module/weChat/img/list_none.png" class="imgs">
									<div class="fonts">暂无此类优惠券</div>
								</div>
							</c:if>
							<c:forEach items="${usedList }" var="used">
								<c:if test="${'5' eq used.eticket.outType }">
									<c:if test="${'2' eq used.eticket.type }">
										<div class="Electronic_coupons_birthday">
											<div class="Electronic_coupons_code">
												<img class="code_img" src="${path }/platform/qrcode/eticket/${used.code }.png" />
											</div>
											<img class="Electronic_birthday" src="${path}/module/weChat/img/birthday.png" />
											<div class="store_name"></div>
											<div class="Electronic_coupons_value">
												<span style="font-size: 18px;">&yen;</span><span>${used.eticket.price }</span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												<span class="Electronic_coupons_type">通用券 </span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												满<span style="color: #ec196b;font-size: 20px;">${used.eticket.useLimit }</span>
												使用 &nbsp;&nbsp;<fmt:formatDate value="${used.endDate }" pattern="yyyy-MM-dd"/>前使用
											</div>
											<img class="Electronic_bg_black" src="${path}/module/weChat/img/Electronic_bg_black.png" />
											<p class="Electronic_state">已使用</p>
										</div>
									</c:if>
									<c:if test="${'1' eq used.eticket.type }">
										<div class="Electronic_coupons_birthday">
											<div class="Electronic_coupons_code">
												<img class="code_img" src="${path }/platform/qrcode/eticket/${used.code }.png" />
											</div>
											<img class="Electronic_birthday" src="${path}/module/weChat/img/birthday.png" />
											<div class="store_name">${used.eticket.useStore.name }</div>
											<div class="Electronic_coupons_value">
												<span style="font-size: 18px;">&yen;</span><span>${used.eticket.price }</span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												<span class="Electronic_coupons_type">专用券 </span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												满<span style="color: #ec196b;font-size: 20px;">${used.eticket.useLimit }</span>
												使用 &nbsp;&nbsp;<fmt:formatDate value="${used.endDate }" pattern="yyyy-MM-dd"/>前使用
											</div>
											<img class="Electronic_bg_black" src="${path}/module/weChat/img/Electronic_bg_black.png" />
											<p class="Electronic_state">已使用</p>
										</div>
									</c:if>
								</c:if>
								<c:if test="${'5' ne used.eticket.outType }">
									<c:if test="${'2' eq used.eticket.type }">
										<div class="Electronic_coupons_able">
											<div class="Electronic_coupons_code">
												<img class="code_img" src="${path }/platform/qrcode/eticket/${used.code }.png" />
											</div>
											<div class="store_name"></div>
											<div class="Electronic_coupons_value">
												<span style="font-size: 18px;">&yen;</span><span>${used.eticket.price }</span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												<span class="Electronic_coupons_type">通用券 </span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												满<span style="color: #ec196b;font-size: 20px;">${used.eticket.useLimit }</span>
												使用 &nbsp;&nbsp;<fmt:formatDate value="${used.endDate }" pattern="yyyy-MM-dd"/>前使用
											</div>
											<img class="Electronic_bg_black" src="${path}/module/weChat/img/Electronic_bg_black.png" />
											<p class="Electronic_state">已使用</p>
										</div>
									</c:if>
									<c:if test="${'1' eq used.eticket.type }">
										<div class="Electronic_coupons_able">
											<div class="Electronic_coupons_code">
												<img class="code_img" src="${path }/platform/qrcode/eticket/${used.code }.png" />
											</div>
											<div class="store_name">${used.eticket.useStore.name }</div>
											<div class="Electronic_coupons_value">
												<span style="font-size: 18px;">&yen;</span><span>${used.eticket.price }</span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												<span class="Electronic_coupons_type">专用券 </span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												满<span style="color: #ec196b;font-size: 20px;">${used.eticket.useLimit }</span>
												使用 &nbsp;&nbsp;<fmt:formatDate value="${used.endDate }" pattern="yyyy-MM-dd"/>前使用
											</div>
											<img class="Electronic_bg_black" src="${path}/module/weChat/img/Electronic_bg_black.png" />
											<p class="Electronic_state">已使用</p>
										</div>
									</c:if>
								</c:if>
							</c:forEach>
						</div>
					</ul>
					<!--已过期-->
					<ul class="txt-imgs" style="display: table-cell; vertical-align: top; max-width: 768px;width: 100%;max-height:300px!important">
						<div class="format" style="margin-top: -4px;padding-top:4px">
							<!--<img src="img/about.png" class="about" id="about1" />-->
							<c:if test="${empty failList}">
								<div class="list-none" style="display: block;">
									<img src="${path}/module/weChat/img/list_none.png" class="imgs">
									<div class="fonts">暂无此类优惠券</div>
								</div>
							</c:if>
							<c:forEach items="${failList }" var="fail">
								<c:if test="${'5' eq fail.eticket.outType }">
									<c:if test="${'2' eq fail.eticket.type }">
										<div class="Electronic_coupons_birthday">
											<div class="Electronic_coupons_code">
												<img class="code_img" src="${path }/platform/qrcode/eticket/${fail.code }.png" />
											</div>
											<img class="Electronic_birthday" src="${path}/module/weChat/img/birthday.png" />
											<div class="store_name"></div>
											<div class="Electronic_coupons_value">
												<span style="font-size: 18px;">&yen;</span><span>${fail.eticket.price }</span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												<span class="Electronic_coupons_type">通用券 </span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												满<span style="color: #ec196b;font-size: 20px;">${fail.eticket.useLimit }</span>
												使用 &nbsp;&nbsp;<fmt:formatDate value="${fail.endDate }" pattern="yyyy-MM-dd"/>前使用
											</div>
											<img class="Electronic_bg_black" src="${path}/module/weChat/img/Electronic_bg_black.png" />
											<p class="Electronic_state">已过期</p>
										</div>
									</c:if>
									<c:if test="${'1' eq fail.eticket.type }">
										<div class="Electronic_coupons_birthday">
											<div class="Electronic_coupons_code">
												<img class="code_img" src="${path }/platform/qrcode/eticket/${fail.code }.png" />
											</div>
											<img class="Electronic_birthday" src="${path}/module/weChat/img/birthday.png" />
											<div class="store_name">${fail.eticket.useStore.name }</div>
											<div class="Electronic_coupons_value">
												<span style="font-size: 18px;">&yen;</span><span>${fail.eticket.price }</span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												<span class="Electronic_coupons_type">专用券 </span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												满<span style="color: #ec196b;font-size: 20px;">${fail.eticket.useLimit }</span>
												使用 &nbsp;&nbsp;<fmt:formatDate value="${fail.endDate }" pattern="yyyy-MM-dd"/>前使用
											</div>
											<img class="Electronic_bg_black" src="${path}/module/weChat/img/Electronic_bg_black.png" />
											<p class="Electronic_state">已过期</p>
										</div>
									</c:if>
								</c:if>
								<c:if test="${'5' ne fail.eticket.outType }">
									<c:if test="${'2' eq fail.eticket.type }">
										<div class="Electronic_coupons_able">
											<div class="Electronic_coupons_code">
												<img class="code_img" src="${path }/platform/qrcode/eticket/${fail.code }.png" />
											</div>
											<div class="store_name"></div>
											<div class="Electronic_coupons_value">
												<span style="font-size: 18px;">&yen;</span><span>${fail.eticket.price }</span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												<span class="Electronic_coupons_type">通用券 </span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												满<span style="color: #ec196b;font-size: 20px;">${fail.eticket.useLimit }</span>
												使用 &nbsp;&nbsp;<fmt:formatDate value="${fail.endDate }" pattern="yyyy-MM-dd"/>前使用
											</div>
											<img class="Electronic_bg_black" src="${path}/module/weChat/img/Electronic_bg_black.png" />
											<p class="Electronic_state">已过期</p>
										</div>
									</c:if>
									<c:if test="${'1' eq fail.eticket.type }">
										<div class="Electronic_coupons_able">
											<div class="Electronic_coupons_code">
												<img class="code_img" src="${path }/platform/qrcode/eticket/${fail.code }.png" />
											</div>
											<div class="store_name">${fail.eticket.useStore.name }</div>
											<div class="Electronic_coupons_value">
												<span style="font-size: 18px;">&yen;</span><span>${fail.eticket.price }</span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												<span class="Electronic_coupons_type">专用券 </span>
											</div>
											<div class="Electronic_coupons_period_of_validity">
												满<span style="color: #ec196b;font-size: 20px;">${fail.eticket.useLimit }</span>
												使用 &nbsp;&nbsp;<fmt:formatDate value="${fail.endDate }" pattern="yyyy-MM-dd"/>前使用
											</div>
											<img class="Electronic_bg_black" src="${path}/module/weChat/img/Electronic_bg_black.png" />
											<p class="Electronic_state">已过期</p>
										</div>
									</c:if>
								</c:if>
							</c:forEach>
						</div>
					</ul>
				</div>
			</div>
		</div>
		<!--<div id="alert-about" class="coupon-alert" style="display: none;">
			<p class="grey">电子券使用说明</p>
			<p class="grey">电子券使用说明电子券使用说明电子券使用说明电子券使用说明电子券使用说明电子券使用说明电子券使用说明</p>
			<button id="sure_choose_coupon" class="sure_choose_coupon">关闭</button>
		</div>-->
		<!--电子券结束-->
		<div style="height: 50px;"></div>
		<!--底部菜单开始-->
		<nav class="nav-bar nav-bar-tab">
			<a onclick="window.location='${path}/weChat/weChatIndex?employeeId=${employeeId}'">
				<img src="${path}/module/weChat/img/nav-icon-index.png" class="nav-icon">
				<div class="nav_font ">首页</div>
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
				<img src="${path}/module/weChat/img/nav-icon-personalactive.png" class="nav-icon">
				<div class="nav_font active">我的</div>
			</a>
		</nav>
		<!--底部菜单结束-->
		<!--图片放大-->
		<div class="box_null"></div>
		<div class="bigimg_box">
			<img class="bigimg_content" src="" />
			<img class="bigimg_close" src="${path}/module/weChat/img/register-close.png" />
		</div>
		<!--底部菜单结束-->
		<script type="text/javascript">
			TouchSlide({
				slideCell: "#goodsContent",

				endFun: function(i) { //高度自适应
					var bd = document.getElementById("touchslide");
					bd.parentNode.style.height = bd.children[i].children[0].offsetHeight + "px";
					if(i > 0) bd.parentNode.style.transition = "200ms"; //添加动画效果
				}

			});
			//帮助
			//			$("#about,#about1").click(function() {
			//				$("#alert-about").show();
			//				$("body").scrollTop(0);
			//				$("html").css("overflow-y", "hidden");
			//			});
			//			$("#sure_choose_coupon").click(function() {
			//				$("#coupon-alert").hide();
			//				$("html").css("overflow-y", "scroll");
			//			});

			//二维码点击放大
			$('.Electronic_coupons_code .code_img').click(function() {
				$("body").css("overflow-y", "hidden");
				$(".box_null").show();
				$(".bigimg_box").show();
				$(".bigimg_box .bigimg_content").attr("src", $(this).attr('src'));
			});
			$(".box_null,.bigimg_close").click(function() {
				$(".box_null").hide();
				$(".bigimg_box").hide();
			});
		</script>
		<%@ include file="/platform/common/jsp/weChat_jsSdk.jsp"%>
	</body>

</html>