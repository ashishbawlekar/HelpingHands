import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands/Home/PostDetails.dart';
import 'package:helping_hands/Utils/UserData.dart';
import 'package:helping_hands/Registration/Authentication.dart';
import 'package:provider/provider.dart';
class PostPage extends StatefulWidget {
  // UserData userData;
  PostPage();
  
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  // String verificationId;
  final ph = PhoneAuth();
  TextEditingController _smsCode = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
          value: Post().posts,
          child: Scaffold(
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
            PostList(),
            // Post2(),
            // Post(),
          ],
        ),
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
  

final CollectionReference postCollection = Firestore.instance.collection('Posts');
Stream<QuerySnapshot> get posts{
    return postCollection.snapshots();
}

}


class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    // final posts = Provider.of<QuerySnapshot>(context);
    // print(posts.documents);
    // print(posts.documents[0].data);
    return Container(
      height: 100,
      width: 100,
      color: Colors.red,
    );
  }
}



// class 
