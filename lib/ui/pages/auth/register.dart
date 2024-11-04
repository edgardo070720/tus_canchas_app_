import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tus_canchas_app_v2/domain/controllers/client_controllers.dart';
import 'package:tus_canchas_app_v2/domain/controllers/owner_controllers.dart';
import 'package:tus_canchas_app_v2/domain/controllers/user_controllers.dart';
import 'package:tus_canchas_app_v2/domain/models/business.dart';
import 'package:tus_canchas_app_v2/domain/models/client.dart';
import 'package:tus_canchas_app_v2/domain/models/owner.dart';
import 'package:tus_canchas_app_v2/domain/models/reservation.dart';
import 'package:tus_canchas_app_v2/domain/models/user.dart';

import 'widgets_auth.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  TextEditingController email_text_controller = TextEditingController();
  TextEditingController password_confirm_text_controller =
      TextEditingController();
  TextEditingController password_text_controller = TextEditingController();
  TextEditingController id_text_controller = TextEditingController();
  TextEditingController name_text_controller = TextEditingController();
  TextEditingController last_name_text_controller = TextEditingController();
  TextEditingController ege_text_controller = TextEditingController();
  TextEditingController departament_text_controller = TextEditingController();
  TextEditingController city_text_controller = TextEditingController();
  TextEditingController address_text_controller = TextEditingController();
  TextEditingController phone_number_text_controller = TextEditingController();
  OwnerController ownerController = Get.find();
  ClientController clientController = Get.find();
  UserController userController = Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String selected_option = '--Seleccione tipo de usuario--';
  List<String> items = [
    '--Seleccione tipo de usuario--',
    'Propietario',
    'Cliente'
  ];

  void changeValueItems(String selectedItem) {
    setState(() {
      selected_option = selectedItem;
    });
  }

  Future<void> validateFields() async {
    if (formKey.currentState!.validate() &&
        selected_option != '--Seleccione tipo de usuario--') {
      if (password_text_controller.text ==
          password_confirm_text_controller.text) {
        bool userValidate = await userController
            .userValidateExistence(email_text_controller.text);
        if (!userValidate) {
          seveData();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('¡Su registro fue exitoso, bienvenido!'),
            backgroundColor: Colors.green,
          ));
          cleanFields();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('¡Ya existe un usuario registrado con este correo!'),
            backgroundColor: Colors.red,
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('¡Los campos de contraseña no coinciden!'),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('¡Asegurese se llenar todos los campos!'),
        backgroundColor: Colors.red,
      ));
    }
    setState(() {});
  }

  void cleanFields() {
    email_text_controller.text = '';
    password_confirm_text_controller.text = '';
    password_text_controller.text = '';
    id_text_controller.text = '';
    name_text_controller.text = '';
    last_name_text_controller.text = '';
    ege_text_controller.text = '';
    departament_text_controller.text = '';
    city_text_controller.text = '';
    address_text_controller.text = '';
    phone_number_text_controller.text = '';
  }

  void seveData() {
    User user = User(
        userName: email_text_controller.text,
        password: password_text_controller.text,
        typeUser: selected_option);
    userController.seveUser(user.toMap());
    if (selected_option == 'Propietario') {
      List<Business> businessList = [];
      Owner owner = Owner(
          ownerId: id_text_controller.text,
          ownerName: name_text_controller.text,
          ownerLastName: last_name_text_controller.text,
          ownerEge: int.parse(ege_text_controller.text),
          departament: departament_text_controller.text,
          city: city_text_controller.text,
          address: address_text_controller.text,
          email: email_text_controller.text,
          phoneNumber: int.parse(phone_number_text_controller.text),
          ownerUser: user,
          businessList: businessList);
      ownerController.seveOwner(owner.toMap());
    } else {
      List<Reservation> reservatioList = [];
      if (selected_option == 'Cliente') {
        ClientReservation client = ClientReservation(
            clientId: id_text_controller.text,
            clientName: name_text_controller.text,
            clientLastName: last_name_text_controller.text,
            clientEge: int.parse(ege_text_controller.text),
            departament: departament_text_controller.text,
            city: city_text_controller.text,
            address: address_text_controller.text,
            email: email_text_controller.text,
            phoneNumber: int.parse(phone_number_text_controller.text),
            clientUser: user,
            reservatioList: reservatioList);
        clientController.seveClient(client.toMap());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/auth/background_register.png'),
            fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: formKey,
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: const Color.fromARGB(222, 30, 30, 30),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/auth/logo_login.png'),
                                          fit: BoxFit.fill)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 1,
                              child: ListView(
                                children: [
                                  TextFieldLoginRegister(
                                      text_controller: id_text_controller,
                                      text: 'Identificación',
                                      password: false,
                                      typeNumber: true),
                                  TextFieldLoginRegister(
                                      text_controller: name_text_controller,
                                      text: 'Nombres',
                                      password: false,
                                      typeNumber: false),
                                  TextFieldLoginRegister(
                                      text_controller:
                                          last_name_text_controller,
                                      text: 'Apellidos',
                                      password: false,
                                      typeNumber: false),
                                  TextFieldLoginRegister(
                                      text_controller: ege_text_controller,
                                      text: 'edad',
                                      password: false,
                                      typeNumber: true),
                                  TextFieldLoginRegister(
                                      text_controller:
                                          departament_text_controller,
                                      text: 'Departamento',
                                      password: false,
                                      typeNumber: false),
                                  TextFieldLoginRegister(
                                      text_controller: city_text_controller,
                                      text: 'Ciudad',
                                      password: false,
                                      typeNumber: false),
                                  TextFieldLoginRegister(
                                      text_controller: address_text_controller,
                                      text: 'Dirección',
                                      password: false,
                                      typeNumber: false),
                                  TextFieldLoginRegister(
                                      text_controller:
                                          phone_number_text_controller,
                                      text: 'Telefono',
                                      password: false,
                                      typeNumber: true),
                                  TextFieldLoginRegister(
                                      text_controller: email_text_controller,
                                      text: 'Correo',
                                      password: false,
                                      typeNumber: false),
                                  TextFieldLoginRegister(
                                      text_controller: password_text_controller,
                                      text: 'Contraseña',
                                      password: true,
                                      typeNumber: false),
                                  TextFieldLoginRegister(
                                    text_controller:
                                        password_confirm_text_controller,
                                    text: 'Confirmar contraseña',
                                    password: true,
                                    typeNumber: false,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.063,
                                      child: DropdownButton<String>(
                                        dropdownColor: Colors.amber,
                                        value: selected_option,
                                        onChanged: (value) {
                                          changeValueItems(value!);
                                        },
                                        icon: Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05),
                                          child:
                                              const Icon(Icons.arrow_drop_down),
                                        ),
                                        items: items.map((String item) {
                                          return DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                '  $item',
                                                style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 20),
                                              ));
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.026,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.86,
                              height:
                                  MediaQuery.of(context).size.height * 0.057,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(255, 0, 154, 80))),
                                onPressed: () {
                                  validateFields();
                                },
                                child: const Text(
                                  'Sing Up',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('¿Ya estas Registrado?',
                                      style: TextStyle(color: Colors.white)),
                                  GestureDetector(
                                      onTap: () {
                                        Get.toNamed('/login');
                                      },
                                      child: const Text(
                                        'Iniciar Sesión',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 0, 154, 80)),
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.toNamed('/home');
                      },
                      icon: const Icon(Icons.home),
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
