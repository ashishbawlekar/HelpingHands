import 'package:flutter/material.dart';
import 'EventDetails.dart';
class EventViewer extends StatefulWidget {
  final event;
  EventViewer(this.event);
  @override
  _EventViewerState createState() => _EventViewerState();
}

class _EventViewerState extends State<EventViewer> {
  @override
  Widget build(BuildContext context) {
    final testEvent = widget.event;
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => EventDetails(testEvent)
          )
        );
      },
          child: Card(
        margin: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))
        ),
        elevation: 10.0,
        child: Container(
          // margin: EdgeInsets.all(100.0),
          width: MediaQuery.of(context).size.width - 100,
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: Image.asset("assets/emptyProfile.png", height: 100, width: 100).image,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      testEvent.ngoName,
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                      ),
                  )
                ],
              ),
              Divider(),  
              Text(
                testEvent.title,
                style: TextStyle(
                  fontSize: 20.0,
                  // fontWeight: FontWeight.w300
                    ),
                      ),
              Divider(),
              Container(
                constraints: BoxConstraints.tightFor(width: 300, height: 300),
                child: Image.asset("assets/emptyProfile.png")
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  testEvent.description,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300
                  ),
                
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      "On: " + testEvent.getDate(),
                      style: TextStyle(
                        fontWeight: FontWeight.w200
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),    
        ),
      ),
    );
  }
}