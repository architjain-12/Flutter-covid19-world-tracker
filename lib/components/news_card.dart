import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class NewsCard extends StatelessWidget {
  final String thumbnail;
  final String title;
  final String description;
  final String source;
  final String link;
  final String publishDate;
  NewsCard({this.description , this.title , this.thumbnail , this.link , this.source , this.publishDate});
  final titleStyle = TextStyle(fontSize: 18.0 , color: Colors.black , fontWeight: FontWeight.bold);
  final descrStyle = TextStyle(fontSize: 14.0 , color: Colors.black45 );
  final srcStyle = TextStyle(fontSize: 11.0 , color: Colors.grey );
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1.7,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child:  Column(
            children: [
               Row(
                children: <Widget>[
                   Padding(
                    padding:  EdgeInsets.only(left: 4.0),
                    child:  Text(
                      timeAgo.format(DateTime.parse('$publishDate')),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child:  Text('$source',
                      style:  TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
               Row(
                children: [
                  Expanded(
                    child:  GestureDetector(
                      child:  Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(
                                left: 4.0,
                                right: 8.0,
                                bottom: 8.0,
                                top: 8.0),
                            child:  Text('$title',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                           Padding(
                            padding:  EdgeInsets.only(
                                left: 4.0,
                                right: 4.0,
                                bottom: 4.0),
                            child:  Text('$description',
                              style:  TextStyle(
                                color: Colors.grey[500],
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () async{
                          var url = '$link';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                      },
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding:
                             EdgeInsets.only(top: 8.0),
                        child:  SizedBox(
                          height: 100.0,
                          width: 100.0,
                          child:  Image.network('$thumbnail',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: <Widget>[
                      //     new GestureDetector(
                      //       child: new Padding(
                      //           padding:
                      //               new EdgeInsets.symmetric(
                      //                   vertical: 10.0,
                      //                   horizontal: 5.0),
                      //           child: Icon(Icons.share)),
                      //       onTap: () {
                      //         // share(data["articles"][index]
                      //         //     ["url"]);
                      //       },
                      //     ),
                      //   ],
                      // ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
    );
  }
}


              





