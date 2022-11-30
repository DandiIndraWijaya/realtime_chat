import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_chat/models/user_model.dart';
import 'package:realtime_chat/services/firebase_service.dart';
import 'package:realtime_chat/ui/pages/contacts/contactsPage.dart';

class AuthController extends GetxController {
  Future<void> handleGoogleSignIn() async {
    try {
      UserModel user = await FirebaseService().googleSignIn();

      if (user.token != null) {
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
