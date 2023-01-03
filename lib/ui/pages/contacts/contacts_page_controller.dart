import 'dart:convert';

import 'package:get/get.dart';
import 'package:realtime_chat/helpers/user_helper.dart';
import 'package:realtime_chat/models/user_model.dart';
import 'package:realtime_chat/services/firebase_service.dart';
import 'package:realtime_chat/services/user_service.dart';
import 'package:realtime_chat/ui/pages/add_contact/add_contact_page.dart';
import 'package:realtime_chat/ui/pages/auth/auth_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactsPageController extends GetxController {
  UserModel? loggedInUser;

  List<UserModel> users = [];
  late bool isLoading;

  @override
  void onInit() async {
    isLoading = true;
    getLoggedInUser();
    super.onInit();
  }

  void getLoggedInUser() async {
    loggedInUser = await UserHelper().getSignedUser();
    isLoading = false;
    update();
  }

  goToContactPage() async {
    var result = Get.to(AddContactPage());
    print("Result nih bos: " + result.toString());
    if (result == 'success') {
      getLoggedInUser();
    }
  }

  void checkChatsInLocalStorage() {}

  void downloadChats() {}

  Future<void> signOut() async {
    await FirebaseService().googleSignOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAll(AuthPage());
  }
}
