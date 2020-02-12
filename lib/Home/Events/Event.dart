import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

     String getDate(){
		 String year = this.date.year.toString();
     String month = this.date.month.toString();
		 String day = this.date.day.toString();

		 return day + "/" + month + "/" + year;
	 }
	 String getTime(){
		 String hours = this.date.hour.toString();
		 String minutes = this.date.minute.toString();
		 return hours+ ":" + minutes; 
	 }

}


