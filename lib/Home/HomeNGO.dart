import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands/Registration/Authentication.dart';
import 'package:helping_hands/Home/PostPage.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              FutureBuilder(
                future: NgoUserData.getDataAsFuture(),
                builder: (context, snapshot){
                  if(_userData != null){
                  CircleAvatar(
                    backgroundImage: _userData.ngoLogo,
                    radius: _drawerRadius.value,
                  //  child: _userData == null? Text("Loading") : Text(_userData.ngoName),
                  );
                  }
                  if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                    _userData = snapshot.data;
                    _userData.ngoLogo = Image.network(snapshot.data.ngoLogoUrl).image;
                    return CircleAvatar(
                      backgroundImage: _userData.ngoLogo,
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

  @override
  void initState() { 
     super.initState();
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
    return MaterialApp(
      title: "Home",
      home: Scaffold(
        appBar: AppBar(
          // title: Text("Home"),
          // leading: IconButton(
          //   icon: Icon(Icons.menu),
          //   onPressed: (){
          //     // _scaffoldKey.currentState.openDrawer();
          //     _drawerController.forward();
          //     setState(() {
                
          //     });
          //   },
          //   ),
          // flexibleSpace: FlexibleSpaceBar(
          //   title: Text("Hello World"),
          // ),

          
          backgroundColor: Colors.blue,
          bottom: TabBar(
            controller: _tabController,
            tabs: <Widget>[
              Tab(text: "Posts",),
              Tab(text: "Events",),
            ],
            labelPadding: EdgeInsets.all(10.0),

          ),
        ),
        drawerDragStartBehavior: DragStartBehavior.down,
        drawer: HomeDrawer(),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            PostPage(),
            Text("Profile Page"),
          ],
        ),
      ),
    );
  }
}



