class ApiUrl {
  static const String baseUrl = "http://103.90.86.112:80/salesforce";
  static const String apiUrl = baseUrl + "/api";
  static const String login = baseUrl + "/oauth/token";
  static const String changePassword = apiUrl + "/user/changePassword";
  static const String depotProductAndRetailor = baseUrl + "/api/merge";
  static const String saveAttendence = baseUrl + "/api/attendance/save";
  static const String saveSalesCollectionTracking =
      baseUrl + "/api/saleDataTracking/save";
  static const String saveSalesDataCollection = baseUrl + "/api/salesdata/save";
  static const String getSalesStaff = baseUrl + '/api/user/getsalesstaffbyid/';
  static const String saveAllRetailer = baseUrl + '/api/retailer/saveall';
  static const String saveUser = baseUrl + "/api/user/save";
  static const String salesData = baseUrl + "/api/salesdata/save";
  static const String imageUpload = baseUrl + '/api/image/save';
  static const String multipleImageUpload =
      baseUrl + '/api/image/multipleImageSave';
}
