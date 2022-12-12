import 'package:get/get.dart';
import 'package:realtime_chat/helpers/userHelper.dart';
import 'package:realtime_chat/models/user_model.dart';
import 'package:realtime_chat/services/user_service.dart';

class AddContactPageController extends GetxController {
  UserModel? signedInUser;
  String userId = '';
  String? errorMessage;

  @override
  void onInit() {
    getSignedInUser();
    super.onInit();
  }

  void getSignedInUser() async {
    signedInUser = await UserHelper().getSignedUser();
    update();
  }

  void onChangeUserIdInput(String id) {
    userId = id;
    update();
  }

  void addContact() async {
    UserModel addedUserIdData = await UserService().fetchUserById(userId);
    if (addedUserIdData.id == '') {
      print("User is not found");
      return;
    } else {
      if (userId == signedInUser!.id) {
        print("user is the shame");
        return;
      }
    }
    await UserService()
        .updateUserFriendsById(signedInUser!.id, addedUserIdData);
    print(addedUserIdData.id);

    update();
  }
}
