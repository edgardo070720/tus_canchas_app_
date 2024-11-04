import 'package:tus_canchas_app_v2/domain/models/business.dart';
import 'package:tus_canchas_app_v2/domain/models/user.dart';

class Owner {
  late String ownerId;
  late String ownerName;
  late String ownerLastName;
  late int ownerEge;
  late String departament;
  late String city;
  late String address;
  late String email;
  late int phoneNumber;
  late User ownerUser;
  late List<Business> businessList;

  Owner(
      {required this.ownerId,
      required this.ownerName,
      required this.ownerLastName,
      required this.ownerEge,
      required this.departament,
      required this.city,
      required this.address,
      required this.email,
      required this.phoneNumber,
      required this.ownerUser,
      required this.businessList});

  factory Owner.fromJson(Map<String, dynamic> dataJson,List<Business> business_list,User user) {
    return Owner(
        ownerId: dataJson['owner_id'] ?? 'NN',
        ownerName: dataJson['owner_name'] ?? 'not name',
        ownerLastName: dataJson['owner_last_name'] ?? 'not last name',
        ownerEge: dataJson['owner_ege'] ?? 0,
        departament: dataJson['departament'] ?? 'not departament',
        city: dataJson['city'] ?? 'not city',
        address: dataJson['address'] ?? 'not address',
        email: dataJson['email'] ?? 'not email',
        phoneNumber: dataJson['phone_number'] ?? 0000,
        ownerUser: user,
        businessList: business_list);
  }

  Map<String, dynamic> toMap() {
    return {
      'owner_id': ownerId,
      'owner_name': ownerName,
      'owner_last_name': ownerLastName,
      'owner_ege': ownerEge,
      'departament': departament,
      'city': city,
      'address': address,
      'email': email,
      'phone_number': phoneNumber
    
    };
  }
}
