/**
 *
 * <P> AliPay.java </p>
 *
 * @author 闫枫
 * @date Aug 28, 2017
 */
package com.unitever.platform.util;

/**
 *
 * <P>
 * client-tianhe->com.scanpay.model->AliPay.java
 * </p>
 * <P>
 * TODO
 * </p>
 *
 * @author 闫枫
 * @date Aug 28, 2017
 */
public class AliPay {

	/** 阿里--蚂蚁金服--后台配置的应用的appid **/
	public static String APPID;
	/** 阿里--蚂蚁金服--后台配置的应用的公钥所对应的私钥（这个由开发者自己生成，阿里有提供生成工具，可以使用） **/
	public static String PRIVATE_KEY;
	/** 阿里--蚂蚁金服--后台配置的应用的配置好公钥后，阿里给出的对应的阿里的公钥 **/
	public static String ALI_PUBLIC_KEY;
	/** 阿里--蚂蚁金服--接口调用URL **/
	public static String HTTP_URL;
	/** 阿里--蚂蚁金服--查询等待时间 **/
	public static int SELECT_STOP_TIME;
	/** 阿里--蚂蚁金服--查询次数 **/
	public static int SELECT_NUMBER;

	/**
	 *
	 * <P>
	 * 初始化支付宝支付必要参数
	 * </p>
	 *
	 * @author 闫枫
	 * @date Aug 28, 2017
	 * @param appid
	 * @param privateKey
	 * @param aliPayPublicKey
	 * @param httpUrl
	 *            void
	 */
	public static void initSDKConfiguration(String appid, String privateKey, String aliPayPublicKey, String httpUrl
	// ,int stopTime, int selectNumber
	) {
		APPID = appid;
		PRIVATE_KEY = privateKey;
		ALI_PUBLIC_KEY = aliPayPublicKey;
		HTTP_URL = httpUrl;
		// SELECT_STOP_TIME = stopTime;
		// SELECT_NUMBER = selectNumber;
	}
}
