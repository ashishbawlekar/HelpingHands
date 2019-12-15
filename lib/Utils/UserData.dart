import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
abstract class UserData{
  // UserData getData(String uid);
//  static Future<UserData> getDataAsFuture(String uid);
static Future<bool> storeData(String username, String password, bool isVol) async{
 
  SharedPreferences.getInstance().then((prefs){
  prefs.setString("username", username);
  prefs.setString("password", password);
  prefs.setBool("isVol", isVol);
  return true;
  }).catchError((e){
    print(e);
    return false;
  });
  return false;
}

static Future<bool> userDataExists() async{
  final prefs = await SharedPreferences.getInstance();
  String name = prefs.getString('username');
  String password = prefs.getString('password');
  return !(name == null || password == null);
}
  
static Future<String> getUsername() async{
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('username');
}

static Future<String> getPassword() async{
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('password');
}

static Future<bool> getVol() async{
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isVol');
}


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
  final bool isVolunteer = false;

  final String ngoCity;
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
    this.ngoCity,
    });

    

    static UserData getData(String uid) {
      final doc = Firestore.instance.document("/NgoUsers/$uid");
      NgoUserData ngo;
      doc.get().then(
        (document){
          final data = document.data;
          print(document.exists);
          ngo = NgoUserData(
            ngoAddress: data['Address'],
            ngoZipCode: data['ZipCode'],
            ngoCity: data['City'],
            ngoName: data['Name'],
            ngoContact: data['Contact'],
            ngoRepName: data['RepName'],
            ngoLogoUrl:  data['LogoUrl'],
            ngoDescription:  data['Description'],
            ngoEmail:  data['Email'],
            ngoTelephone:  data['Telephone'],
            ngoWebsite:  data['Website'],
            // isVolunteer: false,
          );
        return ngo;
        }
        
      );
      throw Exception("Unable to load document");
    }
  @override
  @override
  String toString() {
  return "This data belongs to $ngoName which is represented by $ngoRepName located at $ngoAddress. You can contact us at $ngoContact.";
   }
    static Future<NgoUserData> getDataAsFuture() async {
      final user = await FirebaseAuth.instance.currentUser();
      final doc = Firestore.instance.document("/NgoUsers/${user.uid}");
         NgoUserData ngo;
         try{
          final document =await doc.get() ; //.then(
            //(document){
          final data = document.data;
          ngo = NgoUserData(
            ngoAddress: data['Address'],
            ngoZipCode: data['ZipCode'],
            ngoCity: data['City'],
            ngoName: data['Name'],
            ngoContact: data['Contact'],
            ngoRepName: data['RepName'],
            ngoLogoUrl:  data['LogoUrl'],
            ngoDescription:  data['Description'],
            ngoEmail:  data['Email'],
            ngoTelephone:  data['Telephone'],
            ngoWebsite:  data['Website'],
            // isVolunteer: false,
          );
          // print("NGO NAME : ${data['Name']}");
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
  final bool isVolunteer = true;

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