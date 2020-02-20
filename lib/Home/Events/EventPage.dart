import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helping_hands/Home/Events/EventViewer.dart';
import 'CreateEvent.dart';
import 'Event.dart';


class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> with SingleTickerProviderStateMixin{
  Animation floatingButtonColor;
  AnimationController floatingButtonColorController;
  

  @override
  void dispose(){
    floatingButtonColorController.dispose();
    super.dispose();
  }

  @override
  void initState() { 
    
    super.initState();
    floatingButtonColorController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    floatingButtonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.green
    ).animate(floatingButtonColorController)
    ..addStatusListener((status){
      switch(status){  
        case AnimationStatus.dismissed:
          floatingButtonColorController.forward();
          break;
        case AnimationStatus.completed:
          floatingButtonColorController.reverse();
          break;
        default:
          floatingButtonColorController.repeat();
          break;
      }
    });

    floatingButtonColorController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (_) => CreateEvent(),
            )
          );
        },
        child: Icon(Icons.add),
        backgroundColor: floatingButtonColor.value,
        // splashColor: Colors.blueGrey,
        heroTag: 'Add Event',
        elevation: 20.0,
        // clipBehavior:,
        tooltip: "Create a new event",
      ),
      // appBar: AppBar(
      //   title: Text("Events"),
      // ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.lightBlueAccent,
        
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.all(5.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      child: Text("Reload"),
                      onPressed: (){
                        print("I would reload If I could");
                      },
                    )
                  ],
                ),
                SingleChildScrollView(
                  child: FutureBuilder(
                    future: Firestore.instance.collection("Events").orderBy("date").getDocuments(),  //Have to implement a where on this function to make sure only dates after today are shown
                    builder: (context, AsyncSnapshot snapshot){
                      if(snapshot.connectionState == ConnectionState.done && snapshot.hasData)
                      {
                        final documents = snapshot.data.documents;
                        List <Widget>events = [];
                        for (var document in documents) {
                          final data = document.data;
                          final ts = data["date"] as Timestamp;
                          final date = ts.toDate();
                          final event = new Event(
                            address: data["address"], 
                            title: data["title"], 
                            date: date, 
                            description: data["description"], 
                            headName: data["headName"], 
                            location: new LatLng(data["locationLat"], data["locationLong"]), 
                            ngoName: data["ngoName"], 
                            requirement: data["requirement"]
                          );
                          print(data["date"]);
                          events.add(EventViewer(event));
                        }
                        
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // height: 10,
                          // width: 10,
                          // color: Colors.green
                          children: events,
                        );
                      }
                      else{
                        print("Dont have data yet");
                        return Container(
                        // color: Colors.red,
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(),
                      );
                      }
                      
                    },
                  )
                )
              ],
            ),
          ),
      ),
    );
  }
}