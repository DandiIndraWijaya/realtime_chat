import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_chat/models/user_model.dart';
import 'package:realtime_chat/shared/theme.dart';
import 'package:realtime_chat/ui/pages/add_contact/add_contact_page.dart';
import 'package:realtime_chat/ui/pages/chat/chat_page.dart';
import 'package:realtime_chat/ui/pages/contacts/contacts_page_controller.dart';
import 'package:realtime_chat/ui/widgets/contact/contact_tile.dart';

class ContactsPage extends StatelessWidget {
  final routeName = '/contacts';

  final contactsPageController = ContactsPageController();

  ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: GetBuilder<ContactsPageController>(
            init: contactsPageController,
            builder: (_) {
              UserModel? signedInUser = contactsPageController.loggedInUser;

              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      signedInUser == null
                          ? ''
                          : contactsPageController.loggedInUser!.name
                              .toString(),
                      style: whiteTextStyle.copyWith(fontSize: 18),
                    ),
                    PopupMenuButton(itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                            child: InkWell(
                          onTap: () {
                            final result = Get.to(() => AddContactPage(),
                                transition: Transition.rightToLeft);
                            print("RESULT: " + result.toString());
                          },
                          child: Text(
                            "Add Contact",
                            style: blackTextStyle,
                          ),
                        )),
                        PopupMenuItem(
                            child: InkWell(
                          onTap: () => contactsPageController.signOut(),
                          child: Text(
                            "Logout",
                            style: blackTextStyle,
                          ),
                        ))
                      ];
                    })
                  ]);
            }),
      ),
      body: GetBuilder<ContactsPageController>(
          init: contactsPageController,
          builder: (context) {
            if (contactsPageController.isLoading) {
              return Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              );
            }

            if (contactsPageController.loggedInUser != null) {
              if (contactsPageController.loggedInUser!.friends.isEmpty) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      size: 70,
                      color: kGreyColor,
                    ),
                    Text(
                      'Contact is Empty',
                      style: greyTextStyle.copyWith(fontSize: 22),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                        onPressed: () {
                          Get.to(() => AddContactPage(),
                              transition: Transition.rightToLeft);
                        },
                        child: Text(
                          '+ Add Contact',
                          style: whiteTextStyle.copyWith(fontSize: 16),
                        ))
                  ],
                ));
              }
              return ListView(
                children: [
                  for (Map<String, dynamic> user
                      in contactsPageController.loggedInUser!.friends)
                    ContactTile(
                      name: user['name'],
                      picture: user['profilePicture'],
                      chatId: user['chatUid'],
                      updatedAt: 0,
                    )
                ],
              );
            }

            return Center(
              child: Text(
                "Check Your Connection",
                style: greyTextStyle.copyWith(fontSize: 18),
              ),
            );
          }),
    );
  }
}
