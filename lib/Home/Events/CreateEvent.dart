import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'FilterPage.dart';
import 'package:latlong/latlong.dart';

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> with SingleTickerProviderStateMixin {

DateTime date;
LatLng location = LatLng(0,0);
TextEditingController description = TextEditingController();
TextEditingController title = TextEditingController();
// TextEditingController ngoName = TextEditingController();
TextEditingController headName = TextEditingController();
TextEditingController headContact = TextEditingController();
TextEditingController address  = TextEditingController();
TextEditingController dateText = TextEditingController();
TextEditingController requirement = TextEditingController();
AnimationController progressColorController;
Animation progressColor;

@override
  void dispose() {
    // TODO: implement dispose
    progressColorController.dispose();
    super.dispose();
    
  }
@override
void initState() { 
  super.initState();
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
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(),
            // isScrollControlled: true,            
            builder: (context){
              return FilterPage();
            }

          );
        },
        child: Icon(Icons.add),
        splashColor: Colors.blueGrey,
        // heroTag: 'Add Event',
        elevation: 20.0,
        // clipBehavior:,
        tooltip: "Create a new event",
      ),
      appBar: AppBar(
        title: Text('Create Event'),
        leading: Hero(
          tag: 'Add Event',
          child: Icon(Icons.add)
          ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
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
                  enabled: false,
                  controller: dateText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(10.0), right: Radius.circular(10.0))
                    ),
                    hintText: "Tap to set date" 
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
              // Event Address
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: description,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(10.0), right: Radius.circular(10.0))
                    ),
                    hintText: "Event Address" 
                  ),
                ),
              ),
              // Map
              Container(
                height: 100.0,
                color: Colors.pinkAccent,
              ),
              //
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
                onPressed: () {
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
                                valueColor: progressColor.value,
                              )
                            ],
                          ),
                        ),
                  );
                  Firestore.instance
                    .collection("Events")
                      .document()
                        .setData({
                          "date" : date,
                          "location" : location,
                          'description' : description.text,
                          'title' : title.text,
                          'ngoName' : "Test NGO",
                          "headName" : headName.text,
                          "address" : address.text,
                          "requirement" : int.parse(requirement.text),
                        }).then((doc){
                          Navigator.of(context, rootNavigator : true).pop();
                        });
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

