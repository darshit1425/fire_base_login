import 'package:fire_base_login/screen/home_screen/model/home_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Details_product extends StatefulWidget {
  const Details_product({Key? key}) : super(key: key);

  @override
  State<Details_product> createState() => _Details_productState();
}

class _Details_productState extends State<Details_product> {
  Home_model data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back(result: "/Home");
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.notification_add_outlined,
                color: Colors.black,
              ),
            ),
          ],
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Details",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  // color: Colors.grey.shade400,
                  height: 300,
                  width: double.infinity,
                  child: Image.network("${data.p_image}"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${data.p_name}",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, left: 3),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${data.p_review}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
