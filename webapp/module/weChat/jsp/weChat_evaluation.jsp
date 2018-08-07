<!DOCTYPE html>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/platform/common/jsp/taglibs.jsp"%>
<html>
	<head>
		<meta charset="utf-8">
		<title>用户评价</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<!--微信不缓存东西  start-->
		<meta http-equiv="Pragma" content="no-cache" />
		<meta http-equiv="Expires" content="0" />
		<!--微信不缓存东西  end-->

		<link rel="stylesheet" href="${path}/module/weChat/css/all.css">
		<script type="text/javascript" src="${path}/module/weChat/js/jquery-3.1.1.min.js" ></script>
		<script>
		var isSuccess=true;
		function submitEvaluate(){
			var content = $("#content").val();
			if("" == content){
				displayTip("请输入内容!");
			}else{
				var formData = $("#theForm").serialize();
				if (isSuccess) {
					showLodding();
					$.ajax({
						url : "${path}/weChat/saveEvaluation?orderId=${orderId}",
						data : formData,
						type : "POST",
						dataType : "json",
						success : function(data) {
							if (data.success) {
								hiddenLodding();
								isSuccess = false;//防止重复提交
								window.location='${path}/weChat/goOrder?employeeId=${employeeId}&orderState=6'
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
		}
		</script>
	</head>

	<body class="bg-white" style="padding: 0 24px;">
	<form class="from-padding" style="padding-top: 0;" id="theForm">
		<input type="hidden" name="model.goods.id" value="${goodsId }">
		<input type="hidden" name="model.customer.id" value="${customer.id }">
		<!--评价-->
		<textarea class="feedback-textarea" rows="5" id="content" maxlength="100" name="model.content" placeholder="说两句吧，您的评论对其他买家很有帮助哦！"></textarea>
		<!--上传图片-->
		<ul class="img-list">
			<input type="file" id="choose" accept="image/*" multiple />
			<img id="upload" class="upload" src="${path}/module/weChat/img/addimg.png" class="addimg" />
		</ul>
		<button type="button" class="login_btn" onclick="submitEvaluate()">
			提交
		</button>
		
		<!-- 提示弹窗 -->
		<div id="successTip" class="toast">msg</div>
		
		<!-- loading -->
		<div id="loadingDiv" class="loaded" style="display:none">
			<div class="loading">
				<img src="${path }/module/weChat/img/ball-triangle.svg" alt="">
				<p class="loading-text">加载中</p>
			</div>
		</div>
		
	</form>
		
		<script>
		
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
		
		
			var filechooser = document.getElementById("choose");
			//    用于压缩图片的canvas
			var canvas = document.createElement("canvas");
			var ctx = canvas.getContext('2d');
			//    瓦片canvas
			var tCanvas = document.createElement("canvas");
			var tctx = tCanvas.getContext("2d");
			var maxsize = 100 * 1024;
			//上传证件
			$(".upload").on("click", function() {
					filechooser.click();
				})
				.on("touchstart", function() {
					$(this).addClass("touch")
				})
				.on("touchend", function() {
					$(this).removeClass("touch")
				});
			var uploadImgMaxNumber = 3;
			filechooser.onchange = function() {
				if(!this.files.length) return;
				var files = Array.prototype.slice.call(this.files);
				var filesNumber = files.length + ($(".img-list li").length - 0);
				if (filesNumber > uploadImgMaxNumber) {
					displayTip("最多上传3张图片！");
					return;
				}
				files.forEach(function(file, i) {
					if(!/\/(?:jpeg|png|gif)/i.test(file.type)) return;
					var reader = new FileReader();
					var li = document.createElement("li");

					//li显示内容，加删除图标
					li.innerHTML = '<img src=""/><div class="progress"><span></span></div><img class="close-li" src="${path}/module/weChat/img/register-close.png">';

					$(".upload").before($(li));
					
					if(uploadImgMaxNumber <= ($(".img-list li").length-0)){
						$("#upload").hide();
					}
					//点击删除图标删除当前li
					$(".close-li").on("click", function() {
						//alert("最多同时只可上传3张图片");
						$(this).parent('li').remove();
						$("#upload").show();
					})
					reader.onload = function() {
						var result = this.result;
						var img = new Image();
						var li_img = $(li).children("img").get(0);
						img.src = result;
						li_img.src = result;
						//			        $(li).css("background-image", "url(" + result + ")");

						//如果图片大小小于100kb，则直接上传
						if(result.length <= maxsize) {
							img = null;
							upload(result, file.type, $(li));
							return;
						}
						//图片加载完毕之后进行压缩，然后上传
						if(img.complete) {
							callback();
						} else {
							img.onload = callback;
						}

						function callback() {
							var data = compress(img);
							upload(data, file.type, $(li));
							img = null;
						}
					};
					reader.readAsDataURL(file);
				})
			};

			// 使用canvas对大图片进行压缩
			function compress(img) {
				var initSize = img.src.length;
				var width = img.width;
				var height = img.height;
				//如果图片大于四百万像素，计算压缩比并将大小压至400万以下
				var ratio;
				if((ratio = width * height / 4000000) > 1) {
					ratio = Math.sqrt(ratio);
					width /= ratio;
					height /= ratio;
				} else {
					ratio = 1;
				}
				canvas.width = width;
				canvas.height = height;
				//        铺底色
				ctx.fillStyle = "#fff";
				ctx.fillRect(0, 0, canvas.width, canvas.height);
				//如果图片像素大于100万则使用瓦片绘制
				var count;
				if((count = width * height / 1000000) > 1) {
					count = ~~(Math.sqrt(count) + 1); //计算要分成多少块瓦片
					//    计算每块瓦片的宽和高
					var nw = ~~(width / count);
					var nh = ~~(height / count);
					tCanvas.width = nw;
					tCanvas.height = nh;
					for(var i = 0; i < count; i++) {
						for(var j = 0; j < count; j++) {
							tctx.drawImage(img, i * nw * ratio, j * nh * ratio, nw * ratio, nh * ratio, 0, 0, nw, nh);
							ctx.drawImage(tCanvas, i * nw, j * nh, nw, nh);
						}
					}
				} else {
					ctx.drawImage(img, 0, 0, width, height);
				}
				//进行最小压缩
				var ndata = canvas.toDataURL('image/jpeg', 0.1);
				console.log('压缩前：' + initSize);
				console.log('压缩后：' + ndata.length);
				console.log('压缩率：' + ~~(100 * (initSize - ndata.length) / initSize) + "%");
				tCanvas.width = tCanvas.height = canvas.width = canvas.height = 0;
				return ndata;
			}
			//    图片上传，将base64的图片转成二进制对象，塞进formdata上传
			function upload(basestr, type, $li) {
				var text = window.atob(basestr.split(",")[1]);
				var buffer = new Uint8Array(text.length);
				var pecent = 0,
					loop = null;
				for(var i = 0; i < text.length; i++) {
					buffer[i] = text.charCodeAt(i);
				}
				var blob = getBlob([buffer], type);
				var xhr = new XMLHttpRequest();
				var formdata = getFormData();
				formdata.append('file', blob);
				formdata.append('fileType', type);
				xhr.open('post', '${path}/weChat/saveUploadFile');
				xhr.onreadystatechange = function() {
				  if (xhr.readyState == 4 && xhr.status == 200) {
					var jsonData = JSON.parse(xhr.responseText);
					var imagedata = jsonData.imagedata || {};
					var text = imagedata.path ? '上传成功' : '上传失败';
					console.log(text + '：' + imagedata.path);
					clearInterval(loop);
					//当收到该消息时上传完毕
					$li.find(".progress span").animate({'width': "100%"}, pecent < 95 ? 200 : 0, function() {
					  $(this).html(text);
					});
					if (!imagedata.path) return;
					$li.append("<input type='hidden' name='model.imgName' value='"+imagedata.path+"'/>");
				  }
				};
				//数据发送进度，前50%展示该进度
				xhr.upload.addEventListener('progress', function(e) {
					if(loop) return;
					pecent = ~~(100 * e.loaded / e.total) / 2;
					$li.find(".progress span").css('width', pecent + "%");
					if(pecent == 50) {
						mockProgress();
					}
				}, false);
				//数据后50%用模拟进度
				function mockProgress() {
					if(loop) return;
					loop = setInterval(function() {
						pecent++;
						$li.find(".progress span").css('width', pecent + "%");
						if(pecent == 99) {
							clearInterval(loop);
						}
					}, 100)
				}
				xhr.send(formdata);
			}
			/**
			 * 获取blob对象的兼容性写法
			 * @param buffer
			 * @param format
			 * @returns {*}
			 */
			function getBlob(buffer, format) {
				try {
					return new Blob(buffer, {
						type: format
					});
				} catch(e) {
					var bb = new(window.BlobBuilder || window.WebKitBlobBuilder || window.MSBlobBuilder);
					buffer.forEach(function(buf) {
						bb.append(buf);
					});
					return bb.getBlob(format);
				}
			}
			/**
			 * 获取formdata
			 */
			function getFormData() {
				var isNeedShim = ~navigator.userAgent.indexOf('Android') &&
					~navigator.vendor.indexOf('Google') &&
					!~navigator.userAgent.indexOf('Chrome') &&
					navigator.userAgent.match(/AppleWebKit\/(\d+)/).pop() <= 534;
				return isNeedShim ? new FormDataShim() : new FormData()
			}
			/**
			 * formdata 补丁, 给不支持formdata上传blob的android机打补丁
			 * @constructor
			 */
			function FormDataShim() {
				console.warn('using formdata shim');
				var o = this,
					parts = [],
					boundary = Array(21).join('-') + (+new Date() * (1e16 * Math.random())).toString(36),
					oldSend = XMLHttpRequest.prototype.send;
				this.append = function(name, value, filename) {
					parts.push('--' + boundary + '\r\nContent-Disposition: form-data; name="' + name + '"');
					if(value instanceof Blob) {
						parts.push('; filename="' + (filename || 'blob') + '"\r\nContent-Type: ' + value.type + '\r\n\r\n');
						parts.push(value);
					} else {
						parts.push('\r\n\r\n' + value);
					}
					parts.push('\r\n');
				};
				// Override XHR send()
				XMLHttpRequest.prototype.send = function(val) {
					var fr,
						data,
						oXHR = this;
					if(val === o) {
						// Append the final boundary string
						parts.push('--' + boundary + '--\r\n');
						// Create the blob
						data = getBlob(parts);
						// Set up and read the blob into an array to be sent
						fr = new FileReader();
						fr.onload = function() {
							oldSend.call(oXHR, fr.result);
						};
						fr.onerror = function(err) {
							throw err;
						};
						fr.readAsArrayBuffer(data);
						// Set the multipart content type and boudary
						this.setRequestHeader('Content-Type', 'multipart/form-data; boundary=' + boundary);
						XMLHttpRequest.prototype.send = oldSend;
					} else {
						oldSend.call(this, val);
					}
				};
			}
		</script>
		<%@ include file="/platform/common/jsp/weChat_jsSdk.jsp"%>
	</body>

</html>