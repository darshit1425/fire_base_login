
import 'package:fire_base_login/e_commerce/consts/colors.dart';
import 'package:fire_base_login/e_commerce/consts/styles.dart';
import 'package:fire_base_login/e_commerce/views/cart/controller/cart_controller.dart';
import 'package:fire_base_login/e_commerce/views/cart/payment_method/payment_method.dart';
import 'package:fire_base_login/e_commerce/widget/custom_textfiled.dart';
import 'package:fire_base_login/e_commerce/widget/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Shipping Info",
              style: TextStyle(color: darkFontGrey, fontFamily: semibold)),
        ),
        bottomNavigationBar: SizedBox(
          height: Get.height*0.075,
          child: ourButton(
            onPress: () {
              if (controller.addressController.text.length > 10) {
                Get.to(() => PaymentMethod());
              } else {
                final address = SnackBar(
                  content: Text("Please fill the form"),
                  backgroundColor: Colors.red,
                );
                ScaffoldMessenger.of(context).showSnackBar(address);
              }
            },
            color: Colors.red,
            title: "Continue",
            textColor: Colors.white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              customTextFiled(
                  title: "Address",
                  hint: "Address",
                  isPass: false,
                  controller: controller.addressController),
              customTextFiled(
                  title: "City",
                  hint: "City",
                  isPass: false,
                  controller: controller.cityController),
              customTextFiled(
                  title: "State",
                  hint: "State",
                  isPass: false,
                  controller: controller.stateController),
              customTextFiled(
                  title: "Postal Code",
                  hint: "Postal Code",
                  isPass: false,
                  controller: controller.postalCodeController),
              customTextFiled(
                  title: "Phone",
                  hint: "Phone",
                  isPass: false,
                  controller: controller.phoneController),
            ],
          ),
        ),
      ),
    );
  }
}
