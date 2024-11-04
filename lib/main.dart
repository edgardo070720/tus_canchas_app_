import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tus_canchas_app_v2/domain/controllers/business_controller.dart';
import 'package:tus_canchas_app_v2/domain/controllers/client_controllers.dart';
import 'package:tus_canchas_app_v2/domain/controllers/owner_controllers.dart';
import 'package:tus_canchas_app_v2/domain/controllers/system_controllers.dart';
import 'package:tus_canchas_app_v2/domain/controllers/user_controllers.dart';

import 'firebase_options.dart';
import 'ui/app.dart';

void main() {
  initServices();
}

Future<void> initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServicesBinding.instance;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(SystemControllers());
  Get.put(UserController());
  Get.put(ClientController());
  Get.put(OwnerController());
  Get.put(BusinessConttroller());
  runApp(const MyApp());
}
