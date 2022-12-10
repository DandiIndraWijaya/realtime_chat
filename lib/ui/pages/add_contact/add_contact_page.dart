import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_chat/shared/theme.dart';
import 'package:realtime_chat/ui/pages/add_contact/add_contact_page_controller.dart';

class AddContactPage extends StatelessWidget {
  final routeName = "/add-contact";
  final addContactPageController = AddContactPageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<AddContactPageController>(
        init: addContactPageController,
        builder: (_) {
          return Center(
            child: Text("Add Contact Page"),
          );
        },
      ),
    );
  }
}
