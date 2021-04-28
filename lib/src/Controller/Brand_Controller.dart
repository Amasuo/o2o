import 'package:ecommerce_app_ui_kit/src/Services/remote_services.dart';
import 'package:ecommerce_app_ui_kit/src/models/brandFromJson.dart';
import 'package:get/get.dart';

class BrandController extends GetxController {
  var isLoading = true;
  var brandList = List<Result>().obs;

  static BrandController get to => Get.find();

  Future<void> getBrands() async{
    try{
      isLoading=true;
      update();
      var brands = await RemoteServices.getBrands();
      if (brands == null){
        brandList.assignAll([]);
      }
      else {
        brandList.assignAll(brands.results);
      }
    } finally {
      isLoading=false;
      update();
    }
  }

}