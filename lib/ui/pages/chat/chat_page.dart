import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_chat/helpers/chat_messages_sort.dart';
import 'package:realtime_chat/models/chat_message.dart';
import 'package:realtime_chat/models/chat_message_stream_publisher.dart';
import 'package:realtime_chat/shared/theme.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:realtime_chat/ui/pages/chat/chat_page_controller.dart';
import 'package:realtime_chat/ui/widgets/chat/receivedChat.dart';
import 'package:realtime_chat/ui/widgets/chat/sentChat.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);

  final argumentData = Get.arguments;
  final routName = '/chat';
  final ScrollController _scrollController = ScrollController();
  final chatPageController = ChatPageController();

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
    runScroll() {
      Timer(
          const Duration(milliseconds: 100),
          () => _scrollController
              .jumpTo(_scrollController.position.maxScrollExtent));
    }

    return GetBuilder<ChatPageController>(
        init: chatPageController,
        builder: (_) {
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
                  child: StreamBuilder(
                      stream: ChatMessageStreamPublisher()
                          .getChatMessageStream(Get.arguments['chatUid']),
                      builder: (context, snapshot) {
                        final List<ChatMessage> chatMessages;
                        if (snapshot.hasData) {
                          chatMessages =
                              runQuickSort(snapshot.data as List<ChatMessage>);
                        } else {
                          chatMessages = [];
                        }

                        return ListView.builder(
                            controller: _scrollController,
                            itemCount: chatMessages.length,
                            itemBuilder: (context, index) {
                              runScroll();
                              if (chatMessages[index].sentBy ==
                                  chatPageController.loggedInUser!.id) {
                                return SentChat(
                                  message:
                                      chatMessages[index].message.toString(),
                                );
                              }
                              return ReceivedChat(
                                message: chatMessages[index].message.toString(),
                              );
                            });
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
                        controller: chatPageController.typedMessage,
                        clipBehavior: Clip.none,
                        style: blackTextStyle.copyWith(fontSize: 18),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 20),
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                            color: kPrimaryColor),
                        child: IconButton(
                            color: kWhiteColor,
                            onPressed: () => chatPageController
                                .sendMessage(Get.arguments['chatUid']),
                            icon: const Icon(Icons.send)),
                      ),
                    )
                  ]),
                )
              ],
            )),
          );
        });
  }
}
