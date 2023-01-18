class APIConst {
  static String baseUrl = "http://52.66.209.219:5000";

  static String loginUrl = "/auth/login";
  static String addMedicine = "/medicine/";
  static String userData = "/user/";
  static String getPosts = "/post";
  static String addComment = "/post/comment";
  static String getComment = "/post/comment/";
  static String postLike = "/post/like";
  static String video = "/video";
  static String videoLike = "/video/like";
  static String searchUser = "/user/search?text=";
  static String sendRequest = "/user/send-request";
  static String getReqUser = "/user/my-requests";
  static String rejectRequest = "/user/reject-request";
  static String acceptRequest = "/user/accept-request";
  static String glass = "/glass";
  static String getReminder = "/user/reminders?";
  static String dependent = "/user/dependents";
  static String removeMedicine = "/medicine/delete/";
  static String recordMedicine = "/medicine/record";
  static String allCategory = "/admin/category";
  static String getFaq = "/admin/faq/";
  static String emailOTP = "/auth/email-otp";
  static String dateMedicineRecord = "/medicine/date-record";
  static String getAllPostCategories = "/post/category";
  static String heartRate = "/heart";
}
