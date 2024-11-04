import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tus_canchas_app_v2/domain/controllers/business_controller.dart';
import 'package:tus_canchas_app_v2/domain/controllers/client_controllers.dart';
import 'package:tus_canchas_app_v2/domain/controllers/owner_controllers.dart';
import 'package:tus_canchas_app_v2/domain/models/business.dart';
import 'package:tus_canchas_app_v2/domain/models/owner.dart';

import '../../../domain/controllers/system_controllers.dart';
import '../../../domain/controllers/user_controllers.dart';
import '../../../domain/models/sports_field.dart';
import 'widget_seve_business.dart';

class SeveBusiness extends StatefulWidget {
  const SeveBusiness({super.key});

  @override
  State<SeveBusiness> createState() => _SeveBusinessState();
}

class _SeveBusinessState extends State<SeveBusiness> {
  TextEditingController NITController = TextEditingController();
  TextEditingController nameBusinessController = TextEditingController();
  TextEditingController departamentController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserController userController = Get.find();
  BusinessConttroller businessConttroller = Get.find();
  SystemControllers systemControllers = Get.find();
  OwnerController ownerController=Get.find();
  ClientController clientController=Get.find();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void seveData() {
    List<SportsField> sportsFieldList = [];
    Owner? owner= ownerController.owner;
    Business business = Business(
        NIT: NITController.text,
        businessName: nameBusinessController.text,
        departament: departamentController.text,
        city: cityController.text,
        address: addressController.text,
        email: emailController.text,
        phoneNumber: int.parse(phoneNumberController.text),
        sportsFieldList: sportsFieldList,owner:owner);
        print(owner);
        print(business);
    businessConttroller.seveBusiness(business.toMap(),owner!.ownerId);
  }
  Future<void> seeWelomeName() async {
    if (userController.typeUser == 'Cliente') {
      await clientController.getClient(userController.user!.userName);
    } else {
      if (userController.typeUser == 'Propietario') {
        await ownerController.getOwner(userController.user!.userName);
      }
    }

    if (userController.typeUser == 'Propietario') {
      systemControllers.setWelcomeName(ownerController.owner!.ownerName);
    } else {
      if (userController.typeUser == 'Cliente') {
        systemControllers.setWelcomeName(clientController.client!.clientName);
      }
    }
    setState(() {});
  }
  Future<void> validateFields() async {
    if (formKey.currentState!.validate()) {
      seveData();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('¡Su registro fue exitoso, bienvenido!'),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('¡Asegurese se llenar todos los campos!'),
        backgroundColor: Colors.red,
      ));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
      setState(() {
      seeWelomeName();
    });
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 50,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/auth/logo_login.png'),
                      fit: BoxFit.fill)),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.sports_soccer,
              size: 35,
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DrawerHeader(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/auth/logo_login.png'),
                                  fit: BoxFit.fill)),
                        ),
                      ),
                      const Text(
                        '¡Hola!',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Text(
                        systemControllers.welcomeName ?? '',
                        style: const TextStyle(color: Colors.grey, fontSize: 9),
                      )
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {},
                  title: const Text('Canchas'),
                  leading: const Icon(Icons.sports_soccer_outlined),
                ),
                Visibility(
                  visible: userController.sessionState ?? false,
                  child: ListTile(
                    onTap: () {},
                    title: const Text('Editar Iformación'),
                    leading: const Icon(Icons.person),
                  ),
                ),
                Visibility(
                  child: ListTile(
                    onTap: () {},
                    title: const Text('Gestion Reservas'),
                    leading: const Icon(Icons.edit),
                  ),
                ),
                Visibility(
                  visible: (userController.typeUser=='Propietario')?true:false,
                  child: ListTile(
                    onTap: () {
                      Get.toNamed('/seveBusiness');
                    },
                    title: const Text('Registrar Negocio'),
                    leading: const Icon(Icons.add_circle),
                  ),
                ),
              
                Visibility(
                  // visible: session_state,
                  child: ListTile(
                    onTap: () {},
                    title: const Text('Gestion Quejas'),
                    leading: const Icon(Icons.announcement_rounded),
                  ),
                ),
              ],
            ),
            Container(
              color: const Color.fromARGB(255, 94, 23, 235),
              child: ListTile(
                onTap: () {
                  if (userController.sessionState == true) {
                    userController.singOff();
                  }
                  Get.toNamed('/login');
                },
                title: (userController.sessionState == false)
                    ? const Text(
                        'Iniciar Sesión',
                        style: TextStyle(color: Colors.white),
                      )
                    : const Text(
                        'Cerrar Sesión',
                        style: TextStyle(color: Colors.white),
                      ),
                leading: (userController.sessionState == false)
                    ? const Icon(
                        Icons.login_rounded,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.logout_rounded,
                        color: Colors.white,
                      ),
              ),
            )
          ],
        ),
      ),
      body: Form(
          key: formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black),
                  child: const Center(
                      child: Text(
                    'Registro del Negocio',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.06,
                  height: MediaQuery.of(context).size.height * 0.04,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 94, 23, 235)),
                  child: const Center(
                      child: Text(
                    'Datos del Negocio',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )),
                ),
              ),
              TextFieldSeveBusiness(
                  text: 'NIT',
                  textControllers: NITController,
                  typeKeyboard: false,
                  maxLine: 1),
              TextFieldSeveBusiness(
                  textControllers: nameBusinessController,
                  text: 'Nombre del negocio',
                  typeKeyboard: false,
                  maxLine: 1),
              TextFieldSeveBusiness(
                  textControllers: departamentController,
                  text: 'Departamento',
                  typeKeyboard: false,
                  maxLine: 1),
              TextFieldSeveBusiness(
                  textControllers: cityController,
                  text: 'Ciudad',
                  typeKeyboard: false,
                  maxLine: 1),
              TextFieldSeveBusiness(
                  textControllers: addressController,
                  text: 'Dirección',
                  typeKeyboard: false,
                  maxLine: 1),
              TextFieldSeveBusiness(
                  textControllers: emailController,
                  text: 'Email',
                  typeKeyboard: false,
                  maxLine: 1),
              TextFieldSeveBusiness(
                  textControllers: phoneNumberController,
                  text: 'Numero de telefono',
                  typeKeyboard: true,
                  maxLine: 1),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.057,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 30, 30, 30))),
                            onPressed: () {},
                            child: const Text(
                              'Cancelar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.057,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 0, 154, 80))),
                            onPressed: () {
                              validateFields();
                            },
                            child: const Text(
                              'Registrar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    systemControllers.seletedNavegationHome();
                  });
                  Get.toNamed('/businessList');
                },
                icon: Icon(
                  Icons.house,
                  color: (systemControllers.seletedNavegation == 0)
                      ? const Color.fromARGB(255, 94, 23, 235)
                      : const Color.fromARGB(125, 30, 30, 30),
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      systemControllers.seletedNavegationPersonalIformation();
                    });
                  },
                  icon: Icon(
                    Icons.person,
                    color: (systemControllers.seletedNavegation == 2)
                        ? const Color.fromARGB(255, 94, 23, 235)
                        : const Color.fromARGB(125, 30, 30, 30),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
