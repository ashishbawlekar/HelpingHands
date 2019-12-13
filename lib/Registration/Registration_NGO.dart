import 'dart:async';
import 'dart:core';
import 'dart:developer';
import 'dart:io';
// import 'dart:isolate';
// import 'package:flutter/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:helping_hands/Registration/Authentication.dart';
import 'package:helping_hands/Home/HomeNGO.dart';
import 'package:helping_hands/Utils/Cities.dart';
import 'package:helping_hands/Utils/UserData.dart';
import 'package:helping_hands/Registration/Verification.dart';
// import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:helping_hands/Utils/CropImage.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

// class UserLogo{
//   final logo;
//   UserLogo(this.logo);
// }

class NgoReg extends StatefulWidget {
  @override
  _NgoRegState createState() => _NgoRegState();
}

class _NgoRegState extends State<NgoReg> {
  var init;

  var distance;

  _backButtonConfirmation() {
    return AlertDialog(
        title: Text("Are you sure?"),
        content: Text("You'll lose all unsaved data!"),
        actions: <Widget>[
          FlatButton(
            child: Text("Yes"),
            onPressed: () {
              print("False");
              Navigator.of(context).pop(false);
              Navigator.pop(context);
              return false;
            },
          ),
          FlatButton(
            child: Text("No"),
            onPressed: () {
              print("True");
              Navigator.of(context).pop(true);

              return true;
            },
          )
        ]);
  }

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add((val) {
      showDialog(
        context: context,
        builder: (context) => _backButtonConfirmation(),
      );
      return true;
    }, name: "Confirm");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    BackButtonInterceptor.removeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Registration",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Registration"),
          elevation: 20.0,
          backgroundColor: Color.fromARGB(100, 150, 120, 200),
        ),
        body: GestureDetector(
          child: NGO_Reg_Form(),
          onPanStart: (DragStartDetails deets) {
            init = deets.globalPosition.dx;
          },
          onPanUpdate: (DragUpdateDetails deets) {
            distance = deets.globalPosition.dx - init;
          },
          onPanEnd: (DragEndDetails deets) {
            init = 0.0;
            if (distance > 120) {
              Navigator.pop(context);
            }
            print(distance);
          },
        ),
      ),
    );
  }
}

class NGO_Reg_Form extends StatefulWidget {
  @override
  _NGO_Reg_FormState createState() => _NGO_Reg_FormState();
}

class _NGO_Reg_FormState extends State<NGO_Reg_Form>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  // final _cropKey = GlobalKey<CropState>();
  
  TextEditingController ngoName = TextEditingController();
  TextEditingController ngoRepName = TextEditingController();
  TextEditingController ngoContact = TextEditingController();
  TextEditingController ngoTelephone = TextEditingController();
  TextEditingController ngoDescription = TextEditingController();
  TextEditingController ngoEmail = TextEditingController();
  TextEditingController ngoPass = TextEditingController();
  TextEditingController ngoRePass = TextEditingController();
  TextEditingController ngoWebsite = TextEditingController();
  TextEditingController ngoAddress = TextEditingController();
  TextEditingController ngoZipCode = TextEditingController();
  String city;
  File logo;
  AssetImage emptyLogo = AssetImage("assets/emptyProfile.png");
  final photos = "/ProfilePhotos/";
  StorageReference storageReference;
  Animation progressColor;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });

    progressColor = ColorTween(begin: Colors.blue, end: Colors.green)
        .animate(_animationController);
  }

  // Animation<Color> bgColor;
  // AnimationController bgColorController;
  var croppedImage;

  // @override
  // void initState() {
  //   bgColorController = AnimationController(
  //     vsync: this,
  //     duration: Duration(seconds: 5),
  //   )
  //   ..addListener((){
  //     setState(() {});
  //   })
  //   ..addStatusListener((status){
  //     if(status == AnimationStatus.completed){
  //       bgColorController.reverse();
  //     }else if(status == AnimationStatus.dismissed){
  //       bgColorController.forward();
  //     }
  //   });
  //   bgColor = ColorTween(
  //     begin: Colors.blue,
  //     end: Colors.green
  //   ).animate(bgColorController);

  //   bgColorController.forward();
  //   super.initState();
  // }

  Future getImg() async {
    var img = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      // maxHeight: 320.0,
      // maxWidth: 240.0
    );
    if (img == null) return;
    var route = MaterialPageRoute(
      builder: (BuildContext context) => UserImageCrop(img: img),
    );
    // if(img == null) return;
    croppedImage = await Navigator.of(context).push(route);
    if (croppedImage == null) return;
    setState(() {
      logo = croppedImage;
    });
  }

  // TextEditingController ;
  @override
  Widget build(BuildContext context) {
    bool submitted = false;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Spacer(),
                Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: getImg,
                      child: Container(
                        // color: Colors.red,
                        width: 140.0,
                        height: 140.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: logo != null
                                    ? FileImage(logo) //Image.file(logo)
                                    : emptyLogo)),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text("NGO Logo")),
                  ],
                ),
                Spacer(),
              ],
            ),
            FieldControl(
              autofocus: true,
              label: "NGO Name",
              hint: "Enter your NGO name",
              controller: ngoName,
              validate: (val) {
                if (val.trim().isEmpty) {
                  return "Name cannot be empty";
                } else {
                  return null;
                }
              },
            ),
            FieldControl(
              label: "Representative Name",
              hint: "Enter your name",
              controller: ngoRepName,
              validate: (val) {
                if (val.trim().isEmpty) {
                  return "Representative Name cannot be empty";
                } else {
                  return null;
                }
              },
            ),

            FieldControl(
              label: "Contact No.",
              hint: "Enter your contact no.",
              controller: ngoContact,
              maxLength: 10,
              keyboardType: TextInputType.phone,
              validate: (val) {
                var pattern = RegExp(r"[0-9]{10}");
                if (!pattern.hasMatch(val.trim())) {
                  return 'Please enter valid phone no.';
                } else {
                  return null;
                }
              },
            ),

            FieldControl(
              label: "Telephone No.",
              hint: "Enter your landline no.",
              controller: ngoTelephone,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              validate: (val) {
                var pattern = RegExp(r"[0-9]{10}");
                if (!pattern.hasMatch(val.trim())) {
                  return 'Please enter valid telephone no.';
                } else {
                  return null;
                }
              },
            ),

            FieldControl(
              label: "Email ID.",
              hint: "Enter your official Email ID.",
              controller: ngoEmail,
              validate: (val) {
                var pattern = RegExp(
                    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
                if (!pattern.hasMatch(val.trim())) {
                  return "Please enter valid email address";
                } else {
                  return null;
                }
              },
            ),
            FieldControl(
              label: "Password",
              hint: "Enter your password",
              hideText: true,
              controller: ngoPass,
              validate: (val) {
                // var pattern = RegExp(r"");
                if (val.length < 8) {
                  return "Password has to be atleast 8 characters";
                } else {
                  return null;
                }
              },
            ),

            FieldControl(
              label: "ReEnter Password",
              hint: "Enter your password again",
              hideText: true,
              controller: ngoRePass,
              validate: (val) {
                // var pattern = RegExp(r"");
                if (ngoPass.text == val) {
                  return null;
                } else {
                  return "Passwords don't match";
                }
              },
            ),

            FieldControl(
              label: "Website",
              hint: "Enter your official website.",
              controller: ngoWebsite,
              validate: (val) {
                var pattern = RegExp(
                    r"((http)s?:\/\/)?www.(\w+).(\w+.)*.(com|co.in|org|net)");
                if (!pattern.hasMatch(val.trim())) {
                  return "Please enter valid website";
                } else {
                  return null;
                }
              },
            ),

            Container(
              // width: 300.0,
              // color: Colors.black,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 5.0, bottom: 5.0, left: 20.0, right: 3.0),
                      child: DropdownButton(
                        value: city,
                        onChanged: (val) {
                          city = val;
                          setState(() {});
                        },
                        elevation: 10,
                        hint: Text("City"),
                        items: Cities.cityList.map((city) {
                          return DropdownMenuItem(
                            value: city,
                            child: Text(city),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    child: FieldControl(
                      hpad: 10.0,
                      label: "Zipcode",
                      hint: "Enter your Zip Code",
                      controller: ngoZipCode,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      validate: (val) {
                        final pattern = RegExp(r"[0-9]{6}");
                        if (pattern.hasMatch(val)) {
                          return null;
                        } else {
                          return 'Please enter valid Zip Code';
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            FieldControl(
                label: "Address",
                hint: "Enter your NGO's branch's address",
                maxlines: 5,
                controller: ngoAddress,
                maxLength: 320,
                validate: (val) {
                  if (val.trim().length < 30) {
                    return "Address has to be atleast 30 characters";
                  } else {
                    return null;
                  }
                }),

            FieldControl(
                label: "NGO Description",
                hint: "Enter your NGO's cause.",
                maxlines: 5,
                controller: ngoDescription,
                maxLength: 320,
                expand: false,
                validate: (val) {
                  if (val.trim().length < 100) {
                    return "Description has to be atleast 100 characters";
                  } else {
                    return null;
                  }
                }),

            // Container(
            //   color: Colors.black,
            //   padding: const EdgeInsets.all(20.0),
            //   child: Crop(
            //   key: _cropKey,
            //   image: Image.file(logo).image,
            //   aspectRatio: 4.0 / 3.0,
            //   )
            // ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          // shape: CircleBorder(
                          //   side: BorderSide(
                          //     width: 100.0
                          //   )
                          // ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          contentPadding: EdgeInsets.all(50.0),
                          content: Row(
                            children: <Widget>[
                              Text("Loading"),
                              Spacer(),
                              CircularProgressIndicator(
                                valueColor: progressColor,
                              )
                            ],
                          ),
                        ),
                      );

                      registerUser();
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Invalid Data"),
                      ));
                    }
                    // uploadFile();
                  },
                ),
              ],
            ),
            RaisedButton(
              child: Text("Auto-Fill"),
              onPressed: () {
                ngoName.text = "Sathaye";
                ngoRepName.text = "Riki";
                ngoContact.text = "9152204054";
                ngoTelephone.text = "0222222222";
                ngoDescription.text =
                    'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
                ngoEmail.text = "bansoderahul432@gmail.com";
                ngoPass.text = "16may2000";
                ngoRePass.text = "16may2000";
                ngoWebsite.text = "www.google.com";
                ngoAddress.text =
                    "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab";
                ngoZipCode.text = "400093";
              },
            )
          ],
        ),
      ),
    );
  }

  void registerUser() async {
    bool gotError = false;
    FirebaseUser user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: ngoEmail.text.trim(),
      password: ngoPass.text,
    )
    .catchError((exp) {
      gotError = true;
      Navigator.of(context, rootNavigator: true).pop();
      // if (exp.code == "ERROR_EMAIL_ALREADY_IN_USE") 
        // print(exp);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(
              exp.message,
            ),
            contentTextStyle: TextStyle(color: Colors.black, fontSize: 20.0),
            contentPadding: EdgeInsets.all(50.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FlatButton(
                  color: Colors.blue,
                  child: Text("OK", style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // return;
                  },
                ),
              )
            ],
          ),
        );
      
      return;
    });
    // If any error occurs in the createUser statement abandon the rest of the function
    if(gotError) return; 
    final phoneAuth = PhoneAuth();

    phoneAuth.sendSms("+91" + ngoContact.text);
    Timer t;
    // print("OTP send! for ${user.uid}");
    Navigator.of(context, rootNavigator: true).pop();
    final otp = await showDialog(
        useRootNavigator: true,
        context: context,
        barrierDismissible: false,
        builder: (_) {
          TextEditingController controller = TextEditingController();
          bool canResendOtp = true;
          int counterOtp = 30;        
          return StatefulBuilder(
            // stream: null,
            builder: (context, setState) {
              return AlertDialog(
                title: ListTile(
                  title: Text(
                    "Enter your OTP",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: Icon(Icons.mail),
                ),
                contentPadding: EdgeInsets.all(20.0),
                content: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "OTP here", border: OutlineInputBorder()),
                ),
                elevation: 15.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Re-send OTP ($counterOtp)"),
                    onPressed: canResendOtp ?
                         () {
                           
                            Timer.periodic(Duration(seconds: 1), (Timer timer) {
                              t = timer;
                              setState(() {
                              counterOtp--;
                              if (counterOtp == 0) {
                                counterOtp = 30;
                                
                                canResendOtp = true;
                                print("Counter Active $counterOtp");
                                timer.cancel();
                              }else{
                                canResendOtp = false;
                                print("Counter DeActive $counterOtp");
                              }  
                              });
                              
                            });
                          }
                        : null,
                  ),
                  FlatButton(
                    child: Text("Submit"),
                    onPressed: () {
                      t.cancel();
                      Navigator.of(context, rootNavigator: true)
                          .pop(controller.text);
                    },
                  )
                ],
              );
            }
          );
        });
    // Navigator.push(context, MaterialPageRoute(
    //   builder: (BuildContext context) => VerificationNgo(phoneAuth),
    // ));
    // user.linkWithCredential();
    // final otp = controller.text;
    print("Recived OTP $otp");
    if (otp != null) {
      await phoneAuth.linkCred(otp);
    }

    final cu = await FirebaseAuth.instance.currentUser();
    print(cu.phoneNumber);
    print(cu);
    final verification = cu.phoneNumber == null ? false : true;
    if (!verification) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("ERROR"),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Verification Failed"),
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      );
      return;
    }
    print("Verification Successful!");
    print("User UID : " + user.uid);
    //  Navigator.of(context, rootNavigator : true).pop();
    BackButtonInterceptor.removeByName("Confirm");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => HomeNgo(
                userData: NgoUserData(
                  ngoName: ngoName.text.trim(),
                  ngoRepName: ngoRepName.text.trim(),
                  ngoContact: ngoContact.text.trim(),
                  ngoTelephone: ngoTelephone.text.trim(),
                  ngoDescription: ngoDescription.text.trim(),
                  ngoEmail: ngoEmail.text.trim(),
                  ngoWebsite: ngoWebsite.text,
                  ngoAddress: ngoAddress.text,
                  ngoLogo: logo != null
                      ? Image.file(logo)
                      : Image.asset("/assets/emptyProfile.png"),
                ),
              )),
    );

    try {
      if (user == null) throw Exception("Null User");
      //  final u = UserUpdateInfo();

      final String url = await uploadFile(user.uid);

      uploadToDB(user.uid, url);
      //   Firestore.instance.collection("/NgoUsers")
      //   .document(user.uid)
      //     ..setData(
      //        {
      //           "Name"          : ngoName.text.trim(),
      //           "RepName"       : ngoRepName.text.trim(),
      //           "Contact"       : ngoContact.text.trim(),
      //           "Telephone"     : ngoTelephone.text.trim(),
      //           "Description"   : ngoDescription.text.trim(),
      //           "Email"         : ngoEmail.text.trim(),
      //           "Website"       : ngoWebsite.text,
      //           "Address"       : ngoAddress.text,
      //           "LogoUrl"       : url,
      //   }
      // );
    } catch (err) {
      print(err);
    }
  }

  uploadToDB(String uid, String url) {
    Firestore.instance.collection("/NgoUsers").document(uid)
      ..setData({
        "Name": ngoName.text.trim(),
        "RepName": ngoRepName.text.trim(),
        "Contact": ngoContact.text.trim(),
        "Telephone": ngoTelephone.text.trim(),
        "Description": ngoDescription.text.trim(),
        "Email": ngoEmail.text.trim(),
        "Website": ngoWebsite.text,
        "LogoUrl": url,
        "Address": ngoAddress.text,
        "City": city,
        "ZipCode": ngoZipCode.text,
      });
  }

  Future<String> uploadFile(String uid) async {
    if (logo == null) return "";
    storageReference = FirebaseStorage().ref().child(photos + uid);
    final StorageUploadTask uploadTask = storageReference.putFile(logo);

    final StreamSubscription<StorageTaskEvent> streamSubscription =
        uploadTask.events.listen((event) {
      print('EVENT ${event.type}');
    });

// Cancel your subscription when done.
    final downloadurl = await uploadTask.onComplete;
    streamSubscription.cancel();
    final String url = (await downloadurl.ref.getDownloadURL());
    return url;
  }
}

class FieldControl extends StatelessWidget {
  FieldControl({
    this.label,
    this.hint,
    this.controller,
    this.autofocus = false,
    this.hideText = false,
    this.validate,
    this.keyboardType = TextInputType.text,
    this.maxlines = 1,
    this.maxLength,
    this.expand = false,
    this.icon,
    this.hpad = 30.0,
  });
  @required
  var label;
  var autofocus;
  var hideText;
  TextEditingController controller;
  @required
  var hint;
  var validate;
  var keyboardType;
  var maxlines;
  var maxLength;
  bool expand;
  var icon;
  var hpad;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: hpad, vertical: 5.0),
      decoration: BoxDecoration(
        border: Border(
            // right: BorderSide(color: Colors.red),
            // left: BorderSide(color: Colors.red),
            ),
        // color: Colors.red,
      ),
      // transform: Matrix4.rotationZ(0.01),
      child: TextFormField(
        expands: this.expand,
        maxLength: this.maxLength,
        maxLines: this.maxlines,
        keyboardType: this.keyboardType,
        validator: this.validate,
        obscureText: this.hideText,
        autofocus: this.autofocus,
        controller: this.controller,
        decoration: InputDecoration(
            icon: this.icon,
            hintText: this.hint,
            hintStyle: TextStyle(fontWeight: FontWeight.w600),
            focusColor: Colors.black,
            labelText: this.label),
      ),
    );
  }
}
