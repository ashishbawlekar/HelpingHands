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

class PhoneAuth{
  String verificationId;
  String phoneNumber = "+919152204054";
  AuthCredential authCred;
  final FirebaseUser user;
  PhoneAuth(this.user);
  sendSms(String ph){
    // print("Starting verification");
    final verficationCompleted = (AuthCredential auth){
      print("Verification SMS sent $auth");
    };
    final phoneVerificationFailed = (AuthException exp){
      print("Something went wrong : ${exp.message}");
    };
    print("Starting Verificcation");
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber : "+917045714845",
      timeout: Duration(minutes: 2),
      verificationCompleted: (AuthCredential auth){
      print("Verification SMS sent $auth");
    },
      verificationFailed: (AuthException exp){
      print("Something went wrong : ${exp.message}");
    }, 
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
      },
      codeSent: (String verificationId, [int forceResendingToken]) {
        this.verificationId = verificationId;
      },
      
    );
    print("VerificEation Over" + this.verificationId.toString());
  }


  linkCred(String smsCode) async {
    print("Starting Link");
    AuthCredential authCred;
    try{
   authCred = PhoneAuthProvider.getCredential(
      smsCode: "160520",//smsCode, 
      verificationId: this.verificationId,
    );
    }catch(exp){
      print(exp.message);
    }

    print("Auth Credential : " + authCred.toString());

    final user = await FirebaseAuth.instance.currentUser();
    await user.linkWithCredential(authCred);
    // print(user.providerData.toString());
    // print(user.phoneNumber);

  }

}