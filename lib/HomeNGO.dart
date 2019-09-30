import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands/Authentication.dart';
import 'package:helping_hands/UserData.dart';

import 'PostDetails.dart';

FirebaseUser _user;
NgoUserData _userData;



ValueNotifier vn = ValueNotifier(_userData);

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
              CircleAvatar(
                backgroundImage: _userData == null? Image.asset("assets/emptyProfile.png") : Image.network(_userData.ngoLogoUrl).image,
                radius: _drawerRadius.value,
                // child: _userData == null? Text("Loading") : Text(_userData.ngoName),
              ),
              Text("Hello User!"),
              Spacer(),
              FlatButton(
                child: Text("Sign Out"),
                onPressed: (){
                  // Implement Sign out
                  print("Signing out!");
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
              Tab(text: "Profile",),
            ],
            labelPadding: EdgeInsets.all(10.0),

          ),
        ),
        drawerDragStartBehavior: DragStartBehavior.down,
        drawer: HomeDrawer(),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            PostPage(_userData),
            Text("Profile Page"),
          ],
        ),
      ),
    );
  }
}



class PostPage extends StatefulWidget {
  NgoUserData userData;
  PostPage(this.userData);
  
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String verificationId;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
         floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(Icons.control_point),
          onPressed: (){

          },
          elevation: 20.0,
          focusColor: Colors.red,  
      ),
      body: ListView(
        children: <Widget>[
          RaisedButton(
            child: Text("Get Data"),
            onPressed: () async {
                final ph = PhoneAuth(_user);
                ph.sendSms("9152204054");
                ph.linkCred("160520")  ;
            },
          ),
          FutureBuilder(
            future: NgoUserData.getDataAsFuture(),
            builder: (context, snapshot){
                      switch(snapshot.connectionState){
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                        case ConnectionState.active:
                          return CircularProgressIndicator();
                        case ConnectionState.done:
                          if(snapshot.hasData){ 
                            _userData = snapshot.data;
                            
                            return Text(snapshot.data.ngoName);
                          }else{
                            return Text("Something went wrong");
                          }
                          break;
                        default:
                          return Text("Loading");
                          break;
                      }

            }
          ),
          // Text(_data),
          Text( _user != null ? _user.uid : "No user"),
          // Text(_userData.ngoName),
          // Text(_userData.ngoDescription),
          Post(),
          // Post2(),
          // Post(),
        ],
      ),
    );
  }
}


class Post extends StatelessWidget{

  // Post({
  //   this.imageUrl, 
  //   this.userName, 
  //   this.description,
  //   this.postID,
  //   this.eventName,
  //   this.ngoName,
  // })
      
  @override
  Widget build(BuildContext context) {
    var image = Image.asset("assets/Beach.jpeg");
    var userName = "Name of User";
    String fullDescrption = "This is the full description of the image i don't care I can add whatever I want allalallalalallalallafbafeufgbaeub fueaaibf wiudhauwbawbfuw fwabfuiawbfuwabfa fwuibfaiuwbfia wfafiabwfawufiuab iwufbawfawbfa wfawbfawfiuab awfibawfi wfbawug awgibawawugbawf awfiubawfawufbwafa fwbafiuawfbaw fawufbawfbwiuabwaf afbaiuwfbafiuwbfwi";
    Post();
    return GestureDetector(
      onTap: (){
        Navigator.push(context, 
          MaterialPageRoute(
            builder: (context) => PostDetails(
              image: image,
              userName: userName,
              description: fullDescrption,
            ),
          ),
        );
      },
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.landscape), //Cirular Avatar
              title: Text(userName),
              subtitle: Text(fullDescrption.substring(0, 20) + "..."),
            ),
            Hero(
              tag: "Post",
              child: image,
              ),

          ],
        ),
      ),
    );
  }
  
}

// class Post2 extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//           leading: Icon(Icons.landscape),
//           title: Text("Name of User"),
//           subtitle: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Image.asset("assets/Beach.jpeg"),
//               Text("Description of Image"),
//             ],
//           ),
        
//         // Image.asset("assets/Beach.jpeg"),
        
//     );
//   }
  
// }