import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'dart:async';
abstract class UserData{
  // UserData getData(String uid);
//  static Future<UserData> getDataAsFuture(String uid);
  
}



UserData dummyNgo = NgoUserData(
  ngoName: "",
  ngoWebsite: "",
  ngoContact: "",
  ngoTelephone: "",
  ngoEmail: "",
  ngoDescription: "",
  ngoRepName: "",
  ngoZipCode: "",
  city: "",

);
class NgoUserData extends UserData{
  final String ngoName;
  final String ngoRepName;
  var  ngoLogo;
  String ngoLogoUrl;
  final String ngoDescription;
  final String ngoWebsite;
  final String ngoContact;
  final String ngoTelephone;
  final String ngoEmail;
  final String ngoAddress;
  final String city;
  final String ngoZipCode;
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
    this.city,
    this.ngoZipCode,
    this.ngoAddress,
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

    static Future<UserData> getDataAsFuture() async {
      final user = await FirebaseAuth.instance.currentUser();
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
           return dummyNgo;
         }
    }
  // return;
    // String get name => ngoName;
}

final dummyVol = VolunteerUserData(
  displayName: "",
  email: "",
  eventCount: 0,
  profileUrl: "",
);

class VolunteerUserData extends UserData{
  final String displayName;
  final String email;
  int eventCount;
  final String profileUrl;
  var profile;

  VolunteerUserData({
    @required this.displayName,
    @required this.email,
    this.eventCount = 0,
    @required this.profileUrl,
    this.profile,

  });

  static Future<VolunteerUserData> getDataAsFuture() async {
          final user = await FirebaseAuth.instance.currentUser();
      final doc = Firestore.instance.document("/VolunteerUsers/${user.uid}");
         VolunteerUserData vol;
         try{
          final document =await doc.get() ; //.then(
            //(document){
          final data = document.data;
          vol = VolunteerUserData(
          displayName: data['Name'],
          profileUrl:  data['ProfileUrl'],
          email:  data['Email'],
          eventCount: data["EventCount"],
        );
          print("Volunteer : ${data['Name']}");
          return vol;
         }
         catch(ex){
           return dummyVol;
         }
    }
  
}


Future<String> uploadFile(String uid, File file) async{
      if(file == null) return "";
      StorageReference storageReference = FirebaseStorage().ref().child("/ProfilePhotos/" + uid);
      final StorageUploadTask uploadTask = storageReference.putFile(file);
      
    final StreamSubscription<StorageTaskEvent> streamSubscription = uploadTask.events.listen((event) {
        print('EVENT ${event.type}');
    });

// Cancel your subscription when done.
    final downloadurl = await uploadTask.onComplete;
      streamSubscription.cancel();
    final String url = (await downloadurl.ref.getDownloadURL());
      return url;
}