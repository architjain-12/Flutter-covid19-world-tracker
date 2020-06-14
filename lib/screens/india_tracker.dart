import 'package:flutter/material.dart';
import 'package:covid19/utilities/http.dart';
import 'package:covid19/components/india_region_card.dart';
import 'package:covid19/utilities/india_region_data.dart';
import 'package:covid19/screens/state_screen.dart';
class IndiaTracker extends StatefulWidget {
  @override
  _IndiaTrackerState createState() => _IndiaTrackerState();
}

class _IndiaTrackerState extends State<IndiaTracker> {
  bool isCardView = true;
  Icon cardViewIcon = Icon(Icons.view_day , color: Colors.white) ;
  int totalCases=0;
  int totalDeaths=0;
  int totalRecovered=0;
  int todayRecovered=0;
  int todayDeaths=0;
  int active=0;
  int newDeaths=0;
  String updateTime = DateTime.now().toString();
  var worldData;

    //https://api.apify.com/v2/key-value-stores/toDWvRj1JpTXiM8FF/records/LATEST?disableRedirect=true
  //
    void getIndia() async{
      FetchData fetchData = FetchData('https://corona.lmao.ninja/v2/countries/India?yesterday&strict&query%20');
      worldData = await fetchData.getData();
      setState(() {
      totalCases = worldData['cases'].toInt();
      totalDeaths = worldData['deaths'].toInt();
      totalRecovered = worldData['recovered'].toInt();
      todayDeaths = worldData['todayDeaths'].toInt();
      todayRecovered = worldData['todayRecovered'].toInt();
      active = worldData['active'].toInt();
      //updateTime = worldData['lastUpdateAtApify'].toInt();
      });
    }

    

      Future<List<Region>> _getStates() async {
        FetchData fetchDataCountry = FetchData('https://api.apify.com/v2/key-value-stores/toDWvRj1JpTXiM8FF/records/LATEST?disableRedirect=true');
        var getWorldData = await fetchDataCountry.getData();
        List<Region> regionList = [];
      for (var regions in getWorldData['regionData']){
        Region region = Region(regions['region'] ,regions['totalInfected'].toInt() , regions['deceased'].toInt() ,regions['recovered'].toInt() , regions['totalCases'].toInt());
        regionList.add(region);
      }
      return regionList;
      }
     

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:10.0),
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0 , 0 ,0,0),
                child: Text('India' ,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                  color: Colors.white,
                ),
                ),
              ),
              FlatButton(
                onPressed:(){
                  setState(() {
                    updateTime = DateTime.now().toString();
                  });
                  getIndia();
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25.0,0,0,0),
                  child: Icon(Icons.refresh,
                  color: Colors.white,
                  ),
                ),
                ),
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
                        color: Colors.white,
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
                        color: Colors.white,
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
                  Text('  +$todayRecovered' ,
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('  +$todayDeaths' ,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Active Cases: $active' ,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Times New Roman',
                        fontSize: 18.0,
                      ),
                      ),
                      Text('Last Updated\n ${updateTime.substring(11, 19)}' , 
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  




               Container(
                 margin: EdgeInsets.only(top: 10.0),
                 height: MediaQuery.of(context).size.height - 80,
                 child: Column(
                   children: <Widget>[
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      Icon(Icons.drag_handle , size: 25.0, color: Colors.white,),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0 , left: 12.0 , top: 5.0),
                              child: Text('States & UTs' , 
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                              ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: FlatButton(
                                onPressed: (){
                                  setState(() {
                                    if(isCardView==true)
                                  {
                                    isCardView = false;
                                    cardViewIcon = Icon(Icons.view_headline , color: Colors.white,);
                                  }
                                  else{
                                    isCardView = true;
                                    cardViewIcon = Icon(Icons.view_day , color: Colors.white,);
                                  }
                                  });
                                },
                                child: cardViewIcon 
                                ),
                            ),
                          ],
                      ),
                    Divider(
                      height: 0.2,
                      thickness: 1.0,
                      color: Colors.white60,
                    ),
                     FutureBuilder(
                       future: _getStates(),
                       builder: (BuildContext context , AsyncSnapshot snapshot){
                         if(snapshot.data == null)
                         {
                           getIndia();
                           return Container(
                             child: Center(
                               child: Padding(
                                 padding: const EdgeInsets.only(top: 50.0),
                                 child: Text('Loading...' , style: TextStyle(color: Colors.white),),
                               ),
                             ),
                           );
                         }
                         else{
                         return Expanded(
                               child: ListView.builder(
                               itemCount: snapshot.data.length,
                               shrinkWrap: true,
                               itemBuilder: (BuildContext context , int index){
                                 if(isCardView == false){
                                   return ListTile(
                                     title: Text(snapshot.data[index].name , style: TextStyle(color: Colors.grey[200] , fontWeight: FontWeight.bold , fontSize: 18.0),),
                                     subtitle: Text('Cases: ${snapshot.data[index].totalCases.toString()} \nRecovered: ${snapshot.data[index].totalRecovered} \nDeaths: ${snapshot.data[index].totalDeaths}',style: TextStyle(color: Colors.white70 , fontSize: 14.0)),
                                     onTap: (){
                                       Navigator.push(context, MaterialPageRoute(builder: (context){
                                          return StateScreen(stateName: snapshot.data[index].name , totalCases: snapshot.data[index].totalCases, totalDeaths: snapshot.data[index].totalDeaths, totalInfected: snapshot.data[index].totalInfected, totalRecovered: snapshot.data[index].totalRecovered, );
                                     }));
                                     }
                                   );
                                 }
                                 else{
                                   return RegionCard(
                                    regionName: snapshot.data[index].name,
                                    totalCases: snapshot.data[index].totalCases,
                                    totalDeaths: snapshot.data[index].totalDeaths,
                                    recovered: snapshot.data[index].totalRecovered,
                                    totalInfected: snapshot.data[index].totalInfected,
                                     );
                               }
                               }
                             ),
                         );
                         }
                       }
                     ),
                   ],
                 ),
               ),     
        ],
      ),
    );
  }
}
