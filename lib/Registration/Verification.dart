import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Authentication.dart';

Future<FirebaseUser> refreshUser(){
  return Future.delayed(
    Duration(seconds: 3),
    () async {
      var user = await FirebaseAuth.instance.currentUser();
      
      user.reload();
      return user;
    },
  );
}

class VerificationNgo extends StatefulWidget {
  final PhoneAuth phoneAuth;
  
  VerificationNgo(this.phoneAuth);
  @override
  _VerificationNgoState createState() => _VerificationNgoState();
}

class _VerificationNgoState extends State<VerificationNgo> {
ValueNotifier isVerified;
  FirebaseUser _user;
  TextEditingController _smsCode = TextEditingController();
  var sentEmail = false, otpChecked = false, verifiedEmail = false;
  @override
  void initState() { 
    FirebaseAuth.instance.currentUser().then((user){_user = user;});
    isVerified = ValueNotifier(_user)
    ..addListener((){
      setState(() {
        verifiedEmail = _user.isEmailVerified;
      });
    });
    print("Init State Called for Verification");
    // setState(() {
    //   // _user.reload();
    // });
    super.initState();
    
  }



Future<bool> _onWillPop(){
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Sorry'),
        content: new Text('You cannot exit at this point.'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('OK'),
          ),

        ],
      ),
    ) ?? false;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
          child: Scaffold(
          appBar: AppBar(
            title: Text("Verification Page"),
            backgroundColor: Colors.greenAccent,
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                AnimatedPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0), 
                  duration: Duration(milliseconds: 500),
                  child: FlatButton(
                    child: Text("Click here to send verification Email!"),
                    color: Colors.blue,
                    onPressed: (){
                      if(!sentEmail){
                         _user.sendEmailVerification(); 
                      } 
                      sentEmail = true;
                      print(_user.isEmailVerified);
                    },
                  )
                ),

                Row(
                  children: <Widget>[
                    FutureBuilder(
                      future: refreshUser(),
                      builder: (context, snapshot){
                        if(snapshot.connectionState == ConnectionState.done){
                          verifiedEmail = snapshot.data.isEmailVerified;
                          // setState(() {
                            
                          // });
                          return Text("Email Verified :" + verifiedEmail.toString());
                        }
                        else{
                          return Text("Loading");
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton.icon(
                        label: Text("Reload"),
                        icon: Icon(Icons.redo),
                        onPressed: () {
                          setState(() { });
                        },
                      ),
                    )
                  ],
                ),

                AnimatedPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0), 
                  duration: Duration(milliseconds: 500),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        maxLength: 6,
                        autocorrect: false,
                        controller: _smsCode,
                        onChanged: (val){
                          if(val.length == 6){
                            otpChecked = true;
                          }else{
                            otpChecked = false;
                          }
                        },
                      ),
                      RaisedButton(
                        child: Text("Submit OTP"),
                        
                        onPressed: !(sentEmail && verifiedEmail && otpChecked) ? null : () async {
                          if(widget.phoneAuth == null ) throw Exception("Phone Auth was null");
                          try{
                            widget.phoneAuth.linkCred(
                              _smsCode.text
                            );
                            final user = await FirebaseAuth.instance.currentUser();
                            if(user.isEmailVerified){
                              Navigator.pop(context, true);
                              }
                            else{
                                print("Deleting user!");
                                user.delete();
                                Navigator.pop(context, false);
                                }
                            }
                          catch(err){
                            print(err);
                          }
                        },
                      )
                    ],
                  ),
                  
                ),
              ],
            ),
          ),
        ),
    );
  }
}