import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_chat/shared/theme.dart';
import 'package:realtime_chat/ui/pages/contacts/contactsPage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);
  final routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Center(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: kWhiteColor, padding: const EdgeInsets.all(10)),
          onPressed: () =>
              Get.to(() => const ContactsPage(), transition: Transition.zoom),
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
      )),
    );
  }
}
