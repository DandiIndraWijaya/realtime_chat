import 'dart:convert';

import 'package:realtime_chat/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHelper {
  UserModel? signedInUser;

  Future<UserModel?> getSignedUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? signedInUserStringData = pref.getString('user');
    Map<String, dynamic> signedInUserData =
        json.decode(signedInUserStringData.toString());
    signedInUser = UserModel(
        id: signedInUserData['id'],
        groupCode: signedInUserData['groupCode'],
        name: signedInUserData['name'],
        email: signedInUserData['email'],
        friends: signedInUserData['friends']);
    return signedInUser;
  }
}
