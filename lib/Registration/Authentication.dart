import 'dart:async';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';



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
    
    //GetIt.I.registerSingleton(user);
    return user;
  }


}


class PhoneAuth{
  String verificationId;
  String phoneNumber = "+919152204054";
  AuthCredential authCred;
  // final FirebaseUser user;
  PhoneAuth();
  sendSms(String ph){
    /*
    This function sends an sms to the phone number specified.
    Retain the class object as it contains the verification id 
    of the current transaction which is used cross check against the smsCode. 
    */
    print("Starting Verificcation");
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber : ph,
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
    /* 

    Links the OTP recieved with the user account.
    You need to have an account before you can link with the current account.
    The trigger is set to false to submit the OTP, unless the email is verified.
    If you try to submit the OTP without verifying the email, the entire user object is deleted.
    Also during login, you're only allowed to process forward if 
    (In case of NGO) you're email and phone number are verified.
    (In case of Volunteer) if he uses phone number and password there's the issue of 
    how to create an email id user to link the phone number with.
     

    */
    AuthCredential authCred;
    try{
     authCred = PhoneAuthProvider.getCredential(
      smsCode: smsCode, 
      verificationId: this.verificationId,
    );
    }catch(exp){
      print(exp.message);
    }
    print("Auth Credential : " );
    print(authCred);
    final user = await FirebaseAuth.instance.currentUser();
    await user.linkWithCredential(authCred);

  }

}

class GoogleLogin{  
  static Future<FirebaseUser> googleSignIn() async{
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final _auth = FirebaseAuth.instance;
    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
    AuthCredential _creds =  GoogleAuthProvider.getCredential(
      accessToken: _googleAuth.accessToken,
      idToken: _googleAuth.idToken
    );
    print("Access Token: " +_googleAuth.accessToken);
    print("ID Token :  " + _googleAuth.idToken);
    print("Display Name: " +_googleUser.displayName);
    print("Email :" + _googleUser.email);
    print("PhotoURL :" + _googleUser.photoUrl);
    FirebaseUser user = await _auth.signInWithCredential(_creds); 
         
    print(user.providerData);
    print(user.uid);
    print(user.displayName);
    return user;
  }

  static Future<bool> sendVolunteerDataToDB(FirebaseUser user) async{
  /* 
  If user signs up with Google or FaceBook 
  there's no explicit way of sending user data into the database.
  But asking the user to add the data manually again,
  is an unnecessary hassle.
  So we check if the user is singning up for the firsst time and put what data we get into the db.
  Another additional benefit of using Google or FB sign up is,
  The storage space is not ours. 
  */

  print("Setting data for user with uid : ${user.uid}");
    try{
    await Firestore.instance.collection("VolunteerUsers").document(user.uid).setData(
          {
            "Name" : user.displayName,
            "Email" : user.email,
            "ProfileUrl" : user.photoUrl,
            "EventCount" : 0,
            "JoinedEvents" : [],

          }
        );
    }catch(err){
      print(err);
      return false;
    }
    return true;    
  
  }


}

