
import 'package:fire_base_login/e_commerce/consts/images.dart';
import 'package:fire_base_login/e_commerce/consts/styles.dart';
import 'package:fire_base_login/e_commerce/firebase/firebase_consts/firebase_consts.dart';
import 'package:fire_base_login/e_commerce/views/auth_screen/home/view/main_screen.dart';
import 'package:fire_base_login/e_commerce/views/auth_screen/login/view/login_screen.dart';
import 'package:fire_base_login/e_commerce/widget/applogo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() {
    Future.delayed(Duration(seconds: 3), () {

      // Get.off(() => LoginScreen());
      auth.authStateChanges().listen((User? user) {
        if(user==null && mounted){
          Get.to(() => LoginScreen());
        }else{
          Get.to(() => MainScreen());
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Image.asset(icSplashBg, width: 300)),
            SizedBox(height: 20),
            appLogoWidget(),
            SizedBox(height: 10),
            Text("eMart",
                style: TextStyle(
                    fontFamily: bold, fontSize: 22, color: Colors.white)),
            SizedBox(height: 5),
            Text("Version 1.0.0",
                style: TextStyle(
                  color: Colors.white,
                )),
            Spacer(),
            Text("@Baaba Devs",
                style: TextStyle(color: Colors.white, fontFamily: semibold)),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
