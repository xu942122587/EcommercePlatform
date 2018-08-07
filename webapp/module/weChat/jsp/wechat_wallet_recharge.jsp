<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>
	<head>
		<meta charset="UTF-8">
		<title>充值</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<!--微信不缓存东西  start-->
		<meta http-equiv="Pragma" content="no-cache" />
		<meta http-equiv="Expires" content="0" />
		<!--微信不缓存东西  end-->

		<link rel="stylesheet" href="${path}/module/weChat/css/all.css">
		<script type="text/javascript" src="${path}/module/weChat/js/jquery-3.1.1.min.js"></script>
	</head>

	<body>
		<div class="bg-white others_hide">
			<p class="recharge_title title">充值</p>
			<ul class="recharge_options recharge_options_ul">
			<c:forEach items="${backCashList}" var="backCash">
				<li class="recharge_option recharge_option_li" isSelect=''>
					<input type="hidden" value="${backCash.startMoney }" />
					<span class="recharge_value">&yen;${backCash.startMoney }</span>
					<span class="recharge_reminder">返现${backCash.proportion }%</span>
				</li>
			</c:forEach>
				<li class="recharge_option recharge_option_li others_click">
					<span class="recharge_value" style="line-height: 39px;font-size: 16px;">其他金额</span>
					<!--<span class="recharge_reminder">&nbsp;</span>-->
				</li>
			</ul>
		</div>
		<form class="bg-white mt6 pb4" style="overflow: hidden;">
			<div class="others">
				<div class="input-row">
					<span>*金额(&yen;)</span>
					<input type="text" id="rechargeMoney" placeholder="请输入充值金额"></input>
				</div>
				<hr/>
			</div>
			<div class="input-row" style="position: relative;">
				<span>导购(选填)</span>
				<input class="Guide_number" type="text" placeholder="请输入导购编号"></input>
				<img class="guide_more" src="${path}/module/weChat/img/classify_more.png" />
				<input type="hidden" id="model_guideUser_id" name="model.guideUser.id"></input>
			</div>
			<c:if test="${not empty guideUserList }">
				<ul class="Guides" style="width: 60%; float: right; margin-right: 5.5%;">
					<c:forEach items="${guideUserList}" var="guideUser">
						<li class="Guide_name" regCode="${guideUser.username}" id="${guideUser.id}">${guideUser.username}--${guideUser.name}</li>
					</c:forEach>
				</ul>
			</c:if>
		</form>
		<!--微信支付-->
		<div class="wechat_pay mt6" onclick="saveRecharge()">
			<img src="${path}/module/weChat/img/wechatpay.png" />
			<span>微信支付</span>
		</div>
		<p class="center">即将跳转到微信支付</p>
	
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
			//选择金额
			$(".recharge_option_li").click(function(){
				$(".recharge_options_ul li").each(function(){
					$(this).attr("isSelect","");
				});
				$("#rechargeMoney").attr("isSelect","");
				$(this).attr("isSelect","select");
				$(".recharge_option_li").css("backgroundColor","#fff");
				$(this).css("backgroundColor","#fee3ec");
			});
			$(".others_click").click(function() {
				$(".recharge_options_ul li").each(function(){
					$(this).attr("isSelect","");
				});
				$("#rechargeMoney").attr("isSelect","select");
				$(".others").show();
				$(".others_hide").hide();
			});
			var isSuccess =true;
			function saveRecharge(){
				if (isSuccess) {
					var rechargeMoney="";
					var rechargeMoneyReg =/^(([1-9][0-9]{0,7})(\.{1}[0-9]{1,2}){0,1}|([0-9]{1}\.{1}[0-9]{0,1}[1-9]))$/;
					isSuccess=false;
					if("select" == $("#rechargeMoney").attr("isSelect")){
						rechargeMoney = $("#rechargeMoney").val().trim();
					}else{
						$(".recharge_options_ul li").each(function(){
							if("select" == $(this).attr("isSelect")){
								rechargeMoney = $(this).find("input").val().trim();
							}
						});
					}
					var guideUserId = $("#model_guideUser_id").val().trim();
					var guideUserId_number = $(".Guide_number").val().trim();
					
					if("" != guideUserId_number){
						if(undefined == guideUserId || "" == guideUserId ){
							displayTip("导购无效,请检查或删除!");
							isSuccess = true;
							return false;
						}
					}
					if(undefined == rechargeMoney ||"" == rechargeMoney ){
						displayTip("金额不能为空!");
						isSuccess = true;
						return false;
					}
					if(!rechargeMoneyReg.test(rechargeMoney)){
						displayTip("请正确输入金额!");
						isSuccess = true;
					}else{
						showLodding();
						$.ajax({
							url : "${path}/weChat/saveRecharge?employeeId=${employeeId}&guideUserId="+guideUserId+"&rechargeMoney="+rechargeMoney,
							data : null,
							type : "POST",
							dataType : "json",
							success : function(data) {
								if (data.success) {
									hiddenLodding();
									isSuccess = false;//防止重复提交
									wxPayF(data.obj);
								} else {
									hiddenLodding();
									isSuccess = true;
									displayTip(data.msg);
								}
							},
							error : function(xhr, type, exception) {
								hiddenLodding();
								isSuccess = true;
								displayTip("请检查网络设置");
							}
						});
					}
				}
				return false;//防止页面刷新
			}
			
			<c:if test="${not empty guideUserList }">
				$(".Guide_number").focus(function() {
					var guide_value = $(".Guide_number").val().trim();
					if("" == guide_value){
						$(".Guides li").show();
					}else{
						$(".Guides li[regCode*=" + guide_value + "]").show();
						$(".Guides li:not(li[regCode*=" + guide_value + "])").hide();
					}
					$(".Guides").show();
					if(0 >= $(".Guides li:not(:hidden)").length){
						$(".Guides").hide();
					}else{
						$(".Guides").show();
					}
					$(".guide_more").show();
				});
				$(".Guide_name").click(function() {
					$(".Guide_number").val($(this).html());
					$("#model_guideUser_id").val($(this).attr("id"));
					$(".Guides").hide();
					$(".guide_more").hide();
				});
				$(".Guide_number").keyup(function() {
					var guide_value = $(".Guide_number").val().trim();
					if("" == guide_value){
						$(".Guides li").show();
					}else{
						$(".Guides li[regCode*=" + guide_value + "]").show();
						$(".Guides li:not(li[regCode*=" + guide_value + "])").hide();
					}
					$(".Guides").show();
					$("#model_guideUser_id").val("");
					if(0 >= $(".Guides li:not(:hidden)").length){
						$(".Guides").hide();
					}else{
						$(".Guides").show();
					}
				});
				$(".guide_more").click(function() {
					$(".Guides").hide();
					$(".guide_more").hide();
				});
			</c:if>
			
			function wxPayF(data){
				 var obj = eval("(" + data + ")"); 
				//var obj = data;
				//在线支付 
				if (typeof WeixinJSBridge == "undefined") {
					if (document.addEventListener) {
						document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
					} else if (document.attachEvent) {
						document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
						document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
					}
				} else {
					WeixinJSBridge.invoke('getBrandWCPayRequest', {
								"appId" : obj.appId, //公众号名称，由商户传入
								"timeStamp" : obj.timeStamp, //时间戳，自1970年以来的秒数
								"nonceStr" : obj.nonceStr, //随机串
								"package" : obj.package,
								"signType" : obj.signType, //微信签名方式:
								"paySign" : obj.paySign //微信签名
							},
							function(res) {
								if (res.err_msg == "get_brand_wcpay_request:ok") {
									hiddenLodding();
									window.location.href = "${path}/weChat/paySuccess?employeeId=${employeeId}&flag=wallet";
								} else {
									hiddenLodding();
									window.location.href = "${path}/weChat/payFail?employeeId=${employeeId}&flag=wallet";
								} // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回   ok，但并不保证它绝对可靠。
							});
				}
			}
			
			
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