import 'package:flutter/material.dart';
import 'NGO_Registration.dart';
import 'Volunteer_Registration.dart';

class Registration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          elevation: 20.0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 GestureDetector(
                   
                   onTap: (){
                     Navigator.push(context, 
                     MaterialPageRoute(
                       builder: (context) => NgoReg(),
                     )
                     );
                   },
                     child: Container(
                     decoration: BoxDecoration(
                       color: Colors.grey,
                      //  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                       shape: BoxShape.circle
                     ),
                     height: 150.0,
                     width: 150.0,
                     child: Image(
                       image: AssetImage(
                         "assets/Ngo.png"
                       ),
                     ),
                     
                   ),
                 ),
                  // Divider(),
                  // Image.asset("assets/Ngo.png"),
                  Divider(height: 10.0,),
                  Divider(),
                   GestureDetector(
                     onTap: (){
                      Navigator.push(context, 
                      MaterialPageRoute(
                       builder: (context) => VolunteerForm(),
                      )
                      );
                     }, 
                    child: Container(
                     decoration: BoxDecoration(
                       color: Colors.grey,
                      //  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                       shape: BoxShape.circle
                     ),
                     height: 150.0,
                     width: 150.0,
                     child: Image(
                       image: AssetImage(
                         "assets/Volunteer.png"
                       ),
                     ),
                 ),
                   ),
                ],
              ),
            ),
          ),
    );
  }
}