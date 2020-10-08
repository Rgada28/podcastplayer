import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:podcastplayer/episodePage.dart';
import 'dart:convert';

class PodcastPage extends StatefulWidget {
  final feedUrl;
  PodcastPage({Key key, this.feedUrl}) : super(key: key);

  @override
  _PodcastPageState createState() => _PodcastPageState();
}

class _PodcastPageState extends State<PodcastPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Podcast page"),
      ),
      body: data != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        var route = MaterialPageRoute(
                          builder: (BuildContext context) => EpisodePage(
                            episodeUrl: "",
                          ),
                        );
                        Navigator.of(context).push(route);
                      },
                      title: Text(data["body"]["audio_clips"][index]["title"]),
                    )
                  ],
                );
              },
              itemCount: data["body"]["audio_clips"].length,
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
