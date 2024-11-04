import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tus_canchas_app_v2/data/service/owner_requests.dart';
import 'package:tus_canchas_app_v2/domain/models/business.dart';
import 'package:tus_canchas_app_v2/domain/models/owner.dart';
import 'package:tus_canchas_app_v2/domain/models/sports_field.dart';

class BusinessRequest {
  static final FirebaseFirestore dataBase = FirebaseFirestore.instance;

  static Future<void> seveBusiness(Map<String, dynamic> business, String id) async {
    business['owner_id']=id;
    await dataBase.collection('Business').doc().set(business).catchError((e) {
      print(e);
    });
  }

  static Future<List<Business>> getBusiness(String user) async {
    Owner owner = await OwnerRequest.getOwners(user);
    return await dataBase.collection('Business').get().then((value) {
      List<Map<String, dynamic>> businessMapList = [];
      List<Business> businessList = [];
      List<SportsField> sportsFieldList = [];
      value.docs.forEach((element) {
          businessMapList.add(element.data());
      });
      businessMapList.forEach((element) {
        if (element['owner_id'] == owner.ownerId) {
          businessList.add(Business.fromJson(element, sportsFieldList, owner));
        }
      });
      print(businessList.length);
      return businessList;
    });
  }
}
