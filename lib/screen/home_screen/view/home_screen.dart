import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_login/screen/home_screen/model/home_model.dart';
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
              icon: Icon(
                Icons.logout_outlined,
              ),
            ),
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseHelper.firebaseHelper.GetData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              List<Home_model> homeList = [];
              QuerySnapshot? snapData = snapshot.data;

              for (var x in snapData!.docs) {
                Map data = x.data() as Map;
                String? name = data['p_name'];
                String? notes = data['p_notes'];
                String? date = data['p_date'];
                String? time = data['p_time'];
                String? price = data['p_price'];
                String? review = data['p_review'];
                String? warranty = data['p_warranty'];
                String? paytypes = data['p_paytypes'];
                String? model = data['p_modelno'];

                print(name);

                Home_model home_model = Home_model(
                    p_name: name,
                    p_warranty: warranty,
                    p_review: review,
                    p_paytypes: paytypes,
                    p_notes: notes,
                    p_modelno: model,
                    p_date: date,
                    p_price: price,
                    p_time: time);

                homeList.add(home_model);
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  print(homeList.length);
                  return Column(
                    children: [
                      Text("${homeList[index].p_name}"),
                      Text("${homeList[index].p_review}"),
                      Text("${homeList[index].p_modelno}"),
                      Text("${homeList[index].p_price}"),
                      Text("${homeList[index].p_notes}"),
                      Text("${homeList[index].p_paytypes}"),
                    ],
                  );
                },
                itemCount: homeList.length,
              );
            }
            return CircularProgressIndicator();
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Get.toNamed('/add');
          },
        ),
      ),
    );
  }
}
