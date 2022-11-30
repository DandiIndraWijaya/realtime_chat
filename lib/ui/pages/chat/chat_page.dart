import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_chat/shared/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);
  final argumentData = Get.arguments;
  final routName = '/chat';

  final ScrollController _scrollController = ScrollController();

  Widget sentChat(message) {
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
                            style: blackTextStyle.copyWith(fontSize: 16),
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
                            border: Border.all(color: kBGGreyColor),
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

  Widget receivedChat(message) {
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
                            style: blackTextStyle.copyWith(fontSize: 16),
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
                            border: Border.all(color: kPrimaryColor),
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

  var chats = [
    {
      "tipe": "sent",
      "message":
          "Assalamu'alaikum warahmatullahi pak alamsyah. saya Dandi Indra Wijaya Mengenai skripsi saya yang sudah saya revisi, apa hari ini saya bisa bertemu dengan pak alamsyah di kampus untuk membahas revisi skripsi ini pak? Terima kasih."
    },
    {
      "tipe": "sent",
      "message":
          "Assalamu'alaikum warahmatullahi pak alamsyah. saya Dandi Indra Wijaya Mengenai skripsi saya yang sudah saya revisi, apa hari ini saya bisa bertemu dengan pak alamsyah di kampus untuk membahas revisi skripsi ini pak? Terima kasih."
    },
    {
      "tipe": "received",
      "message":
          "Assalamu'alaikum warahmatullahi pak alamsyah. saya Dandi Indra Wijaya Mengenai skripsi saya yang sudah saya revisi, apa hari ini saya bisa bertemu dengan pak alamsyah di kampus untuk membahas revisi skripsi ini pak? Terima kasih."
    },
    {
      "tipe": "received",
      "message":
          "Assalamu'alaikum warahmatullahi pak alamsyah. saya Dandi Indra Wijaya Mengenai skripsi saya yang sudah saya revisi, apa hari ini saya bisa bertemu dengan pak alamsyah di kampus untuk membahas revisi skripsi ini pak? Terima kasih."
    }
  ];
  @override
  Widget build(BuildContext context) {
    Timer(
        const Duration(milliseconds: 100),
        () => _scrollController
            .jumpTo(_scrollController.position.maxScrollExtent));

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        automaticallyImplyLeading: true,
        titleSpacing: 0,
        title: Row(children: [
          const Text('Claire'),
          const Text(' is typing'),
          AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                '...',
                speed: const Duration(milliseconds: 200),
              ),
            ],
            repeatForever: true,
          )
        ]),
      ),
      body: SingleChildScrollView(
          // alignment: Alignment.bottomCenter,
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 150,
            child: ListView.builder(
                controller: _scrollController,
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  if (chats[index]["tipe"] == "sent") {
                    return sentChat(chats[index]["message"]);
                  }
                  return receivedChat(chats[index]["message"]);
                }),
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
                      onPressed: () {
                        print('Send button pressed');
                      },
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
