import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:podcastplayer/pages/podcastPage.dart';

class CardList extends StatefulWidget {
  final feedUrl;
  final Widget page;
  const CardList({Key key, this.feedUrl, this.page}) : super(key: key);

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  var data;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(widget.feedUrl);
    data = jsonDecode(res.body);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 265,
      margin: EdgeInsets.only(left: 18.0),
      child: data != null
          ? ListView.builder(
              itemCount: data["results"].length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  width: 200,
                  margin: EdgeInsets.only(right: 18),
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        enableFeedback: true,
                        onTap: () {
                          var route = MaterialPageRoute(
                            builder: (BuildContext context) => PodcastPage(
                              feedUrl: data["results"][index]["feedUrl"],
                            ),
                          );
                          Navigator.of(context).push(route);
                        },
                        child: Column(
                          children: [
                            Card(
                              elevation: 20,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0)),
                              child: Column(
                                children: [
                                  Container(
                                    width: 200.0,
                                    height: 200.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            data["results"][index]
                                                ["artworkUrl600"],
                                          ),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        data["results"][index]["collectionName"].toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
