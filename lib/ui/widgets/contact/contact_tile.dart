import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_chat/shared/theme.dart';
import 'package:realtime_chat/ui/pages/chat/chat_page.dart';

class ContactTile extends StatelessWidget {
  final String name;
  final String picture;
  final int updatedAt;
  final String chatId;

  const ContactTile(
      {Key? key,
      required this.name,
      required this.picture,
      required this.updatedAt,
      required this.chatId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => ChatPage(),
          transition: Transition.rightToLeft, arguments: {"chatUid": chatId}),
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
}
