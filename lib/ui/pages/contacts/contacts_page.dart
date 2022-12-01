import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_chat/shared/theme.dart';
import 'package:realtime_chat/ui/pages/chat/chat_page.dart';
import 'package:realtime_chat/ui/pages/contacts/contacts_page_controller.dart';

class ContactsPage extends StatelessWidget {
  final routeName = '/contacts';

  final contactsPageController = ContactsPageController();

  Widget contactTile({picture, name}) {
    return InkWell(
      onTap: () => Get.to(() => ChatPage(),
          transition: Transition.rightToLeft, arguments: {"id": "923khigig"}),
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill, image: NetworkImage(picture)))),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: blackTextStyle.copyWith(
                              fontSize: 18, fontWeight: bold),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
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
                    height: 0.2,
                    decoration: BoxDecoration(color: kGreyColor),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactsPageController>(
        init: contactsPageController,
        builder: (_) {
          return Scaffold(
            backgroundColor: kWhiteColor,
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(contactsPageController.loggedInUser.name.toString()),
                    IconButton(
                        onPressed: () {
                          contactsPageController.signOut();
                        },
                        icon: const Icon(Icons.logout))
                  ]),
            ),
            body: ListView(
              children: [
                contactTile(
                    name: "Clara",
                    picture:
                        "https://images.unsplash.com/photo-1518577915332-c2a19f149a75?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=562&q=80"),
                contactTile(
                    name: "Jhon",
                    picture:
                        "https://images.unsplash.com/photo-1529068755536-a5ade0dcb4e8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=581&q=80"),
                contactTile(
                    name: "Sita",
                    picture:
                        "https://images.unsplash.com/photo-1485893086445-ed75865251e0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"),
              ],
            ),
          );
        });
  }
}
