import 'package:flutter/material.dart';
import 'package:podcastplayer/widget/player.dart';

class EpisodePage extends StatefulWidget {
  final episodeUrl;
  final episodeImage;
  final episodeTitle;
  EpisodePage({Key key, this.episodeUrl, this.episodeImage, this.episodeTitle})
      : super(key: key);

  @override
  _EpisodePageState createState() => _EpisodePageState();
}

class _EpisodePageState extends State<EpisodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.episodeTitle),
          backgroundColor: Colors.teal,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    child: Image.network(
                      widget.episodeImage,
                      height: 360,
                      width: 360,
                      fit: BoxFit.fill,
                    ),
                    elevation: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    widget.episodeTitle,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Player(
                  episodeUrl: widget.episodeUrl,
                ),
              ],
            ),
          ),
        ));
  }
}
