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

  TextEditingController txtp_name = TextEditingController();
  TextEditingController txtp_notes = TextEditingController();
  TextEditingController txtp_date = TextEditingController();
  TextEditingController txtp_time = TextEditingController();
  TextEditingController txtp_price = TextEditingController();
  TextEditingController txtp_review = TextEditingController();
  TextEditingController txtp_warranty = TextEditingController();
  TextEditingController txtp_paytypes = TextEditingController();
  TextEditingController txtp_modelno = TextEditingController();

  Widget build(BuildContext context) {
    // Timer(
    //   Duration(seconds: 5),
    //   () => Get.offAndToNamed("/"),
    // );
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
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseHelper.firebaseHelper.signOut();
                },
                icon: Icon(Icons.logout_outlined))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              TextField(
                controller: txtp_name,
                decoration:
                    InputDecoration(focusColor: Colors.blue, hintText: "p_name"),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: txtp_notes,
                decoration:
                    InputDecoration(focusColor: Colors.blue, hintText: "p_notes"),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: txtp_date,
                decoration:
                    InputDecoration(focusColor: Colors.blue, hintText: "date"),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: txtp_time,
                decoration:
                    InputDecoration(focusColor: Colors.blue, hintText: "time"),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: txtp_price,
                decoration:
                    InputDecoration(focusColor: Colors.blue, hintText: "price"),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: txtp_review,
                decoration:
                    InputDecoration(focusColor: Colors.blue, hintText: "Review"),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: txtp_warranty,
                decoration:
                    InputDecoration(focusColor: Colors.blue, hintText: "warranty"),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: txtp_paytypes,
                decoration:
                    InputDecoration(focusColor: Colors.blue, hintText: "paytypes"),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: txtp_modelno,
                decoration:
                    InputDecoration(focusColor: Colors.blue, hintText: "modelno"),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  FirebaseHelper.firebaseHelper.AddData(
                    p_price: txtp_price.text,
                    p_name: txtp_name.text,
                    p_date: txtp_date.text,
                    p_modelno: txtp_modelno.text,
                    p_notes: txtp_notes.text,
                    p_paytypes: txtp_paytypes.text,
                    p_review: txtp_review.text,
                    p_time: txtp_time.text,
                    p_warranty: txtp_warranty.text,
                  );
                },
                child: Text("Save"),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
