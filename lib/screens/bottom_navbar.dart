import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:covid19/screens/myth_busters.dart';
import 'package:covid19/screens/stats_screen.dart';




class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex=0;
  final tabs = [
    HomeScreen(),
    StatsScreen(),
    MythBusters(),
    Scaffold(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex] ,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        elevation: 10.0,
        items: [Icons.home, Icons.insert_chart, Icons.description, Icons.info]
            .asMap()
            .map((key, value) => MapEntry(
                  key,
                  BottomNavigationBarItem(
                    title: Text(''),
                    icon: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                        color: _currentIndex == key
                            ? Colors.blue[600]
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Icon(value),
                    ),
                  ),
                ))
            .values
            .toList(),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   //backgroundColor: Colors.grey[200],
      //   selectedFontSize: 15,
      //   unselectedFontSize: 12,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.public),
      //       title: Text('Global'),
      //       backgroundColor: Colors.blue),
      //        BottomNavigationBarItem(
      //       icon: Icon(Icons.flag),
      //       title: Text('India'),
      //       backgroundColor: Colors.blue),
      //   ],
      //   onTap: (index){
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      //   ),
    );
 }
}