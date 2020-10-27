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
        body: SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Card(
              child: Image.network(
                widget.episodeImage,
                height: 360,
                width: 360,
                fit: BoxFit.fill,
              ),
              elevation: 20,
            ),
            SizedBox(
              height: 50,
            ),
            Text(widget.episodeTitle),
            SizedBox(
              height: 50,
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
