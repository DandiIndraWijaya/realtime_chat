import 'package:realtime_chat/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> setUser(UserModel user) async {
    try {
      _userReference.doc().set({
        'groupCode': '1111',
        'name': user.name,
        'email': user.email,
        'profilePicture': user.profilePicture,
        'createdAt': user.createdAt,
        'updatedAt': user.updatedAt,
        'isSuspended': user.isSuspended
      });
    } catch (e) {
      rethrow;
    }
  }

  Future checkIsUserAlreadySignIn(String email) async {
    return _userReference
        .where('email', isEqualTo: email)
        .get()
        .then((snapshot) {
      snapshot.docs[0].data() as Map<String, dynamic>;

      return true;
    }).catchError((onError) {
      return false;
    });
  }
}
