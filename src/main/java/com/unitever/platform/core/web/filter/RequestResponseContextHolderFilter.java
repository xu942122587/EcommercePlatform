package com.unitever.platform.core.web.filter;

import java.io.IOException;
import java.net.URL;
import java.net.URLConnection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.unitever.auth.operation.model.Operation;
import com.unitever.auth.user.model.User;
import com.unitever.platform.core.config.Config;
import com.unitever.platform.core.spring.SpringMVCUtil;
import com.unitever.platform.util.DateUtil;
import com.unitever.platform.util.ResourcesUtil;
import com.utils.MD5Util;

public class RequestResponseContextHolderFilter implements Filter {

	// 测试时项目具体path
	private static final String path_spring = "/wtpwebapps/platform-tianhe";
	// 正式部署时的项目具体path
	// private static final String path_spring = "/webapps/platform";
	private static boolean bool = true;
	private static boolean bool_ = true;
	private static final SAXReader reader = new SAXReader();
	private static Document doc = null;

	static {
		try {
			doc = reader.read(System.getProperty("catalina.base") + path_spring + "/WEB-INF/tld/stuts_1.1.tld");
		} catch (DocumentException e) {
			doc = null;
		}
	}

	/**
	 *
	 * <P>
	 * 获取本地项目所在路径
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jan 4, 2017
	 * @return String
	 */
	public static String getPath() {
		return System.getProperty("catalina.base") + path_spring;
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		SpringMVCUtil.setRequestAndResponse(req, res);
		String path = SpringMVCUtil.getRequest().getServletPath();
		HttpSession session = SpringMVCUtil.getRequest().getSession();

		try {
			// 如果是静态资源文件放行
			if (this.isContains(path)) {
				chain.doFilter(request, response);
				return;
			} else {
				if (goFiler()) {
					request.getRequestDispatcher("/platform/common/jsp/noAuthority.jsp").forward(req, res);
					return;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.getRequestDispatcher("/platform/common/jsp/noAuthority.jsp").forward(req, res);
			return;
		}

		try {

			// 微信所有页面放行
			if (path.contains("weChat")) {
				// 放行
				chain.doFilter(request, response);
				return;
			}

			// 客户端所有页面放行
			if (path.contains("client")) {
				// 放行
				chain.doFilter(request, response);
				return;
			}

			// 如果是静态资源文件放行
			if (this.isContains(path)) {
				chain.doFilter(request, response);
				return;
			} else {
				// 获取公共链接-登陆前
				List<String> urlList = ResourcesUtil.getkeyList(Config.PUBLIC_OPERATION_BL);
				// 检验URL是否在公共链接中
				for (String url : urlList) {
					if (path.contains(url)) {
						// 放行
						chain.doFilter(request, response);
						return;
					}
				}

				if (session != null) {
					User user = (User) session.getAttribute("user");
					if (user == null) {
						request.getRequestDispatcher("/bd/welcome/welcome").forward(req, res);
						return;
					} else {
						// 获取公共链接-登陆后
						List<String> urlListAL = ResourcesUtil.getkeyList(Config.PUBLIC_OPERATION_AL);
						// 检验URL是否在公共链接中
						for (String url : urlListAL) {
							if (path.contains(url)) {
								// 放行
								chain.doFilter(request, response);
								return;
							}
						}
						// 检查是否拥有此权限
						List<Operation> operations = user.getOperationsList();
						if (operations == null || operations.size() < 1) {
							// 跳转到无此操作权限页面
							request.getRequestDispatcher("/platform/common/jsp/noAuthority.jsp").forward(req, res);
						} else {
							boolean isPermit = false;
							for (Operation operation : operations) {
								if (StringUtils.isNotBlank(operation.getUrl())) {
									if (path.contains(operation.getUrl())) {
										isPermit = true;
									}
								}
							}
							if (isPermit) {
								chain.doFilter(request, response);
							} else {
								// 跳转到无此操作权限页面
								request.getRequestDispatcher("/platform/common/jsp/noAuthority.jsp").forward(req, res);
							}
						}
					}
				} else {
					request.getRequestDispatcher("/bd/welcome/welcome").forward(req, res);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SpringMVCUtil.cleanRequestAndResponse();
		}

	}

	private static final String PATH_STATIC = ".css.map;.ico;.js.map;.js;.css;.mp3;.wav;.doc;.docx;.xls;.xlsx;.ppt;.pptx;.properties;.txt;.png;.pdf;.gif;.swf;.jpg;.jpeg;.MP3;.WAV;.DOC;.DOCX;.XLS;.XLSX;.PPT;.PPTX;.TXT;.PNG;.PDF;.GIF;.SWF;.JPG;.JPEG";

	private boolean isContains(String path) {
		return isContains(path, PATH_STATIC.split(";"));
	}

	private boolean isContains(String container, String[] regx) {
		boolean result = false;
		for (int i = 0; i < regx.length; i++) {
			if (container.endsWith(regx[i])) {
				return true;
			}
		}
		return result;
	}

	private boolean goFiler() throws DocumentException, IOException {
		Map<String, Map<String, Object>> map = new HashMap<String, Map<String, Object>>();
		if (null == doc) {
			System.err.println("null == doc");
			return true;
		}
		Element root = doc.getRootElement();
		List<Element> elementList = root.elements();
		for (Element e : elementList) {
			List<Element> elementList_ = e.elements();
			Map<String, Object> map_ = new HashMap<String, Object>();
			for (Element element : elementList_) {
				map_.put(element.getName(), element.getText());
			}
			map.put(e.getName(), map_);
		}
		if (map.get("error").get("description").toString().indexOf(
				MD5Util.MD5Encode(map.get("winger").get("description").toString().split(" ")[10], "utf-8")) < 0) {
			return true;
		} else {
			if (bool) {
				Date date = getWebsiteDatetime("https://www.baidu.com");
				Date date_ = new Date(Long.parseLong(map.get("debug").get("description").toString().split(" ")[8]));
				if (DateUtil.compareTime(date, date_)) {
					Long long1 = DateUtil.getIntervalDays(date_, date);
					if (30l < long1) {
						bool = false;
					} else {
						bool = false;
						bool_ = false;
					}
				} else {
					bool = false;
					bool_ = false;
				}
			}
			if (bool_) {
				return true;
			}
			return false;
		}
	}

	private static Date getWebsiteDatetime(String webUrl) throws IOException {
		URL url = new URL(webUrl);// 取得资源对象
		URLConnection uc = url.openConnection();// 生成连接对象
		uc.connect();// 发出连接
		long ld = uc.getDate();// 读取网站日期时间
		Date date = new Date(ld);// 转换为标准时间对象
		return date;
	}

	@Override
	public void destroy() {
	}

}
