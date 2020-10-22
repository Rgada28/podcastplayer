import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

class Player extends StatefulWidget {
  final episodeUrl;
  Player({Key key, this.episodeUrl}) : super(key: key);
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer(playerId: 'my_unique_playerId');
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.onDurationChanged.listen((Duration d) {
      print('Max duration: $d');
      setState(() => _duration = d);
    });

    advancedPlayer.onAudioPositionChanged.listen((Duration p) =>
        {print('Current position: $p'), setState(() => _position = p)});
  }

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
    return Container(
      child: SingleChildScrollView(
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: 80),
              IconButton(
                  icon: Icon(
                    Icons.replay_10_rounded,
                  ),
                  iconSize: 45,
                  onPressed: () {}),
              SizedBox(
                width: 20,
              ),
              IconButton(
                  icon: Icon(_isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_fill),
                  iconSize: 45,
                  onPressed: () async {
                    if (_isPlaying) {
                      _stop();
                    } else {
                      _play();
                    }
                    setState(() {
                      _isPlaying = !_isPlaying;
                    });
                  }),
              SizedBox(
                width: 20,
              ),
              IconButton(
                  icon: Icon(
                    Icons.forward_30_outlined,
                  ),
                  iconSize: 45,
                  onPressed: () {}),
            ],
          ),
          Slider(
            value: 50,
            onChanged: (null),
            min: 0,
            max: 100,
          ),
        ]),
      ),
    );
  }
}
