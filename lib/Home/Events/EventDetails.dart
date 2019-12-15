import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

class Event{
final DateTime date; 
final LatLng location; 
final String description; 
final String title;
final String ngoName;
// final String name;
final String address;
final String headName;
final int requirement;
Event({
    @required this.date,
    @required this.location,
    @required this.address,
    @required this.description,
    @required this.title,
    @required this.ngoName,
    // @required this.name,
    @required this.headName, 
    @required this.requirement,
  });
}


class EventDetails extends StatefulWidget {
  
  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}