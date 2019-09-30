// import 'package:flare_flutter/flare_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flare_flutter/flare_controller.dart';
// import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:helping_hands/Authentication.dart';
import 'package:helping_hands/HomeNGO.dart';
// import 'package:helping_hands/Registration.dart';
// import 'package:helping_hands/main.dart';
// import 'package:toast/toast.dart';
// import 'RouteAnimation.dart';
import 'Authentication.dart';
import 'package:flare_flutter/flare_actor.dart';


class LoginVia extends AnimatedWidget{
  final Animation<Offset> register;
  final Animation<Color> registerColor;
  final Animation<double> registerScale;
  final AnimationController controller;
  LoginVia({
    Key key, 
    @required this.register,
    @required this.registerColor,
    @required this.registerScale,
    @required this.controller,
    }):super(key : key, listenable: register);

  @override
  Widget build(BuildContext context) {
    return Container(
            // color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Transform.translate(
                  offset: register.value,
                    child: Transform.scale(
                      scale: registerScale.value,
                      child: RaisedButton(
                      color: registerColor.value,
                      // splashColor: Colors.red,
                        onPressed: (){
                          controller.forward();
                          },
                        child: Text("Register"),
                  ),
                    ),
                )
              ],
            ),
          );
  }
  
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}


class _LoginState extends State<Login> with TickerProviderStateMixin {
  bool isVol = true;
  Animation<Offset> animG;
  Animation<Offset> animF;
  AnimationController controller;
  AnimationController _controllerR;
  Animation<Offset> _register;
  Animation<Color> _registerColor;
  Animation<double> _registerScale;

  
  @override
  void initState() { 
    super.initState();
    _controllerR = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )
    ..addListener((){
      setState(() {
        
      });
    })
    ..addStatusListener((status){
      if(status == AnimationStatus.completed){
        print("Animation Started!");
        _controllerR.reverse();
      }else if(status == AnimationStatus.dismissed){
        print("Animation Finished!");
          Navigator.popAndPushNamed(context, "/Registration");       
      }
    });
    
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _register = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(-40.0, 0)
    ).animate(_controllerR);

    _registerColor = ColorTween(
      begin: Colors.green,
      end: Colors.blue
    ).animate(_controllerR);

    _registerScale = Tween(
      begin: 1.0,
      end: 1.5
    ).animate(_controllerR);

    animG = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(1.0, 0.0),
    ).animate(controller);
    
    animF = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(2.0, 0.0),
    ).animate(controller);
    
    // controller.forward();
  }
  
  
  @override
  void dispose() { 
    controller.dispose();
    _controllerR.dispose();
    super.dispose();
  }
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  // var registerAnim = "idle";
  var init, distance, stackElevation=10.0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Login",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.black54,
              fontWeight: FontWeight.w400,
              // fontStyle: FontStyle.italic
            ),
          ),
        backgroundColor: Color.fromARGB(100, 150, 120, 200),
        leading: Icon(Icons.local_activity),
        elevation: 30.0,
        actions: <Widget>[

        ],
        ),
        body: Container(
          height: 800.0,
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
                    child: Container(
                      // color: Colors.green,
                padding: EdgeInsets.only(top: 80.0, left: 10.0, right: 10.0),
                decoration: BoxDecoration(
               // borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  border: Border(
                    right: BorderSide(color: Colors.blue, width: 4.0),
                    left: BorderSide(color: Colors.blue, width: 4.0),
                  ),
                ), 
                  child:  Column(            
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        LoginVia(
                          register: _register,
                          registerColor: _registerColor,
                          registerScale: _registerScale,
                          controller: _controllerR,
                        ),
                         Padding(
                           padding: const EdgeInsets.all(15.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: <Widget>[
                               Stack(
                                 children: <Widget>[
                                 
                               SlideTransition(
                                 position: animF,
                                    child: ClipRect(
                                   clipBehavior: Clip.antiAlias,
                                   child: Padding(
                                     padding: const EdgeInsets.all(10.0),
                                     child: RaisedButton(
                                       onPressed: (){

                                       },
                                       elevation: 10.0,
                                       color: Colors.white,
                                       splashColor: Colors.blue,
                                      //  icon: Icon(Icons.face),
                                       child: Image.asset(
                                         "assets/f.png",
                                         height: 30.0,
                                         width: 30.0,
                                         ),
                                     ),
                                   ),
                                 ),
                               ),
                                 SlideTransition(
                                   position: animG,
                                   child: ClipRect(
                                   child: Padding(
                                     padding: const EdgeInsets.all(10.0),
                                     child: RaisedButton(
                                       color: Colors.white,
                                       splashColor: Colors.redAccent,
                                       onPressed: (){

                                       },
                                       elevation: 10.0,
                                      //  icon: Icon(Icons.group_work),
                                       child: Image.asset(
                                         "assets/g.png",
                                         height: 30.0,
                                         width: 30.0,
                                         ),
                                     ),
                                   ),
                                   ),
                                 ),
                                    RaisedButton(
                                      padding: EdgeInsets.all(15.0),
                                 onPressed: (){
                                   switch (controller.status) {
                                       case AnimationStatus.completed:
                                         stackElevation=10.0;
                                         controller.reverse();
                                         break;
                                       case AnimationStatus.dismissed:
                                          stackElevation = 20.0;
                                         controller.forward();
                                                  break;
                                      default:
                                   }
                                 },
                                 elevation: stackElevation,
                                 child: Text("Login via :"),
                                 color: Color.fromARGB(255, 37, 204, 247),
                                 splashColor: Color.fromARGB(255, 27, 156, 252),
                               ),
                               
                                 ],
                               ),
                               
                             ],
                           ),
                         ), 

                        // Container(
                        //   alignment: Alignment.centerLeft,
                        //   margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                        //   child: Text(
                        //     "Enter your name: ",
                        //     style: TextStyle(
                        //       fontWeight: FontWeight.w300,
                        //       fontSize:  18.0
                        //     ),
                        //     )
                        //   ),
                        Container(
                          // decoration: BoxDecoration(

                          // ),
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                          transform: Matrix4.rotationZ(0.01),
                          child: TextField(
                            // autofocus: true,
                            controller: _email,
                            decoration: InputDecoration(
                              hintText: "Enter your Email ID",
                              fillColor: Colors.redAccent,
                              prefixIcon: Icon(Icons.mail_outline),
                              border: OutlineInputBorder(),
                              focusColor: Colors.black87,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0)
                              ),
                            ),
                            // scrollPhysics: ScrollPhysics(),
                          ),
                        ),

                      //  Container(
                      //     alignment: Alignment.centerLeft,
                      //     margin: EdgeInsets.only(top: 20.0),
                      //     // padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                      //     child: Text(
                      //       "Enter your Email ID: ",
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.w300,
                      //         fontSize:  16.0
                      //       ),
                      //       )
                      //     ),
                        Container(
                           padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0, bottom: 30.0), //symmetric(horizontal: 20.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            // color: Colors.blueGrey,
                          ),
                          transform: Matrix4.rotationZ(0.01),
                          child: TextField(
                              // keyboardType: TextInputType.,
                              // autofocus: true,
                              controller: _password,
                              decoration: InputDecoration(
                              hintText: "Enter your password ",
                              prefixIcon: Icon(Icons.lock),
                              fillColor: Colors.redAccent,
                              border: OutlineInputBorder(),
                              focusColor: Colors.black87,
                              focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0)
                              ),
                            ),
                          ),
                        ),
                        RaisedButton(
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: 78.0,
                              maxHeight: 70.0,
                            ),
                            margin: EdgeInsets.symmetric(horizontal: .0),
                            child:Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 1.0),
                                      child: Image.asset(
                                        'assets/login.png',
                                        width: 20.0,
                                        height: 20.0,
                                        ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.0),
                                      child: Text("Submit", 
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w300
                                        )
                                      ),
                                    ),
                                  ],
                                ),
                               ),
                          // rgba(37, 204, 247,1.0)
                          color: Color.fromARGB(255, 37, 204, 247),
                          // rgba(27, 156, 252,1.0)
                          splashColor: Color.fromARGB(255, 27, 156, 252), 
                          elevation: 20.0,
                          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                          onPressed: (){
                              String email = _email.text.toString().trim();
                              String pass = _password.text.toString(); 
                              // FirebaseUser currentUser;
                              // Check if doc exists in NgoUsers before letting user get to NgoHome
                              // To prevent people from seeing NGO page without having to sign up as NGO
                              EmailAuth()
                              ..signInWithEmail(email, pass)
                              .then((currentUser){
                                if(!isVol){
                                Navigator.push(context,
                                  MaterialPageRoute(
                                   builder: (context) => HomeNgo(),
                                  ),
                                );
                                }else{
                                  print("Home Volunteer is under construction");
                                }
                              }).catchError((err){
                                print(err);
                                // print(err.);
                              });
                              }),
                        
                        RaisedButton(
                          child: isVol ? Text("as Volunteer") : Text("as NGO"),
                          onPressed: (){
                            setState(() {
                            isVol = !isVol;  
                            });
                            
                          },
                          color: Colors.red,
                          splashColor: Colors.green,
                        ),
                        
                        Container(
                          padding: EdgeInsets.only(top: 20.0),
                          // curve: Curves.bounceIn,
                          // duration: Duration(seconds: 2),
                          constraints: BoxConstraints(
                            maxHeight: 150.0, 
                          ),
                          decoration: BoxDecoration(
                            // border: Border.all(color: Colors.brown)
                          ),
                          // height: 200.0,
                          // width: 400.0,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: FlareActor(
                              "assets/Compassion.flr", 
                              animation: "Rotate",
                              color: Colors.red,
                              // fit: BoxFit.contain,
                              // controller: FlareController(
                                
                              // ),
                              ),
                          ),
                        ),
                      ],
                    ),
              ),
            ),
          ),
        ),
        
      );
  }
}
