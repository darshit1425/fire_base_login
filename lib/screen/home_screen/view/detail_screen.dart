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
        appBar: AppBar(
            title: Text(
          "Details",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        )),
        body: Column(
          children: [
            Text("${data.p_name}"),
          ],
        ),
      ),
    );
  }
}
