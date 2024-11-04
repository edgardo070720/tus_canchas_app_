import 'package:get/get.dart';
import 'package:tus_canchas_app_v2/data/service/owner_requests.dart';

import '../models/owner.dart';

class OwnerController extends GetxController {
  final Rxn<Owner> _owner = Rxn();
  Future<void> seveOwner(Map<String, dynamic> owner) async {
    await OwnerRequest.seveOwner(owner);
  }

  Future<void> getOwner(String user) async {
    _owner.value = await OwnerRequest.getOwners(user);
  }

  Owner? get owner => _owner.value;
}
