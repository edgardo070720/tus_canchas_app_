import 'package:tus_canchas_app_v2/domain/models/owner.dart';
import 'package:tus_canchas_app_v2/domain/models/sports_field.dart';

class Business {
  late String NIT;
  late String businessName;
  late String departament;
  late String city;
  late String address;
  late String email;
  late int phoneNumber;
  late List<SportsField> sportsFieldList;
  late Owner? owner;

  Business(
      {required this.NIT,
      required this.businessName,
      required this.departament,
      required this.city,
      required this.address,
      required this.email,
      required this.phoneNumber,
      required this.sportsFieldList,
      required this.owner});

  factory Business.fromJson(Map<String, dynamic> dataJson,
      List<SportsField> sports_field_list, Owner _owner) {
    return Business(
        NIT: dataJson['NIT'] ?? 'not NIT',
        businessName: dataJson['business_name'] ?? 'not business name',
        departament: dataJson['departament'] ?? 'not departament',
        city: dataJson['city'] ?? 'not city',
        address: dataJson['address'] ?? 'not address',
        email: dataJson['email'] ?? 'not email',
        phoneNumber: dataJson['phone_number'] ?? 0,
        sportsFieldList: sports_field_list,
        owner: _owner);
  }

  Map<String, dynamic> toMap() {
    return {
      'NIT': NIT,
      'business_name': businessName,
      'departament': departament,
      'city': city,
      'address': address,
      'email': email,
      'phone_number': phoneNumber
    };
  }
}
