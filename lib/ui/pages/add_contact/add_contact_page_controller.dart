import 'package:get/get.dart';
import 'package:realtime_chat/helpers/user_helper.dart';
import 'package:realtime_chat/models/chat_model.dart';
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

  addContact() async {
    // check if added user id is same as signed in user
    if (userId == signedInUser!.id) {
      print("user is the shame");
      return;
    }

    UserModel addedUserIdData = await UserService().fetchUserById(userId);

    // check if added user id is on db
    if (addedUserIdData.id == '') {
      print("User is not found");
      return;
    }

    // check if added user is alreade signed user friend
    for (var signedUserFriend in signedInUser!.friends) {
      if (signedUserFriend['id'] == userId) {
        print("Added user id is already friend");
        return;
      }
    }

    ChatModel().createChat(
        [signedInUser!.id, addedUserIdData.id],
        DateTime.now().millisecondsSinceEpoch,
        DateTime.now().millisecondsSinceEpoch);

    String chatUid = await ChatModel()
        .getChatUIDByMembers([signedInUser!.id, addedUserIdData.id]);

    UserService()
        .updateUserFriendsById(signedInUser!.id, addedUserIdData, chatUid);

    Get.back(result: "success");
  }
}
