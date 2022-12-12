import 'dart:convert';

import 'package:realtime_chat/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> setUser(UserModel user) async {
    try {
      _userReference.doc().set({
        'id': user.id,
        'groupCode': '1111',
        'name': user.name,
        'email': user.email,
        'profilePicture': user.profilePicture,
        'friends': [],
        'createdAt': user.createdAt,
        'updatedAt': user.updatedAt,
        'isSuspended': user.isSuspended
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> fetchUserInDb(String email) async {
    try {
      QuerySnapshot result =
          await _userReference.where('email', isEqualTo: email).get();
      if (result.docs.isEmpty) {
        return UserModel(id: '', groupCode: '', name: '', email: '');
      }
      UserModel userInDb = UserModel.fromJson(
          result.docs[0].id, result.docs[0].data() as Map<String, dynamic>);
      return userInDb;
    } catch (onError) {
      rethrow;
    }
  }

  Future<UserModel> fetchUserById(String id) async {
    try {
      QuerySnapshot result =
          await _userReference.where('id', isEqualTo: id).get();
      if (result.docs.isEmpty) {
        return UserModel(id: '', name: '', email: '');
      }

      UserModel userData =
          UserModel.fromJson(id, result.docs[0].data() as Map<String, dynamic>);
      return userData;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateUserFriendsById(String id, UserModel friend) async {
    QuerySnapshot signedInUser =
        await _userReference.where('id', isEqualTo: id).get();

    UserModel signedInUserData = UserModel.fromJson(
        id, signedInUser.docs[0].data() as Map<String, dynamic>);

    // Check if user id is already signed user friend

    // End check if user id is already signed user friend

    List<dynamic> updatedsignedInUserFriends = [
      ...signedInUserData.friends,
      {
        "id": friend.id,
        "profilePicture": friend.profilePicture,
        "name": friend.name,
        "email": friend.email,
        "groupCode": friend.groupCode,
        "isSuspended": friend.isSuspended,
      }
    ];
    await _userReference
        .doc(signedInUser.docs[0].id)
        .update({"friends": updatedsignedInUserFriends})
        .then((_) => print('Success'))
        .catchError((error) => print('Failed: $error'));
  }

  Future<List<UserModel>> fetchUsersByGroupCode(String groupCode) async {
    try {
      QuerySnapshot result =
          await _userReference.where('groupCode', isEqualTo: groupCode).get();
      List<UserModel> usersByGroupCode = result.docs.map((e) {
        return UserModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      }).toList();

      return usersByGroupCode;
    } catch (e) {
      rethrow;
    }
  }
}
