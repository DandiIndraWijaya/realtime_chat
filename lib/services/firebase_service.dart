import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:realtime_chat/models/user_model.dart';

class FirebaseService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  Future<UserModel> googleSignIn() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return UserModel();
    }
    _user = googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    await FirebaseAuth.instance.signInWithCredential(credential);

    return UserModel(
        email: _user!.email.toString(),
        name: _user!.displayName.toString(),
        token: googleAuth.idToken.toString());
  }

  Future checkGoogleSign() async {
    final _user = FirebaseAuth.instance.currentUser;
    if (_user == null) {
      return UserModel();
    }

    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    return UserModel(
        email: _user.email.toString(),
        name: _user.displayName.toString(),
        token: googleAuth.idToken.toString());
  }

  Future googleSignOut() async {
    _googleSignIn.signOut();
  }
}
