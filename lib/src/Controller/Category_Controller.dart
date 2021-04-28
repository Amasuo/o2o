import 'package:ecommerce_app_ui_kit/src/Services/remote_services.dart';
import 'package:ecommerce_app_ui_kit/src/models/categoryFromJson.dart';
import 'package:ecommerce_app_ui_kit/src/models/parentCategoryFromJson.dart' as ParentCategory;
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var isLoading = true;
  var categoryList = List<Result>().obs;
  var parentCategoryList = List<ParentCategory.Result>().obs;

  static CategoryController get to => Get.find();

  Future<void> getCategories() async{
    try{
      isLoading=true;
      update();
      var categories = await RemoteServices.getCategories();
      if (categories == null){
        categoryList.assignAll([]);
      }
      else {
        categoryList.assignAll(categories.results);
      }
    } finally {
      isLoading=false;
      update();
    }
  }

  Future<void> getParentCategories() async{
    try{
      isLoading=true;
      update();
      var parentCategories = await RemoteServices.getParentCategories();
      if (parentCategories == null){
        categoryList.assignAll([]);
      }
      else {
        parentCategoryList.assignAll(parentCategories.results);
      }
    } finally {
      isLoading=false;
      update();
    }
  }

}