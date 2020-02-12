import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'FilterPage.dart';
import 'MapPage.dart';
// import 'package:latlong/latlong.dart';

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> with SingleTickerProviderStateMixin {

DateTime date;
TimeOfDay time;
LatLng location = LatLng(0,0);
TextEditingController description = TextEditingController();
TextEditingController title = TextEditingController();
// TextEditingController ngoName = TextEditingController();
TextEditingController headName = TextEditingController();
TextEditingController headContact = TextEditingController();
TextEditingController address  = TextEditingController();
TextEditingController dateText = TextEditingController();
TextEditingController timeText = TextEditingController();
TextEditingController requirement = TextEditingController();
Completer<GoogleMapController> mapController = Completer();
FirebaseUser user;
AnimationController progressColorController;
Animation<Color> progressColor;
Color statusColor = Colors.blue;
String prevEvent;
Set<Marker> markers = Set();
LatLng markerPosition;
LatLng mapInitPosition = LatLng(19.075, 72.877);
// DocumentSnapshot document;

@override
  void dispose() {
    progressColorController.dispose();
    super.dispose();
    
  }
@override
void initState(){ 
  super.initState();
  markers.add(Marker(
    markerId: MarkerId("EventMarker"),
    draggable: true,
    onDragEnd: (pos){
      markerPosition = pos;
    }
  ));
  // Marker(

  // );
  progressColorController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 2),
  );

  progressColor = ColorTween(
    begin: Colors.green,
    end: Colors.blue
  ).animate(progressColorController);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showModalBottomSheet(
      //       context: context,
      //       shape: RoundedRectangleBorder(),
      //       // isScrollControlled: true,            
      //       builder: (context){
      //         return FilterPage();
      //       }

      //     );
      //   },
      //   child: Icon(Icons.add),
      //   splashColor: Colors.blueGrey,
      //   // heroTag: 'Add Event',
      //   elevation: 20.0,
      //   // clipBehavior:,
      //   tooltip: "Create a new event",
      // ),
      appBar: AppBar(
        title: Text('Create Event'),
        leading: Hero(
          tag: 'Add Event',
          child: Icon(Icons.add)
          ),
          backgroundColor: statusColor,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                future : FirebaseAuth.instance.currentUser(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.connectionState == ConnectionState.done) { 
                    user = snapshot.data; 
                    // this.document = Firestore.instance.collection("/NgoUsers").document(user.uid).get(); 
                    }
                  return Container();
                },  
              ),
              //   FutureBuilder(
              //   future : Firestore.instance.collection("/NgoUsers").document(user.uid).get(),
              //   builder: (BuildContext context, AsyncSnapshot snapshot) {
              //     if(snapshot.connectionState == ConnectionState.done && user != null) document = snapshot.data;
              //     return null;
              //   },  
              // ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: Text(
                  "Create Event",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 26.0,
                  ),
                )
              ),
              Divider(),
              // Event Name
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: title,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(10.0), right: Radius.circular(10.0))
                    ),
                    hintText: "Event Name" 
                  ),
                ),
              ),
              // Event Rep Name
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: headName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(10.0), right: Radius.circular(10.0))
                    ),
                    hintText: "Event Head Name" 
                  ),
                ),
              ),
              //Event Head Contact No.
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: headContact,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(10.0), right: Radius.circular(10.0))
                    ),
                    hintText: "Event contact no." 
                  ),
                ),
              ),
              // Event Date  
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  enabled: true,
                  controller: dateText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(10.0), right: Radius.circular(10.0))
                    ),
                    hintText: "Tap to set date",
                  ),
                  onTap: () async {
                    date = await showDatePicker(
                      context: context, 
                      firstDate: DateTime.now(), 
                      initialDate: DateTime.now(), 
                      lastDate: DateTime.now().add(Duration(days: 365)),
                    );
                    if(date != null){
                      dateText.text = date.day.toString() + "/" + date.month.toString() + "/" + date.year.toString();
                    }
                    else{
                      dateText.text = "Please set a date!"; 
                    }
                  },
                ),
              ),

              //Event Time
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  enabled: true,
                  controller: timeText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(10.0), right: Radius.circular(10.0))
                    ),
                    hintText: "Tap to set time",
                  ),
                  onTap: () async {
                    time = await showTimePicker(
                      context: context, 
                      initialTime: TimeOfDay.now()
                    );
                    if(date != null){
                      timeText.text = time.hour.toString() + ":" + time.minute.toString(); 
                    }
                    else{
                      timeText.text = "Please set a time!"; 
                    }
                  },
                ),
              ),
              // Event Address
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: address,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(10.0), right: Radius.circular(10.0))
                    ),
                    hintText: "Event Address" ,
                  ),
                  maxLines: 5,
                ),
              ),
              //Description
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: description,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(10.0), right: Radius.circular(10.0))
                    ),
                    hintText: "Event Description" ,
                  ),
                  maxLines: 5,
                ),
              ),
              RaisedButton(
                child: Text("Open Map"),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MapPage()
                    ),
                  );
                },
              ),
              // Map
              Container(
                height: 500.0,
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  onTap: () async{
                    print("Tap!!!");
                    mapInitPosition =  await Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (_) => MapPage(initPosition: mapInitPosition,)
                      ));
                    setState(() {  });
                  },
                    child: GoogleMap(
                    initialCameraPosition: CameraPosition(target: mapInitPosition, zoom: 17),
                    mapType: MapType.hybrid,
                    onMapCreated: (GoogleMapController controller){
                      mapController.complete(controller);
                    },
                    markers: markers,
                  ),
                ),
                
              ),
              // Event Requirement
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: requirement,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  decoration: InputDecoration(                    
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(10.0), right: Radius.circular(10.0))
                    ),
                    hintText: "Event Requirement" 
                  ),
                ),
              ),

              //Submit Button

              RaisedButton(
                child: Text("Submit"),
                color: Colors.green,
                splashColor: Colors.lightBlue,
                onPressed: () async {
                  if(prevEvent == title.text)
                  {
                    await showDialog(
                      context: context,
                      builder: (_){
                        return AlertDialog(
                          title: Text("You're adding the same event again!"),
                        );
                      }
                    );
                    return;
                  }
                  print("Posting event! ${title.text}");
                  progressColorController.forward();
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
                                // valueColor: Colors.blue,
                              )
                            ],
                          ),
                        ),
                  );
                  DocumentSnapshot document = await Firestore.instance.collection("/NgoUsers").document(user.uid).get();
                  Firestore.instance
                    .collection("Events")
                      .document()
                        .setData({
                          "date" : date,
                          "locationLat" : location.latitude,
                          "locationLong" : location.longitude,
                          'description' : description.text,
                          'title' : title.text,
                          'ngoName' : document.data["Name"],
                          "headName" : headName.text,
                          "address" : address.text,
                          "requirement" : int.parse(requirement.text),
                        }).then((doc){
                          Navigator.of(context, rootNavigator : true).pop();
                        });
                        prevEvent = title.text;
                        statusColor = Colors.green;
                        setState(() {});
                        // Clear Texts
                        description.text = "";
                        title.text = "";
                        headName.text = "";
                        headContact.text = "";
                        address.text = "";
                        dateText.text = "";
                        timeText.text = "";
                        requirement.text = "";
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}


// Time, Location, Description, Title, NgoName, Name,

