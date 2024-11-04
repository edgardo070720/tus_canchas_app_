
import 'package:get/get.dart';
import 'package:tus_canchas_app_v2/data/service/user_requests.dart';
import 'package:tus_canchas_app_v2/domain/models/user.dart';

class UserController extends GetxController {
  final _sessionState = false.obs;
  final _typeUser = ''.obs;
  final Rxn<User> _user=Rxn();
  Future<bool> userValidate(String user, String password) async {
    List<User> userList = await UserRequest.getUser();
    for (var element in userList) {
      if (element.userName == user && element.password == password) {
        _sessionState.value = true;
        
        _typeUser.value=element.typeUser;
        return true;
      }
    }
    return false;
  }
    Future<bool> userValidateExistence(String user) async {
    List<User> userList = await UserRequest.getUser();
    for (var element in userList) {
      if (element.userName == user) {
        return true;
      }
    }
    return false;
  }

  Future<void> seveUser(Map<String, dynamic> user) async {
    await UserRequest.seveUser(user);
  }

  Future<void> loadUser(String user_,String password)async{
    User user=User(userName: user_, password: password, typeUser: _typeUser.value);
    _user.value=user;
  }

  void singOff() {
    _sessionState.value = false;
    _typeUser.value = '';
  }

  bool? get sessionState => _sessionState.value;
  String? get typeUser => _typeUser.value;
  User? get user=>_user.value;
}
