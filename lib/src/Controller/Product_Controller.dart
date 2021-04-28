import 'package:ecommerce_app_ui_kit/src/Services/remote_services.dart';
import 'package:ecommerce_app_ui_kit/src/models/productFromJson.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var isLoading = true;
  var productList = List<Result>().obs;
  var productByCategoryList = List<Result>().obs;
  var productByStoreList = List<Result>().obs;
  var productDiscountedList = List<Result>().obs;

  static ProductController get to => Get.find();

  void getProducts() async{
    try{
      isLoading=true;
      update();
      var products = await RemoteServices.getProducts();
      if (products == null){
        productList.assignAll([]);
      }
      else {
        productList.assignAll(products.results);
      }
    } finally {
      isLoading=false;
      update();
    }
  }

  void getProductsByCategory(String category) async{
    try{
      isLoading=true;
      update();
      var products = await RemoteServices.getProductsByCategory(category);
      if (products == null){
        productByCategoryList.assignAll([]);
      }
      else {
        productByCategoryList.assignAll(products.results);
      }
    } finally {
      isLoading=false;
      update();
    }
  }

  void getProductsByStore(String store) async{
    try{
      isLoading=true;
      update();
      var products = await RemoteServices.getProductsByStore(store);
      if (products == null){
        productByStoreList.assignAll([]);
      }
      else {
        productByStoreList.assignAll(products.results);
      }
    } finally {
      isLoading=false;
      update();
    }
  }

  void getDiscountedProducts() async{
    try{
      isLoading=true;
      update();
      var products = await RemoteServices.getDiscountedProducts();
      if (products == null){
        productDiscountedList.assignAll([]);
      }
      else {
        productDiscountedList.assignAll(products.results);
      }
    } finally {
      isLoading=false;
      update();
    }
  }

}