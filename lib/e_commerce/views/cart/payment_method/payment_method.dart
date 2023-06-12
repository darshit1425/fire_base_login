
import 'package:fire_base_login/e_commerce/consts/colors.dart';
import 'package:fire_base_login/e_commerce/consts/styles.dart';
import 'package:fire_base_login/e_commerce/views/auth_screen/home/view/main_screen.dart';
import 'package:fire_base_login/e_commerce/views/cart/controller/cart_controller.dart';
import 'package:fire_base_login/e_commerce/views/cart/payment_method/list/payment_method_list.dart';
import 'package:fire_base_login/e_commerce/widget/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: SizedBox(
          height: Get.height*0.075,
          child: controller.placingOrder.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                )
              : ourButton(
                  onPress: () async {
                    await controller.placeMyOrder(
                        orderPaymentMethod:
                            paymentMethods[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);
                    await controller.clearCart();
                    Get.offAll(MainScreen());
                  },
                  color: Colors.red,
                  title: "Place my order",
                  textColor: Colors.white,
                ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Choose Payment Method",
              style: TextStyle(color: darkFontGrey, fontFamily: semibold)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethodsImg.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          style: BorderStyle.solid,
                          color: controller.paymentIndex.value == index
                              ? Colors.red
                              : Colors.transparent,
                          width: 4),
                    ),
                    margin: EdgeInsets.only(bottom: 8),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(
                          paymentMethodsImg[index],
                          width: double.infinity,
                          height: Get.height*0.18,
                          colorBlendMode: controller.paymentIndex.value == index
                              ? BlendMode.darken
                              : BlendMode.color,
                          color: controller.paymentIndex.value == index
                              ? Colors.black.withOpacity(0.4)
                              : Colors.transparent,
                          fit: BoxFit.cover,
                        ),
                        controller.paymentIndex.value == index
                            ? Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                    activeColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    value: true,
                                    onChanged: (value) {}),
                              )
                            : Container(),
                        Positioned(
                            right: 10,
                            bottom: 10,
                            child: Text(
                              "${paymentMethods[index]}",
                              style: TextStyle(
                                  fontFamily: semibold,
                                  fontSize: 16,
                                  color: Colors.white),
                            )),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
