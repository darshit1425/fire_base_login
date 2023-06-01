import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_login/screen/home_screen/controller/home_controller.dart';
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
  Home_Controller contoller = Get.put(Home_Controller());

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
        // drawer: Drawer(
        //   child: Padding(
        //     padding: EdgeInsets.all(10),
        //     child: Column(
        //       children: [
        //         CircleAvatar(
        //           radius: 30,
        //           backgroundImage:
        //               NetworkImage("${contoller.userDetail['image']}"),
        //         ),
        //         SizedBox(height: 10),
        //         Text(
        //           "${contoller.userDetail['name']}",
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 16,
        //             color: Colors.black,
        //           ),
        //         ),
        //         SizedBox(height: 10),
        //         Text(
        //           "${contoller.userDetail['email']}",
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 12,
        //             color: Colors.black,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
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
                    p_time: time,
                    key: x.id);

                homeList.add(home_model);
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 230,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onLongPress: () {
                        // FirebaseHelper.firebaseHelper
                        // .UpadteData(Home_model[index].key);
                        Get.toNamed("/add", arguments: 1);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          border:
                              Border.all(color: Colors.grey.shade800, width: 5),
                          color: Colors.black,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              "Name :-${homeList[index].p_name}",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Price :-${homeList[index].p_price}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Transiction :-${homeList[index].p_paytypes}",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "Notes :-${homeList[index].p_notes}",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "Review :-${homeList[index].p_review}",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "ModelNo :-${homeList[index].p_modelno}",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "Date :-${homeList[index].p_date}",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "Time :-${homeList[index].p_time}",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
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
            Get.toNamed('/add',arguments: 0);
          },
        ),
      ),
    );
  }
}
