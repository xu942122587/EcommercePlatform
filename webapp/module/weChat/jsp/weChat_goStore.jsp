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
						},
						error : function(xhr, type, exception) {
							$("#loadingDiv").removeClass("loaded");
							isSuccess = true;
							displayTip("请检查网络设置");
						}
					});
				}
			}
			
			function getGoodsByClass(classType,classId) {
				var classList =new Array();
				if("3" == classType){
					$(".classify_detial_box:not(:hidden)").each(function(){
						$(this).find(".classify_detial_list").each(function(){
							if("isSelect" == $(this).attr("isSelect")){
								classList.push($(this).attr("classId"))
							}
						});
					});
				}else{
					classList.push(classId);
				}
				$(".recommend_lists").attr('pageClassId',classList);
				$.ajax({
					type : "POST",
					url : "${path}/weChat/getGoodsListData?storeId=${store.id}&classList="+classList+"&page=1",
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
							var jsonData = eval(data.obj.goodsList);
							if(data.obj.goodsList.length<10){
								$("#loadData").html("更多商品，敬请期待");
							}
							$(".recommend_lists").html("");
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
							$("#sumGoodsNumber").html(data.obj.totalRecord);
							$("body").css("overflow","scroll");
							$(".recommend_img").height($(".recommend_img").width());
						}else{
							displayTip(data.msg);
						}
					}
				});
			}
			
			function selectGoods(){
				$("#selectGoods_input").blur();
				if("" != $("#selectGoods_input").val().trim()){
					var goodsName = $("#selectGoods_input").val().trim();
					var classList = $(".recommend_lists").attr('pageClassId');
					window.location = "${path}/weChat/selectGoods?employeeId=${employeeId}&storeId=${store.id}&classList="+classList+"&goodsName="+goodsName;
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
					<input class="search_input" type="search" name="selectGoods_input" id="selectGoods_input" value="" placeholder="搜索" onsearch="selectGoods()"/>
				</form>
			</div>
			<div class="search_btn"></div>
		</div>
		<div style="height: 50px;clear: both;"></div>
		<div class="bg-white overflow" style="padding: 6px 8px 0;">
			<img class="brand_icon left" src="${path}/platform/images/${store.imgUrl[1]}" />
			<span class="right lineh31">共<span id="sumGoodsNumber">${goodsPageVo.totalRecord}</span>商品</span>
		</div>
		
		<!--三级分类-->
		<c:forEach items="${childClassList}" var="childClass">
			<c:if test="${ not empty childClass.childrenClassifications}">
				<div class="classify_detial_box"  parentClass='${childClass.id}' ">
					<img class="classify_more" src="${path}/module/weChat/img/classify_more.png">
					<ul class="classify_detial">
						<c:forEach items="${threeClassList}" var="threeClass">
							<c:if test="${childClass.id eq threeClass.parentClassification.id}">
								<span class="classify_detial_list" isSelect='' classId='${threeClass.id}' onclick="selectThreeClass(this)">${threeClass.name}</span>
							</c:if>
						</c:forEach>
					</ul>
				</div>
			</c:if>
		</c:forEach>
		
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
			<a onclick="window.location='${path}/weChat/goPersonalCenter?employeeId=${employeeId}'">
				<img src="${path}/module/weChat/img/nav-icon-personal.png" class="nav-icon">
				<div class="nav_font">我的</div>
			</a>
		</nav>
		<!--底部菜单结束-->
		
		<!--分类-->
		<ul class="classify">
			<div class="classify_null"></div>
			<li class="classify_list" onclick="selectOneClass(this,'')">
				<div class="classify_list_title">
					<span>全部</span>
				</div>
			</li>
			<c:forEach items="${parentClassList}" var="parentClass">
				<li class="classify_list">
					<%-- onclick="getGoodsByClass('1','${parentClass.id}')" --%>
					 <%-- onclick="window.location='${path}/weChat/goStore?storeId=${store.id}&employeeId=${employeeId}&classId=${parentClass.id}'" --%>
					<div class="classify_list_title" onclick="selectOneClass(this,'${parentClass.id}')">
						<input type="hidden" value="${parentClass.id}">
						<span>${parentClass.name}</span>
						<img class="classify_more" src="${path}/module/weChat/img/classify_more.png">
					</div>
					<ul class='classify_type'>
						<c:forEach items="${childClassList}" var="childClass">
							<c:if test="${parentClass.id eq childClass.parentClassification.id}">
								<li onclick="selectTwoClass('${childClass.id}')">
									<input type="hidden" value="${childClass.id}">
									<span >${childClass.name}</span>
								</li>
								<%-- onclick="getGoodsByClass('2','${childClass.id}')" --%>
								<%-- onclick="window.location='${path}/weChat/goStore?storeId=${store.id}&employeeId=${employeeId}&classId=${childClass.id}'" --%>
							</c:if>
						</c:forEach>
					</ul>
				</li>
			</c:forEach>
		</ul>

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
			$(".recommend_img").height($(".recommend_img").width());
			//点击跳转至商品详情
			/* $(".recommend_lists").height(window.screen.availHeight - 150); */
			//点击购买
			$(".brand_buy").click(function() {

			});
			//分类
			$(".search_btn").click(function() {
				if($(".classify").is(":hidden")){
					$(".classify").show();
				}else{
					$(".classify").hide();
				}
			});
			
			$(".classify_null").click(function() {
				$(".classify").hide();
			});
			
			function selectOneClass(this_,classId) {
				$(".classify_detial_box ").each(function(){
					$(this).hide();
				});
				
				var isBlock= false;
				$(".classify .classify_type").each(function(){
					if("block" == $(this).css("display")){
						isBlock = true;
					}
				});
				
				if(isBlock){
					if("block" == $(this_).parent().find(".classify_type").css("display")){
						$(this_).parent().find(".classify_type").hide();
					}else{
						$(".classify_type").hide();
						$(this_).parent().find(".classify_type").show();
					}
				}else{
					$(this_).parent().find(".classify_type").show();
				}
				$(this_).parent().find(".classify_type").each(function(){
					if("" == $(this).html().trim()){
						getGoodsByClass('1,2',classId);
						$(".classify").hide();
					}else{
						getGoodsByClass('1,2',classId);
					}
				});
			};
			
			function selectTwoClass(classId){
				$(".classify").hide();
				var isCheck = true;
				$(".classify_detial_box ").each(function(){
					if(classId == $(this).attr("parentClass")){
						$(this).show();
						isCheck = false;
					}else{
						$(this).hide();
					}
				});
				getGoodsByClass('1,2',classId);
			}
			
			function selectThreeClass(this_){
				if("" == $(this_).attr("isSelect")){
					$(this_).attr("isSelect","isSelect");
					$(this_).toggleClass("classify_detial_active");
					getGoodsByClass('3','');
				}else if ("isSelect" == $(this_).attr("isSelect")){
					$(this_).attr("isSelect","");
					$(this_).toggleClass("classify_detial_active");
					getGoodsByClass('3','');
				}
			}
			$(".classify_detial_box .classify_more").click(function() {
				$(".classify_detial_box").toggleClass("height_inherit");
				$(".classify_detial_box .classify_more").toggleClass("rotate180");
			});s
		</script>
		<%@ include file="/platform/common/jsp/weChat_jsSdk.jsp"%>
	</body>

</html>