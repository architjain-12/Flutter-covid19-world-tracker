import 'package:flutter/material.dart';

class CountryCard extends StatelessWidget {

  CountryCard({this.countryName , this.countryFlag ,this.newCases , this.newDeaths , this.newRecovered , this.totalCases , this.totalDeaths , this.totalRecovered});
  final String countryName;
  final String countryFlag;
  final int totalCases;
  final int newCases;
  final int totalDeaths;
  final int newDeaths;
  final int totalRecovered;
  final int newRecovered;

  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: Card(
        child: Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 20.0 , right:20.0),
            width: double.infinity,
          //padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            //border: Border.all(),
            // gradient: LinearGradient(
            // begin: Alignment.topRight,
            // end: Alignment.bottomLeft,
            // colors: [Colors.indigo, Colors.cyan]),        
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
                BoxShadow(
                    color: Colors.grey[400],
                    blurRadius: 2.0,
                    spreadRadius: 2.0,
                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
            ],
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top : 10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0 , top:5.0),
                              child: Image(
                                image: NetworkImage('$countryFlag' ,
                                scale: 8,
                                ),
                              ),
                            ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0 , 5.0 ,20,0),
                      child: Text('$countryName' ,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
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
                  /*Column(
                    children: <Widget>[
                      FlatButton(onPressed: null, child: Icon(Icons.info),),
                    ],
                  ),*/
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
                            fontSize: 17.0,
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
                            fontSize: 20.0,
                          ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('   +$newCases' ,
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                    ],
                  ),
                  SizedBox(
          width: 10.0,
          height: 80.0,
          // child: VerticalDivider(
          //       color: Colors.white,
          //),
        ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Recovered' ,
                      style: TextStyle(
                        color: Colors.green[300],
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
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
                        fontSize: 20.0,
                      ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text('  +$newRecovered' ,
                          style: TextStyle(
                            color: Colors.green[300],
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                          ),
                        ],
                      ),
                ],
              ),
              SizedBox(
                width: 10.0,
                height: 80.0,
                // child: VerticalDivider(
                //       color: Colors.white,
                //),
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Death' ,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
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
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                  ),
                  Row(
                        children: <Widget>[
                          Text('   +$newDeaths' ,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                   ],
                  ),
                ],
              ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: <Widget>[
            //     Text('Last Updated\n $updateTime' , 
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 12.0,
            //       fontWeight: FontWeight.bold,
            //     ),
            //    ),
            //   ],
            //  ),
           ],
          ),
          ),
            ),
      ),
    );
  }
}