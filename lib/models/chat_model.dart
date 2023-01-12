class Chat {
  late String uid;
  late List<String> members;
  late String lastMessageSent;
  late bool isDeleted;
  late int createdAt;
  late int updatedAt;

  Chat(
      {required this.uid,
      required this.members,
      required this.lastMessageSent,
      required this.isDeleted,
      required this.createdAt,
      required this.updatedAt});

  factory Chat.fromRTDB(String uid, Map<String, dynamic> data) {
    return Chat(
        uid: uid,
        members: List<String>.from(data['members'] as List<Object?>),
        lastMessageSent: data['lastMessageSent'],
        isDeleted: data['isDeleted'],
        createdAt: data['createdAt'],
        updatedAt: data['updatedAt']);
  }
}
