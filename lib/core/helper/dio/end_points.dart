abstract class EndPoints {
  static const String baseUrl = "https://api.hagzz.com/api/";
  static const String baseUrlTemp = "https://ipv2.hagzz.com/api/";
  static const String login = "login";
  static const String logout = "logout";
  static const String register = "register";
  static const String verifyCode = "verify-otp";
  static const String sports = "sports";
  static const String userSports = "user/sports";
  static const String countries = "countries";
  static const String cities = "cities";
  static const String areas = "areas";
  static const String profile = "profile";
  static const String updateProfile = "update/user-profile";
  static const String resendOtp = "resendCode";
  static const String sendOtp = "sendCode";
  static const String home = "home";
  static const String language = "language";
  static const String deleteAccount = "delete/account";
  static const String updateSports = "user/update_sports_data";

  static String academyDetails({required int id}) => "academyDetails/$id";

  static String coachDetails({required int id}) => "coachProfile/$id";
  static const String explore = "explore";
  static const String follows = "follows";
  static const String follow = "follow";
  static const String saved = "favorites";
  static const String addToSaved = "addFavorite";

  static String deleteFromSaved({required int id}) => "deleteFavorite/$id";
  static const String addFollow = "$follow/addFollow";
  static const String deleteFollow = "$follow/deleteFollow";

  static String trainingDetails({required int id}) => "trainingDetails/$id";

  static String getAcademyTraining({required int id}) => "academyTrainings/$id";

  static String getCoachTraining({required int id}) => "coach/trainings/$id";
  static const String allArea = "all-area";
  static const String addJoin = "addJoin";
  static const String cancelJoin = "cancelBooking";
  static const String mySessions = "join";
  static const String allTraining = "trainings/list";
  static const String allAcademies = "academies";
  static const String getCoachesForU = "coach/user/sports";
  static const String settings = "settings";
  static const String payment = "payment";

  // faqs
  static const String faqs = "faqs";
  static const String notifications = "user/notifications";

  static String makeNotificationRead({required String id}) =>
      "user/notification/$id";
}
