import 'package:flutter/material.dart';

class ViewEvents extends StatefulWidget {
  @override
  _ViewEventsState createState() => _ViewEventsState();
}

class _ViewEventsState extends State<ViewEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context, 
              builder: (BuildContext context) {
                return AdvancedFind();
              },
            );
          },
          child: Icon(Icons.format_align_center),

        ),
        appBar: AppBar(
          title: Text("Events"),
          centerTitle: true,
        ),
        body: Container(
          child: Column(

          ),
        ),
    );
  }
}

class Event extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
          onTap: null, //(){
            // Navigator.of(context, rootNavigator: true).push(
              // MaterialPageRoute(
                // builder: (_) =>  EventDetails(
                //   EventObject(

                //   ),
                // );
              // )
            // );
          // },
          child: Card(
          elevation: 10.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(""),
              Text("NGO Name"),
              Text("Event Name"),
              Text("Event Description")
            ],
          ),
        ),
      ),
    );
  }
}
















class AdvancedFind extends StatefulWidget {
  @override
  _AdvancedFindState createState() => _AdvancedFindState();
}

class _AdvancedFindState extends State<AdvancedFind> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 300,
        width: 300,
        color: Colors.red,
      ),
    );
  }
}