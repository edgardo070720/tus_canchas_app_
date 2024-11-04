import 'package:tus_canchas_app_v2/domain/models/reservation.dart';
import 'package:tus_canchas_app_v2/domain/models/user.dart';

class ClientReservation{
  late String clientId;
  late String clientName;
  late String clientLastName;
  late int clientEge;
  late String departament;
  late String city;
  late String address;
  late String email;
  late int phoneNumber;
  late User clientUser;
  late List<Reservation> reservatioList;

  ClientReservation(
      {required this.clientId,
      required this.clientName,
      required this.clientLastName,
      required this.clientEge,
      required this.departament,
      required this.city,
      required this.address,
      required this.email,
      required this.phoneNumber,
      required this.clientUser,
      required this.reservatioList});

  factory ClientReservation.fromJson(Map<String, dynamic> dataJson,List<Reservation> reservation_list, User _user ) {
    return ClientReservation(
        clientId: dataJson['client_id'] ?? 'NN',
        clientName: dataJson['client_name'] ?? 'not name',
        clientLastName: dataJson['client_last_name'] ?? 'not last name',
        clientEge: dataJson['client_ege'] ?? 0,
        departament: dataJson['departament'] ?? 'not departament',
        city: dataJson['city'] ?? 'not city',
        address: dataJson['address'] ?? 'not address',
        email: dataJson['email'] ?? 'not email',
        phoneNumber: dataJson['phone_number'] ?? 0000,
        clientUser:_user,
        reservatioList: reservation_list);
  }

  Map<String, dynamic> toMap() {
    return {
      'client_id': clientId,
      'client_name': clientName,
      'client_last_name': clientLastName,
      'client_ege': clientEge,
      'departament': departament,
      'city': city,
      'address': address,
      'email': email,
      'phone_number': phoneNumber
    };
  }
}