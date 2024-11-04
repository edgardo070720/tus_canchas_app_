import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tus_canchas_app_v2/data/service/user_requests.dart';
import 'package:tus_canchas_app_v2/domain/models/client.dart';
import 'package:tus_canchas_app_v2/domain/models/reservation.dart';
import 'package:tus_canchas_app_v2/domain/models/user.dart';

class ClientRequest {
  static final FirebaseFirestore dataBase = FirebaseFirestore.instance;
  static Future<void> seveClient(Map<String, dynamic> client) async {
    await dataBase
        .collection('clients')
        .doc()
        .set(client)
        .catchError((e) => print(e));
  }

  static Future<ClientReservation> getClients(String user) async {
    List<User> userList = await UserRequest.getUser();
    return await dataBase.collection('clients').get().then((value) {
      late ClientReservation client;
      List<Reservation> reservationList = [];
      late Map<String, dynamic> clientMap;
      for (var element in value.docs) {
        if (element.data()['email'] == user) {
          clientMap = element.data();
          break;
        }
      }
      for (var element in userList) {
        if (element.userName == user) {
          client =
              ClientReservation.fromJson(clientMap, reservationList, element);
          break;
        }
      }
      return client;
    });
  }
}
