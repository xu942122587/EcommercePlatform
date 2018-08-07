<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<meta charset="utf-8" />
<link rel="stylesheet" type="text/css" href="${path}/platform/ui/bootstrap/main.css">
<link rel="stylesheet" type="text/css" href="${path}/platform/common/css/help.css">
<!-- 新 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.css">
<!-- 可选的Bootstrap主题文件（一般不用引入） -->
<!-- <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap-theme.min.css"> -->
<script src="${path }/platform/common/js/jshashtable-3.0.js"></script>
<script src="${path }/platform/common/js/swfobject.js"></script>

<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="${path }/platform/common/js/jquery-1.11.1.js"></script>
<!-- <script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script> -->
<script src="${path }/platform/common/js/jquery-ext.js"></script>

<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
<!-- 引入命名空间 -->
<script src="${path }/platform/common/js/prototype-ext.js"></script>
<script type="text/javascript">
	//注册产品全局变量方法集
	Namespace.register('com.ue.global');
	com.ue.global = {
		path : '<%=path%>',
		basePath : '<%=basePath%>',
		jsessionid : '${pageContext.session.id}',//sessionId用于flash中提交文件无法使用当前session
		theme : 'default',
		productTitle:''
	}
</script>

<script src="${path }/platform/common/js/jquery.i18n.properties-1.0.9.js"></script>
<script src="${path }/platform/common/js/jquery.cookie.js"></script>
<script type="text/javascript">
	// 初始化js国际化文件 
	$.i18n.properties({
	    name:['upload','validationEngine','print'],
	    path: com.ue.global.path+'/sys/i18n/ajaxGetI18nValues.do?bundleName=', 
	    mode:'map',
	    callback: function() {
	    	
	    }
	});
</script>

<!-- 引入BootstrapValidator验证 -->
<script src="${path}/platform/ui/bootstrap/js/bootstrapValidator.js"></script>
<script src="${path}/platform/ui/bootstrap/js/zh_CN.js"></script>
<link rel="stylesheet" type="text/css" href="${path}/platform/ui/bootstrap/css/bootstrapValidator.min.css">

<!-- 引入提示插件 -->
<script src="${path}/platform/ui/bootstrap/js/toastr.min.js"></script>
<link rel="stylesheet" type="text/css" href="${path}/platform/ui/bootstrap/css/toastr.min.css">

<!-- bootstrap表格分页及汉化 -->
<link rel="stylesheet" href="${path}/platform/ui/bootstrap/css/bootstrap-table.min.css" />
<script src="${path}/platform/ui/bootstrap/js/bootstrap-table.min.js"></script>
<script src="${path}/platform/ui/bootstrap/js/bootstrap-table-zh-CN.min.js"></script>

<!-- bootstrap分页 -->
<script src="${path }/platform/component/page/jquery.page.js"></script>
<script src="${path }/platform/common/js/ArrayUtil.js"></script>

<!-- bootstrap日期选择控件 start -->
<link href="http://cdn.bootcss.com/bootstrap-datepicker/1.6.4/css/bootstrap-datepicker3.min.css" rel="stylesheet">
<script src="http://cdn.bootcss.com/bootstrap-datepicker/1.6.4/js/bootstrap-datepicker.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap-datepicker/1.6.4/locales/bootstrap-datepicker.zh-CN.min.js"></script>
<!-- bootstrap日期选择控件 end -->

<!-- bootstrap日期时间选择控件 start -->
<link href="${path }/platform/ui/bootstrap/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
<script src="${path }/platform/ui/bootstrap/js/bootstrap-datetimepicker.min.js"></script>
<script src="${path }/platform/ui/bootstrap/js/bootstrap-datetimepicker.zh-CN.js"></script>
<!-- bootstrap日期时间选择控件 end -->

<script src="${path }/platform/component/progressbar/jquery.progressbar.js"></script>
<script src="${path }/platform/component/swfupload/js/swfupload.js"></script>
<script src="${path }/platform/component/swfupload/js/swfupload.queue.js"></script>
<script src="${path }/platform/component/swfupload/js/jquery.swfupload.js"></script>
<link rel="stylesheet" href="${path}/platform/theme/default/component/swfupload/swfupload.css" />

<script src="${path }/platform/ui/bootstrap/js/bootstrap-slider.min.js"></script>
<link rel="stylesheet" href="${path}/platform/ui/bootstrap/css/bootstrap-slider.min.css" />

<script src="${path }/platform/ui/baiduEcharts/echarts.min.js"></script>
<script src="${path }/platform/ui/baiduEcharts/shine.js"></script>
<script src="${path }/platform/ui/baiduEcharts/infographic.js"></script>
<script src="${path }/platform/ui/baiduEcharts/macarons.js"></script>
<script src="${path }/platform/ui/baiduEcharts/roma.js"></script>
<script src="${path }/platform/ui/baiduEcharts/vintage.js"></script>

<style type="text/css">
	a:link {
		text-decoration: none;
	} /*未被访问过的链接不显示下划线*/
	a:active {
		text-decoration: none;
	} /*正在点击的链接文本闪烁*/
	a:hover {
		text-decoration: none;
	} /*鼠标移入的链接文字有下划线*/
	a:visited {
		text-decoration: none;
	} /*已被访问过链接*/
	div,span,p,td,lable,a{text-overflow: ellipsis;word-break: break-all;word-wrap: break-word;}
	.dropdown-menu{z-index: 2000;}
	.lantiao_lable{
		background-color: #0AA0D9;text-align: left!important;color: #fff;padding-bottom: 7px;
	}
	pre {
		font-size:18px;
		overflow-x: hidden;
		background:none;
		border:none;
		white-space: pre-wrap;
		/* css-3 */
		white-space: -moz-pre-wrap;
		/* Mozilla, since 1999 */
		white-space: -pre-wrap;
		/* Opera 4-6 */
		white-space: -o-pre-wrap;
		/* Opera 7 */
		word-wrap: break-word;
		/* Internet Explorer 5.5+ */
		line-height: 30px;
		font-family: "PingHei", "PingFang SC", Arial, "FZLanTingHei-R-GBK", 方正兰亭黑, "Microsoft YaHei", 微软雅黑, STHeiti, 华文黑体, SimSun, 宋体, sans-serif, "Myriad Pro";
	}
	input:-webkit-autofill {
		-webkit-box-shadow : 0 0 0px 1000px white inset ;
	}
	input::-webkit-outer-spin-button,
	input::-webkit-inner-spin-button{
	    -webkit-appearance: none !important;
	    margin: 0;
	}
	
	/*Firefox下：*/
	input[type="number"]{-moz-appearance:textfield;}
</style>
<script src="${path }/platform/common/js/NumberUtil.js"></script>
<script src="${path }/platform/common/js/date.js"></script>