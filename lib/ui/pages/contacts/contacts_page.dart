import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_chat/shared/theme.dart';
import 'package:realtime_chat/ui/pages/chat/chat_page.dart';
import 'package:realtime_chat/ui/pages/contacts/contacts_page_controller.dart';

class ContactsPage extends StatelessWidget {
  final routeName = '/contacts';

  final contactsPageController = ContactsPageController();

  Widget contactTile() {
    return InkWell(
      onTap: () => Get.to(() => ChatPage(),
          transition: Transition.rightToLeft, arguments: {"id": "923khigig"}),
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Clara',
                    style:
                        blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
                  ),
                  Text(
                    '09/10/2022',
                    style: greyTextStyle.copyWith(fontSize: 12),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hello world!',
                    style: greyTextStyle.copyWith(fontWeight: medium),
                  ),
                  Container(
                      width: 25,
                      height: 25,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: kPrimaryColor),
                      child: Center(
                        child: Text('3',
                            style: whiteTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: bold,
                            )),
                      ))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: double.infinity,
              height: 0.5,
              decoration: BoxDecoration(color: kGreyColor),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Dandi'),
          IconButton(
              onPressed: () {
                contactsPageController.signOut();
              },
              icon: const Icon(Icons.logout))
        ]),
      ),
      body: ListView(
        children: [
          contactTile(),
          contactTile(),
          contactTile(),
          contactTile(),
        ],
      ),
    );
  }
}
