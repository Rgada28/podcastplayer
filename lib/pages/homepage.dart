import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:podcastplayer/widget/search_bar.dart';
import 'podcastPage.dart';
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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25.0),
              SearchBar(),
              Container(
                width: double.infinity,
                height: 265,
                margin: EdgeInsets.only(left: 18.0),
                child: data != null
                    ? ListView.builder(
                        itemCount: data["body"].length,
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
                                      builder: (BuildContext context) =>
                                          PodcastPage(
                                        feedUrl: data["body"][index]["urls"]
                                                ["web_url"] +
                                            "/audio_clips",
                                      ),
                                    );
                                    Navigator.of(context).push(route);
                                  },
                                  child: Card(
                                    child: Image.network(
                                      data["body"][index]["urls"]["logo_image"]
                                          ["original"],
                                      cacheHeight: 265,
                                      cacheWidth: 265,
                                    ),
                                    elevation: 20,
                                    margin: EdgeInsets.all(30),
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
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey,
    );
  }
}
