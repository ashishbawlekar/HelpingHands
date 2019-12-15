import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands/Registration/NGO_Registration.dart';
import 'package:helping_hands/Utils/Cities.dart';

class VolunteerForm extends StatefulWidget {
  @override
  _VolunteerFormState createState() => _VolunteerFormState();
}

class _VolunteerFormState extends State<VolunteerForm> {
  final formKey = GlobalKey<FormState>();

  TextEditingController volZipCode = TextEditingController();
  TextEditingController volRePass = TextEditingController();
  TextEditingController volEmail = TextEditingController();
  TextEditingController volPass = TextEditingController();
  String city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New User"),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.shifting,
      //   onTap: (index){
      //     setState(() {

      //     });
      //   },
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //         title: Text("Posts"),
      //         backgroundColor: Colors.grey[400],
      //         icon: Icon(Icons.touch_app)),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.traffic),
      //       title: Text("Posts"),
      //       backgroundColor: Colors.grey[400],
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.turned_in_not),
      //       activeIcon: Icon(Icons.turned_in),
      //       title: Text("Posts"),
      //       backgroundColor: Colors.grey[400],
      //     ),
      //   ],
      // ),
      body: FormWrapper(formKey)
    );
  }
}

class FormWrapper extends StatefulWidget {
  final formKey;
  FormWrapper(this.formKey);
  @override
  _FormWrapperState createState() => _FormWrapperState();
}

class _FormWrapperState extends State<FormWrapper> {
  TextEditingController volZipCode = TextEditingController();
  TextEditingController volRePass = TextEditingController();
  TextEditingController volEmail = TextEditingController();
  TextEditingController volPass = TextEditingController();
  String city;

  @override
  Widget build(BuildContext context) {
    return  Form(
        key: widget.formKey,
        child: Container(
          height: 500.0,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FieldControl(
                  label: "Email ID",
                  hint: "Enter your Email ID",
                  controller: volEmail,
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FieldControl(
                  label: "Password",
                  hint: "Enter your password",
                  hideText: true,
                  controller: volPass,
                  validate: (val) {
                    // var pattern = RegExp(r"");
                    if (val.length < 8) {
                      return "Password has to be atleast 8 characters";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FieldControl(
                  label: "ReEnter Password",
                  hint: "Enter your password again",
                  hideText: true,
                  controller: volRePass,
                  validate: (val) {
                    // var pattern = RegExp(r"");
                    if (volPass.text == val) {
                      return null;
                    } else {
                      return "Passwords don't match";
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal:20.0),
                child: Row(
                  children: <Widget>[
                    Padding(
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
                              child: Container(
                                decoration: BoxDecoration(border: Border.all()),
                                child: Text(city),
                              ));
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: FieldControl(
                          hpad: 10.0,
                          label: "Zipcode",
                          hint: "Enter your Zip Code",
                          controller: volZipCode,
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
                    ),
                  ],
                ),
              ),
              RaisedButton(
                child: Text("Submit"),
                onPressed: () {
                  if (!widget.formKey.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Invalid Data"),
                    ));
                  }
                },
              )
            ],
          ),
        ),
      );
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
  String label;
  bool autofocus;
  bool hideText;
  TextEditingController controller;
  @required
  String hint;
  Function validate;
  TextInputType keyboardType;
  int maxlines;
  int maxLength;
  bool expand;
  Icon icon;
  double hpad;

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
