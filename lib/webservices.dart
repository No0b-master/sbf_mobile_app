class Webservices{
  // static const String HOST_URL = "http://15.206.203.176:3000";
  // static const String HOST_URL = "http://10.0.2.2:3333/api";
  // static const String FilePath = "http://10.0.2.2:8080/uploads";

  static const String HOST_URL = "https://sbfapi.welkdock.com/api";

  static const String login =  "$HOST_URL/auth/login";
  static const String register =  "$HOST_URL/auth/register";
  static const String sendOtp =  "$HOST_URL/otp/send-otp";
  static const String verifyOtp =  "$HOST_URL/otp/verify-otp";
  static const String resetPassword =  "$HOST_URL/auth/changePassword";




  static const String basicDetails =  "$HOST_URL/volunteer/saveBasicDetails" ;
  static const String preferences =  "$HOST_URL/volunteer/savePreferences";
  static const String uploadDocuments =  "$HOST_URL/document/upload?id=";
  static const String updateDocuments =  "$HOST_URL/document/update?sbf_id=";



  static const String isBasicDetailsFilled = "$HOST_URL/volunteer/basicDetailsStatus";
  static const String getPreferences =  "$HOST_URL/volunteer/getVolunteerPreferences";


  static const String stateLevel =  "$HOST_URL/approval/approveState";
  static const String localLevel =  "$HOST_URL/approval/approveLocal";
  static const String nationalLevel =  "$HOST_URL/approval/approveNational";
  static const String getApprovalStatus = "$HOST_URL/approval/getApprovals" ;



  static const String getVolunteer = "$HOST_URL/volunteer/getVolunteerDetails" ;
  static const String getVolunteerList = "$HOST_URL/list/volunteer" ;

  static const String downloadId = "$HOST_URL/document/getIdCard/" ;

  static const String viewDocument = "$HOST_URL/document-access/viewDocument/" ;
  static const String downloadDocument = "$HOST_URL/document-access/downloadDocument/" ;













}