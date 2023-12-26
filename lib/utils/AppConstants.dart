// ignore_for_file: constant_identifier_names

class AppConstants {
  static const String APP_NAME = "SpotOn";

  static const String BASE_URL = "https://dev.maxmobility.in/spoton";
  static const String SIGN_IN = "$BASE_URL/api/auth/sign-in";
  static const String VALIDATE_OTP = "$BASE_URL/api/auth/validate-otp";
  static const String PROPERTY_TYPE = "$BASE_URL/api/property-type-list";
  static const String ADD_PROJECT = "$BASE_URL/api/add-project";
  static const String PROJECT_LIST = "$BASE_URL/api/project/list";
  static const String PROJECT_DETAILS = "$BASE_URL/api/project/details/";
  static const String POST_COMMENT = "$BASE_URL/api/project/activity/add";
  static const String ADD_IMAGE = "$BASE_URL/api/project/gallery/image-upload/";
  static const String ADD_PHASE = "$BASE_URL/api/project/card/add";
  static const String PHASE_LIST = "$BASE_URL/api/project/card/list/";
  static const String ADD_REGION = "$BASE_URL/api/project/card/add-region";
  static const String GET_REGION = "$BASE_URL/api/project/card/region-list";
  static const String GET_SCOPE = "$BASE_URL/api/scope-list";
}
