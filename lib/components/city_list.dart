import 'package:flutter/material.dart';

class CityCardList extends StatelessWidget {
  final String cityName;
  final int totalCases;
  final int totalDeaths;
  final int totalRecovered;
  CityCardList({this.cityName , this.totalCases , this.totalDeaths , this.totalRecovered});
  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.only(left: 12.0 , right:12.0),
            width: double.infinity,
          //padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            //border: Border.all(),
            // gradient: LinearGradient(
            // begin: Alignment.topRight,
            // end: Alignment.bottomLeft,
            // colors: [Colors.indigo, Colors.cyan]),        
            // borderRadius: BorderRadius.circular(12.0),
            // boxShadow: [
            //     BoxShadow(
            //         color: Colors.grey[400],
            //         blurRadius: 2.0,
            //         spreadRadius: 2.0,
            //         offset: Offset(2.0, 2.0), // shadow direction: bottom right
            //     )
            // ],
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top : 8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0 , 5.0 ,20,0),
                      child: Text('$cityName' ,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.left,
                      ),
                    ),
                    ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // SizedBox(
              //   height: 10.0,
              //   child: Divider(
              //     indent: 12.0,
              //     endIndent: 18.0,
              //     color: Colors.white,
              //   ),
              // ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('Confirmed' ,
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('$totalCases' ,
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
          width: 10.0,
          height: 50.0,
          child: VerticalDivider(
                color: Colors.grey,
          ),
        ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Recovered' ,
                      style: TextStyle(
                        color: Colors.green[300],
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('$totalRecovered' ,
                      style: TextStyle(
                        color: Colors.green[300],
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 10.0,
                height: 50.0,
                child: VerticalDivider(
                      color: Colors.grey,
                ),
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Death' ,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('$totalDeaths' ,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                  ),
                   ],
                  ),
                ],
              ),
           ],
          ),
          );
  }
}