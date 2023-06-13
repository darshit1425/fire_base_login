import 'package:fire_base_login/screen/home_screen/view/add_product.dart';
import 'package:fire_base_login/screen/home_screen/view/detail_screen.dart';
import 'package:fire_base_login/screen/home_screen/view/home_screen.dart';
import 'package:fire_base_login/screen/login_screen/view/login_screen.dart';
import 'package:fire_base_login/screen/singup_screen/view/singup_screen.dart';
import 'package:fire_base_login/utils/notification_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  NotificationHelper.Helper.init();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        // GetPage(
        //   name: '/',
        //   page: () => api_screen(),
        // ),
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
        GetPage(
          name: '/detalis',
          page: () => Details_product(),
        ),
      ],
    ),
  );
}


//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
//
// import 'e_commerce/consts/colors.dart';
// import 'e_commerce/views/auth_screen/splash_screen.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         scaffoldBackgroundColor: Colors.transparent,
//         appBarTheme: AppBarTheme(
//           iconTheme: IconThemeData(
//             color: darkFontGrey,
//           ),
//         ),
//       ),
//       home: SplashScreen(),
//     );
//   }
// }
//
