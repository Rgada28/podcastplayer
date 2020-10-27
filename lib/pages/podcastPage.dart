import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:podcastplayer/pages/episodePage.dart';
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
    // print(data["body"]["audio_clips"]);
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
                return
                    // data["body"]["audio_clips"].toString() == null
                    //     ? Text("Some text") :
                    Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ListTile(
                        tileColor: Colors.black,
                        onTap: () {
                          var route = MaterialPageRoute(
                            builder: (BuildContext context) => EpisodePage(
                              episodeUrl: data["body"]["audio_clips"][index]
                                  ["urls"]["high_mp3"],
                              episodeImage: data["body"]["audio_clips"][index]
                                  ["urls"]["image"],
                              episodeTitle: data["body"]["audio_clips"][index]
                                  ["title"],
                            ),
                          );
                          Navigator.of(context).push(route);
                        },
                        leading: Image(
                          image: (data["body"]["audio_clips"][index]["urls"]
                                      ["image"] ==
                                  null)
                              ? AssetImage('Asset/download.png')
                              : NetworkImage(
                                  data["body"]["audio_clips"][index]["urls"]
                                      ["image"],
                                ),
                          height: 100,
                          width: 100,
                          alignment: Alignment.topLeft,
                        ),
                        title: Text(
                          data["body"]["audio_clips"][index]["title"],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
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
