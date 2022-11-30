import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_chat/models/user_model.dart';
import 'package:realtime_chat/services/firebase_service.dart';
import 'package:realtime_chat/ui/pages/contacts/contacts_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
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
    }
  }

  Future<void> handleGoogleSignIn() async {
    try {
      UserModel user = await FirebaseService().googleSignIn();

      if (user.token != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString(
            "user",
            json.encode(
                {"name": user.name, "email": user.email, "token": user.token}));
        Get.to(() => ContactsPage(), transition: Transition.zoom);
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
