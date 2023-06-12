
import 'package:fire_base_login/e_commerce/consts/colors.dart';
import 'package:fire_base_login/e_commerce/consts/styles.dart';
import 'package:fire_base_login/e_commerce/controller/auth_controller.dart';
import 'package:fire_base_login/e_commerce/views/auth_screen/home/view/main_screen.dart';
import 'package:fire_base_login/e_commerce/widget/applogo_widget.dart';
import 'package:fire_base_login/e_commerce/widget/bg_widget.dart';
import 'package:fire_base_login/e_commerce/widget/custom_textfiled.dart';
import 'package:fire_base_login/e_commerce/widget/our_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var controller = Get.put(AuthController());
  bool? isCheck = false;
  bool? isMatched = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                const SizedBox(height: 10),
                const Text("Join the eMart",
                    style: TextStyle(
                        fontSize: 18, fontFamily: bold, color: Colors.white)),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: context.screenWidth - 70,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        const BoxShadow(color: Colors.black38, blurRadius: 2)
                      ]),
                  child: Obx(
                    () => Column(
                      children: [
                        customTextFiled(
                            controller: nameController,
                            title: "Name",
                            hint: "name",
                            isPass: false),
                        customTextFiled(
                            controller: emailController,
                            title: "Email",
                            hint: "admin@admin.com",
                            keyBoardType: TextInputType.emailAddress,
                            isPass: false),
                        customTextFiled(
                            controller: passwordController,
                            title: "Password",
                            hint: "*******",
                            isPass: true),
                        customTextFiled(
                            controller: retypePassController,
                            title: "RetypePassword",
                            hint: "*******",
                            isPass: true),
                        TextButton(
                          onPressed: () {},
                          child: const Align(
                              alignment: Alignment.centerRight,
                              child: Text("Forget Password")),
                        ),
                         SizedBox(height: 5),
                        Row(
                          children: [
                            Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.red,
                                value: isCheck,
                                onChanged: (newValue) {
                                  setState(() {
                                    isCheck = newValue;
                                  });
                                }),
                            const SizedBox(height: 10),
                            Expanded(
                              child: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "I agree to the",
                                      style: TextStyle(
                                        color: fontGrey,
                                        fontFamily: regular,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " Terms and Condition",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: regular,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " & ",
                                      style: TextStyle(
                                        color: fontGrey,
                                        fontFamily: regular,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Privacy Policy",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: regular,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: context.screenWidth - 50,
                          // child: ourButton(
                          //     color: isCheck == true ? redColor : lightGrey,
                          //     title: "Sign Up",
                          //     textColor: whiteColor,
                          //     onPress: () async {
                          //       if (isCheck != false) {
                          //         try {
                          //           await controller
                          //               .signupMethod(
                          //                   context: context,
                          //                   email: emailController.text,
                          //                   password: passwordController.text)
                          //               .then(
                          //             (value) {
                          //               return controller.storeUserData(
                          //                 password: passwordController.text,
                          //                 email: emailController.text,
                          //                 name: nameController.text,
                          //               );
                          //             },
                          //           );
                          //         } catch (e) {
                          //           auth.signOut();
                          //         }
                          //       } else {}
                          //     }),
                          child:
                          controller.isloading.value?
                          CircularProgressIndicator(
                              valueColor:
                              AlwaysStoppedAnimation(Colors.red),
                          )
                          :ourButton(
                              color: isCheck == true ? redColor : lightGrey,
                              textColor: whiteColor,
                              title: "Sign Up",
                              onPress: () {
                                if (nameController.text.trim().isEmpty &&
                                    emailController.text.trim().isEmpty &&
                                    passwordController.text.trim().isEmpty) {
                                  final nameEmailPass = SnackBar(
                                    content:
                                        Text("Enter Name,Email And password"),
                                    backgroundColor: Colors.red,
                                    action: SnackBarAction(
                                      label: 'Try Again',
                                      onPressed: () {},
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(nameEmailPass);
                                } else if (nameController.text.trim().isEmpty) {
                                  final name = SnackBar(
                                    content: Text("Enter Name "),
                                    backgroundColor: Colors.red,
                                    action: SnackBarAction(
                                      label: 'Try Again',
                                      onPressed: () {},
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(name);
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
                                } else if (retypePassController.text
                                    .trim()
                                    .isEmpty) {
                                  // if (passwordController.text.toString().compareTo()) {
                                  //   setState(() {
                                  //     isMatched == true;
                                  //   });
                                  // } else {
                                  //   setState(() {
                                  //     isMatched = false;
                                  //   });
                                  // }
                                  final rePass = SnackBar(
                                    content: Text("Enter Re-Type Password "),
                                    backgroundColor: Colors.red,
                                    action: SnackBarAction(
                                      label: 'Try Again',
                                      onPressed: () {},
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(rePass);
                                } else {
                                  createUser(
                                      context: context,
                                      password: passwordController.text,
                                      email: emailController.text);
                                }
                              }),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "Already have an account? ",
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: fontGrey,
                                ),
                              ),
                              TextSpan(
                                text: "Log In",
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
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

  Future createUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print("USER EMAIL=======>>>>>>>${userCredential.user?.email}");

      Get.offAll(() => const MainScreen());

      Get.snackbar(
        "Signup Success",
        "Successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
      );

    } catch (e) {
      print("ERROR======>>>>>>>>>$e");
      Get.snackbar(
        "Process Failed",
        "Failed",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );

    }
  }
}
