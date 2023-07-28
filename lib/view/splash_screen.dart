import 'dart:async';

import 'package:covidtracker_app/view/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late final AnimationController _controller  = AnimationController(
       duration: const Duration(seconds: 3),
      vsync: this)..repeat();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller.dispose();
    Timer(
      Duration(seconds: 5),
      () => Navigator.push(context, MaterialPageRoute(builder: (context) => WorldStatesScreen(),))
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            AnimatedBuilder(
                animation: _controller,
                child: Center(
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Image(image: AssetImage('images/virus.png')),
                  ),
                ),
                builder: (context, child){
                  return Transform.rotate(
                     child: child,
                      angle:_controller.value*2.0*math.pi
                  );
                } ,
            ),
            SizedBox(
              height: 60,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Covid-19',style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold),),
                Text('Tracker App',style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold),),
              ],
            )
          ],
        ),
      ),
    );
  }
}