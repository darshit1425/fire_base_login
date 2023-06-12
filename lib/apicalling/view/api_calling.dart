import 'package:fire_base_login/apicalling/contoller/api_contoller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class api_screen extends StatefulWidget {
  const api_screen({super.key});

  @override
  State<api_screen> createState() => _api_screenState();
}

class _api_screenState extends State<api_screen> {
  TextEditingController txttitle = TextEditingController();
  TextEditingController txtbody = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Message",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Container(
          color: Colors.white10,
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: txttitle,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.title,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "Title",
                    style: TextStyle(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: txtbody,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.message_outlined,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "message details",
                    style: TextStyle(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              String title = txttitle.text;
              String body = txtbody.text;
              APiController.aPiController.SendPushNotification(body, title);
              Get.back();
            },
            child: Icon(Icons.message)),
      ),
    );
  }
}
