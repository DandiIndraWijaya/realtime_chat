import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_chat/shared/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);
  final argumentData = Get.arguments;
  final routName = '/chat';

  Widget sentChat() {
    String message =
        'Lorem ipsum fdsper repyepr ewprewprw rewpep reyp r8 reprp ffdfd fdfsdfsf fefefed';

    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(width: double.infinity),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 5, right: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Column(children: [
                          Text(
                            message,
                            style: blackTextStyle.copyWith(
                                height: 1.6, fontSize: 16),
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            margin: const EdgeInsets.only(top: 5),
                            child: Text(
                              '09.19',
                              textAlign: TextAlign.right,
                              style: greyTextStyle.copyWith(
                                  fontSize: 14, fontWeight: light),
                            ),
                          )
                        ]),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kBGBlueColor),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 0,
                        child: SvgPicture.asset(
                            'assets/polygon_chat_shape_primary.svg'),
                      ),
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget receivedChat() {
    String message =
        'Lorem ipsum fdsper repyepr ewprewprw rewpep reyp r8 reprp ffdfd fdfsdfsf fefefed';

    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 5, left: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Column(children: [
                          Text(
                            message,
                            style: blackTextStyle.copyWith(
                                height: 1.6, fontSize: 16),
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            margin: const EdgeInsets.only(top: 5),
                            child: Text(
                              '09.19',
                              textAlign: TextAlign.right,
                              style: greyTextStyle.copyWith(
                                  fontSize: 14, fontWeight: light),
                            ),
                          )
                        ]),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kBGGreyColor),
                      ),
                      Positioned(
                        bottom: 2,
                        left: 0,
                        child: SvgPicture.asset(
                            'assets/polygon_chat_shape_grey.svg'),
                      ),
                    ],
                  )
                ],
              )),
          const SizedBox(
            width: 10,
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(width: double.infinity),
          ),
        ],
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
        automaticallyImplyLeading: true,
        titleSpacing: 0,
        title: const Text('Claire'),
      ),
      body: SingleChildScrollView(
          // alignment: Alignment.bottomCenter,
          child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 150,
            child: ListView(
              children: [
                sentChat(),
                sentChat(),
                receivedChat(),
                sentChat(),
                sentChat(),
                receivedChat(),
                sentChat(),
                sentChat(),
                receivedChat(),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            color: kWhiteColor,
            child: Row(children: [
              Expanded(
                flex: 7,
                child: TextField(
                  clipBehavior: Clip.none,
                  style: blackTextStyle.copyWith(fontSize: 18),
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    hintText: "Type Message",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(30)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  maxLines: null,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      color: kPrimaryColor),
                  child: IconButton(
                      color: kWhiteColor,
                      onPressed: () {},
                      icon: const Icon(Icons.send)),
                ),
              )
            ]),
          )
        ],
      )),
    );
  }
}
