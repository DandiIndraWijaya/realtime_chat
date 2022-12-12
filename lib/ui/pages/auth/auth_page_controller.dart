import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_chat/models/user_model.dart';
import 'package:realtime_chat/services/firebase_service.dart';
import 'package:realtime_chat/services/user_service.dart';
import 'package:realtime_chat/ui/pages/contacts/contacts_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  bool isLoading = true;
  @override
  void onInit() async {
    checkSignIn();
    super.onInit();
  }

  void checkSignIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.getString('user');
    if (user != null) {
      Get.off(() => ContactsPage(), transition: Transition.zoom);
    } else {
      isLoading = false;
      update();
    }
  }

  Future<void> handleGoogleSignIn() async {
    try {
      UserModel user = await FirebaseService().googleSignIn();
      if (user.token != '') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var userInDb = await UserService().fetchUserInDb(user.email);
        try {
          if (userInDb.email == '') {
            await UserService().setUser(user);
            await prefs.setString(
                "user",
                json.encode({
                  "id": user.id,
                  "groupCode": '1111',
                  "name": user.name,
                  "email": user.email,
                  "profilePicture": user.profilePicture,
                  "friends": user.friends,
                  "createdAt": user.createdAt,
                  "updatedAt": user.updatedAt,
                  "isSuspended": user.isSuspended,
                  "token": user.token
                }));
          } else {
            await prefs.setString(
                "user",
                json.encode({
                  "id": userInDb.id,
                  "groupCode": '1111',
                  "name": userInDb.name,
                  "email": userInDb.email,
                  "profilePicture": userInDb.profilePicture,
                  "friends": userInDb.friends,
                  "createdAt": userInDb.createdAt,
                  "updatedAt": userInDb.updatedAt,
                  "isSuspended": userInDb.isSuspended,
                  "token": userInDb.token
                }));
          }

          Get.off(() => ContactsPage(), transition: Transition.zoom);
        } catch (e) {
          rethrow;
        }
      } else {
        Get.snackbar(
          "Can't Login",
          "User not found!",
          icon: const Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          borderRadius: 20,
          margin: const EdgeInsets.all(15),
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      }
    } catch (error) {
      Get.snackbar(
        "Can't Login",
        error.toString(),
        icon: const Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        borderRadius: 20,
        margin: const EdgeInsets.all(15),
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    }
  }
}
