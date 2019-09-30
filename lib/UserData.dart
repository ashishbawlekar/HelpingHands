import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
abstract class UserData{
  // UserData getData(String uid);
//  static Future<UserData> getDataAsFuture(String uid);
  
}
UserData dummy = NgoUserData(
  ngoName: "",
  ngoWebsite: "",
  ngoContact: "",
  ngoTelephone: "",
  ngoEmail: "",
  ngoDescription: "",
  ngoRepName: "",
);
class NgoUserData extends UserData{
  final String ngoName;
  final String ngoRepName;
  Image  ngoLogo;
  String ngoLogoUrl;
  final String ngoDescription;
  final String ngoWebsite;
  final String ngoContact;
  final String ngoTelephone;
  final String ngoEmail;
  // (    @required this.ngoName,
  //   @required ngoRepName,
  //   @required ngologoUrl,
  //   @required ngoDescription,
  //   @required ngoWebsite,
  //   @required ngoContact,
  //   @required ngoTelephone,
  //   @required ngoEmail, 
  // });
  NgoUserData({
    this.ngoName, 
    this.ngoRepName,
    this.ngoLogo,
    this.ngoDescription,
    this.ngoWebsite,
    this.ngoContact,
    this.ngoTelephone,
    this.ngoEmail,
    this.ngoLogoUrl,
    });

    

    static UserData getData(String uid) {
      final doc = Firestore.instance.document("/NgoUsers/$uid");
      NgoUserData ngo;
      doc.get().then(
        (document){
          final data = document.data;
          print(document.exists);
          ngo = NgoUserData(
            ngoName: data['Name'],
            ngoContact: data['Contact'],
            ngoRepName: data['RepName'],
            ngoLogoUrl:  data['LogoUrl'],
            ngoDescription:  data['Description'],
            ngoEmail:  data['Email'],
            ngoTelephone:  data['Telephone'],
            ngoWebsite:  data['Website'],
          );
        return ngo;
        }
        
      );
      throw Exception("Unable to load document");
    }

    static Future<String> testFuture() async{
      await Future.delayed(Duration(seconds:2));
      return "HELLO wOrLd";
    }
  
    static Future<UserData> getDataAsFuture() async {
      final user = await FirebaseAuth.instance.currentUser();
      // return dummy;
      // return Future((){
        final doc = Firestore.instance.document("/NgoUsers/${user.uid}");
         NgoUserData ngo;
         try{
          final document =await doc.get() ; //.then(
            //(document){
          final data = document.data;
          ngo = NgoUserData(
          ngoName: data['Name'],
          ngoContact: data['Contact'],
          ngoRepName: data['RepName'],
          ngoLogoUrl:  data['LogoUrl'],
          ngoDescription:  data['Description'],
          ngoEmail:  data['Email'],
          ngoTelephone:  data['Telephone'],
          ngoWebsite:  data['Website'],
        );
          print("NGO NAME : ${data['Name']}");
          return ngo;
         }
         catch(ex){
           return dummy;
         }
    }
  // return;
    // String get name => ngoName;
}