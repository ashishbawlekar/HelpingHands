
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';


class PostDetails extends StatefulWidget {
  final Image image;
  final String description;
  final String userName;
  final String ngoName = "Sasti Astha";
  final String eventName = "Bhoot Bhagao";
  PostDetails({this.image, this.description, this.userName});
  
  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> with SingleTickerProviderStateMixin {
  Animation<Color> anim;
  AnimationController controller;
  double init, distance;
  @override
  void initState() { 
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )
    ..addListener((){
      setState(() {});
    })
    ..addStatusListener((status){
      if(status == AnimationStatus.completed){
        controller.reverse();
      }else if(status == AnimationStatus.dismissed){
        controller.forward();
      }
    });
    
    anim = ColorTween(
      begin: Colors.blue,
      end: Colors.green,
    ).animate(controller);
    controller.forward();
    super.initState();
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
/*
          onPanStart: (DragStartDetails deets){
            init = deets.globalPosition.dx;
          },
          onPanUpdate: (DragUpdateDetails deets){
            distance = deets.globalPosition.dx - init;
          },
          onPanEnd: (var deets){
            init = 0.0;
            if(distance < -120 ){
               Navigator.push(context, SlideRoute(offset: Offset(1, 0),page: Registration())); 
            }
          },

*/
//  git@github.com:Riki432/HelpingHands.git 
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Post Details",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: anim.value,
        ),
        body: GestureDetector(
             onPanStart: (DragStartDetails deets){
              init = deets.globalPosition.dx;
             },
             onPanUpdate: (DragUpdateDetails deets){
               distance = deets.globalPosition.dx - init;
             },
             onPanEnd: (DragEndDetails deets){
               init = 0.0;
               print(distance); 
              if(distance > 120){
                 Navigator.pop(context);
               }
             },
             child: Container(
              constraints: BoxConstraints(
                minWidth: 400.0,
                minHeight: 400.0,
              ),
              child: SingleChildScrollView(
               physics: ScrollPhysics(),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                  children: <Widget>[
                      CircleAvatar(
                    backgroundImage: Image.asset("assets/emptyProfile.png").image,
                    radius: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
                    child: Text(
                      widget.userName,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w300,
                        // shadows: [BoxShadow()],
                      ),
                    ),

                  ),
                  ],
                  ),
                  Container(
                    color: Colors.black,
                    width: double.maxFinite ,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                      child: Hero(
                        tag: "Post",
                        child: Image.asset("assets/Beach.jpeg", fit: BoxFit.contain)
                        ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left : 10.0, top: 15.0, bottom: 5.0),
                    child: Text(
                      "Event Name : ",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0, left: 25.0, bottom: 10.0),  //symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      widget.eventName,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                      ),
                      ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(left : 10.0, top: 10.0, bottom: 0.0),
                    child: Text(
                      "NGO Name : ",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                      ),
                  ),

                  ListTile(
                    // dense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                    leading: CircleAvatar(
                      backgroundImage: Image.asset("assets/emptyProfile.png").image,
                    ),  
                    title: Text(widget.ngoName,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                    ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 2.0, left: 25.0, bottom: 10.0),  //symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      widget.ngoName,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,

                      ),
                      ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
                    child: Text(
                      widget.description,
                      style: TextStyle(
                        fontSize : 16.0,
                        fontWeight: FontWeight.w300
                      ),
                      ),
                  ),
                  
                  // Un-necessary
                  Container(
                    color: Colors.red,
                    height: 100.0,
                  ),

                  Container(
                    color: Colors.red,
                    height: 100.0,
                  ),
                  Container(
                    color: Colors.orange,
                    height: 100.0,
                    
                  ),
                  Container(
                    color: Colors.blue,
                    height: 100.0,
                  ),
                  Container(
                    color: Colors.black,
                    height: 100.0,
                  ),
                  Container(
                    color: Colors.yellow,
                    height: 100.0,
                  ),
                  Container(
                    color: Colors.green,
                    height: 100.0,
                  ),
                  // Stuff
                ],
            ),
          ),
             ),
        ),
      ),
    );
  }
}