import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tus_canchas_app_v2/domain/models/business.dart';
import 'package:tus_canchas_app_v2/domain/models/owner.dart';

import '../../domain/models/user.dart';
import 'user_requests.dart';

class OwnerRequest{
  static final FirebaseFirestore dataBase=FirebaseFirestore.instance;
  static Future<void> seveOwner(Map<String,dynamic> owner)async{
    await dataBase.collection('owners').doc().set(owner).catchError((e)=>print(e));
    print('se guardo el propietario');
  }

  
  static Future<Owner> getOwners(String user)async{
    List<User> userList =await UserRequest.getUser();
    return await dataBase.collection('owners').get().then((value){
      List<Business> businessList = [];
      late Map<String, dynamic> ownerMap;
      late Owner owner;
      value.docs.forEach((element) {
        if (element.data()['email'] == user) {
          ownerMap = element.data();
        }
      });
      userList.forEach((element) {
        if (element.userName == user) {
          owner =
              Owner.fromJson(ownerMap, businessList, element);
        }
      });
      return owner;
    });
  }
}