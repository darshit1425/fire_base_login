
import 'package:fire_base_login/e_commerce/consts/colors.dart';
import 'package:fire_base_login/e_commerce/consts/lists.dart';
import 'package:fire_base_login/e_commerce/consts/styles.dart';
import 'package:fire_base_login/e_commerce/controller/auth_controller.dart';
import 'package:fire_base_login/e_commerce/views/auth_screen/home/view/main_screen.dart';
import 'package:fire_base_login/e_commerce/views/auth_screen/login/controller/login_controller.dart';
import 'package:fire_base_login/e_commerce/views/auth_screen/signup_screen.dart';
import 'package:fire_base_login/e_commerce/widget/applogo_widget.dart';
import 'package:fire_base_login/e_commerce/widget/bg_widget.dart';
import 'package:fire_base_login/e_commerce/widget/custom_textfiled.dart';
import 'package:fire_base_login/e_commerce/widget/our_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';


class LoginScreen extends GetView<LoginController> {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: bgWidget(
          child: Center(
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                appLogoWidget(),
                // 10.heightBox,
                SizedBox(height: 10),
                Text("Log in to eMart",
                    style: TextStyle(
                        fontFamily: bold, color: Colors.white, fontSize: 18)),

                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.all(16),
                  width: context.screenWidth - 70,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.black38, blurRadius: 2)
                      ]),
                  child: Obx(
                    () => Column(
                      children: [
                        customTextFiled(
                            title: "email",
                            hint: "admin@admin.com",
                            controller: emailController,
                            keyBoardType: TextInputType.emailAddress,
                            isPass: false),
                        customTextFiled(
                            title: "password",
                            hint: "********",
                            controller: passwordController,
                            isPass: true),
                        TextButton(
                          onPressed: () {},
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text("Forget Password"),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: context.screenWidth - 50,
                          child: controller.isloading.value
                              ? CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.red),
                                )
                              : ourButton(
                                  color: redColor,
                                  textColor: whiteColor,
                                  title: "Log In",
                                  onPress: () {
                                    controller.isloading(true);
                                    if (emailController.text.trim().isEmpty &&
                                        passwordController.text
                                            .trim()
                                            .isEmpty) {
                                      final emailPass = SnackBar(
                                        content:
                                            Text("Enter Email And password"),
                                        backgroundColor: Colors.red,
                                        action: SnackBarAction(
                                          label: 'Try Again',
                                          onPressed: () {},
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(emailPass);
                                    } else if (emailController.text
                                        .trim()
                                        .isEmpty) {
                                      final email = SnackBar(
                                        content: Text("Enter Email "),
                                        backgroundColor: Colors.red,
                                        action: SnackBarAction(
                                          label: 'Try Again',
                                          onPressed: () {},
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(email);
                                    } else if (passwordController.text
                                        .trim()
                                        .isEmpty) {
                                      final pass = SnackBar(
                                        content: Text("Enter Password "),
                                        backgroundColor: Colors.red,
                                        action: SnackBarAction(
                                          label: 'Try Again',
                                          onPressed: () {},
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(pass);
                                    } else {
                                      logInUser(
                                          password: passwordController.text,
                                          context: context,
                                          email: emailController.text);
                                      controller.isloading(false);
                                    }
                                    Get.to(() => MainScreen());
                                  }),
                        ),
                        SizedBox(height: 5),
                        Text("or, Create a new account",
                            style: TextStyle(color: fontGrey)),
                        SizedBox(height: 5),
                        Container(
                          width: context.screenWidth - 50,
                          child: ourButton(
                              color: lightGolden,
                              textColor: redColor,
                              title: "Sign Up",
                              onPress: () {
                                Get.to(() => SignupScreen());
                              }),
                        ),
                        SizedBox(height: 10),
                        Text("Log in with", style: TextStyle(color: fontGrey)),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              3,
                              (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundColor: lightGrey,
                                      radius: 25,
                                      child: Image.asset(
                                        socialIconList[index],
                                        width: 30,
                                      ),
                                    ),
                                  )),
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

  Future logInUser(
      {required String email,
      required BuildContext context,
      required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print("USER EMAIL=======>>>>>>>${userCredential.user?.email}");
      Get.offAll(() => MainScreen());
      final snackbar = SnackBar(
        content: Text("Success"),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'done',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } catch (e) {
      print("ERROR======>>>>>>>>>$e");
      final snackbar = SnackBar(
        content: Text("Failed"),
        backgroundColor: Colors.redAccent,
        action: SnackBarAction(
          label: 'done',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
