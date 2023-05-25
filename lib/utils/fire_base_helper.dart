import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseHelper {
  static FirebaseHelper firebaseHelper = FirebaseHelper._();

  FirebaseHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> Singup({required email, required password}) async {
    String msg = "";

    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => msg = "Success")
        .catchError((e) => msg = "Faild $e");
    return msg;
  }

  String? SingIn({required email, required password}) {
    String? msg;
     firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value){
          print("succes Login");
          msg = "sucees";

    }).catchError((e){
      print("$e");
      msg = ("$e");
     });

    return msg;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }



// GoogleSing() {}
}
