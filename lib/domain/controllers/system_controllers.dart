import 'package:get/get.dart';
import 'package:tus_canchas_app_v2/data/service/system_requests.dart';

class SystemControllers extends GetxController{
  final Rxn<List<String>> _typeSportsField=Rxn<List<String>>([]);
  final _welcomName=''.obs;
  final _seletedNavegation=0.obs;
  final _selected_option=0.obs;
  
  Future<void> getTypeSportsField()async{
    Map<String,dynamic> mapGetRequest;
    List<String>typeSportsField=[];
    List<dynamic> dynamicList=[];
    mapGetRequest=await SystemRequest.getTypeSportsField();

    dynamicList=mapGetRequest['type_sports_field'];
    for (var element in dynamicList) {
      typeSportsField.add(element.toString());
    }
    _typeSportsField.value=typeSportsField;
  }
  void setWelcomeName(String textName){
    _welcomName.value=textName;
  }
  void seletedNavegationHome(){
    _seletedNavegation.value=0;
  }
  void seletedNavegationfavorite(){
    _seletedNavegation.value=1;
  }
  void seletedNavegationPersonalIformation(){
    _seletedNavegation.value=2;
  }
  void seletedOptions(int index){
    _selected_option.value=index;
  }
  
  List<String>? get typeSportsField => _typeSportsField.value;
  String? get welcomeName=>_welcomName.value;
  int? get seletedNavegation=>_seletedNavegation.value;
  int? get selected_option=>_selected_option.value;
}