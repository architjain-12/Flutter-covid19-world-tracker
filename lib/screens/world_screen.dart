import 'package:flutter/material.dart';
import 'package:covid19/utilities/http.dart';
import 'package:covid19/components/country_card.dart';
import 'package:covid19/utilities/country_list.dart';
class WorldScreen extends StatefulWidget {
  @override
  _WorldScreenState createState() => _WorldScreenState();
}

class _WorldScreenState extends State<WorldScreen> {
  bool isCardView = true;
  Icon cardViewIcon = Icon(Icons.view_day) ;
  int totalCases=0;
  int totalDeaths=0;
  int totalRecovered=0;
  int active=0;
  int newDeaths=0;
  String updateTime = DateTime.now().toString();
  var worldData;

  @override
  void initState() {
    getWorldInfo();
    super.initState();
  }
    
    //https://api.covid19api.com/summary
    void getWorldInfo() async{
      FetchData fetchData = FetchData('https://corona.lmao.ninja/v2/all?yesterday');
      worldData = await fetchData.getData();
      setState(() {
      totalCases = worldData['cases'].toInt();
      totalDeaths = worldData['deaths'].toInt();
      totalRecovered = worldData['recovered'].toInt();
      active = worldData['active'].toInt();
      newDeaths = worldData['todayDeaths'].toInt(); 
      });
    }

    
      Future<List<Country>> _getCountries() async {
        FetchData fetchDataCountry = FetchData('https://corona.lmao.ninja/v2/countries?yesterday&sort=cases');
        var getWorldData = await fetchDataCountry.getData();
        List<Country> countriesList = [];
      for (var countries in getWorldData){
        Country country = Country(countries['country'] , countries['countryInfo']['flag'] , countries['cases'].toInt() , countries['todayCases'].toInt() ,countries['deaths'].toInt(), countries['todayDeaths'].toInt(), countries['todayRecovered'] , countries['recovered'].toInt() );
        countriesList.add(country);
      }
      return countriesList;
      }
    
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0 , 0 ,0,0),
                            child: Text('Across World' ,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              color: Colors.white,
                            ),
                            ),
                          ),
                          FlatButton(
                            onPressed:(){
                              setState(() {
                                updateTime = DateTime.now().toString();
                              });
                              getWorldInfo();
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
                                    color: Colors.black87,
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
                                    color: Colors.black87,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        
                      ],
                     ),
                   ],
                  ),
              ),
            ),
          ],
        ),


        Container(
                height: MediaQuery.of(context).size.height - 70,
                padding: EdgeInsets.fromLTRB(10.0,5,10,0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0) , topRight: Radius.circular(20.0)),
                  boxShadow: [
                      BoxShadow(
                          color: Colors.grey[700],
                          blurRadius: 4.0,
                          spreadRadius: 2.0,
                          offset: Offset(2.0, 0.2), 
                          // shadow direction: bottom right
                          )
                        ],
                      ),
                
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      Icon(Icons.drag_handle , size: 25.0, color: Colors.grey[600],),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0.0 , left: 12.0),
                            child: Text('Countries' , 
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                            ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: FlatButton(
                              onPressed: (){
                                setState(() {
                                  if(isCardView==true)
                                {
                                  isCardView = false;
                                  cardViewIcon = Icon(Icons.view_headline);
                                }
                                else{
                                  isCardView = true;
                                  cardViewIcon = Icon(Icons.view_day);
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
                      thickness: 1.6,
                      color: Colors.grey[300],
                    ),
                  FutureBuilder(
                    future: _getCountries(),
                    builder: (BuildContext context , AsyncSnapshot snapshot){
                      if(snapshot.data == null)
                      {
                        return Container(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: Text('Loading...'),
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
                          return Container(
                            color: Colors.grey[200],
                            child: ListTile(
                              contentPadding: EdgeInsets.all(5.0),
                              dense: false,
                              title: Text(snapshot.data[index].name , style: TextStyle(fontWeight: FontWeight.bold),),
                              subtitle: Text('Cases: ${snapshot.data[index].totalCases.toString()} \nDeaths: ${snapshot.data[index].totalDeaths}'),
                              leading: Image.network('${snapshot.data[index].flag}' , scale: 5.0,),
                              trailing: Icon(Icons.info),
                            ),
                          );
                        }
                        else{
                          return CountryCard(
                           countryName: snapshot.data[index].name,
                           countryFlag: snapshot.data[index].flag,
                           totalCases: snapshot.data[index].totalCases,
                           newCases: snapshot.data[index].newCases,
                           totalDeaths: snapshot.data[index].totalDeaths,
                           newDeaths: snapshot.data[index].newDeaths,
                           totalRecovered: snapshot.data[index].totalRecovered,
                           newRecovered: snapshot.data[index].newRecovered,
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

