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
        title: Text(
          "Add Contact",
          style: whiteTextStyle.copyWith(fontSize: 18),
        ),
      ),
      body: GetBuilder<AddContactPageController>(
        init: addContactPageController,
        builder: (_) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Contact by User ID",
                    style: greyTextStyle.copyWith(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (value) {
                      addContactPageController.onChangeUserIdInput(value);
                    },
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        hintText: "User ID",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: kRedColor),
                      onPressed: () => addContactPageController.addContact(),
                      child: Text(
                        "+ Add",
                        style: whiteTextStyle,
                      ))
                ]),
          );
        },
      ),
    );
  }
}
