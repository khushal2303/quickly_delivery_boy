import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:quickly_delivery/constants/constants.dart';

class AnalyticsLogger {
  //
  //
  //event names defined here
  static const String app_open = "App_Opened";
  static const String log_in = "Log_In";
  static const String sign_up = "Sign_Up";
  static const String veriry_user = "Verify_User";
  static const String forgot_pass = "Forgot_Password";
  static const String reset_pass = "Reset_Password";
  static const String create_post = "Create_Post";
  static const String flag_post = "Flag_Post";
  static const String delete_post = "Delete_Post";
  static const String like_post = "Like_Post";
  static const String unlike_post = "Unlike_Post";
  static const String comment_post = "Comment_Post";
  static const String delete_comment = "Delete_Comment";
  static const String share_post = "Share_Post";
  static const String search = "Search";
  static const String edit_profile = "Edit_Profile";
  static const String change_password = "Change_Password";
  static const String group_search = "Group_Search";
  static const String create_group = "Create_Group";
  static const String delete_group = "Delete_Group";
  static const String join_group = "Join_Group";
  static const String leave_group = "Leave_Group";
  static const String group_post = "Group_Post";
  static const String group_details = "Group_Details";
  static const String view_group_members = "View_Group_Members";
  static const String remove_from_group = "Remove_from_Group";
  static const String start_new_chat = "Start_New_Chat";
  static const String change_feed_filter = "Change_Feed_Filter";
  static const String follow_user = "Follow_User";
  static const String unfollow_user = "Unfollow_User";
  static const String visit_user = "Visit_User_Profile";
  static const String logout = "Logout";

  AnalyticsLogger._privateConstructor();

  final FirebaseAnalytics analytics = FirebaseAnalytics();

  static final AnalyticsLogger instance = AnalyticsLogger._privateConstructor();

  void logEvent(String eventName, Map<String, dynamic>? params) {
    params?.addEntries([
      MapEntry<String, dynamic>("user_id", Constants.userId),
      MapEntry<String, dynamic>("user_email", Constants.userEmail),
      if (params["_id"] != null) MapEntry<String, dynamic>("id", params["_id"]),
    ]);
    print("logevent");
    analytics.logEvent(
      name: eventName,
      parameters: params ?? params,
    );
  }
}
