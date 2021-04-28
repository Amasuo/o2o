import 'package:ecommerce_app_ui_kit/src/Controller/Location_Picker_Controller.dart';
import 'package:ecommerce_app_ui_kit/src/Controller/Login_Controller.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocationController(), fenix: true);
    Get.put(LoginController(), permanent: true);
  }
}