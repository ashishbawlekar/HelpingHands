import 'dart:async';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth{
  Future<FirebaseUser> signInWithEmail(String email, String password);
  Future<FirebaseUser> signInWithPhone(String phone, String password);
  Future<FirebaseUser> signUp(String email, String password);
}

class EmailAuth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<FirebaseUser> signUpWithEmail(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password
    );
    print(user.uid);
    return user;
    
  }

  Future<FirebaseUser> signInWithEmail(String email, String password) async{
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password
    );
    
    return user;
  }


}