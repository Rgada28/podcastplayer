import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:podcastplayer/pages/podcastPage.dart';

class SearchList extends StatefulWidget {
  final feedUrl;
  const SearchList({Key key, this.feedUrl}) : super(key: key);

  @override
  _SearchList createState() => _SearchList();
}

class _SearchList extends State<SearchList> {
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
      child: data != null
          ? ListView.builder(
              itemCount: data["results"].length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  width: 100,
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
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: Colors.black,
                      )
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
