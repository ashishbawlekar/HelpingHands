
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:helping_hands/Home/Events/EventDetails.dart';
// import 'package:helping_hands/AnimationExampleBasic.dart';
import 'Home/HomeNGO.dart';
import 'Registration/Login.dart';
// import 'Registration.dart';

import 'Registration/NGO_Registration.dart';
import 'Registration/Registration.dart';

class Router{
static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyApp());
      case '/Login':
        return MaterialPageRoute(builder: (_) => Login());
      case '/Registration':
        return MaterialPageRoute(builder: (_) => Registration());
      case '/Registration/NgoReg':
        return MaterialPageRoute(builder: (_) => NgoReg());
      case '/Registration/NgoReg/HomeNGO':
        return MaterialPageRoute(builder: (_) => HomeNgo());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
  }

//GetIt getIt = GetIt.asNewInstance();

void main() => runApp(
   MaterialApp(
      title: "Vote Up",
      // home: MyApp(),
      initialRoute: '/',
      home: MyApp(),
      // routes: {
      //   '/' : (context) => MyApp(),
      //   '/Login' : (context) => Login(),
      //   '/Registration' : (context) => Registration(),
      //   '/Animation' : (context) => AnimationExample(),
      //   '/NgoReg' : (context) => NgoReg(),
      //   '/HomeNGO' : (context) => HomeNgo(),
      //   '/Registration/NgoReg/HomeNGO' : (context) => HomeNgo(),
      // },
      onGenerateRoute: Router.generateRoute,

      )
);
// void main() => runApp(GetTextApp());
class MyApp extends StatefulWidget{
  // MyApp({key: key}): super(key:key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  int count = 30;
  bool resendOTP = false;
  voteUp(){
    setState(() {
    count++;  
    });
  }
   
voteDown() { 
  setState(() {
    count--;  
    });
 
  }




  // Future<bool> _onWillPop(){
  // print("In Will pop scope!");
  //   return showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text('Are you sure?'),
  //       content: Text('You will lose all the data!'),
  //       actions: <Widget>[
  //         FlatButton(
  //           onPressed: () => Navigator.of(context).pop(false),
  //           child: Text('No'),
  //         ),
  //         FlatButton(
  //           onPressed: () => Navigator.of(context).pop(true),
  //           child: new Text('Yes'),
  //         ),
  //       ],
  //     ),
  //   ) ?? false;
  // }

  @override
  Widget build(BuildContext context) {
    
    // Timer timer = new Timer.(duration, callback);
    return Scaffold(
          appBar: AppBar(
          title: Text("Voting App", 
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black
          ),),
          backgroundColor: Colors.grey,
          leading: const Icon(Icons.home),
          ),
          body: Center(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                // TestMap(),
                EventDetails(),
                RaisedButton(
                  child: Text("Vote up! $count"),
                  onPressed: resendOTP ? null : () {
                    Timer.periodic(
                      Duration(seconds: 1), 
                      (Timer timer){
                        setState(() {
                          count--;
                        if(count == 0){
                          count = 30;
                          timer.cancel();
                          resendOTP = false;
                          print("Button Enabled");
                        }
                        if(count < 30 && count > 0){
                          resendOTP = true;
                          print("Button Disabled");
                        }
                        
                        });
                        
                      });
                    // TextEditingController controller  = TextEditingController();
                    // final otp = await showDialog(
                    //   context: context,
                    //   builder: (_){
                    //     return AlertDialog(
                    //       title: ListTile(
                    //         title: Text(
                    //             "Enter your OTP",
                    //             style: TextStyle(
                    //             fontWeight: FontWeight.w500,
                    //             ),
                    //           ),
                    //         leading: Icon(Icons.mail),
                    //         ),
                    //       contentPadding: EdgeInsets.all(20.0),
                    //       content: TextField(
                    //         controller: controller,
                    //         keyboardType: TextInputType.number,
                    //         decoration: InputDecoration(
                    //           hintText: "OTP here",
                    //           border: OutlineInputBorder(
                                
                    //           )
                    //         ),
                    //       ),
                    //       elevation: 15.0,
                    //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    //       actions: <Widget>[
                    //         FlatButton(
                    //           child: Text("Re-send OTP"),
                    //           onPressed: null,
                    //         ),
                    //         FlatButton(
                    //           child: Text("Submit"),
                    //           onPressed: (){
                                
                    //             Navigator.of(context).pop(controller.text);
                    //           },
                    //         )
                    //       ],
                    //     );
                        
                    //   }
                    // );         
                    // print(otp);

                  },      
                                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 12.0),
                                color: Colors.lightGreen,
                                // colorBrightness: Brightness.light,
                                elevation: 20.0,
                                splashColor: Colors.green,
                              ),
                              RaisedButton(
                                child: Text("Login"),
                                onPressed: (){
                                //  Navigator.push(
                                //  context,
                                //  MaterialPageRoute(builder: (context) => GetTextApp()),
                                // );
                                Navigator.pushNamed(context, '/Login');
                            },
                                padding: const EdgeInsets.all(10.0),
                                color: Color.fromARGB(100, 250, 0, 0),
                                // colorBrightness: Brightness.light,
                                splashColor: Color.fromARGB(255, 250, 0, 0),
                              ),
                            ],
                          ),
                        ),
                      
    );
                    
                }
                
             
}

