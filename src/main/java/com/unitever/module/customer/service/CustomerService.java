package com.unitever.module.customer.service;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.joda.time.DateTime;
import org.joda.time.Minutes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONObject;
import com.unitever.auth.user.model.User;
import com.unitever.auth.user.service.UserService;
import com.unitever.module.customer.dao.manual.CustomerDAO;
import com.unitever.module.customer.model.Customer;
import com.unitever.module.employee.model.Employee;
import com.unitever.module.employee.service.EmployeeService;
import com.unitever.module.eticketoutRecord.service.EticketOutRecordService;
import com.unitever.module.rechargeRecord.model.RechargeRecord;
import com.unitever.module.rechargeRecord.service.RechargeRecordService;
import com.unitever.module.smsverifALi.dao.manual.SMSVerifALiDAO;
import com.unitever.module.smsverifALi.model.SMSVerifALi;
import com.unitever.module.smsverifALi.service.SMSVerifALiService;
import com.unitever.module.weChat.service.WeChatService;
import com.unitever.module.weChat.util.WeChatUtil;
import com.unitever.platform.component.attachment.service.AttachmentConfigService;
import com.unitever.platform.core.common.model.AjaxJson;
import com.unitever.platform.core.dao.Page;
import com.unitever.platform.util.ExceptionUtil;
import com.unitever.platform.util.FileUtil;
import com.unitever.platform.util.RandCodeEnum;
import com.unitever.platform.util.ThreadPoolUtil;
import com.unitever.platform.util.UUID;

@Service
@Transactional
public class CustomerService {

	@Autowired
	private CustomerDAO customerDAO;
	@Autowired
	private AttachmentConfigService attachmentConfigService;
	@Autowired
	private SMSVerifALiDAO smsVerifALiDAO;
	@Autowired
	private SMSVerifALiService smsVerifALiService;
	@Autowired
	private WeChatService weChatService;
	@Autowired
	private EticketOutRecordService eticketOutRecordService;
	@Autowired
	private UserService userService;
	@Autowired
	private EmployeeService employeeService;
	@Autowired
	private RechargeRecordService rechargeRecordService;

	private Logger logger_customerService = LoggerFactory.getLogger("CustomerService");

	/**
	 * 保存新信息
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param customer
	 *            void
	 */
	public int save(Customer customer) {
		if (customer != null) {
			customer.setId(UUID.getUUID());
			customer.setIsBlank(Customer.ISBLANK_FALSE);
			customer.setCreateTime(new Date());
			return customerDAO.save(customer);
		}
		return 0;
	}

	/**
	 * 更新数据
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param customer
	 * @return int
	 */
	public int update(Customer customer) {
		if (null != customer) {
			if (StringUtils.isNotBlank(customer.getId())) {
				return customerDAO.update(customer);
			}
		}
		return 0;
	}

	/**
	 * 更新信息
	 * 
	 * @author XiaoYu
	 * @date 2017年1月3日
	 * @param customer
	 * @return AjaxJson
	 */
	public AjaxJson updateInfo(Customer customer) {
		AjaxJson json = new AjaxJson();
		json.setSuccess(false);
		String filePath = attachmentConfigService.getAttachmentConfigDefault().getSaveDir();
		if (StringUtils.isNotBlank(customer.getHeadImgurl())) {
			try {
				FileUtil.bindFile(customer.getHeadImgurl(), filePath);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		int count = customerDAO.update(customer);
		if (count > 0) {
			json.setSuccess(true);
			json.setMsg("更新信息成功</br>1秒后返回个人中心！");
		} else {
			json.setMsg("更新信息失败！");
		}
		return json;
	}

	/**
	 * 根据Id获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param id
	 * @return Customer
	 */
	public Customer getCustomerById(String id) {
		if (StringUtils.isNotBlank(id)) {
			return customerDAO.get(id);
		}
		return null;
	}

	/**
	 * 根据Object获取
	 * 
	 * @author XiaoYu
	 * @date 2016年12月23日
	 * @param customer
	 * @return List<Customer>
	 */
	public List<Customer> getCustomerByCustomer(Customer customer) {
		return customerDAO.getCustomerByCustomer(customer);
	}

	/**
	 * 获取符合当前条件的Customer数量
	 * 
	 * @author XiaoYu
	 * @date 2016年12月28日
	 * @param customer
	 * @return int
	 */
	public int getCountByCustomer(Customer customer) {
		return customerDAO.getCountByObject(customer);
	}

	/**
	 *
	 * <P>
	 * 获取customer分页对象
	 * </p>
	 *
	 * @author 闫枫
	 * @date Dec 24, 2016
	 * @param page
	 * @param customer
	 * @return Page<Customer>
	 */
	public Page<Customer> getPage(Page<Customer> page, Customer customer) {
		if (StringUtils.isNotBlank(customer.getEndDate())) {
			customer.setEndDate(customer.getEndDate() + " 23:59:59");
		}
		page.setTotalRecord(customerDAO.getCountByObject(customer));
		customer.setStartOfPage(page.getStartOfPage());
		customer.setPageSize(page.getPageSize());
		page.setResults(customerDAO.getCustomerByCustomer(customer));
		if (StringUtils.isNotBlank(customer.getEndDate())) {
			customer.setEndDate(customer.getEndDate().split(" ")[0]);
		}
		return page;
	}

	/**
	 *
	 * <P>
	 * 获取有推荐人的用户并根据推荐人分组
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月9日
	 * @return List<Customer>
	 */
	public List<Customer> getHaveGuideUserCustomer(String username) {
		return customerDAO.getHaveGuideUserCustomer(username);
	}

	/**
	 *
	 * <P>
	 * 获取有推荐人的用户并根据推荐人分组
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月9日
	 * @return List<Customer>
	 */
	public List<Customer> getCustomerByguideUserId(String guideUserId) {
		return customerDAO.getCustomerByguideUserId(guideUserId);
	}

	/**
	 * 登陆
	 * 
	 * @author XiaoYu
	 * @date 2016年12月29日
	 * @param model
	 * @return AjaxJson
	 */
	public AjaxJson loginVerification(Customer model) {
		AjaxJson json = new AjaxJson();
		json.setSuccess(false);

		Customer customer = new Customer();
		customer.setPhone(model.getPhone());

		List<Customer> list = getCustomerByCustomer(customer);
		if (list.size() != 0) {
			if (list.get(0).getLoginPassword().equals(model.getLoginPassword())) {
				json.setSuccess(true);
				list.get(0).setEmployee(model.getEmployee());
				update(list.get(0));
			} else {
				json.setMsg("用户名密码错误，请重新输入!");
			}
		} else {
			json.setMsg("手机号错误或尚未注册！");
		}

		return json;
	}

	/**
	 *
	 * <P>
	 * 退出登陆
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月31日
	 * @param model
	 * @return int
	 */
	public int doLogOutService(Customer model) {
		List<Customer> list = getCustomerByCustomer(model);
		int tmp = customerDAO.doLogout(list.get(0));
		if (tmp > 0) {
			return tmp;
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 更新密码
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月1日
	 * @param customer
	 * @param smsCode
	 * @param newPassword
	 * @return AjaxJson
	 */
	public AjaxJson updatePassword(Customer customer, String smsCode, String newPassword) {
		AjaxJson json = new AjaxJson();
		json.setSuccess(false);
		json.setMsg("修改失败了，再试试把~");
		// 先看看验证码是否正确
		SMSVerifALi smsverify = null;
		SMSVerifALi smsSearch = new SMSVerifALi();
		smsSearch.setPhone(customer.getPhone());
		smsSearch.setCode(smsCode);
		List<SMSVerifALi> list = smsVerifALiDAO.getSMSVerifListWithSMSVerif(smsSearch);
		if (list.isEmpty() || list.get(0) == null) {
			json.setSuccess(false);
			json.setMsg("验证码错误，先去检查一下吧~");
			return json;
		}
		// 再看看验证码是否过期
		DateTime before = new DateTime(list.get(0).getCreateTime().getTime());
		DateTime now = new DateTime(new Date().getTime());
		int minute = Minutes.minutesBetween(before, now).getMinutes();
		if (minute >= 10) {
			json.setSuccess(false);
			json.setMsg("验证码过期，重新获取一个吧~");
			return json;
		} else {
			smsVerifALiDAO.deleteByPhone(customer.getPhone());
		}

		customer.setLoginPassword(newPassword);
		this.update(customer);
		json.setSuccess(true);
		json.setMsg("修改密码成功");
		return json;
	}

	/**
	 *
	 * <P>
	 * 更新支付密码
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年8月1日
	 * @param customer
	 * @param smsCode
	 * @param newPassword
	 * @return AjaxJson
	 */
	public AjaxJson updatePayPassword(Customer customer, String smsCode, String newPassword) {
		AjaxJson json = new AjaxJson();
		json.setSuccess(false);
		json.setMsg("修改失败了，再试试把~");
		// 先看看验证码是否正确
		SMSVerifALi smsverify = null;
		SMSVerifALi smsSearch = new SMSVerifALi();
		smsSearch.setPhone(customer.getPhone());
		smsSearch.setCode(smsCode);
		List<SMSVerifALi> list = smsVerifALiDAO.getSMSVerifListWithSMSVerif(smsSearch);
		if (list.isEmpty() || list.get(0) == null) {
			json.setSuccess(false);
			json.setMsg("验证码错误，先去检查一下吧~");
			return json;
		}
		// 再看看验证码是否过期
		DateTime before = new DateTime(list.get(0).getCreateTime().getTime());
		DateTime now = new DateTime(new Date().getTime());
		int minute = Minutes.minutesBetween(before, now).getMinutes();
		if (minute >= 10) {
			json.setSuccess(false);
			json.setMsg("验证码过期，重新获取一个吧~");
			return json;
		} else {
			smsVerifALiDAO.deleteByPhone(customer.getPhone());
		}

		customer.setPayPassword(newPassword);
		this.update(customer);
		json.setSuccess(true);
		json.setMsg("修改支付密码成功");
		return json;
	}

	/**
	 * 注册
	 * 
	 * @author XiaoYu
	 * @date 2017年2月25日
	 * @param customer
	 * @param smsCode
	 * @param employeeId
	 * @return AjaxJson
	 */
	public AjaxJson saveRegister(Customer customer, String smsCode, String employeeId) {
		AjaxJson ajaxJson = new AjaxJson();
		ajaxJson.setSuccess(false);
		ajaxJson.setMsg("注册失败了，再试试把~");
		// 先看看验证码是否正确
		SMSVerifALi smsverify = null;
		SMSVerifALi smsSearch = new SMSVerifALi();
		smsSearch.setPhone(customer.getPhone());
		smsSearch.setCode(smsCode);
		List<SMSVerifALi> list = smsVerifALiDAO.getSMSVerifListWithSMSVerif(smsSearch);
		if (list.isEmpty() || list.get(0) == null) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("验证码错误，先去检查一下吧~");
			return ajaxJson;
		}
		// 再看看验证码是否过期
		DateTime before = new DateTime(list.get(0).getCreateTime().getTime());
		DateTime now = new DateTime(new Date().getTime());
		int minute = Minutes.minutesBetween(before, now).getMinutes();
		if (minute >= 3) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("验证码过期，重新获取一个吧~");
			return ajaxJson;
		} else {
			smsVerifALiDAO.deleteByPhone(customer.getPhone());
		}
		customer.setId(UUID.getUUID());
		customer.setEmployee(new Employee(employeeId));
		customer.setIsBlank(Customer.ISBLANK_FALSE);
		customer.setCreateTime(new Date());
		// 保存信息
		if (0 < customerDAO.save(customer)) {
			eticketOutRecordService.sendEticketRegister(customer.getId());
			customer.setEmployee(employeeService.getEmployeeById(employeeId));
			final Customer customer1 = customer;
			ThreadPoolUtil.getPool().execute(new Runnable() {
				@Override
				public void run() {
					try {
						WeChatUtil.sendCustomerRegister(customer1, weChatService.getWeChatList().get(0));
					} catch (Exception e) {
						logger_customerService.error("会员注册成功通知模板消息出错，具体错误如下："
								+ ExceptionUtil.getExceptionAllinformation(e, this.getClass().getName()));
					}
				}
			});
			ajaxJson.setSuccess(true);
			ajaxJson.setMsg("注册成功，祝您购物愉快");
		} else {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("注册失败了，请刷新页面重试~");
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 通过微信用户ID获取系统中注册的客户ID（客户绑定的微信号即微信用户ID）
	 * </p>
	 *
	 * @author 闫枫
	 * @date Jan 9, 2017
	 * @param employeeId
	 * @return Object
	 */
	public Customer getCustomerByEmployeeId(String employeeId) {
		if (StringUtils.isNotBlank(employeeId))
			return customerDAO.getCustomerByEmployeeId(employeeId);
		return null;
	}

	/**
	 *
	 * <P>
	 * 注册时 获取短信验证码
	 * </p>
	 *
	 * @author 闫枫
	 * @date Oct 12, 2016
	 * @param phone
	 * @return
	 */
	public AjaxJson getSMSCodeR(String phone) {
		AjaxJson ajaxJson = new AjaxJson();
		// 默认获取验证码出错
		ajaxJson.setSuccess(false);
		ajaxJson.setMsg("获取验证码失败！");
		if (StringUtils.isBlank(phone)) {
			ajaxJson.setMsg("手机号不可为空~");
			return ajaxJson;
		}
		// 看看之前是否已经注册
		Customer customer = new Customer();
		customer.setPhone(phone);
		if (0 >= customerDAO.getCountByCustomerForRegist(customer)) {
			// 调用获取短信验证码
			// TODO 短信签名和模板
			String SMSCodeReturnMsg = smsVerifALiService.getSMSCode(phone, SMSVerifALi.SIGNNAME_TWO,
					SMSVerifALi.TEMPLATECODE_TWO);
			if ("0".equals(SMSCodeReturnMsg)) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("获取验证码出错了~稍后再试试吧~");
			} else if ("1".equals(SMSCodeReturnMsg)) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("一分钟内不可以重复获取验证码哦~");
			} else if ("2".equals(SMSCodeReturnMsg)) {
				ajaxJson.setSuccess(true);
				ajaxJson.setMsg("获取验证码成功");
			}
			return ajaxJson;
		} else {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("该手机号已注册，不可重复注册~");
			return ajaxJson;
		}
	}

	/**
	 *
	 * <P>
	 * 忘记密码 获取短信验证码
	 * </p>
	 *
	 * @author 闫枫
	 * @date Oct 12, 2016
	 * @param phone
	 * @return
	 */
	public AjaxJson getSMSCodeF(String phone) {
		AjaxJson ajaxJson = new AjaxJson();
		// 默认获取验证码出错
		ajaxJson.setSuccess(false);
		ajaxJson.setMsg("获取验证码失败！");
		// 看看之前是否已经注册
		Customer customer = new Customer();
		customer.setPhone(phone);
		if (0 < customerDAO.getCountByObject(customer)) {
			// 调用获取短信验证码
			// TODO 短信签名和模板
			String SMSCodeReturnMsg = smsVerifALiService.getSMSCode(phone, SMSVerifALi.SIGNNAME_TWO,
					SMSVerifALi.TEMPLATECODE_TWO);
			if ("0".equals(SMSCodeReturnMsg)) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("获取验证码出错了~稍后再试试吧~");
			} else if ("1".equals(SMSCodeReturnMsg)) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("一分钟内不可以重复获取验证码哦~");
			} else if ("2".equals(SMSCodeReturnMsg)) {
				ajaxJson.setSuccess(true);
				ajaxJson.setMsg("获取验证码成功");
			}
			return ajaxJson;
		} else {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("该手机号未注册，请先注册~");
			return ajaxJson;
		}
	}

	/**
	 *
	 * <P>
	 * 获取所有客户list
	 * </p>
	 *
	 * @author 闫枫
	 * @date Mar 15, 2017
	 * @return List<Customer>
	 */
	public List<Customer> getAll() {
		return customerDAO.getAll();
	}

	/**
	 *
	 * <P>
	 * 拉黑会员
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年7月6日
	 * @param id
	 * @return int
	 */
	public int doIsBlank(String id) {
		if (StringUtils.isNotBlank(id)) {
			Customer customer = new Customer(id);
			customer.setIsBlank("2");
			return customerDAO.update(customer);
		}
		return 0;
	}

	/**
	 *
	 * <P>
	 * 通过手机号获取会员信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 10, 2017
	 * @param phone
	 * @return Customer
	 */
	public Customer getCustomerByPhone(String phone) {
		return StringUtils.isNotBlank(phone) ? customerDAO.getCustomerByPhone(phone) : null;
	}

	/**
	 *
	 * <P>
	 * 发送天和钱包支付动态密码
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 29, 2017
	 * @param customerPhone
	 * @return AjaxJson
	 */
	public AjaxJson sendCustomerPayCode(String customerPhone) {
		AjaxJson ajaxJson = new AjaxJson();
		Customer customer = customerDAO.getCustomerByPhone(customerPhone);
		if (null == customer || StringUtils.isBlank(customer.getId())) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("该手机号未注册为会员~");
			return ajaxJson;
		} else if (null == customer.getEmployee() || StringUtils.isBlank(customer.getEmployee().getOpenid())) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("客户未在微信端登陆，请引导客户去往微信端登陆~");
			return ajaxJson;
		}
		String payCode = RandCodeEnum.NUMBER_CHAR.generateStr(4);
		boolean isSuccess = false;
		for (int i = 0; i < 10; i++) {
			if (0 < customerDAO.sendCustomerPayCode(customerPhone, payCode)) {
				customer = customerDAO.getCustomerByPhone(customerPhone);
				isSuccess = true;
				ajaxJson.setSuccess(true);
				ajaxJson.setMsg("发送支付动态密码成功~");
				ajaxJson.setObj(customer.getId());
				WeChatUtil.sendCustomerPayCode(customer, weChatService.getWeChatList().get(0));
			}
			if (isSuccess)
				break;
		}
		if (!isSuccess) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("发送支付动态密码失败，请重试~");
		}
		return ajaxJson;
	}

	public AjaxJson rechargeWithInline(HttpServletRequest request, String employeeId, String guideUserId,
			String rechargeMoney) {
		AjaxJson ajaxJson = new AjaxJson();
		Customer customer = this.getCustomerByEmployeeId(employeeId);
		if (null != customer && StringUtils.isNotBlank(customer.getId())) {
			User guideUser = userService.getUserWithId(guideUserId);
			RechargeRecord rechargeRecord = rechargeRecordService.creatRechargeRecord(customer, rechargeMoney,
					guideUser, RechargeRecord.PAYTYPE_THREE);
			if (null == rechargeRecord || StringUtils.isBlank(rechargeRecord.getId())) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("保存充值记录失败,请稍后重试~");
			} else if (0 >= rechargeRecordService.save(rechargeRecord)) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("保存充值记录失败,请重试~");
			} else {
				ajaxJson.setSuccess(true);
				ajaxJson.setMsg("即将调起微信支付~");
				ajaxJson.setObj(weChatService.getWeChatPaymentJson_recharge(rechargeRecord, request, customer
						.getEmployee().getOpenid(), weChatService.getWeChatList().get(0).getWechatnum()));
			}
		} else {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("未登录，请稍后重试~");
		}
		return ajaxJson;
	}

	/**
	 *
	 * <P>
	 * 获取所有没被拉黑的客户列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 6, 2017
	 * @return Object
	 */
	public List<Customer> getAllNoBlankCustomer() {
		return customerDAO.getAllNoBlankCustomer();
	}

	/**
	 *
	 * <P>
	 * 获取本月过生日的所有会员列表
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 7, 2017
	 * @return List<Customer>
	 */
	public List<Customer> getThisMonthBirthdayCustomerList() {
		return customerDAO.getThisMonthBirthdayCustomerList();
	}

	/**
	 *
	 * <P>
	 * 根据导购获取上月的注册总人数
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年9月18日
	 * @param guideUserId
	 * @return String
	 */
	public String getCountCustomerByGuideUserInLastMonth(String guideUserId) {
		return customerDAO.getCountCustomerByGuideUserInLastMonth(guideUserId);
	}

	/**
	 *
	 * <P>
	 * 客户端获取会员信息
	 * </p>
	 *
	 * @author 闫枫
	 * @date Sep 12, 2017
	 * @param customerPhone
	 * @return AjaxJson
	 */
	public AjaxJson getClisentCustomerMsgByPhone(String customerPhone) {
		AjaxJson ajaxJson = new AjaxJson();
		if (StringUtils.isBlank(customerPhone)) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("获取客户信息失败，请联系技术人员~");
			logger_customerService.error("客户端获取客户信息传入客户手机为空，请检查代码实现！");
			return ajaxJson;
		}
		Customer customer = this.getCustomerByPhone(customerPhone);
		if (null == customer || StringUtils.isBlank(customer.getId())) {
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg("客户信息不存在，请检查手机号是否输入正确或是否注册为天和会员！");
			return ajaxJson;
		}
		ajaxJson.setSuccess(true);
		JSONObject customerJson = new JSONObject();
		customerJson.put("customerId", customer.getId());
		customerJson.put("customerName", customer.getName());
		ajaxJson.setObj(customerJson);
		return ajaxJson;
	}

}
