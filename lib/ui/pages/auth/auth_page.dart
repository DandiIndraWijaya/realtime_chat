import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_chat/shared/theme.dart';
import 'package:realtime_chat/ui/pages/auth/auth_page_controller.dart';
import 'package:realtime_chat/ui/pages/contacts/contacts_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:realtime_chat/services/firebase_service.dart';

class AuthPage extends StatelessWidget {
  final routeName = '/auth';

  final authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Center(
        child: GetBuilder<AuthController>(
            init: authController,
            builder: (_) {
              // if (authController.checkGoogleSignIn() == true) {}
              return Container(
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: kWhiteColor, padding: const EdgeInsets.all(10)),
                  onPressed: () {
                    authController.handleGoogleSignIn();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/google_logo.png'))),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Sign in with Google',
                        style: greyTextStyle.copyWith(fontWeight: medium),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
