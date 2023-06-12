import 'package:fire_base_login/e_commerce/views/auth_screen/login/controller/login_controller.dart';
import 'package:get/get.dart';

class LoginBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}