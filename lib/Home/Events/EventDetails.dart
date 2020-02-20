
// import 'dart:html';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'Event.dart';

// final testEvent = new Event(
//   address: "mahakali caves road",
//   date: DateTime.now(),
//   headName: "Ashish",
//   ngoName: "Swadesh Foundation",
//   title: "Saf Safai",
//   location: LatLng(19.1047, 72.8539),
//   description: "I'm just the boy inside the man, not exactly who you think I am. I'm just a speck inside your hand, you came and made me who I am. I remember where it all began so clearly. I feel a million miles away still you connect me in your way. When I could only see the floor you made my window a door so when they say they don't I hope they see you and me.",
//   requirement: 50,
// );


class EventDetails extends StatefulWidget {
  final event;
  EventDetails(this.event);
  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {

  @override
  void initState() { 
    super.initState();
    BackButtonInterceptor.add((val){
      // Navigator.of(context).pop(false);
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final testEvent = widget.event;
    return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                vertical: 20 , 
                horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment : MainAxisAlignment.end,
                  children: <Widget>[
                       Container(
                         decoration: BoxDecoration(
                           border: Border.all(
                             color: Colors.pinkAccent
                           )
                         ),
                         padding: EdgeInsets.all(5.0),
                         child: Text(
                          testEvent.getDate(),
                          style: TextStyle(
                          fontSize: 15, 
                          fontWeight: FontWeight.w500),
                         ),
                       ),
                       
                       
                  ],
                ),
              ),
              Row(
                  children: <Widget>[
                      CircleAvatar(
										child: Image.asset("assets/emptyProfile.png",),
										radius: 40.0,
										),
									Padding(
										padding: EdgeInsets.all(8.0),
										child: Text(testEvent.ngoName,style: TextStyle(fontSize: 30),
                        ),
									)
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
              ),
					Row(
              mainAxisAlignment: MainAxisAlignment.center,
					  children: <Widget>[
					    Padding(
					    	padding: EdgeInsets.all(15.0),
					    	child: Text(testEvent.title,style: TextStyle(fontSize: 24),
                ),
					    ),
					  ],
					),
              
					 Padding(
						 padding: EdgeInsets.all(8.0),
						 child: Text(testEvent.description,style: TextStyle(
							 fontSize: 24,
							 fontWeight: FontWeight.w300
						 ),
						 softWrap: true),

					 ),
              Divider(),
                Padding(
							padding: const EdgeInsets.all(8.0),
							child: Text("You have to be there at: "+testEvent.getTime(),style: TextStyle(fontSize: 20),),
						),
              Divider(),
               Padding(
						 padding: EdgeInsets.all(8.0),
						 child: Text(testEvent.address,
                 style: TextStyle(
							 fontSize: 24,
							 fontWeight: FontWeight.w300
						 ),
						 softWrap: true),

					 ),
             Divider(),
               Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Container(
                      height: 200 , 
                     width: 200 , 
                     color : Colors.red,
                     child: FlatButton(
                       child: Text("Open in Map"),
                       onPressed: () => MapsLauncher.launchCoordinates(testEvent.location.latitude, testEvent.location.longitude),
                     ),
                     ),
                   ],
                 ),
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Padding(
                     padding: EdgeInsets.all(8.0),
                     child: Container(
                       color: Colors.red,
                       width: MediaQuery.of(context).size.width / 3,
                      //  padding: EdgeInsets.symmetric(horizontal: 20.0),
                       child: RaisedButton(
                         onPressed: () => 'ok',
                         child: Text(
                           "Register",
                           style: TextStyle(
                             fontSize: 18.0
                           )
                           ),
                         color: Colors.blueAccent,
                         splashColor: Colors.blue,
                       ),
                     ),
                   ),
                 ],
               ),
               Padding(
                 padding: EdgeInsets.all(8.0),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: <Widget>[
                     Text(testEvent.requirement.toString(),style: TextStyle(color: Colors.grey),
                     ),
                   ],
                 ),
               )


            ],
     		
          ),
     
    );
  }
}