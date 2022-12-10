import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_chat/models/user_model.dart';
import 'package:realtime_chat/shared/theme.dart';
import 'package:realtime_chat/ui/pages/add_contact/add_contact_page.dart';
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
                  width: 55.0,
                  height: 55.0,
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
                              fontSize: 16, fontWeight: bold),
                        ),
                        Text(
                          '09/10/2022',
                          style: greyTextStyle.copyWith(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
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
                                    const BorderRadius.all(Radius.circular(20)),
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
                    IconButton(
                        onPressed: () {
                          contactsPageController.signOut();
                        },
                        icon: const Icon(Icons.logout))
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
                  for (UserModel user
                      in contactsPageController.loggedInUser!.friends)
                    contactTile(name: user.name, picture: user.profilePicture)
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
