import 'package:flutter/material.dart';

import 'PostDetails.dart';

class HomeNgo extends StatefulWidget {
  @override
  _HomeNgoState createState() => _HomeNgoState();
}

class _HomeNgoState extends State<HomeNgo> with SingleTickerProviderStateMixin{
  TabController _tabController;

  @override
  void initState() { 
    _tabController = TabController(
    vsync: this,
    initialIndex: 0,
    length: 2,
  );
    super.initState();
    
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Home",
      home: Scaffold(
        appBar: AppBar(
          // title: Text("Home"),
          // leading: Icon(Icons.home),
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



class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
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