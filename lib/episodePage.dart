import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

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
  AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  void _play() {
    _audioPlayer.play(widget.episodeUrl);
  }

  void _stop() {
    _audioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: <Widget>[
          Image.network(
            widget.episodeImage,
            height: 600,
            width: 600,
          ),
          Text(widget.episodeTitle),
          IconButton(
              icon: _isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
              onPressed: () async {
                if (_isPlaying) {
                  _stop();
                } else {
                  _play();
                }
                setState(() {
                  _isPlaying = !_isPlaying;
                });
              })
        ],
      ),
    ));
  }
}
