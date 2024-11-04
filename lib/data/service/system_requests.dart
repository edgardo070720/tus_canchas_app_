
import 'package:cloud_firestore/cloud_firestore.dart';

class SystemRequest{
  static final FirebaseFirestore dataBase= FirebaseFirestore.instance;

  static Future<Map<String,dynamic>> getTypeSportsField() async{
    return await dataBase.collection('type_sports_field').get().then((value){
      late Map<String,dynamic> typeSportsField;
      for (var element in value.docs) {
        typeSportsField=element.data();
      }
      return typeSportsField;
    });
  }
}