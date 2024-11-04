import 'package:get/get.dart';
import 'package:tus_canchas_app_v2/data/service/business_requests.dart';
import 'package:tus_canchas_app_v2/domain/models/business.dart';

class BusinessConttroller extends GetxController{
  final Rxn<List<Business>> _businessList=Rxn<List<Business>>([]);
  Future<void> seveBusiness(Map<String,dynamic> business,String id)async{
    await BusinessRequest.seveBusiness(business,id);
  }

  Future<void> getBusiness(String user)async{
    _businessList.value=await BusinessRequest.getBusiness(user);
  }
  List<Business>? get businessList=>_businessList.value;
}