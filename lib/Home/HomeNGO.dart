import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands/Home/Events/EventPage.dart';
import 'package:helping_hands/Home/Posts/PostPage.dart';
import 'package:helping_hands/Utils/Medals.dart';
import 'package:helping_hands/Utils/Routes.dart';
import 'package:helping_hands/Utils/UserData.dart';
import 'HomeDrawer.dart';

                    
class HomeNgo extends StatefulWidget {
  UserData userData;
  HomeNgo({this.userData});
  @override
  _HomeNgoState createState() => _HomeNgoState();
}

class _HomeNgoState extends State<HomeNgo> with TickerProviderStateMixin{
  FirebaseUser _user;
  NgoUserData _userData;
  TabController _tabController;
  double init;
  double dist;
   _backButtonConfirmation() {
    return AlertDialog(
        title: Text("Are you sure?"),
        content: Text("You want to log out?"),
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
    //   BackButtonInterceptor.add((val){
    //   print(ModalRoute.of(context).settings.name);
    //   if(ModalRoute.of(context).settings.name == Routes.homeNGO || ModalRoute.of(context).settings.name == Routes.homeVol){
    //    showDialog(
    //      context: context,
    //     builder: (_) => _backButtonConfirmation()
    //    );
    //    return false;
    //  }
    //  else{
    //    return true;
    //  }
    //   }
    //  );
    _tabController = TabController(
    vsync: this,
    initialIndex: 0,
    length: 3,
  );
   FirebaseAuth.instance.currentUser().then((user){
     _user=user;
   });
   NgoUserData.getDataAsFuture().then((data){
     _userData = data;
   });
   
   
    // (FirebaseAuth.instance.currentUser());   
  }

  @override
  void dispose() {
    _tabController.dispose();
    // vn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey  = GlobalKey<ScaffoldState>(); 
    return WillPopScope(
          onWillPop: () { 
            //False means no pop
            return showDialog<bool>(
              context: context,
              builder: (_) => AlertDialog(
                title: Text("Are you sure?"),
                content: Text("You want to log out?"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: () {
                      print("true");
                      Navigator.of(context).pop(true);
                      Navigator.popAndPushNamed(context, Routes.login);
                    }),
                  FlatButton(
                    child: Text("No"),
                    onPressed: () {
                    print("False");
                    Navigator.of(context).pop(false);
                  })
                ]       
              )
            ); 
          },
          child: Scaffold(
          key: _scaffoldKey,
          drawer: HomeDrawer(userData: _userData,),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              GestureDetector(
                child: PostPage(),
                onHorizontalDragStart: (deets) => init = deets.globalPosition.dx,
                onHorizontalDragUpdate: (deets)=> dist = deets.globalPosition.dx - init,
                onHorizontalDragEnd: (DragEndDetails deets){
                  if(dist > 120)  _scaffoldKey.currentState.openDrawer(); //Open the drawer
                  if(dist < 120) _tabController.animateTo(1);             //Open events page
                }
              ),
              GestureDetector(
                child: EventPage(),
                onHorizontalDragStart: (deets) => init = deets.globalPosition.dx,
                onHorizontalDragUpdate: (deets) => dist = deets.globalPosition.dx - init,
                onHorizontalDragEnd: (DragEndDetails deets){ 
                  if(dist > 120) _tabController.animateTo(0); //Open posts page
                  if(dist < 120) _tabController.animateTo(2); //Open medals page
                }
              ),
              Medals()
            ],
          ),
      ),
    );
  }
}



