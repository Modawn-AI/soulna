class ErrorCode {
  static const String getContentInfo_1 = "getContentInfo_1";

  static const String purchaseContent_1 = "purchaseContent_1";
  static const String purchaseContent_2 = "purchaseContent_2";
  static const String purchaseContent_3 = "purchaseContent_3";

  static const String saveToken_1 = "saveToken_1";

  static const String getUserSubscribe_1 = "getUserSubscribe_1";
  static const String subscribeToTopic_1 = "subscribeToTopic_1";
  static const String unSubscribeToTopic_1 = "unSubscribeToTopic_1";

  static const String socialSign_1 = "socialSign_1";
  static const String socialSign_2 = "socialSign_2";
  static const String socialSign_3 = "socialSign_3";
  static const String socialSign_4 = "socialSign_4";
  static const String socialSign_5 = "socialSign_5";
  static const String socialSign_6 = "socialSign_6";

  static const String addPoint_1 = "addPoint_1";

  static const String verifyApplePurchase_1 = "verifyApplePurchase_1";
  static const String verifyGooglePurchase_1 = "verifyGooglePurchase_1";

  // 존재하지 않는 코드
  static const String applyPromotionCode_1 = "applyPromotionCode_1";

  // 날짜 기간이 지난 코드
  static const String applyPromotionCode_2 = "applyPromotionCode_2";

  // 이미 사용된 코드
  static const String applyPromotionCode_3 = "applyPromotionCode_3";

  // 등록 가능 유저 수가 종료된 코드
  static const String applyPromotionCode_4 = "applyPromotionCode_4";

  static const String getUserImageDetail_1 = "getUserImageDetail_1";

  static const String refreshToken_1 = "refreshToken_1";

  static const String validUser_1 = "validUser_1";
  static const String validUser_2 = "validUser_2";

  static const String verifyToken_1 = "verifyToken_1";
  static const String verifyToken_2 = "verifyToken_2";
  static const String verifyToken_3 = "verifyToken_3";
  static const String verifyToken_4 = "verifyToken_4";
  static const String verifyToken_5 = "verifyToken_5";
  static const String verifyToken_6 = "verifyToken_6";

  static const String verifyAppleReceipt_1 = "verifyAppleReceipt_1";

  static const String reportUserImage_1 = "reportUserImage_1";
  static const String reportUserImage_2 = "reportUserImage_2";

  static const String detectFace_1 = "detectFace_1";
  static const String detectFace_2 = "detectFace_2";
  static const String detectFace_3 = "detectFace_3";
  static const String detectFace_4 = "detectFace_4";
  static const String detectFace_5 = "detectFace_5";
  static const String detectFace_6 = "detectFace_6";
}

Map<String, String> errorCodeMap = {
  "getContentInfo_1": ErrorCode.getContentInfo_1,
  "purchaseContent_1": ErrorCode.purchaseContent_1,
  "purchaseContent_2": ErrorCode.purchaseContent_2,
  "purchaseContent_3": ErrorCode.purchaseContent_3,
  "saveToken_1": ErrorCode.saveToken_1,
  "getUserSubscribe_1": ErrorCode.getUserSubscribe_1,
  "subscribeToTopic_1": ErrorCode.subscribeToTopic_1,
  "unSubscribeToTopic_1": ErrorCode.unSubscribeToTopic_1,
  "socialSign_1": ErrorCode.socialSign_1,
  "socialSign_2": ErrorCode.socialSign_2,
  "socialSign_3": ErrorCode.socialSign_3,
  "socialSign_4": ErrorCode.socialSign_4,
  "socialSign_5": ErrorCode.socialSign_5,
  "socialSign_6": ErrorCode.socialSign_6,
  "addPoint_1": ErrorCode.addPoint_1,
  "verifyApplePurchase_1": ErrorCode.verifyApplePurchase_1,
  "verifyGooglePurchase_1": ErrorCode.verifyGooglePurchase_1,
  "applyPromotionCode_1": ErrorCode.applyPromotionCode_1,
  "applyPromotionCode_2": ErrorCode.applyPromotionCode_2,
  "applyPromotionCode_3": ErrorCode.applyPromotionCode_3,
  "applyPromotionCode_4": ErrorCode.applyPromotionCode_4,
  "getUserImageDetail_1": ErrorCode.getUserImageDetail_1,
  "refreshToken_1": ErrorCode.refreshToken_1,
  "validUser_1": ErrorCode.validUser_1,
  "validUser_2": ErrorCode.validUser_2,
  "verifyToken_1": ErrorCode.verifyToken_1,
  "verifyToken_2": ErrorCode.verifyToken_2,
  "verifyToken_3": ErrorCode.verifyToken_3,
  "verifyToken_4": ErrorCode.verifyToken_4,
  "verifyToken_5": ErrorCode.verifyToken_5,
  "verifyToken_6": ErrorCode.verifyToken_6,
  "verifyAppleReceipt_1": ErrorCode.verifyAppleReceipt_1,
  "reportUserImage_1": ErrorCode.reportUserImage_1,
  "reportUserImage_2": ErrorCode.reportUserImage_2,
  "detectFace_1": ErrorCode.detectFace_1,
  "detectFace_2": ErrorCode.detectFace_2,
  "detectFace_3": ErrorCode.detectFace_3,
  "detectFace_4": ErrorCode.detectFace_4,
  "detectFace_5": ErrorCode.detectFace_5,
  "detectFace_6": ErrorCode.detectFace_6,
};

String getErrorCode(String code) {
  return errorCodeMap[code] ?? 'Error code not found';
}
