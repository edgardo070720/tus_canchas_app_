import 'package:get/get.dart';
import 'package:tus_canchas_app_v2/data/service/client_requests.dart';

import '../models/client.dart';

class ClientController extends GetxController{
   final Rxn<ClientReservation> _client=Rxn();
  Future<void> seveClient(Map<String,dynamic> client)async{
    await ClientRequest.seveClient(client);
  }

  Future<void> getClient(String user)async{
    
    _client.value=await ClientRequest.getClients(user);
    
  }
  ClientReservation? get client=>_client.value;
}