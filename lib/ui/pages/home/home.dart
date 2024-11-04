import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tus_canchas_app_v2/domain/controllers/client_controllers.dart';
import 'package:tus_canchas_app_v2/domain/controllers/owner_controllers.dart';
import 'package:tus_canchas_app_v2/domain/controllers/system_controllers.dart';
import 'package:tus_canchas_app_v2/domain/controllers/user_controllers.dart';
import 'package:tus_canchas_app_v2/ui/pages/business_management/constul_business.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SystemControllers systemControllers = Get.find();
  UserController userController = Get.find();
  ClientController clientController = Get.find();
  OwnerController ownerController = Get.find();
  List<bool> list_state_favorite = List.filled(20, false);
  int selected_navigation = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  Widget seeView(){
    if(userController.typeUser=='Propietario'){
      return const BusinessList();
    }
    return homeView(context);
  }
  Future<void> loadData() async {
    await systemControllers.getTypeSportsField();
    setState(() {});
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
            onPressed: () {
              
            },
            icon: const Icon(
              Icons.sports_soccer,
              size: 35,
            ),
          )
        ],
      ),
      body: seeView(),
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
                        systemControllers.welcomeName??'',
                        style: TextStyle(color: Colors.grey, fontSize: 9),
                      )
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                   
                  },
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
                    onTap: () {Get.toNamed('/seveBusiness');  },
                    title: const Text('Registrar Negocio'),
                    leading: const Icon(Icons.add_circle),
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
    
    );
  }

  ListView homeView(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                  image: AssetImage('assets/images/home/banner_home.png'),
                  fit: BoxFit.fill),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Reserva las mejores canchas\n de los mejores sitios a buen precio.\nAceptamos diversas formas de pago.\n Atencion 24 horas',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.04,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: systemControllers.typeSportsField?.length ?? 0,
              itemBuilder: (context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      systemControllers.seletedOptions(index); 
                    });
                  },
                  child: Text(
                    '${systemControllers.typeSportsField?[index]}  ',
                    style: TextStyle(
                        fontSize: 20,
                        decoration: (systemControllers.selected_option == index)
                            ? TextDecoration.underline
                            : TextDecoration.none,
                        color: (systemControllers.selected_option == index)
                            ? const Color.fromARGB(255, 94, 23, 235)
                            : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.6,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.115,
                      decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10)),
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/home/cancha.jpg'),
                              fit: BoxFit.fill)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('\$ 50.000 COP'),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                (list_state_favorite[index] == false)
                                    ? list_state_favorite[index] = true
                                    : list_state_favorite[index] = false;
                              });
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: (list_state_favorite[index] == true)
                                  ? const Color.fromARGB(255, 94, 23, 235)
                                  : const Color.fromARGB(125, 30, 30, 30),
                            )),
                      ],
                    ),
                    const Text(
                      'cancha de futbol 5',
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    const Text(
                      'Biblos',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
