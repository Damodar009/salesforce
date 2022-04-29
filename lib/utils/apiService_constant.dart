class ApiService {
  static const String base2 = "http://167.71.209.112:8081";
  static const String base = "http://192.168.1.67:5000";
  static const String projectId = "projectId";
  static const String postAnswer = base + "/survey/api/answer/save";
  static const String postImageAnswer =
      base + "/survey/api/image/multipleAnswerImageSave";
  static const String sucessDownload =
      base + "/survey/api/user/successDownload/";

  static const String combineProject = base + "/survey/deployed/combine";
  static const String forgetPassword = base + "/survey/api/user/forgotPassword";
  static const String dashBoardCount = base + "/api/mobileDashboard";
  static const String login = base + "/oauth/token";
}
