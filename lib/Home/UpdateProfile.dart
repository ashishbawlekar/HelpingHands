import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'package:helping_hands/Registration/Volunteer_Registration.dart';
import 'package:helping_hands/Utils/Cities.dart';
import 'package:helping_hands/Utils/UserData.dart';

class UpdateNGOProfile extends StatefulWidget {
  @override
  _UpdateNGOProfileState createState() => _UpdateNGOProfileState();
}

class _UpdateNGOProfileState extends State<UpdateNGOProfile> {
  TextEditingController ngoName = TextEditingController();
  TextEditingController ngoRepName = TextEditingController();
  TextEditingController ngoCity = TextEditingController();
  TextEditingController ngoContact = TextEditingController();
  TextEditingController ngoAddress = TextEditingController();
  TextEditingController ngoDescription = TextEditingController();
  TextEditingController ngoEmail = TextEditingController();
  TextEditingController ngoTelephone = TextEditingController();
  TextEditingController ngoWebsite = TextEditingController();
  TextEditingController ngoZipCode = TextEditingController();
  TextEditingController ngoLogoUrl = TextEditingController();
  String city;
  Color appbarColor;


  @override
  void initState() {
    super.initState();
    appbarColor = Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
        backgroundColor: appbarColor,
      ),
      body: Container(
        child: FutureBuilder(
          // future: NgoUserData.getDataAsFuture(),
          future: FirebaseAuth.instance.currentUser(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              print(snapshot.data);
              return FutureBuilder(
                future: Firestore.instance.collection("NgoUsers").document(snapshot.data.uid).get(),
                builder: (context, AsyncSnapshot snapshot){
                  if (snapshot.connectionState == ConnectionState.done && snapshot.hasData)
                  {
                    String imageUrl = snapshot.data["LogoUrl"];
                    ngoName.text = snapshot.data["Name"];
                    ngoRepName.text = snapshot.data["RepName"];
                    ngoCity.text = snapshot.data["City"];
                    ngoContact.text = snapshot.data["Contact"];
                    ngoAddress.text = snapshot.data["Address"];
                    ngoDescription.text = snapshot.data["Description"];
                    ngoEmail.text = snapshot.data["Email"];
                    ngoTelephone.text = snapshot.data["Telephone"];
                    ngoWebsite.text = snapshot.data["Website"];
                    ngoZipCode.text = snapshot.data["ZipCode"];
                  return Container(
                // color: Colors.red,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: CircleAvatar(
                                backgroundImage:
                                    imageUrl == null? Image.asset("assets/emptyProfile.png").image : Image.network(imageUrl).image,
                                radius: 50.0,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
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
                                ],
                              ),
                            )
                          ],
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
                                      top: 5.0,
                                      bottom: 5.0,
                                      left: 20.0,
                                      right: 3.0),
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

                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: RaisedButton(
                                child: Text("Update"),
                                color: Colors.lightBlueAccent,
                                splashColor: Colors.greenAccent,
                                onPressed: () async {
                                  if(!_formkey.currentState.validate()){
                                    Toast.show(
                                      "Invalid Data!",
                                      context,
                                      duration: 2
                                    );
                                    return;
                                  } 
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    useRootNavigator: true,
                                    builder: (_) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      contentPadding: EdgeInsets.all(50.0),
                                      content: Row(
                                        children: <Widget>[
                                          Text("Loading"),
                                          Spacer(),
                                          CircularProgressIndicator()
                                        ],
                                      ),
                                    ),
                                  );
                                  await Firestore.instance.collection("NgoUsers")
                                    .document(snapshot.data.documentID)
                                      .setData({
                                                "Name": ngoName.text.trim(),
                                                "RepName": ngoRepName.text.trim(),
                                                "Contact": ngoContact.text.trim(),
                                                "Telephone": ngoTelephone.text.trim(),
                                                "Description": ngoDescription.text.trim(),
                                                "Email": ngoEmail.text.trim(),
                                                "Website": ngoWebsite.text,
                                                "LogoUrl": imageUrl,
                                                "Address": ngoAddress.text,
                                                "City": city,
                                                "ZipCode": ngoZipCode.text,
                                                "isVolunteer" : false,
                                      });
                                      
                                      Navigator.of(context, rootNavigator: true).pop();
                                      setState(() {
                                        appbarColor = Colors.green;  
                                      });

                                      Toast.show("Updated!", context, duration: 3, backgroundRadius: 10);
                                },
                              ),
                            )
                      ],
                    ),
                  ),
                ),
              );
                  }
                  else
                  {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              );
            } 
            else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
