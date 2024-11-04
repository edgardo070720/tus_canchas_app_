import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tus_canchas_app_v2/domain/controllers/system_controllers.dart';
import 'package:tus_canchas_app_v2/domain/controllers/user_controllers.dart';

class SeveSportsFieldState extends StatefulWidget {
  const SeveSportsFieldState({super.key});

  @override
  State<SeveSportsFieldState> createState() => _SeveSportsFieldStateState();
}

class _SeveSportsFieldStateState extends State<SeveSportsFieldState> {
  TextEditingController nameSportsFieldController = TextEditingController();
  TextEditingController valueHourController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserController userController = Get.find();
  SystemControllers systemControllers = Get.find();
  String selected_option = '--seleccione tipo de cancha--';
  List<String> items = ['--seleccione tipo de cancha--'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addOptions();
  }

  void changeValueItems(String selectedItem) {
    setState(() {
      selected_option = selectedItem;
    });
  }

  void addOptions() {
    systemControllers.typeSportsField?.forEach((element) {
      items.add(element);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  // visible: session_state,
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
                    onTap: () {Get.toNamed('/seveSportsField');},
                    title: const Text('Gestion Canchas'),
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
                  borderRadius: BorderRadius.circular(15), color: Colors.black),
              child: const Center(
                  child: Text(
                'Registro de cancha',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.06,
              height: MediaQuery.of(context).size.height * 0.04,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 94, 23, 235)),
              child: const Center(
                  child: Text(
                'Datos de la cancha',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 15),
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.063,
              child: DropdownButton<String>(
                dropdownColor: const Color.fromARGB(255, 94, 23, 235),
                value: selected_option,
                onChanged: (value) {
                  changeValueItems(value!);
                },
                icon: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05),
                  child: const Icon(Icons.arrow_drop_down),
                ),
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        '  $item',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 20),
                      ));
                }).toList(),
              ),
            ),
          ),
          TextFieldSeveSportsField(
              text: 'Nombre de la cancha',
              textControllers: nameSportsFieldController,
              typeKeyboard: false,
              maxLine: 1),
          TextFieldSeveSportsField(
              textControllers: valueHourController,
              text: 'Valor por hora',
              typeKeyboard: true,
              maxLine: 1),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.06,
              height: MediaQuery.of(context).size.height * 0.04,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 94, 23, 235)),
              child: const Center(
                  child: Text(
                'Información adicional',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 15),
              )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 50),
            child: Text(
              'foto 1',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 100),
            child: Container(
              decoration: BoxDecoration(color: Colors.grey[200]),
              width: 80,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'seleccionar archivo',
                      style: TextStyle(color: Colors.grey[800], fontSize: 18),
                    ),
                    GestureDetector(
                        child: const Icon(
                      Icons.archive,
                      size: 30,
                    ))
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 50),
            child: Text(
              'foto 2',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 100),
            child: Container(
              decoration: BoxDecoration(color: Colors.grey[200]),
              width: 80,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'seleccionar archivo',
                      style: TextStyle(color: Colors.grey[800], fontSize: 18),
                    ),
                    GestureDetector(
                        child: const Icon(
                      Icons.archive,
                      size: 30,
                    ))
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 50),
            child: Text(
              'foto 3',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 100),
            child: Container(
              decoration: BoxDecoration(color: Colors.grey[200]),
              width: 80,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'seleccionar archivo',
                      style: TextStyle(color: Colors.grey[800], fontSize: 18),
                    ),
                    GestureDetector(
                        child: const Icon(
                      Icons.archive,
                      size: 30,
                    ))
                  ],
                ),
              ),
            ),
          ),
          TextFieldSeveSportsField(
              textControllers: detailController,
              text: 'descripción de la cancha...',
              typeKeyboard: false,
              maxLine: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                            fontWeight: FontWeight.bold
                          ),
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
                        onPressed: () {},
                        child: const Text(
                          'Registrar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
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
                    Get.toNamed('/home');
                  },
                  icon: Icon(
                    Icons.house,
                    color: (systemControllers.seletedNavegation == 0)
                        ? const Color.fromARGB(255, 94, 23, 235)
                        : const Color.fromARGB(125, 30, 30, 30),
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      systemControllers.seletedNavegationfavorite();
                    });
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: (systemControllers.seletedNavegation == 1)
                        ? const Color.fromARGB(255, 94, 23, 235)
                        : const Color.fromARGB(125, 30, 30, 30),
                  )),
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

class TextFieldSeveSportsField extends StatelessWidget {
  const TextFieldSeveSportsField(
      {super.key,
      required this.textControllers,
      required this.text,
      required this.typeKeyboard,
      required this.maxLine});
  final TextEditingController textControllers;
  final String text;
  final bool typeKeyboard;
  final int maxLine;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: textControllers,
        maxLines: maxLine,
        keyboardType:
            (typeKeyboard) ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            hintText: text,
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red))),
      ),
    );
  }
}
