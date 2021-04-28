import 'package:ecommerce_app_ui_kit/src/Services/remote_services.dart';
import 'package:ecommerce_app_ui_kit/src/models/storeFromJson.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  var isLoading = true;
  var storeList = List<Result>().obs;

  static StoreController get to => Get.find();

  Future<void> getStores() async{
    try{
      isLoading=true;
      update();
      var stores = await RemoteServices.getStores();
      if (stores == null){
        storeList.assignAll([]);
      }
      else {
        storeList.assignAll(stores.results);
      }
    } finally {
      isLoading=false;
      update();
    }
  }

}