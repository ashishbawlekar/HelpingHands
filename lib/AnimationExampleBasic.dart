import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/animation.dart';

class AnimationExample extends StatefulWidget {
  @override
  _AnimationExampleState createState() => _AnimationExampleState();
}

class _AnimationExampleState extends State<AnimationExample> with TickerProviderStateMixin{
  Animation<double> animationSize;
  AnimationController controllerSize;
  Animation<Color> animationColor;
  AnimationController controllerColor;
  AnimationController textController;
  @override
  void initState() {
    textController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    controllerColor = AnimationController(
      vsync: this,
      duration: Duration(seconds:5)
    )
    ..addListener((){
      setState(() {});
    })
    ..addStatusListener((status){
      if(status == AnimationStatus.completed){
        controllerColor.reverse();
      }
      else if(status == AnimationStatus.dismissed){
        controllerColor.forward();
      }
    });
    animationColor = ColorTween(
      begin: Colors.green,
      end: Colors.blue
    ).animate(controllerColor);

    controllerSize = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )
    ..addListener((){
      // print(animationSize.value);
      setState(() {});
    });

    animationSize = Tween<double>(
      begin: 50.0,
      end: 200.0
    ).animate(controllerSize);
    // controller.forward();
    super.initState();
  }
  
  @override
  void dispose() {
    controllerSize.dispose();
    controllerColor.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: animationColor.value,
      child: Center(
        child: Container(
          height: 500.0,
          width: 500.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("Start Animation"),
                onPressed: (){
                  controllerSize.forward();
                  controllerColor.forward();
                },
              ),
              TextAnimation(anim: textController),
            ],
          ),
          // height: animationSize.value,
          // width: animationSize.value,
        ),
      ),
    );
  }
}

class TextAnimation extends AnimatedWidget{
  final Tween<double> animAngle = Tween(begin: 0.0, end: 3.14);
  TextAnimation({Key key, Animation<double> anim}): super(key : key, listenable:anim);
  @override
  Widget build(BuildContext context) {
    final Animation<double> anim = listenable;
    return Transform.rotate(
                  angle: animAngle.evaluate(anim),
                  child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Another Animation!",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                  ),
                  // height: 100.0,
                  // width: 100.0,
                ),
              );
  }

}