import 'package:ecommerce_app_ui_kit/src/models/brandFromJson.dart';
import 'package:ecommerce_app_ui_kit/src/models/categoryFromJson.dart';
import 'package:ecommerce_app_ui_kit/src/models/parentCategoryFromJson.dart';
import 'package:ecommerce_app_ui_kit/src/models/productFromJson.dart';
import 'package:ecommerce_app_ui_kit/src/models/storeFromJson.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class InitController extends GetxController {
  var isLoading = true;

  static InitController get to => Get.find();

  void initializeData() async{
    try {
      isLoading = true;
      update();
      await loadProductsList();
      await loadFlashSalesList();
      await loadCategoriesList();
      await loadParentCategoriesList();
      await loadStoresList();
      await loadBrandsList();
    } finally {
      isLoading = false;
      update();
    }
  }
}