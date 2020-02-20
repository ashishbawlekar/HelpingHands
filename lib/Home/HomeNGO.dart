import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands/Home/Events/EventPage.dart';
// import 'package:helping_hands/Home/Events/EventPage.dart';
import 'package:helping_hands/Home/Posts/PostPage.dart';
import 'package:helping_hands/Home/UpdateProfile.dart';
// import 'package:helping_hands/Registration/Authentication.dart';
// import 'package:helping_hands/Home/PostPage.dart';
import 'package:helping_hands/Registration/Login.dart';
import 'package:helping_hands/Utils/UserData.dart';

FirebaseUser _user;
NgoUserData _userData;                    



ValueNotifier vn = ValueNotifier(_userData);
ValueNotifier vuser = ValueNotifier(_user);

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> with SingleTickerProviderStateMixin{
 AnimationController _drawerController;
  Animation _drawerRadius;

  @override
  void initState() { 
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

  vuser.addListener((){
    setState(() {
      
    });
  });
    _drawerRadius = Tween(
      begin: 50.0,
      end: 100.0,
    ).animate(_drawerController);
    print("Init");
    _drawerController.forward();
    super.initState();
    
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
                Spacer(),
                GestureDetector(
                  onDoubleTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UpdateNGOProfile()
                      )
                    );
                  },
                  child: FutureBuilder(
                    future: NgoUserData.getDataAsFuture(),
                    builder: (context, snapshot){
                      if(_userData != null){
                      return CircleAvatar(
                        backgroundImage: Image.asset("assets/emptyProfile.png").image,
                        radius: _drawerRadius.value,
                      );
                      }
                      if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                        _userData = snapshot.data;
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

                Text(_userData != null ? _userData.ngoName : "Loading"),
                Spacer(),
                FlatButton(
                  child: Text("Sign Out"),
                  onPressed: (){
                    // Implement Sign out
                    print("Signing out!");
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return Login();
                        }

                      ),
                       );
                    // Navigator.popAndPushNamed(context, "/Login");
                    // Navigator.popUntil(context, ModalRoute.withName("/Login"));
                    
                  },
                ),
              ],
            ),
        );
    
  }
}
class HomeNgo extends StatefulWidget {
  UserData userData;
  HomeNgo({this.userData});
  @override
  _HomeNgoState createState() => _HomeNgoState();
}

class _HomeNgoState extends State<HomeNgo> with TickerProviderStateMixin{
  TabController _tabController;
  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();  
  AnimationController _drawerController;
  Animation _drawerRadius;
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
      BackButtonInterceptor.add((val){
       showDialog(
         context: context,
        builder: (_) => _backButtonConfirmation()
       );
       return true;
     });
     vn.addListener((){
       setState(() {});
     });
    _tabController = TabController(
    vsync: this,
    initialIndex: 0,
    length: 2,
  );
   FirebaseAuth.instance.currentUser().then((user){
     _user=user;
    //  print("Getting NGO data: ");
    //  if(widget.userData == null){
    //  _userData = NgoUserData.getData(user.uid);
    //  }else{
    //    _userData = widget.userData;
    //  }
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
    return MaterialApp(
      title: "Home",
      home: Scaffold(
        key: _scaffoldKey,
        // appBar: AppBar(
          
        //   backgroundColor: Colors.blue,
        //   bottom: TabBar(
        //     controller: _tabController,
        //     tabs: <Widget>[
        //       Tab(text: "Posts",),
        //       Tab(text: "Events",),
        //     ],
        //     labelPadding: EdgeInsets.all(10.0),

        //   ),
        // ),
        // drawerDragStartBehavior: DragStartBehavior.down,
        drawer: HomeDrawer(),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            GestureDetector(
              child: PostPage(),
              onHorizontalDragStart: (DragStartDetails deets){
             init = deets.globalPosition.dx;
          },
          onHorizontalDragUpdate: (DragUpdateDetails deets){
            dist = deets.globalPosition.dx - init;
          },
          onHorizontalDragEnd: (DragEndDetails deets){
            if(dist > 120)
            {
              if(_scaffoldKey == null) print("Key is null");
              else if(_scaffoldKey.currentState == null) print("State is null");
              else _scaffoldKey.currentState.openDrawer();
              // Scaffold.of(context).openDrawer();
            }
            if(dist < 120)
            {
              _tabController.animateTo(1);
            }
          }
            ),
            EventPage(),
          ],
        ),
      ),
    );
  }
}



