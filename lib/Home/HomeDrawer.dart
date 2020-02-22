import 'package:flutter/material.dart';
import 'package:helping_hands/About.dart';
import 'package:helping_hands/Registration/Login.dart';
import 'package:helping_hands/Utils/Routes.dart';
import 'package:helping_hands/Utils/UserData.dart';

import 'UpdateProfile.dart';

class HomeDrawer extends StatefulWidget {
  final NgoUserData userData;
  HomeDrawer({@required this.userData});
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> with SingleTickerProviderStateMixin{
 AnimationController _drawerController;
  Animation _drawerRadius;
  NgoUserData _userData;
  static var temp;
  ValueNotifier vn = ValueNotifier(temp); 
  @override
  void initState() { 
    super.initState();
    _userData = widget.userData;
    _drawerController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )
    ..addListener((){
      setState(() {
        
      });
    });

    vn.addListener((){
      setState(() {
        
      });
    });
    
    _drawerRadius = Tween(
      begin: 50.0,
      end: 130.0,
    ).animate(_drawerController);
    print("Init");
    _drawerController.forward();
    
    
  }

  @override
  void dispose() {
    print("Disposed");
    _drawerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
          child :Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 35.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        // color: Colors.lightGreenAccent,
                        constraints: BoxConstraints.loose(Size(300, 300)),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.blue, Colors.greenAccent]
                          )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: GestureDetector(
                            onDoubleTap: (){
                              print(Routes.updateProfile);
                              // Navigator.push(context, MaterialPageRoute(
                              //   builder: (context) => UpdateNGOProfile()
                              // ));
                              // Navigator.pushNamed(context, Routes.updateProfile, );
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamed(Routes.updateProfile);
                            },
                            child: FutureBuilder(
                              future: NgoUserData.getDataAsFuture(),
                              builder: (context, snapshot){
                                // if(_userData != null){
                                // return CircleAvatar(
                                //   backgroundImage: Image.asset("assets/emptyProfile.png").image,
                                //   radius: _drawerRadius.value,
                                // );
                                // }
                                if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                                  _userData = snapshot.data;
                                  print(_userData);
                                  temp = true;
                                  if(snapshot.data.ngoLogoUrl != null)_userData.ngoLogo = Image.network(snapshot.data.ngoLogoUrl, height: 100.0, width: 100.0);
                                  else _userData.ngoLogo = Image.asset("assets/emptyProfile.png");
                                  return CircleAvatar(
                                    backgroundImage: _userData.ngoLogo.image,
                                    radius: _drawerRadius.value,
                                  );
                                }
                                else{
                                  return CircleAvatar(
                                    backgroundImage: Image.asset("assets/emptyProfile.png").image,
                                    radius: _drawerRadius.value,
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.greenAccent,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _userData != null ? _userData.ngoName : "Loading",
                              softWrap: true,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400
                              ),
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _userData != null ? _userData.ngoRepName : "Loading",
                              softWrap: true,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700
                              ),
                              ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.greenAccent,
                        thickness: 2,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                            width: 2 
                          )
                        ),
                        child: FlatButton(
                          child: Text(
                            "About",
                            style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                            ),
                          ),
                          onPressed: (){
                            Navigator.of(context).pop();
                            Navigator.pushNamed(context, Routes.about);
                          },
                        ),
                      ),

                      FlatButton(
                        child: Container(
                          margin: EdgeInsets.only(top: 30),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                              width: 2
                            )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "Sign Out",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                                ),
                          ),
                        ),
                        onPressed: (){
                          // Implement Sign out
                          print("Signing out!");
                          Navigator.of(context).pop();
                          Navigator.pushReplacementNamed(context, Routes.login);
                          }
                        ),
                    ],
                  ),
                )
              ]
          )
    );
  }              
}
