import 'dart:io';


import 'package:fire_base_login/e_commerce/views/profile/controller/profile_controller.dart';
import 'package:fire_base_login/e_commerce/widget/bg_widget.dart';
import 'package:fire_base_login/e_commerce/widget/custom_textfiled.dart';
import 'package:fire_base_login/e_commerce/widget/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../consts/consts.dart';

class EditProfileScreen extends StatelessWidget {
  // final dynamic data;

  EditProfileScreen({Key? key}) : super(key: key);

  // TextEditingController nameController=TextEditingController();
  // TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: bgWidget(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text("Edit Profile",
                      style: TextStyle(fontFamily: bold, color: Colors.white)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50, left: 12, right: 12),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black38, blurRadius: 2)
                      ]),
                  child: Obx(
                    () => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        controller.profileImgPath.isEmpty
                            ? CircleAvatar(
                                backgroundImage: AssetImage(imgProfile2),
                                radius: 35,
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(
                                    File(controller.profileImgPath.value)),
                                radius: 35,
                              ),
                        SizedBox(height: 10),
                        ourButton(
                            color: Colors.red,
                            onPress: () {
                              controller.changeImage(context);
                            },
                            textColor: Colors.white,
                            title: "Change"),
                        Divider(),
                        SizedBox(height: 20),
                        customTextFiled(
                            hint: "name",
                            title: "Name",
                            controller: controller.nameController,
                            isPass: false),
                        customTextFiled(
                            hint: "********",
                            title: "Password",
                            controller: controller.passwordController,
                            isPass: true),
                        SizedBox(height: 20),
                        SizedBox(
                          width: context.screenWidth - 60,
                          child: ourButton(
                              color: redColor,
                              title: "Save",
                              textColor: Colors.white,
                              onPress: () {}),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
