import 'package:flutter/material.dart';
import 'dart:async';
import 'package:covid19/screens/bottom_navbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // theme:ThemeData.dark(),
      home: SplashScreen(),
      routes: <String , WidgetBuilder>{
        '/BottomNavBar' : (BuildContext context) => BottomNavBar(),
      },
    );
  }
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
  Navigator.of(context).pushReplacementNamed('/BottomNavBar');
}

@override
void initState() {
  super.initState();
  startTime();
}

 @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.blueAccent,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white ,
            radius: 80.0,
            child: Expanded(child: Image.asset('assets/images/splash_logo.png')),
            ),
            Text('Track coroNa' , style: TextStyle(color: Colors.white ,fontSize: 28.0 , fontFamily: 'Times New Roman')),
          Column(
            children: <Widget>[
              Text('COVID-19' , style: TextStyle(color: Colors.white ,fontSize: 18.0),),
              Text('WORLD TRACKER' , style: TextStyle(color: Colors.white ,fontSize: 15.0),),
              Divider(color: Colors.white60,thickness: 1,indent: 150 , endIndent: 150,),
              Text('Version 1.0.0' , style: TextStyle(color: Colors.grey[200] ,fontSize: 12.0),),
            ],
          )
        ],
      ),
    ),
  );
  }
}
