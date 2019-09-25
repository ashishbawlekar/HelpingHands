import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:helping_hands/Registration.dart';
// import 'package:toast/toast.dart';
import 'RouteAnimation.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

// class SlideRoute extends PageRouteBuilder{
//    Widget page;
//    Offset offset;
//    SlideRoute({this.page, this.offset}) : super(
//      pageBuilder : (
//        BuildContext context,
//        Animation<double> animation,
//        Animation<double> secondaryAnimation,
//      ) => page, 
//      transitionsBuilder : (
//        BuildContext context,
//        Animation<double> animation,
//        Animation<double> secondaryAnimation,
//        Widget child,
//      ) => SlideTransition(
//        position: Tween<Offset>(
//          begin: offset,
//          end: Offset.zero,
//        ).animate(animation),
//        child: child,
//      ),
//    );

// }

class _LoginState extends State<Login> {
  String userName;
  String contact;
  bool isVol = true;
  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  var init, distance;
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
        body: GestureDetector(
          onPanStart: (DragStartDetails deets){
            init = deets.globalPosition.dx;
          },
          onPanUpdate: (DragUpdateDetails deets){
            distance = deets.globalPosition.dx - init;
          },
          onPanEnd: (var deets){
            init = 0.0;
            if(distance < -120 ){
               Navigator.push(context, SlideRoute(offset: Offset(1, 0),page: Registration())); 
            }
          },
                  child: Container(
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
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                      child: Text(
                        "Enter your name: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize:  18.0
                        ),
                        )
                      ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      transform: Matrix4.rotationZ(0.01),
                      child: TextField(
                        // autofocus: true,
                        controller: _username,
                        decoration: InputDecoration(
                          hintText: "Enter your name",
                          fillColor: Colors.redAccent,
                          border: OutlineInputBorder(),
                        ),
                        // scrollPhysics: ScrollPhysics(),
                      ),
                    ),
                   Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 20.0),
                      // padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                      child: Text(
                        "Enter your contact info: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize:  16.0
                        ),
                        )
                      ),
                    Container(
                       padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 30.0), //symmetric(horizontal: 20.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        // color: Colors.blueGrey,
                      ),
                      transform: Matrix4.rotationZ(0.01),
                      child: TextField(
                          keyboardType: TextInputType.phone,
                          // autofocus: true,
                          controller: _password,
                          decoration: InputDecoration(
                          hintText: "Enter your contact no.",
                          fillColor: Colors.redAccent,
                          border: OutlineInputBorder(),
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
                          userName = _username.text.toString();
                          contact = _password.text.toString(); 
                        Navigator.popAndPushNamed(context, "/Registration");
                      },
                    ),
                    
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
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset("assets/Compassion.jpg", 
                        height: 180.0,
                        width: 690.0,
                      ),
                    ),
                  ],
                ),
          ),
        ),
        ),
      );
  }
}
