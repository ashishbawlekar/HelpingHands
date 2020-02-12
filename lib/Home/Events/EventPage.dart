import 'package:flutter/material.dart';
import 'CreateEvent.dart';


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
      appBar: AppBar(
        title: Text("Events"),
      ),
      body: Container(

      ),
    );
  }
}