import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:podcastplayer/podcastPage.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url = "https://api.audioboom.com/channels/recommended";
  var data;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    data = jsonDecode(res.body);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Podcast App"),
      ),
      body: data != null
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    InkWell(
                      enableFeedback: true,
                      onTap: () {
                        var route = MaterialPageRoute(
                          builder: (BuildContext context) => PodcastPage(
                            feedUrl: data["body"][index]["urls"]["web_url"] +
                                "/audio_clips",
                          ),
                        );
                        Navigator.of(context).push(route);
                      },
                      child: Card(
                        child: Image.network(
                          data["body"][index]["urls"]["logo_image"]["original"],
                          cacheHeight: 265,
                          cacheWidth: 265,
                        ),
                        elevation: 20,
                        margin: EdgeInsets.all(30),
                      ),
                    ),
                  ],
                );
              },
              itemCount: data["body"].length,
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      backgroundColor: Colors.grey[350],
    );
  }
}
