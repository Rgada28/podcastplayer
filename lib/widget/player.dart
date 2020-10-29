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
  String currentTime = "00:00";
  String totalTime = "00:00";

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer(playerId: 'my_unique_playerId');
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.onAudioPositionChanged.listen((Duration p) => {
          setState(() => _position = p),
        });

    advancedPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        _duration = d;
        currentTime = _position.inMinutes.toString() +
            ":" +
            (_position.inSeconds % 60).toString();
        totalTime = _duration.inMinutes.toString() +
            ":" +
            ((_duration.inSeconds % 60) - 1).toString();
      });
    });
  }

  bool _isPlaying = false;

  void _play() {
    advancedPlayer.play(widget.episodeUrl);
  }

  void _stop() {
    advancedPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(children: <Widget>[
          Slider(
            value: _position.inSeconds.toDouble(),
            label: currentTime,
            onChanged: (double value) {
              setState(() {
                advancedPlayer.seek(Duration(seconds: value.toInt()));
              });
            },
            min: 0,
            max: _duration.inSeconds.toDouble(),
            activeColor: Colors.blue[600],
            inactiveColor: Colors.black,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 20,
              ),
              Text(currentTime),
              SizedBox(
                width: 280,
              ),
              Text(totalTime),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 80),
              IconButton(
                  icon: Icon(
                    Icons.replay_10_rounded,
                  ),
                  iconSize: 45,
                  onPressed: () async {
                    await advancedPlayer.seek(
                        Duration(seconds: _position.inSeconds.toInt() - 10));
                  }),
              SizedBox(
                width: 20,
              ),
              IconButton(
                  icon: Icon(_isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_fill),
                  iconSize: 45,
                  color: Colors.blue[600],
                  onPressed: () async {
                    if (_isPlaying) {
                      _stop();
                    } else {
                      _play();
                    }
                    setState(() {
                      // advancedPlayer.setReleaseMode(ReleaseMode.STOP);
                      _isPlaying = !_isPlaying;
                    });
                  }),
              SizedBox(
                width: 20,
              ),
              IconButton(
                  icon: Icon(
                    Icons.forward_10_outlined,
                  ),
                  iconSize: 45,
                  onPressed: () async {
                    await advancedPlayer.seek(
                        Duration(seconds: _position.inSeconds.toInt() + 10));
                  }),
            ],
          ),
        ]),
      ),
    );
  }
}
