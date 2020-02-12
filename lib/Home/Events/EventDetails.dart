
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'Event.dart';

final testEvent = new Event(
  address: "mahakali caves road",
  date: DateTime.now(),
  headName: "Ashish",
  ngoName: "Swadesh Foundation",
  title: "Saf Safai",
  location: LatLng(19.1047, 72.8539),
  description: "aao aur kam karo aur nikal jao maro i dont care about anything you are doing just fuck offf marr ok bro tu bolega vause hoga tension mat le liya kar",
  requirement: 50,




);


class EventDetails extends StatefulWidget {
  // final event;
  // EventDetails(this.event);
  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.orange,
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
              vertical: 20 , 
              horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment : MainAxisAlignment.end,
                children: <Widget>[
                     Text(
                     testEvent.getDate(),
                     style: TextStyle(
                     fontSize: 15, 
                     fontWeight: FontWeight.w500),
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
                   child: RaisedButton(
                     onPressed: () => 'ok',
                     child: Text("Register"),
                     color: Colors.red,
                     splashColor: Colors.blue,
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
      ),

      
    );
  }
}