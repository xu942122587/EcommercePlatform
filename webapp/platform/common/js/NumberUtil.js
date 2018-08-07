// 数字补零 
Number.prototype.LenWithZero = function(oCount) {
	var strText = this.toString();
	while (strText.length < oCount) {
		strText = '0' + strText;
	}
	return strText;
};

/** 
 * <p>
 * 除法函数，用来得到精确的除法结果<br/>
 * 说明：javascript的除法结果会有误差，在两个浮点数相除的时候会比较明显。这个函数返回较为精确的除法结果。<br/>
 * 调用：accDiv(arg1,arg2)<br/>
 * </p>
 * @return arg1除以arg2的精确结果
 */
function accDiv(arg1, arg2) {
	var t1 = 0, t2 = 0, r1, r2;
	try {
		t1 = arg1.toString().split(".")[1].length
	} catch (e) {
	}
	try {
		t2 = arg2.toString().split(".")[1].length
	} catch (e) {
	}
	with (Math) {
		r1 = Number(arg1.toString().replace(".", ""))
		r2 = Number(arg2.toString().replace(".", ""))
		return (r1 / r2) * pow(10, t2 - t1);
	}
}
// 给Number类型增加一个div方法，调用起来更加方便。
Number.prototype.div = function(arg) {
	return accDiv(this, arg);
}

/** 
 * <p>
 * 乘法函数，用来得到精确的乘法结果<br/>
 * 说明：javascript的乘法结果会有误差，在两个浮点数相乘的时候会比较明显。这个函数返回较为精确的乘法结果。<br/>
 * 调用：accMul(arg1,arg2)<br/>
 * </p>
 * @return arg1乘以arg2的精确结果
 */
function accMul(arg1, arg2) {
	var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
	try {
		m += s1.split(".")[1].length
	} catch (e) {
	}
	try {
		m += s2.split(".")[1].length
	} catch (e) {
	}
	return Number(s1.replace(".", "")) * Number(s2.replace(".", ""))
			/ Math.pow(10, m)
}
// 给Number类型增加一个mul方法，调用起来更加方便。
Number.prototype.mul = function(arg) {
	return accMul(arg, this);
}

/** 
 * <p>
 * 加法函数，用来得到精确的加法结果<br/>
 * 说明：javascript的加法结果会有误差，在两个浮点数相加的时候会比较明显。这个函数返回较为精确的加法结果。<br/>
 * 调用：accAdd(arg1,arg2)<br/>
 * </p>
 * @return arg1加上arg2的精确结果
 */
function accAdd(arg1, arg2) {
	var r1, r2, m;
	try {
		r1 = arg1.toString().split(".")[1].length;
	} catch (e) {
		r1 = 0;
	}
	try {
		r2 = arg2.toString().split(".")[1].length;
	} catch (e) {
		r2 = 0;
	}
	m = Math.pow(10, Math.max(r1, r2));
	var result=(arg1 * m + arg2 * m) / m;
	return result.toFixed(2);
}
// 给Number类型增加一个add方法，调用起来更加方便。
Number.prototype.add = function(arg) {
	return accAdd(arg, this);
}

// 在你要用的地方包含这些函数，然后调用它来计算就可以了。
// 比如你要计算：7*0.8 ，则改成 (7).mul(8)
// 其它运算类似，就可以得到比较精确的结果。

/** 
 * <p>
 * 减法函数(绝对值)
 * </p>
 * @return arg1与arg2相减的精确结果(绝对值)
 */
function accSub(arg1, arg2) {
	var r1, r2, m, n;
	try {
		r1 = arg1.toString().split(".")[1].length;
	} catch (e) {
		r1 = 0;
	}
	try {
		r2 = arg2.toString().split(".")[1].length;
	} catch (e) {
		r2 = 0;
	}
	m = Math.pow(10, Math.max(r1, r2));
	//动态控制精度长度
	n = 2;
	//从网上直接拷贝过来发现有点bug，有的时候会变成负数，所以只要发现是负数，就变成正数
	if(((arg2 * m - arg1 * m) / m).toFixed(n)<0){
		return -(((arg2 * m - arg1 * m) / m).toFixed(n));
	}
	return ((arg2 * m - arg1 * m) / m).toFixed(n);
}

/** 
 * <p>
 * 减法函数
 * </p>
 * @return arg1减去arg2的精确结果
 */
function Subtr(arg1, arg2) {
	var r1, r2, m, n;
	try {
		r1 = arg1.toString().split(".")[1].length
	} catch (e) {
		r1 = 0
	}
	try {
		r2 = arg2.toString().split(".")[1].length
	} catch (e) {
		r2 = 0
	}
	m = Math.pow(10, Math.max(r1, r2));
	// last modify by deeka
	// 动态控制精度长度
	n = (r1 >= r2) ? r1 : r2;
	return ((arg1 * m - arg2 * m) / m).toFixed(n);
}
