package com.swm.util;

import java.util.UUID;

public class MomoInfoUtil {
	public static final String partnerCode = "MOMO3I0H20220705";
	public static final String accessKey = "jaRcr7hDRUVLMTpB";
	public static final String secretKey = "FasheySTHkkRHFUBf3a1Zm46He5voo9P";
	public static final String requestId = UUID.randomUUID().toString();
	public static final String orderId = UUID.randomUUID().toString();
	public static final String requestType = "captureWallet";
	public static final String MOMO_CREATE_ORDER_URL = "https://test-payment.momo.vn/v2/gateway/api/create";
	public static final String MOMO_REFUND_URL = "https://test-payment.momo.vn/v2/gateway/api/refund";
//	public static final String MOMO_REDIRECT_URL = "http://localhost:8080/momo/redirect";
	public static final String MOMO_REDIRECT_URL = "http://192.168.1.161:8080/momo/redirect";
	public static final String MOMO_IPN_URL = "http://localhost:8080/momo/redirect";
	
}
