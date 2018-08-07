package com.unitever.module.weChat.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.security.KeyManagementException;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.UnrecoverableKeyException;
import java.security.cert.CertificateException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Random;
import java.util.Set;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.UUID;

import javax.net.ssl.SSLContext;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.ssl.SSLContexts;
import org.apache.http.util.EntityUtils;

import com.unitever.module.weChat.model.WeChat;
import com.utils.MD5Util;

public class HongBaoUtil {
	public static final int FAIL = 0; // 领取失败
	public static final int SUCCESS = 1; // 领取成功

	private static String oldDateVal = null;
	private static Long code = 0l;

	/**
	 * 对请求参数名ASCII码从小到大排序后签名
	 * 
	 * @param openid
	 * @param userId
	 * @return
	 */
	public static void sign(SortedMap<String, String> params, String KEY) {
		Set<Entry<String, String>> entrys = params.entrySet();
		Iterator<Entry<String, String>> it = entrys.iterator();
		String result = "";
		while (it.hasNext()) {
			Entry<String, String> entry = it.next();
			result += entry.getKey() + "=" + entry.getValue() + "&";
		}
		result += "key=" + KEY;
		String sign = null;
		try {
			sign = MD5Util.MD5Encode(result, "UTF-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		params.put("sign", sign);
	}

	public static String getRequestXml(SortedMap<String, String> params) throws UnsupportedEncodingException {
		StringBuffer sb = new StringBuffer();
		sb.append("<xml>");
		Set es = params.entrySet();
		Iterator it = es.iterator();
		while (it.hasNext()) {
			Map.Entry entry = (Map.Entry) it.next();
			String k = (String) entry.getKey();
			String v = (String) entry.getValue();
			if ("nick_name".equalsIgnoreCase(k) || "send_name".equalsIgnoreCase(k) || "wishing".equalsIgnoreCase(k)
					|| "act_name".equalsIgnoreCase(k) || "remark".equalsIgnoreCase(k) || "sign".equalsIgnoreCase(k)) {
				sb.append("<" + k + ">" + "<![CDATA[" + v + "]]></" + k + ">");
			} else {
				sb.append("<" + k + ">" + v + "</" + k + ">");
			}
		}
		sb.append("</xml>");
		return sb.toString();
		// return new String(sb.toString().getBytes(), "ISO8859-1");
	}

	public static SortedMap<String, String> createMap(WeChat weChat, String ipValue, String billNo, String openid,
			int amount) {
		SortedMap<String, String> params = new TreeMap<String, String>();
		params.put("wxappid", weChat.getAppid());
		params.put("nonce_str", createNonceStr());
		params.put("mch_billno", billNo);
		params.put("mch_id", weChat.getMchid());
		params.put("send_name", weChat.getName());
		params.put("re_openid", openid);
		params.put("total_amount", amount + "");
		params.put("min_value", amount + "");
		params.put("max_value", amount + "");
		params.put("total_num", "1");
		params.put("wishing", weChat.getWishing());
		params.put("client_ip", ipValue);
		params.put("act_name", weChat.getActName());
		params.put("remark", weChat.getActRemark());
		return params;
	}

	/**
	 * 生成随机字符串
	 * 
	 * @return
	 */
	public static String createNonceStr() {
		return UUID.randomUUID().toString().toUpperCase().replace("-", "");
	}

	/**
	 * 生成商户订单号
	 * 
	 * @param mch_id
	 *            商户号
	 * @param userId
	 *            该用户的userID
	 * @return
	 */
	public static synchronized String createBillNo(String MCH_ID) {
		// 组成： mch_id+yyyymmdd+10位一天内不能重复的数字
		Date dt = new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat df_10 = new SimpleDateFormat("ddhhmm");
		// 获取一天内不重复的
		String nowDateValue = df_10.format(dt);
		if (oldDateVal != null) {
			if (oldDateVal.equals(nowDateValue)) {
				code++;
			} else {
				oldDateVal = nowDateValue;
				code = 0l;
			}
		} else {
			oldDateVal = nowDateValue;
			code = 0l;
		}

		Long m = Long.parseLong(nowDateValue) * 10000;
		m += code;
		return MCH_ID + df.format(dt) + m.toString();
	}

	/**
	 * 生成特定位数的随机数字
	 * 
	 * @param length
	 * @return
	 */
	public static String getRandomNum(int length) {
		String val = "";
		Random random = new Random();
		for (int i = 0; i < length; i++) {
			val += String.valueOf(random.nextInt(10));
		}
		return val;
	}

	public static String post(String requestXML, InputStream instream, String MCH_ID) throws KeyManagementException,
			UnrecoverableKeyException, NoSuchAlgorithmException, KeyStoreException, CertificateException, IOException {
		KeyStore keyStore = KeyStore.getInstance("PKCS12");
		try {
			keyStore.load(instream, MCH_ID.toCharArray());
		} finally {
			instream.close();
		}
		SSLContext sslcontext = SSLContexts.custom().loadKeyMaterial(keyStore, MCH_ID.toCharArray()).build();
		SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(sslcontext, new String[] { "TLSv1" }, null,
				SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);
		CloseableHttpClient httpclient = HttpClients.custom().setSSLSocketFactory(sslsf).build();
		String result = "";
		try {

			HttpPost httpPost = new HttpPost("https://api.mch.weixin.qq.com/mmpaymkttransfers/sendredpack");

			StringEntity reqEntity = new StringEntity(requestXML, "UTF-8");
			// 设置类型
			reqEntity.setContentType("application/x-www-form-urlencoded");
			httpPost.setEntity(reqEntity);
			CloseableHttpResponse response = httpclient.execute(httpPost);
			try {
				HttpEntity entity = response.getEntity();
				if (entity != null) {
					BufferedReader bufferedReader = new BufferedReader(
							new InputStreamReader(entity.getContent(), "UTF-8"));
					String text;
					while ((text = bufferedReader.readLine()) != null) {
						result += text;
					}
				}
				EntityUtils.consume(entity);
			} finally {
				response.close();
			}
		} finally {
			httpclient.close();
		}
		return result;
	}
}