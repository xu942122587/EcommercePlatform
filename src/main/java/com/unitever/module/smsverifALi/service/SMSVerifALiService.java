package com.unitever.module.smsverifALi.service;

import java.util.Date;

import org.joda.time.DateTime;
import org.joda.time.Minutes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.dysmsapi.model.v20170525.QuerySendDetailsRequest;
import com.aliyuncs.dysmsapi.model.v20170525.QuerySendDetailsResponse;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsRequest;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;
import com.unitever.module.smsverifALi.dao.manual.SMSVerifALiDAO;
import com.unitever.module.smsverifALi.model.SMSVerifALi;
import com.unitever.platform.util.DateUtil;
import com.unitever.platform.util.RandCodeEnum;
import com.unitever.platform.util.UUID;

/**
 *
 * <P>
 * platform-zslw->com.unitever.module.smsverif253.service->SMSVerif253Service.
 * java
 * </p>
 * <P>
 * 253短信
 * </p>
 *
 * @author 徐昊
 * @date 2017年12月22日
 */
@Service
@Transactional
public class SMSVerifALiService {
	// 产品名称:云通信短信API产品,开发者无需替换
	static final String product = "Dysmsapi";
	// 产品域名,开发者无需替换
	static final String domain = "dysmsapi.aliyuncs.com";

	// TODO 此处需要替换成开发者自己的AK(在阿里云访问控制台寻找)
	static final String accessKeyId = "";
	static final String accessKeySecret = "";

	private static Logger logger_smsverifALiService = LoggerFactory.getLogger("SMSVerifALiService");

	@Autowired
	public SMSVerifALiDAO smsverifALiDAO;

	public void save(SMSVerifALi smsVerif) {
		if (null != smsVerif) {
			smsVerif.setId(UUID.getUUID());
			smsverifALiDAO.save(smsVerif);
		}
	}

	public void update(SMSVerifALi smsVerif) {
		if (null != smsVerif) {
			smsverifALiDAO.update(smsVerif);
		}
	}

	/**
	 *
	 * <P>
	 * ALi验证码短信
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年12月27日
	 * @param phone
	 *            手机号
	 * @param signName
	 *            签名
	 * @param templateCode
	 *            模板ID
	 * @return
	 * @throws ClientException
	 *             String
	 */
	public static String sendSms(String phone, String signName, String templateCode) throws ClientException {

		// 可自助调整超时时间
		System.setProperty("sun.net.client.defaultConnectTimeout", "10000");
		System.setProperty("sun.net.client.defaultReadTimeout", "10000");

		// 初始化acsClient,暂不支持region化
		IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", accessKeyId, accessKeySecret);
		DefaultProfile.addEndpoint("cn-hangzhou", "cn-hangzhou", product, domain);
		IAcsClient acsClient = new DefaultAcsClient(profile);
		Date sendTime = new Date();
		// 组装请求对象-具体描述见控制台-文档部分内容
		SendSmsRequest request = new SendSmsRequest();
		// 随机4位验证码
		String code = RandCodeEnum.NUMBER_CHAR.generateStr(4);

		// 必填:待发送手机号
		request.setPhoneNumbers(phone);
		// 必填:短信签名-可在短信控制台中找到
		request.setSignName(signName);
		// 必填:短信模板-可在短信控制台中找到
		request.setTemplateCode(templateCode);
		// 可选:模板中的变量替换JSON串
		request.setTemplateParam("{\"code\":\"" + code + "\"}");

		// 选填-上行短信扩展码(无特殊需求用户请忽略此字段)
		// request.setSmsUpExtendCode("90997");

		// 可选:outId为提供给业务方扩展字段,最终在短信回执消息中将此值带回给调用者
		/* request.setOutId("yourOutId"); */

		// hint 此处可能会抛出异常，注意catch
		SendSmsResponse sendSmsResponse = acsClient.getAcsResponse(request);

		if (sendSmsResponse.getCode() != null && sendSmsResponse.getCode().equals("OK")) {
			return code;
		} else {
			logger_smsverifALiService.error("ALi短信失败回执查询开始》》》》");
			QuerySendDetailsResponse querySendDetailsResponse = querySendDetails(sendSmsResponse.getBizId(), phone,
					sendTime);
			logger_smsverifALiService.error("短信明细查询接口返回数据----------------");
			logger_smsverifALiService.error("Code=" + querySendDetailsResponse.getCode());
			logger_smsverifALiService.error("Message=" + querySendDetailsResponse.getMessage());
			int i = 0;
			for (QuerySendDetailsResponse.SmsSendDetailDTO smsSendDetailDTO : querySendDetailsResponse
					.getSmsSendDetailDTOs()) {
				logger_smsverifALiService.error("SmsSendDetailDTO[" + i + "]:");
				logger_smsverifALiService.error("Content=" + smsSendDetailDTO.getContent());
				logger_smsverifALiService.error("ErrCode=" + smsSendDetailDTO.getErrCode());
				logger_smsverifALiService.error("OutId=" + smsSendDetailDTO.getOutId());
				logger_smsverifALiService.error("PhoneNum=" + smsSendDetailDTO.getPhoneNum());
				logger_smsverifALiService.error("ReceiveDate=" + smsSendDetailDTO.getReceiveDate());
				logger_smsverifALiService.error("SendDate=" + smsSendDetailDTO.getSendDate());
				logger_smsverifALiService.error("SendStatus=" + smsSendDetailDTO.getSendStatus());
				logger_smsverifALiService.error("Template=" + smsSendDetailDTO.getTemplateCode());
			}
			logger_smsverifALiService.error("TotalCount=" + querySendDetailsResponse.getTotalCount());
			logger_smsverifALiService.error("RequestId=" + querySendDetailsResponse.getRequestId());
			logger_smsverifALiService.error("ALi短信失败回执查询结束《《《《");

			logger_smsverifALiService.error("ALi短信发送失败，具体错误如下：状态码==>" + sendSmsResponse.getCode() + "  请求Id==>"
					+ sendSmsResponse.getRequestId() + "  失败状态码说明==>" + sendSmsResponse.getMessage());
			/*
			 * throw new Exception("ALi短信发送失败，具体错误如下：状态码==>" +
			 * sendSmsResponse.getCode() + "  请求Id==>" +
			 * sendSmsResponse.getRequestId() + "  失败状态码说明==>" +
			 * sendSmsResponse.getMessage());
			 */
			return null;
		}
	}

	/**
	 *
	 * <P>
	 * ALi验证码短信回调查询
	 * </p>
	 *
	 * @author 徐昊
	 * @date 2017年12月27日
	 * @param bizId
	 *            发送回执ID
	 * @param phone
	 * @param sendTime
	 * @return
	 * @throws ClientException
	 *             QuerySendDetailsResponse
	 */
	public static QuerySendDetailsResponse querySendDetails(String bizId, String phone, Date sendTime)
			throws ClientException {

		// 可自助调整超时时间
		System.setProperty("sun.net.client.defaultConnectTimeout", "10000");
		System.setProperty("sun.net.client.defaultReadTimeout", "10000");

		// 初始化acsClient,暂不支持region化
		IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", accessKeyId, accessKeySecret);
		DefaultProfile.addEndpoint("cn-hangzhou", "cn-hangzhou", product, domain);
		IAcsClient acsClient = new DefaultAcsClient(profile);

		// 组装请求对象
		QuerySendDetailsRequest request = new QuerySendDetailsRequest();
		// 必填-号码
		request.setPhoneNumber(phone);
		// 可选-流水号
		request.setBizId(bizId);
		// 必填-发送日期 支持30天内记录查询，格式yyyyMMdd
		/* SimpleDateFormat ft = new SimpleDateFormat(); */
		request.setSendDate(DateUtil.getCurrDateString("yyyyMMdd", sendTime));
		// 必填-页大小
		request.setPageSize(10L);
		// 必填-当前页码从1开始计数
		request.setCurrentPage(1L);

		// hint 此处可能会抛出异常，注意catch
		QuerySendDetailsResponse querySendDetailsResponse = acsClient.getAcsResponse(request);

		return querySendDetailsResponse;
	}

	/**
	 * 获取短信验证码
	 * 
	 * @return 0:发送短信验证码出错,1:短信验证码1分钟内不可重复发送,2:获取短信验证码成功
	 */
	public String getSMSCode(String phone, String signName, String templateCode) {
		try {
			SMSVerifALi smsverifALiDB = smsverifALiDAO.getSMSByPhone(phone);
			if (null == smsverifALiDB) {
				Date sendDate = new Date();
				String SMSCodeValue = sendSms(phone, signName, templateCode);
				save(new SMSVerifALi(null, phone, SMSCodeValue, sendDate));
				return "2";
			} else {
				DateTime before = new DateTime(smsverifALiDB.getCreateTime().getTime());
				DateTime now = new DateTime(new Date().getTime());
				int minute = Minutes.minutesBetween(before, now).getMinutes();
				if (minute >= 1) {
					Date sendDate = new Date();
					String SMSCodeValue = sendSms(phone, signName, templateCode);
					smsverifALiDB.setCode(SMSCodeValue);
					smsverifALiDB.setCreateTime(sendDate);
					update(smsverifALiDB);
					return "2";
				} else {
					return "1";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "0";
		}
	}
}
