//当date1大于或等于date2返回true，日期类型为（2015-11-20）
function compareDate(date1,date2) {
	var d2 = new Date(date1.replace(/-/g, "/"));
	var d1 = new Date(date2.replace(/-/g, "/"));
	// 结束日期 等于 当前日期
	if (Date.parse(d1) - Date.parse(d2) == 0) {
		return true;
	}
	// 结束日期 大于 当前日期
	if (Date.parse(d1) - Date.parse(d2) < 0) {
		return true;
	}
	// 结束日期 小于 当前日期
	if (Date.parse(d1) - Date.parse(d2) > 0) {
		return false;
	}
	return true;
}

//当输入的日期值大于或等于当前日期返回true，日期类型为（2015-11-20）
function compareCurrentDate(date) {
	var d2 = new Date(date.replace(/-/g, "/"));
	var d1 = new Date(new Date().toLocaleDateString().replace("年", "/")
			.replace("月", "/").replace("日", ""));
	//结束日期 等于 当前日期
	if (Date.parse(d1) - Date.parse(d2) == 0) {
		return false;
	}
	//结束日期 大于 当前日期
	if (Date.parse(d1) - Date.parse(d2) < 0) {
		return true;
	}
	//结束日期 小于 当前日期
	if (Date.parse(d1) - Date.parse(d2) > 0) {
		return false;
	}
	return true;
}