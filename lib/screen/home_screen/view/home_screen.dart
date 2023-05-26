import 'dart:async';

import 'package:fire_base_login/utils/fire_base_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {

  bool isLogin = false;

  @override
  void initState() {
    super.initState();

    isLogin = FirebaseHelper.firebaseHelper.CheckUser();
  }

  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () => Get.offAndToNamed("/"),);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text(
            "Login System",
            style: TextStyle(fontSize: 22),
          ),
          centerTitle: true,
        ),
        // body: Column(
        //   children: [
        //     Center(
        //       child: ElevatedButton(
        //         onPressed: () {
        //           FirebaseHelper.firebaseHelper.Singup(
        //               email: "hello123@gmail.com", password: "password");
        //         },
        //         child: Text("save"),
        //       ),
        //     ),
        //   ],
        // ),
        body: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            onPressed: () {
              FirebaseHelper.firebaseHelper.signOut();
              Get.back();
            },
            child: Text(
              "Logout",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
