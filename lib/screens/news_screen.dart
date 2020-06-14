import 'package:flutter/material.dart';
import 'package:covid19/utilities/http.dart';
import 'package:covid19/utilities/news_data.dart';
import 'package:covid19/components/news_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {


  Future<List<News>> _getHeadlines() async{
      FetchData fetchData = FetchData('http://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=567ab469e2b9487d9757613a916eec4b');
      var news = await fetchData.getData();
      List<News> newsList = [];
      
      for(var i=0 ; i<20 ; i++){
        News newsData = News(source: news['articles'][i]['source']['name'] , author: news['articles'][i]['author'] , title: news['articles'][i]['title'] , description: news['articles'][i]['description'] , url: news['articles'][i]['url'] , thumbnail: news['articles'][i]['urlToImage'] , publishDate: news['articles'][i]['publishedAt']);
        newsList.add(newsData);
        
      }
      // print(newsList);
      return newsList;
    }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Container(
            color: Colors.grey[200],
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(FontAwesomeIcons.solidNewspaper),
                  SizedBox(width: 10.0,),
                  Text('Top Headlines Today' , style: TextStyle(color:Colors.black , fontSize: 25.0 , fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: _getHeadlines(),
                builder: (BuildContext context , AsyncSnapshot snapshot){
                  if (snapshot.data == null){
                    return Container(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Text('Loading...' , style: TextStyle(color: Colors.black),),
                        ),
                      ),
                    );
                  }
                  else{
                    return Expanded(
                      child: ListView.builder(
                        itemCount: 20,
                        itemBuilder: (BuildContext context , int index){
                          // return ListTile(
                          //   // leading: Image.network('${snapshot.data[index].url}'),
                          //   title: Text('${snapshot.data[index].title}'),
                          //   subtitle: Text('${snapshot.data[index].description}'),
                          // );
                          return NewsCard(
                            link: snapshot.data[index].url ,
                            source: snapshot.data[index].source ,
                            thumbnail: snapshot.data[index].thumbnail,
                            title: snapshot.data[index].title,
                            description: snapshot.data[index].description,
                            publishDate: snapshot.data[index].publishDate ,
                          );
                        }
                        )
                   );
                  }
                } ),
      ),
          ],
        )
      ),
    );
  }
}