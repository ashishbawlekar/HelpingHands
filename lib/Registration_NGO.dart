import 'dart:core';
import 'dart:io';
// import 'package:flutter/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands/HomeNGO.dart';
// import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'CropImage.dart';


class UserLogo{
  final logo;
  UserLogo(this.logo);
}

class NgoReg extends StatelessWidget {
  var init;
  var distance;
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
        onPanStart: (DragStartDetails deets){
          init = deets.globalPosition.dx;
        },
        onPanUpdate: (DragUpdateDetails deets){
          distance = deets.globalPosition.dx - init;
        },
        onPanEnd: (DragEndDetails deets){
          init = 0.0;
          if(distance > 120){
            Navigator.pop(context);
          }
          print(distance);
        },
        ),
      )
    );
  }
}

class NGO_Reg_Form extends StatefulWidget {
  @override
  _NGO_Reg_FormState createState() => _NGO_Reg_FormState();
}

class _NGO_Reg_FormState extends State<NGO_Reg_Form>{
  final _formKey = GlobalKey<FormState>();
  // final _cropKey = GlobalKey<CropState>();
  TextEditingController ngoName;
  TextEditingController ngoRepName;
  TextEditingController ngoContact;
  TextEditingController ngoTelephone;
  TextEditingController ngoDescription;
  TextEditingController ngoEmail;
  TextEditingController ngoWebsite;
  File logo;
  AssetImage emptyLogo = AssetImage("assets/emptyProfile.png");
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

  Future getImg() async{
    var img = await ImagePicker.pickImage(
      source : ImageSource.gallery,
      // maxHeight: 320.0,
      // maxWidth: 240.0
      );
    var route = MaterialPageRoute(
      builder: (BuildContext context) => UserImageCrop(img: img), 
    );
    
    croppedImage = await Navigator.of(context).push(route);
    setState(() {
    logo = croppedImage;  
    });
  }



  // TextEditingController ;
  @override
  Widget build(BuildContext context) {
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
                         onTap:getImg,
                          child: Container(
                            // color: Colors.red,
                          width: 140.0,
                          height: 140.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: logo != null
                                ? FileImage(logo)               //Image.file(logo)
                                : emptyLogo
                            )
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0), 
                        child: Text("NGO Logo") 
                        ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            FieldControl(
              autofocus: true,
              label:"NGO Name" ,
              hint: "Enter your NGO name", 
              controller: ngoName,
              validate: (val){
                if(val.trim().isEmpty){
                  return "Name cannot be empty";
                }else{
                  return null;
                }
              },
              ),                
            FieldControl(
              label:"Representative Name", 
              hint: "Enter your name", 
              controller: ngoRepName,
              validate: (val){
                if(val.trim().isEmpty){
                  return "Representative Name cannot be empty";
                }else{
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
              validate: (val){
                  var pattern = RegExp(r"[0-9]{10}");
                  if(!pattern.hasMatch(val.trim())){
                    return 'Please enter valid phone no.';
                  }else{
                    return null;
                  }
              },
              ),

              FieldControl(
              label: "Telephone No.",
              hint: "Enter your landline no.",
              controller: ngoTelephone,
              keyboardType: TextInputType.phone,
              validate: (val){
                var pattern = RegExp(r"[0-9]{10}");
                if(!pattern.hasMatch(val.trim())){
                  return 'Please enter valid telephone no.';
                }else{
                  return null;
                }
              },
              ),

              FieldControl(
              label: "Email ID.",
              hint: "Enter your official Email ID.",
              controller: ngoEmail,
              validate: (val){
                var pattern = RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
                if(!pattern.hasMatch(val.trim())){
                  return "Please enter valid email address";
                }else{
                  return null;
                }
              },
              ),

              FieldControl(
              label: "Website",
              hint: "Enter your official website.",
              controller: ngoTelephone,
              validate: (val){
                var pattern = RegExp(r"((http)s?:\/\/)?www.(\w+).(\w+.)*.(com|co.in|org|net)");
                if(!pattern.hasMatch(val.trim())){
                  return "Please enter valid website";
                }else{
                  return null;
                }
              },
              ),
                    
              FieldControl(
              label: "NGO Description",
              hint: "Enter your NGO's cause.",
              maxlines: 5,
              controller: ngoDescription,
              maxLength: 320,
              validate: (val){
                if(val.trim().length < 100){
                  return "Description has to be atleast 100 characters"; 
                }
                else{
                  return null;
                }
              }
              ),

              // Container( 
              //   color: Colors.black,
              //   padding: const EdgeInsets.all(20.0),
              //   child: Crop(
              //   key: _cropKey,
              //   image: Image.file(logo).image,
              //   aspectRatio: 4.0 / 3.0,
              //   )
              // ),

             



              RaisedButton(
                child: Text("Submit"),
                onPressed: (){
                  if(_formKey.currentState.validate()){
                    Scaffold.of(context)
                      .showSnackBar(
                        SnackBar(
                          content: Text("Valid Data"),
                        )
                      );
                    
                  }
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => HomeNgo(),
                  )); 
                },
              )

            ],
          ),
        ),
      ); 
  }
}


class FieldControl extends StatelessWidget{
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
  });
 @required var label;
 var autofocus;
  var hideText;
  TextEditingController controller;
  @required var hint;
  var validate;
  var keyboardType;
  var maxlines;
  var maxLength;

  

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
        decoration: BoxDecoration(
        border: Border(
          // right: BorderSide(color: Colors.red),
            // left: BorderSide(color: Colors.red),
          ),
          // color: Colors.red,
          ),
          transform: Matrix4.rotationZ(0.01),
            child: TextFormField(
              maxLength: this.maxLength,
              maxLines: this.maxlines,
              keyboardType: this.keyboardType,
              validator : this.validate,
              obscureText: this.hideText,
              autofocus: this.autofocus,
              controller: this.controller,
            decoration: InputDecoration(
            hintText: this.hint,
            hintStyle: TextStyle(fontWeight: FontWeight.w600),
            focusColor: Colors.black,
            labelText: this.label
            ),
            ),
        );
  }
  
}