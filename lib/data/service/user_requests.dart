import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tus_canchas_app_v2/domain/models/user.dart';

class UserRequest{
  static final FirebaseFirestore dataBase=FirebaseFirestore.instance;

  static Future<List<User>> getUser()async{
    return await dataBase.collection('Users').get().then((value){
      late List<User> userList=[];
      value.docs.forEach((element) {
        userList.add(User.fromJson(element.data()));
      });
      return userList;
    });
  } 

  static Future<void> seveUser(Map<String, dynamic> user)async{
    await dataBase
        .collection('Users')
        .doc()
        .set(user)
        .catchError((e) => print(e));
    print('se guardo el usuario');
  }
}