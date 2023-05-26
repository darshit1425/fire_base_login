import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
        .then((value) {
      print("succes Login");
      msg = "sucees";
    }).catchError((e) {
      print("$e");
      msg = ("$e");
    });

    return msg;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => Get.offAndToNamed('/'));
  }

  bool CheckUser() {
    User? user = firebaseAuth.currentUser;
    return user != null;
  }

  Future<String> signInWithGoogle() async {
    String? msg;
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) => msg = "Success")
        .catchError((e) => msg = "$e");
    return msg!;
  }

// GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
// GoogleSignInAuthentication? Auth =
//     await googleSignInAccount?.authentication;
//
// var crede = GoogleAuthProvider.credential(
//     accessToken: Auth?.accessToken, idToken: Auth?.idToken);
//
// await firebaseAuth
//     .signInWithCredential(crede)
}
