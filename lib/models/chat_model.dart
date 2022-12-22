import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class ChatModel extends ChangeNotifier {
  final _db = FirebaseDatabase.instance;

  createChat(List<String> members, int createdAt, int updatedAt) {
    DatabaseReference ref = _db.ref("/chats");

    ref.push().set({
      "members": members,
      "lastMessageSent": '',
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "isDeleted": false
    }).then((response) {});
  }

  void _updateChat(String uid, String lastMessageSent, int updatedAt) async {
    DatabaseReference ref = _db.ref("/chats/$uid");

    ref.update({
      "lastMessageSent": lastMessageSent,
      "updatedAt": updatedAt,
    });
  }

  getChatUIDByMembers(List<String> members) async {
    String chatUid = '';
    await _db.ref('/chats').get().then((snapshot) {
      final chats =
          Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);

      List<Map<String, dynamic>> chatList = [];
      chats.forEach((key, value) {
        final chat = Map<String, dynamic>.from(value);
        chatList.add({'uid': key, 'members': chat['members']});
      });

      for (var chat in chatList) {
        if (chat['members'][0] == members[0] ||
            chat['members'][0] == members[1] &&
                chat['members'][1] == members[0] ||
            chat['members'][1] == members[1]) {
          chatUid = chat['uid'];
        }
      }
    }).catchError((error) {
      print(error);
    });

    return chatUid;
  }

  createChatMessage(String chatUid, String message, String messageDate,
      String messageTime, String sentBy) {
    DatabaseReference ref = _db.ref("/chatMessages/$chatUid");
    ref.push().set({
      'message': message,
      'messageDate': messageDate,
      'messageTime': messageTime,
      'sentBy': sentBy,
      'isDeleted': false,
    });
  }

  getChatMessages(String chatUid) {
    DatabaseReference ref = _db.ref("/chatMessages/$chatUid");

    ref.onValue.listen((event) {});
  }
}
