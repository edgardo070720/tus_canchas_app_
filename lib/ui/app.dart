import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tus_canchas_app_v2/ui/pages/auth/login.dart';
import 'package:tus_canchas_app_v2/ui/pages/auth/register.dart';
import 'package:tus_canchas_app_v2/ui/pages/business_management/constul_business.dart';
import 'package:tus_canchas_app_v2/ui/pages/business_management/seve_business.dart';
import 'package:tus_canchas_app_v2/ui/pages/home/home.dart';
import 'package:tus_canchas_app_v2/ui/pages/sports_field_management/seve_sports_field.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.grey, useMaterial3: true),
      title: 'Material App',
      initialRoute: '/home',
      routes: {
        '/home': (context)=> const Home(),
        '/login': (context) => const Login(),
        '/register': (context) => const RegisterUser(),
        '/seveSportsField':(context)=>const SeveSportsFieldState(),
        '/seveBusiness':(context)=> const SeveBusiness(),
        '/businessList':(context)=>const BusinessList(),
      },
    );
  }
}
