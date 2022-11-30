import 'package:get/get.dart';
import 'package:realtime_chat/services/firebase_service.dart';
import 'package:realtime_chat/ui/pages/auth/authPage.dart';

class ContactsPageController extends GetxController {
  Future<void> signOut() async {
    await FirebaseService().googleSignOut();
    Get.offAll(AuthPage());
  }
}
