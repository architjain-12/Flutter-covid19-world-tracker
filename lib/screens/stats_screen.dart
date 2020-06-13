import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:covid19/screens/india_tracker.dart';
import 'package:flutter/material.dart';
import 'package:covid19/config/palette.dart';
import 'package:covid19/config/styles.dart';
import 'package:covid19/widgets/widgets.dart';
import 'package:covid19/screens/world_screen.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  bool isWorldView = false;
  int tabIndex=0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        //backgroundColor: Colors.transparent,
        //appBar: CustomAppBar(),
        body: Container(
          decoration: BoxDecoration(
                  gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: [Colors.indigo[800],Colors.cyan[600]]),
            ),
          child: CustomScrollView(
            physics: ClampingScrollPhysics(),
            slivers: <Widget>[
              _buildHeader(),
              _buildRegionTabBar(),
              //_buildStatsTabBar(),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                sliver: SliverToBoxAdapter(
                  child: (isWorldView==true) ? WorldScreen() : IndiaTracker(),
                ),
              ),
              // SliverPadding(
              //   padding: const EdgeInsets.only(top: 20.0),
              //   sliver: SliverToBoxAdapter(
              //     child: CovidBarChart(covidCases: covidUSADailyNewCases),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Statistics',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildRegionTabBar() {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 2,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TabBar(
            indicator: BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: 40.0,
              indicatorColor: Colors.white,
            ),
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(radius: 12.0,child: Image.asset('assets/images/in_flag.png')),
                  Text(' India'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.public),
                  Text(' Global'),
                ],
              ),
            ],
            onTap: (index) {
              setState(() {
                tabIndex = index;
                if(index==1)
                {
                  isWorldView = true; 
                }
                else{
                  isWorldView = false;
                }
              });
            },
          ),
        ),
      ),
    );
  }

  // SliverPadding _buildStatsTabBar() {
  //   return SliverPadding(
  //     padding: const EdgeInsets.all(20.0),
  //     sliver: SliverToBoxAdapter(
  //       child: DefaultTabController(
  //         length: 3,
  //         child: TabBar(
  //           indicatorColor: Colors.transparent,
  //           labelStyle: Styles.tabTextStyle,
  //           labelColor: Colors.white,
  //           unselectedLabelColor: Colors.white60,
  //           tabs: <Widget>[
  //             Text('Total'),
  //             Text('Today'),
  //             Text('Yesterday'),
  //           ],
  //           onTap: (index) {},
  //         ),
  //       ),
  //     ),
  //   );
  // }
}