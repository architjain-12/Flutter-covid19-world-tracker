import 'package:flutter/material.dart';
import 'package:covid19/screens/state_screen.dart';

class RegionCard extends StatelessWidget {

  RegionCard({this.regionName , this.totalInfected , this.totalDeaths , this.recovered , this.totalCases});
  final String regionName;
  final int totalCases;
  final int totalInfected;
  final int totalDeaths;
  final int recovered;

  @override
  Widget build(BuildContext context) {
    return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: double.infinity,
      //padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        //border: Border.all(),
        // gradient: LinearGradient(
        // begin: Alignment.topRight,
        // end: Alignment.bottomLeft,
        // colors: [Colors.indigo, Colors.cyan]),        
        borderRadius: BorderRadius.circular(15.0),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
      Wrap(
        runAlignment: WrapAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0 , 5.0 ,20,0),
            child: Text('$regionName' ,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
              color: Colors.black,
            ),
            overflow: TextOverflow.clip,
            textAlign: TextAlign.left,
            ),
          ),
          //FlatButton(onPressed: null, child: Icon(Icons.info),),
        ],
      ),
      SizedBox(
        height: 10.0,
        child: Divider(
          indent: 12.0,
          endIndent: 18.0,
          color: Colors.white,
        ),
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
                fontSize: 17.0,
              ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text('$recovered' ,
              style: TextStyle(
                color: Colors.green[300],
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
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
           ],
          ),
        ],
      ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                              child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return StateScreen(stateName: regionName , totalCases: totalCases, totalDeaths: totalDeaths, totalInfected: totalInfected, totalRecovered: recovered, );
                    }));
                  },
                  child: Icon(Icons.expand_more)
                  ),
              ),
            ],
          ),
       ],
      ),
      ),
    ),
      );
  }
}