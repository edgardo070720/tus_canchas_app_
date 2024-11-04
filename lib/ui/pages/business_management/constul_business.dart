import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tus_canchas_app_v2/domain/controllers/business_controller.dart';
import 'package:tus_canchas_app_v2/domain/controllers/system_controllers.dart';
import 'package:tus_canchas_app_v2/domain/controllers/user_controllers.dart';

class BusinessList extends StatefulWidget {
  const BusinessList({super.key});

  @override
  State<BusinessList> createState() => _BusinessListState();
}

class _BusinessListState extends State<BusinessList> {
  SystemControllers systemController = Get.find();
  UserController userController = Get.find();
  BusinessConttroller businessConttroller=Get.find();
  TextEditingController searchTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadBusiness();
  }
  Future<void> loadBusiness() async {
    await businessConttroller.getBusiness(userController.user!.userName);
    setState(() {});
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
      body: ListView(
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
                'Listado de Negocios',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
            ),
          ),
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.054,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: searchTextController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                      prefixIcon: GestureDetector(
                          onTap: () {},
                          child: const Icon(Icons.search_outlined)),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            searchTextController.text = '';
                          },
                          child: const Icon(Icons.close_outlined))),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
              itemCount: businessConttroller.businessList?.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text('${businessConttroller.businessList?[index].businessName.substring(0,1).toString().toUpperCase()}'),
                    ),
                    title: Text('${businessConttroller.businessList?[index].businessName}'),
                    subtitle: Text('NIT: ${businessConttroller.businessList?[index].NIT}'),
                    trailing: SizedBox(
                      width: MediaQuery.of(context).size.width*0.25,
                      child: Row(
                        children: [
                          IconButton(onPressed:(){}, icon:const Icon(Icons.delete,color: Colors.red,)),
                          IconButton(onPressed:(){}, icon:const Icon(Icons.edit,color:  Color.fromARGB(255, 94, 23, 235),)),
                        ],
                      ),
                    ),
                  ),
                );
              },
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
                        systemController.welcomeName ?? '',
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
                    onTap: () {
                      Get.toNamed('/seveSportsField');
                    },
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    systemController.seletedNavegationHome();
                  });
                  Get.toNamed('/home');
                },
                icon: Icon(
                  Icons.house,
                  color: (systemController.seletedNavegation == 0)
                      ? const Color.fromARGB(255, 94, 23, 235)
                      : const Color.fromARGB(125, 30, 30, 30),
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      systemController.seletedNavegationPersonalIformation();
                    });
                  },
                  icon: Icon(
                    Icons.person,
                    color: (systemController.seletedNavegation == 2)
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
