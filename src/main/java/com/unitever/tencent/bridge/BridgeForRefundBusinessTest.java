package com.unitever.tencent.bridge;

import java.net.InetAddress;
import java.net.UnknownHostException;

import com.tencent.bridge.IBridge;
import com.tencent.common.Configure;
import com.unitever.platform.util.UUID;

/**
 * User: rizenguo Date: 2014/11/7 Time: 15:54
 */
public class BridgeForRefundBusinessTest implements IBridge {

	private int totalFee;
	private int refundFee;
	private String out_trade_no;
	private String cashierCode;
	private String transactionId;

	/**
	 * @param order
	 *            订单
	 */
	public BridgeForRefundBusinessTest(int totalFee, int refundFee, String transactionId, String cashierCode) {
		super();
		this.totalFee = totalFee;
		this.refundFee = refundFee;
		this.transactionId = transactionId;
		this.cashierCode = cashierCode;
	}

	@Override
	public String getAuthCode() {
		return null;
	}

	@Override
	public String getOutTradeNo() {
		return null;
	}

	@Override
	public String getBody() {
		return null;
	}

	@Override
	public String getAttach() {
		return null;
	}

	@Override
	public int getTotalFee() {
		return totalFee;
	}

	@Override
	public String getDeviceInfo() {
		return cashierCode;
	}

	@Override
	public String getUserIp() {
		try {
			return InetAddress.getLocalHost().getHostAddress();
		} catch (UnknownHostException e) {
		}
		return "8.8.8.8";
	}

	@Override
	public String getSpBillCreateIP() {
		return null;
	}

	@Override
	public String getTimeStart() {
		return null;
	}

	@Override
	public String getTimeExpire() {
		return null;
	}

	@Override
	public String getGoodsTag() {
		return null;
	}

	@Override
	public String getTransactionID() {
		return transactionId;
	}

	@Override
	public String getOutRefundNo() {
		return UUID.getUUID();
	}

	@Override
	public int getRefundFee() {
		return refundFee;
	}

	@Override
	public String getRefundID() {
		return null;
	}

	@Override
	public String getBillDate() {
		return null;
	}

	@Override
	public String getBillType() {
		return null;
	}

	@Override
	public String getOpUserID() {
		return Configure.getSubMchid();
	}

	@Override
	public String getRefundFeeType() {
		return "CNY";
	}
}
