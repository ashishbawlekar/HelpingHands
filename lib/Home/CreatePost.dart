import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePost extends StatefulWidget {
  
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> with SingleTickerProviderStateMixin{
  FirebaseUser currentUser;
  File image;
  TextEditingController controller = TextEditingController();
  Animation progressColor;
  AnimationController _animationController;
  Color containerColor = Colors.white;
  Color buttonColor = Colors.blue;
  String buttonText = "Post!";
  @override
  void initState() {
     _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });

    progressColor = ColorTween(begin: Colors.blue, end: Colors.green)
        .animate(_animationController); 
    FirebaseAuth.instance.currentUser().then(
      (currentUser){
        this.currentUser = currentUser;
    });
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Create Post"),
        ),
        body: Container(
          // constraints: ,
          // width: 400.0,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // margin: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.all(10.0),
              child: Container(
                child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: GestureDetector(
                      onTap: () async {
                        image = await ImagePicker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 90,
                        );
                        setState(() {
                          containerColor = Colors.white;
                          buttonColor = Colors.blueAccent;
                          buttonText = "Post!";
                        });
                      },
                        child: Container(
                          // color: containerColor,
                          constraints: BoxConstraints.tight(
                            Size(400, 500)
                          ),
                        decoration: BoxDecoration(
                          color: containerColor,
                          // shape: BoxShape,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          image: DecorationImage(
                            image: image == null? 
                              Image.network("http://clipart-library.com/images/8cGEnqExi.png").image
                              : Image.file(image).image, 
                            )
                        ),
                      ),
                    ),
                  ),

                  Divider(),

                   Container(
                     alignment: Alignment.centerLeft,
                     child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          child: Text(
                            "Description : ",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                            ),
                        ),
                   ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal : 25.0, vertical: 10.0),
                        child: TextField(
                          controller: controller,
                          maxLines: 8,
                          maxLength: 1000,
                          // expands: true,
                          decoration: InputDecoration(
                            hintText: "Enter description",
                            contentPadding: EdgeInsets.all(5.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide()
                            )
                          ),
                        )
                      ),

                      // Spacer(), 
                      // After 30mins of debugging I have learned never to use Spacer with ScrollViews.


                      RaisedButton(
                        color: buttonColor,
                        splashColor: Colors.yellowAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            buttonText,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 22.0
                            ),
                            ),
                        ),
                        onPressed: () async {
                          showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          contentPadding: EdgeInsets.all(50.0),
                          content: Row(
                            children: <Widget>[
                              Text("Loading"),
                              Spacer(),
                              CircularProgressIndicator(
                                valueColor: progressColor,
                              )
                            ],
                          ),
                        ),
                      );
                          if(currentUser == null) return;
                          String url = await uploadFile(currentUser.uid);
                          if(url == null) throw Exception("Something went wrong in uploading file");
                              Firestore.instance.collection("/Posts").document()
                                ..setData({
                                   "imageUrl" : url, 
                                   "userName" : currentUser.displayName, 
                                   "description" : controller.text,
                                  //  "postID",
                                   "eventName" : "Test Event",
                                   "ngoName" : "Test NGO",
                                }).then((doc){
                                  Navigator.of(context, rootNavigator: true).pop();                            
                                  setState(() {
                                    containerColor = Colors.green;
                                    buttonColor = Colors.greenAccent;
                                    buttonText = "Posted!";  
                                  });
                                });
                          

                          // Navigator.of(context, rootNavigator: true).pop();
                            }     
                      ),
                ],
            ),
              ),
          ),
        ),
      ),
    );
  }

    Future<String> uploadFile(String uid) async {
    if (image == null) throw Exception("No image Given");
    final storageReference = FirebaseStorage().ref().child("/Posts/" + uid + DateTime.now().millisecondsSinceEpoch.toString());
    final StorageUploadTask uploadTask = storageReference.putFile(image);

    final StreamSubscription<StorageTaskEvent> streamSubscription =
        uploadTask.events.listen((event) {
      print('EVENT ${event.type}');
    });
        final downloadurl = await uploadTask.onComplete;
          streamSubscription.cancel();
    return  (await downloadurl.ref.getDownloadURL());
    
    }
}