import 'package:fire_base_login/screen/home_screen/view/add_product.dart';
import 'package:fire_base_login/screen/home_screen/view/home_screen.dart';
import 'package:fire_base_login/screen/login_screen/view/login_screen.dart';
import 'package:fire_base_login/screen/singup_screen/view/singup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/',
          page: () => Login_Screen(),
        ),
        GetPage(
          name: '/SingUp',
          page: () => SingUp_Screen(),
        ),
        GetPage(
          name: '/Home',
          page: () => Home_Screen(),
        ),
        GetPage(
          name: '/add',
          page: () => Add_product(),
        ),
      ],
    ),
  );
}
