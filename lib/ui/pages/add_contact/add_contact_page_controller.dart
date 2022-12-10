import 'package:get/get.dart';
import 'package:realtime_chat/helpers/userHelper.dart';
import 'package:realtime_chat/models/user_model.dart';

class AddContactPageController extends GetxController {
  UserModel? signedInUser;

  @override
  void onInit() {
    getSignedInUser();
    super.onInit();
  }

  void getSignedInUser() async {
    signedInUser = await UserHelper().getSignedUser();

    print(signedInUser!.id.toString());
  }
}
