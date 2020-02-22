import 'package:flutter/material.dart';
import 'package:helping_hands/Utils/Ranks.dart';
import 'package:toast/toast.dart';

class Medals extends StatefulWidget {
  @override
  _MedalsState createState() => _MedalsState();
}

class _MedalsState extends State<Medals> {
  final events = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ranks"),
        leading: Image.asset(Rank.ranks[11]),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            height: 1200.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children : <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Card(
                        elevation: 10.0,
                        shadowColor: Rank.getRankColor(Rank.getRankFromEventCount(events)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10),
                              child: Text(
                                "Total Events : \n$events",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600
                                ),
                                ),
                            ),
                            
                          ),
                    ),
                      Image.asset(Rank.getMedalFromEventCount(events), height: 150, width: 150,)
                    ],
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MedalBox(
                      image: Rank.ranks[1],
                      requirement :Rank.requirement[1],
                      eventsDone: events,
                    ),
                    MedalBox(
                      image: Rank.ranks[2],
                      requirement :Rank.requirement[2],
                      eventsDone: events,
                    ),
                    MedalBox(
                      image: Rank.ranks[3],
                      requirement :Rank.requirement[3],
                      eventsDone: events,
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MedalBox(
                      image: Rank.ranks[4],
                      requirement :Rank.requirement[4],
                      eventsDone: events,
                    ),
                    MedalBox(
                      image: Rank.ranks[5],
                      requirement :Rank.requirement[5],
                      eventsDone: events,
                    ),
                    MedalBox(
                      image: Rank.ranks[6],
                      requirement :Rank.requirement[6],
                      eventsDone: events,
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MedalBox(
                      image: Rank.ranks[7],
                      requirement :Rank.requirement[7],
                      eventsDone: events,
                    ),
                    MedalBox(
                      image: Rank.ranks[8],
                      requirement :Rank.requirement[8],
                      eventsDone: events,
                    ),
                    MedalBox(
                      image: Rank.ranks[9],
                      requirement :Rank.requirement[9],
                      eventsDone: events,
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MedalBox(
                      image: Rank.ranks[10],
                      requirement :Rank.requirement[10],
                      eventsDone: events,
                    ),
                    MedalBox(
                      eventsDone: events,
                      image: Rank.ranks[11],
                      requirement :Rank.requirement[11],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
      
    );
  }
}

class MedalBox extends StatelessWidget {
  final String image;
  final int requirement;
  final int eventsDone;
  MedalBox({@required this.image, @required this.requirement, @required this.eventsDone});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          Toast.show(
            "You need to finish ${requirement - eventsDone} more events", 
            context,
            duration: 4,
            );
        },
        child: Card(
        margin: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        elevation: 10.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(image, height: 100.0, width: 100.0,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Required $requirement events."),
            )
          ],
        ),      
      ),
    );
  }
}
