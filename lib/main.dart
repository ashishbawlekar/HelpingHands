
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
// import 'package:helping_hands/AnimationExampleBasic.dart';
import 'package:helping_hands/HomeNGO.dart';
import 'package:helping_hands/Login.dart';
import 'package:helping_hands/Registration.dart';
import 'package:helping_hands/Registration_NGO.dart';

class Router{
static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyApp());
      case '/Login':
        return MaterialPageRoute(builder: (_) => Login());
      case '/Registration':
        return MaterialPageRoute(builder: (_) => Registration());
      case '/Registration/NgoReg':
        return MaterialPageRoute(builder: (_) => NgoReg());
      case '/Registration/NgoReg/HomeNGO':
        return MaterialPageRoute(builder: (_) => HomeNgo());
      case '/NgoReg':
        return MaterialPageRoute(builder: (_) => NgoReg());
      case '/Registration/NgoReg/HomeNGO':
        return MaterialPageRoute(builder: (_) => HomeNgo());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
  }

GetIt getIt = GetIt.asNewInstance();

void main() => runApp(
   MaterialApp(
      title: "Vote Up",
      // home: MyApp(),
      initialRoute: '/',
      home: MyApp(),
      // routes: {
      //   '/' : (context) => MyApp(),
      //   '/Login' : (context) => Login(),
      //   '/Registration' : (context) => Registration(),
      //   '/Animation' : (context) => AnimationExample(),
      //   '/NgoReg' : (context) => NgoReg(),
      //   '/HomeNGO' : (context) => HomeNgo(),
      //   '/Registration/NgoReg/HomeNGO' : (context) => HomeNgo(),
      // },
      onGenerateRoute: Router.generateRoute,

      )
);
// void main() => runApp(GetTextApp());
class MyApp extends StatefulWidget{
  // MyApp({key: key}): super(key:key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  int count = 0;

  voteUp(){
    setState(() {
    count++;  
    });
  }
   
voteDown() { 
  setState(() {
    count--;  
    });
 
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Voting App", 
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.black
        ),),
        backgroundColor: Colors.grey,
        leading: const Icon(Icons.home),
        ),
        body: Center(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text("Votes : $count"),
              RaisedButton(
                child: Text("Vote up!"),
                onPressed: voteUp,
                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 12.0),
                color: Colors.lightGreen,
                // colorBrightness: Brightness.light,
                elevation: 20.0,
                splashColor: Colors.green,
              ),
              RaisedButton(
                              child: Text("Login"),
                              onPressed: (){
                              //  Navigator.push(
                              //  context,
                              //  MaterialPageRoute(builder: (context) => GetTextApp()),
                              // );
                              Navigator.pushNamed(context, '/Login');
                          },
                              padding: const EdgeInsets.all(10.0),
                              color: Color.fromARGB(100, 250, 0, 0),
                              // colorBrightness: Brightness.light,
                              splashColor: Color.fromARGB(255, 250, 0, 0),
                            ),
                          ],
                        ),
                      ),
                    );
                    
                }
                
             
}

