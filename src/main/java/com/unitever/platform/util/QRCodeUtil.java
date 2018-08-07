package com.unitever.platform.util;

import java.io.File;
import java.io.IOException;
import java.util.Hashtable;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;

public class QRCodeUtil {
	private static String oldDateVal = null;
	private static Long code = 0l;

	/**
	 * 生成二维码
	 * 
	 * @param QRCodeValue
	 *            二维码内容
	 * @param width
	 *            二维码宽度
	 * @param height
	 *            二维码高度
	 * @param fileName
	 *            文件名,（具体地址调用时需指定 eg:c:\platform\imgname）
	 */
	public static final void saveQRCode(String QRCodeValue, int width, int height, String fileName)
			throws WriterException, IOException {
		Hashtable hints = new Hashtable();
		hints.put(EncodeHintType.CHARACTER_SET, "utf-8");
		BitMatrix bitMatrix;
		File outputFile;
		bitMatrix = new MultiFormatWriter().encode(QRCodeValue, BarcodeFormat.QR_CODE, width, height, hints);
		outputFile = new File(fileName + ".png");
		MatrixToImageWriter.writeToFile(bitMatrix, "png", outputFile);
	}

	/**
	 * 获取二维码批次号
	 * 
	 * @return String 二维码批次号
	 */
	public static final String getQrcodeBatch() {
		String nowDateValue = DateUtil.getCurrDateString("yyyyMMddHHmm");
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
		return m.toString();
	}
}
