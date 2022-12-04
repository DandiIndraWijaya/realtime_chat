import 'dart:convert';

import 'package:get/get.dart';
import 'package:realtime_chat/models/user_model.dart';
import 'package:realtime_chat/services/firebase_service.dart';
import 'package:realtime_chat/ui/pages/auth/auth_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactsPageController extends GetxController {
  UserModel loggedInUser = UserModel(
    groupCode: '',
    name: '',
    email: '',
  );

  @override
  void onInit() async {
    getLoggedInUser();
    super.onInit();
  }

  Future<void> signOut() async {
    await FirebaseService().googleSignOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAll(AuthPage());
  }

  void getLoggedInUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? loggedInUserStringData = pref.getString('user');
    Map<String, dynamic> loggedInUserData =
        json.decode(loggedInUserStringData.toString());
    loggedInUser = UserModel(
      groupCode: 'Dandi',
      name: loggedInUserData['name'],
      email: loggedInUserData['email'],
    );
    update();
  }
}
