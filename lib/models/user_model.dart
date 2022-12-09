// import '';

class UserModel {
  late String groupCode;
  late String name;
  late String email;
  late String profilePicture;
  late int createdAt;
  late int updatedAt;
  late bool isSuspended;
  late String token;

  UserModel(
      {required this.groupCode,
      required this.name,
      required this.email,
      this.profilePicture = '',
      this.createdAt = 0,
      this.updatedAt = 0,
      this.isSuspended = false,
      this.token = ''});

  factory UserModel.fromJson(String id, Map<String, dynamic> json) => UserModel(
      groupCode: json['groupCode'],
      name: json['name'],
      email: json['email'],
      profilePicture: json['profilePicture'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      isSuspended: json['isSuspended']);
}
