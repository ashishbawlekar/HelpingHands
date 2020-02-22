import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands/Home/Events/EventPage.dart';
// import 'package:helping_hands/Registration/Authentication.dart';
import 'package:helping_hands/Home/Posts/PostPage.dart';
import 'package:helping_hands/Registration/Login.dart';
import 'package:helping_hands/Utils/UserData.dart';

FirebaseUser _user;
VolunteerUserData _userData;



//ValueNotifier vn = ValueNotifier(_userData);
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
                future: VolunteerUserData.getDataAsFuture(),
                builder: (context, snapshot){
                  if(_userData != null){
                    return CircleAvatar(
                     backgroundImage: _userData.profile,
                      radius: _drawerRadius.value,  
                    ); 
                  }
                  if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                    _userData = snapshot.data;
                    _userData.profile = Image.network(snapshot.data.profileUrl).image;
                    return Column(
                      children: <Widget>[
                        CircleAvatar(
                         backgroundImage: _userData.profile,
                          radius: _drawerRadius.value,
                          //  child: Text(snapshot.data.displayName), 
                        ),
                        Text(_userData.displayName),
                      ],
                    );
                  }else{
                      return  CircleAvatar(
                          backgroundImage: Image.asset("assets/emptyProfile.png").image,
                          radius: _drawerRadius.value,
                          child: Text("Loading"),
                        ); 
                  }
                } 
                                  
                //   CircleAvatar(
                //   backgroundImage: _userData == null? Image.asset("assets/emptyProfile.png").image : Image.network(_userData.profileUrl).image,
                //   radius: _drawerRadius.value,
                //   // child: _userData == null? Text("Loading") : Text(_userData.ngoName),
                // ),
              ),
              Text(_userData != null ? _userData.displayName : "Loading"),
              Spacer(),
              FlatButton(
                child: Text("Sign Out"),
                onPressed: (){
                  // Implement Sign out
                  print("Signing out!");
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Login()));
                },
              ),
            ],
          ),
        );
    
  }
}
class HomeVolunteer extends StatefulWidget {
  UserData userData;
  HomeVolunteer({this.userData});
  @override
  _HomeVolunteerState createState() => _HomeVolunteerState();
}

class _HomeVolunteerState extends State<HomeVolunteer> with TickerProviderStateMixin{
  TabController _tabController;
  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();  
  AnimationController _drawerController;
  Animation _drawerRadius;

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
    _tabController = TabController(
    vsync: this,
    initialIndex: 0,
    length: 2,
  );
   FirebaseAuth.instance.currentUser().then((user){
     _user=user;
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
    return Scaffold(
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
            EventPage(),
          ],
        ),
    );
  }
}



