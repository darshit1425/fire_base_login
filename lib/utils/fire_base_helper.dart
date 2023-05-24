import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper {
  static FirebaseHelper firebaseHelper = FirebaseHelper._();

  FirebaseHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void Singup({required email, required password}) {
    firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => print("Success")).catchError((e) => print("Faild $e") );
  }
  void Singin({required })
  {

  }










  //GoogleSing(){}
}
