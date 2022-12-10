import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:realtime_chat/models/user_model.dart';

class FirebaseService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  Future<UserModel> googleSignIn() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return UserModel(
        id: '',
        groupCode: '',
        name: '',
        email: '',
      );
    }
    _user = googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    await FirebaseAuth.instance.signInWithCredential(credential);

    List<String> splitedEmail = _user!.email.toString().split("@");
    String userId = splitedEmail[0];

    return UserModel(
        id: splitedEmail[0],
        groupCode: '',
        email: _user!.email.toString(),
        name: _user!.displayName.toString(),
        profilePicture: _user!.photoUrl.toString(),
        isSuspended: false,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
        token: googleAuth.idToken.toString());
  }

  Future checkGoogleSign() async {
    final _user = FirebaseAuth.instance.currentUser;
    if (_user == null) {
      return UserModel(
        id: '',
        groupCode: '',
        name: '',
        email: '',
      );
    }

    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    return UserModel(
        id: '',
        groupCode: '',
        email: _user.email.toString(),
        name: _user.displayName.toString(),
        token: googleAuth.idToken.toString());
  }

  Future googleSignOut() async {
    _googleSignIn.signOut();
  }
}
