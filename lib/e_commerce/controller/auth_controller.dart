import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_login/e_commerce/firebase/firebase_consts/firebase_consts.dart';
import 'package:fire_base_login/e_commerce/views/auth_screen/home/view/main_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isloading =false.obs;

  Future<UserCredential?> loginMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {}
    return userCredential;
  }

  //signup method
  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.offAll(MainScreen());
    } on FirebaseAuthException catch (e) {}
    return userCredential;
  }

  //storing data method
  storeUserData({name, password, email}) async {
    DocumentReference store =
        await firestore.collection(userCollection).doc(currentUser!.uid);
    store.set({
      "name": name,
      "password": password,
      "email": email,
      "imageUrl": "",
      "id": currentUser!.uid
    });
  }

  // signout method
  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {}
  }
}
