import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tus_canchas_app_v2/domain/controllers/client_controllers.dart';
import 'package:tus_canchas_app_v2/domain/controllers/owner_controllers.dart';
import 'package:tus_canchas_app_v2/domain/controllers/user_controllers.dart';

import 'widgets_auth.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController user_text_controller = TextEditingController();
  TextEditingController password_text_controller = TextEditingController();
  UserController userController = Get.find();
  ClientController clientController = Get.find();
  OwnerController ownerController = Get.find();
  bool sessionValidate = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> userValidate() async {
    sessionValidate = await userController.userValidate(
        user_text_controller.text, password_text_controller.text);
    await userController.loadUser(
        user_text_controller.text, password_text_controller.text);
    validateFields(formKey, sessionValidate, context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/auth/background_login.png'),
              fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: const Color.fromARGB(56, 255, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
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
                          TextFieldLoginRegister(
                              text_controller: user_text_controller,
                              text: 'Correo',
                              password: false,
                              typeNumber: false),
                          TextFieldLoginRegister(
                            text_controller: password_text_controller,
                            text: 'Contraseña',
                            password: true,
                            typeNumber: false,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.86,
                            height: MediaQuery.of(context).size.height * 0.057,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 0, 154, 80))),
                              onPressed: () {
                                print(sessionValidate);
                                userValidate();
                              },
                              child: const Text(
                                'log In',
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
                                const Text('¿No estas registrado?',
                                    style: TextStyle(color: Colors.white)),
                                GestureDetector(
                                    onTap: () {
                                      Get.toNamed('/register');
                                    },
                                    child: const Text(
                                      'Registrarse',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 0, 154, 80)),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
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
        ),
      ),
    );
  }

  void validateFields(GlobalKey<FormState> formKey, bool sessionValidate,
      BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (sessionValidate) {
        if(userController.user?.typeUser=='Propietario'){
          Get.toNamed('/businessList');
        }else{
          Get.toNamed('/home');
        }
        
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('¡Su usuario o contraseña son incorrectas!'),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('¡Asegurese se llenar los campos!'),
        backgroundColor: Colors.red,
      ));
    }
  }
}
