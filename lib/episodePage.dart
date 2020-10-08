import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

class EpisodePage extends StatefulWidget {
  final episodeUrl;
  final episodeImage;
  EpisodePage({Key key, this.episodeUrl, this.episodeImage}) : super(key: key);

  @override
  _EpisodePageState createState() => _EpisodePageState();
}

class _EpisodePageState extends State<EpisodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Row(
        children: <Widget>[
          Image.network(""),
          IconButton(icon: Icon(Icons.play_arrow), onPressed: () {})
        ],
      ),
    ));
  }
}
