class UserModel{
  final String? uid;
  final String nickname;
  final String email;
  final String password;

  const UserModel({
    this.uid,
    required this.email,
    required this.nickname,
    required this.password,
  });

  toJson(){
    return {
      "UserID": uid,
      "Nickname": nickname,
      "Email": email,
      "Password": password,
    };
  }
}