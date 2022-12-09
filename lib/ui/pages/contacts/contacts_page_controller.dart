import 'dart:convert';

import 'package:get/get.dart';
import 'package:realtime_chat/models/user_model.dart';
import 'package:realtime_chat/services/firebase_service.dart';
import 'package:realtime_chat/services/user_service.dart';
import 'package:realtime_chat/ui/pages/auth/auth_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactsPageController extends GetxController {
  UserModel loggedInUser = UserModel(
    groupCode: '',
    name: '',
    email: '',
  );
  List<UserModel> users = [];
  late bool isLoading;

  @override
  void onInit() async {
    isLoading = true;
    getLoggedInUser();
    super.onInit();
  }

  void getLoggedInUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? loggedInUserStringData = pref.getString('user');
    Map<String, dynamic> loggedInUserData =
        json.decode(loggedInUserStringData.toString());
    print(loggedInUserData['groupCode']);
    loggedInUser = UserModel(
      groupCode: loggedInUserData['groupCode'],
      name: loggedInUserData['name'],
      email: loggedInUserData['email'],
    );
    update();
    getUsersByGroupCode(loggedInUser.groupCode);
  }

  Future<void> getUsersByGroupCode(String groupCode) async {
    try {
      users = await UserService().fetchUsersByGroupCode(groupCode);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      rethrow;
    }
    update();
  }

  Future<void> signOut() async {
    await FirebaseService().googleSignOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAll(AuthPage());
  }
}
