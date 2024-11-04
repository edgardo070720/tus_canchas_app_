class User {
  late String userName;
  late String password;
  late String typeUser;

  User({required this.userName, required this.password, required this.typeUser});

  factory User.fromJson(Map<String, dynamic> dataJson) {
    return User(
        userName: dataJson['user_name'] ?? 'not user',
        password: dataJson['password'] ?? 'not password',
        typeUser: dataJson['type_user']??'');

  }

  Map<String, dynamic> toMap() {
    return {'user_name': userName, 'password': password,'type_user':typeUser};
  }
}
