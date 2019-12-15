// import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'CreatePost.dart';
import 'PostDetails.dart';
// import 'package:helping_hands/Utils/UserData.dart';
// import 'package:helping_hands/Registration/Authentication.dart';
import 'package:provider/provider.dart';
class PostPage extends StatefulWidget {
  // UserData userData;
  PostPage();
 
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  // String verificationId;
  // final ph = PhoneAuth();
  // TextEditingController _smsCode = TextEditingController();
@override
void dispose() {
    // TODO: implement dispose
    super.dispose();

  }  

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
              Navigator.of(context, rootNavigator: true)
                .push(
                  MaterialPageRoute(
                    builder: (_) => CreatePost()
                  ),
                );
            },
            elevation: 20.0,
            focusColor: Colors.red,  
        ),
        body: FutureBuilder<Widget>(
          // future: Future.delayed(Duration(seconds: 2)),
          builder: (context, snapshot) {
            final posts = Provider.of<QuerySnapshot>(context);
            if(posts == null){
              return Center(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Text('Loading'),
                      // LinearProgressIndicator(
                      //   backgroundColor: Colors.greenAccent,
                      //   value: 100,
                      // ),
                    ],
                  ),
                ),
              );
            } 
            else
            return ListView.builder(
              itemCount: posts.documents.length,
              itemBuilder: (_, count){
                return Post(
                  ngoName: posts.documents[count].data["ngoName"], // == null? " " : posts.documents[count].data["ngoName"] ,
                  imageUrl: posts.documents[count].data["imageUrl"],
                  description: posts.documents[count].data["description"],
                  eventName: posts.documents[count].data["eventName"],
                  userName: posts.documents[count].data["userName"], // ==  null? " ": posts.documents[count].data["Name"],
                  postID: posts.documents[count].documentID,
                );
              },
            // ),
      // ),
    );
          }
        ),
      ),
    );
  }
}


class Post extends StatelessWidget{
  String imageUrl;
  String userName;
  String description;
  String postID;
  String eventName;
  String ngoName;


  Post({
    this.imageUrl, 
    this.userName, 
    this.description,
    this.postID,
    this.eventName,
    this.ngoName,
  });
      
  @override
  Widget build(BuildContext context) {
    var image = Image.network(this.imageUrl);
    var userName = this.userName;
    String fullDescrption = this.description;
    // Post();
    return GestureDetector(
          onTap: (){
            Navigator.of(context, rootNavigator: true).push( 
              MaterialPageRoute(
                builder: (context) => PostDetails(
                  image: image,
                  userName: userName,
                  description: fullDescrption,
                  postID: postID,
                  eventName: eventName,
                  ngoName: ngoName,
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
                  subtitle: Text(
                    fullDescrption.length > 20 ? fullDescrption.substring(0, 20) + "..." : fullDescrption,
                    
                    ),
                ),
                Hero(
                  tag: postID,
                  child: image,
                  ),

              ],
            ),
            ),
          );
      }
  

final CollectionReference postCollection = Firestore.instance.collection('Posts');
Stream<QuerySnapshot> get posts{
    return postCollection.orderBy("TimeStamp").snapshots();
}
}

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<QuerySnapshot>(context);
    print(posts.documents.length);
    // print(posts.documents[3].data);
    print(posts.documents[0].data);
    return 
    // SingleChildScrollView(
    //       child: Container(
    //       height: MediaQuery.of(context).size.height,
    //     child: 
        ListView.builder(
          itemCount: posts.documents.length,
          itemBuilder: (_, count){
            return Post(
              ngoName: posts.documents[count].data["ngoName"], // == null? " " : posts.documents[count].data["ngoName"] ,
              imageUrl: posts.documents[count].data["imageUrl"],
              description: posts.documents[count].data["description"],
              eventName: posts.documents[count].data["eventName"],
              userName: posts.documents[count].data["userName"], // ==  null? " ": posts.documents[count].data["Name"],
              postID: posts.documents[count].documentID,
            );
          },
        // ),
      // ),
    );
      // return Container(
      //   height: 100.0,
      //   width: 100.0,
      //   color: Colors.red,
      // );
  }
}



// class 
