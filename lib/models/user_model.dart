// import '';

class UserModel {
  late String id;
  late String groupCode;
  late String name;
  late String email;
  late String profilePicture;
  late List<dynamic> friends;
  late int createdAt;
  late int updatedAt;
  late bool isSuspended;
  late String token;

  UserModel(
      {required this.id,
      this.groupCode = '',
      required this.name,
      required this.email,
      this.profilePicture = '',
      this.friends = const [],
      this.createdAt = 0,
      this.updatedAt = 0,
      this.isSuspended = false,
      this.token = ''});

  addFriend(friends) {
    this.friends = friends;
  }

  factory UserModel.fromJson(String id, Map<String, dynamic> json) => UserModel(
      id: id,
      groupCode: json['groupCode'],
      name: json['name'],
      email: json['email'],
      profilePicture: json['profilePicture'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      isSuspended: json['isSuspended'],
      friends: json['friends']);
}
