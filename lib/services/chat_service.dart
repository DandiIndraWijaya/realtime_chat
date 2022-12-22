import 'package:firebase_database/firebase_database.dart';

class ChatService {
  final _db = FirebaseDatabase.instance;

  createChatMessage(String chatUid, String message, String messageDate,
      String messageTime, String sentBy) {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    DatabaseReference ref = _db.ref("/chatMessages/$chatUid/$timestamp");
    ref.set({
      'message': message,
      'messageDate': messageDate,
      'messageTime': messageTime,
      'sentBy': sentBy,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'isDeleted': false
    });
  }
}
