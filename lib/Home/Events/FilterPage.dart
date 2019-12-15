import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:helping_hands/Utils/UserData.dart';

class FilterPage extends StatefulWidget {
  TextEditingController ngoNameFilter = TextEditingController();
  FilterPage({
    this.ngoNameFilter,
  });
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return
        //  Container(
        //   //  width: MediaQuery.of(context).size.width - 400,
          
        //   decoration: BoxDecoration(
        //     color: Colors.blueGrey,
        //     borderRadius : BorderRadius.all(Radius.circular(50.0))
        //   ),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       TextField(
        //         controller: widget.ngoNameFilter,
        //         decoration: InputDecoration(
        //           border: OutlineInputBorder(
        //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
        //           ),
        //           hintText: "NGO name",
        //           hintStyle: TextStyle(
        //             fontWeight: FontWeight.w300
        //           ),
        //         ),
        //       ),
        //       Divider(),
        //       Container(
        //         height: 10,
        //         width: 10,
        //         color: Colors.green,
        //       ),

        //     ],
        //   )
        // ); 
    
    DraggableScrollableSheet(
      initialChildSize: 0.9,
      expand: false,

      builder: (BuildContext context, ScrollController scroll) {
        return ClipRRect(
          clipBehavior: Clip.hardEdge,
          // borderRadius: BorderRadius.all(Radius.circular(100.0)),
            child: Container(
            color: Colors.cyanAccent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: widget.ngoNameFilter,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    hintText: "NGO name",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w300
                    ),
                  ),
                ),
                Divider(),
                RaisedButton(
                  child: Text("Test"),
                  onPressed: (){
                    NgoUserData data = GetIt.instance.get<NgoUserData>();
                    print(data.toString());
                    showAboutDialog(
                      context: context,
                      children: [
                        Text(data.ngoName)
                      ]

                    );
                  },
                )

              ],
            )
          ),
        );
      },

    );
  }
}