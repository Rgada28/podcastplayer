import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:podcastplayer/widget/player.dart';

class Download extends StatefulWidget {
  Download({Key key}) : super(key: key);

  @override
  _DownloadState createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  String currentTime = "00:00";
  String totalTime = "00:00";

  @override
  void initState() {
    super.initState();
    fetchDir();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();

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

  void _play(String url) {
    advancedPlayer.play(url, isLocal: true);
  }

  void _stop() {
    advancedPlayer.pause();
  }

  List<FileSystemEntity> _songs = [];
  List<FileSystemEntity> _files;

  fetchDir() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final dir = await getExternalStorageDirectory();
      print("Path:" + dir.path);
      _files = dir.listSync(recursive: true, followLinks: false);
      for (FileSystemEntity entity in _files) {
        String path = entity.path;
        if (path.endsWith('.mp3')) _songs.add(entity);
      }
    }
    // print(_songs);
    print(_songs.length);
  }

  @override
  void setState(fetchDir) {
    super.setState(fetchDir);
    fetchDir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Downloads"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: _songs.length,
        itemBuilder: (context, index) {
          var podTitle =
              _songs.elementAt(index).toString().substring(72).split(".mp3")[0];
          return new Dismissible(
            key: Key(_songs[index].toString()),
            onDismissed: (direction) {
              _songs.elementAt(index).delete();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "$podTitle is deleted",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              );
            },
            background: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.red,
              ),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 20,
                    child: Container(
                      alignment: Alignment.center,
                      child: ListTile(
                        title: Text(podTitle),
                        subtitle: Text(""),
                        trailing: IconButton(
                            icon: Icon(Icons.play_circle_fill),
                            iconSize: 45,
                            color: Colors.teal,
                            onPressed: () async {
                              if (_isPlaying) {
                                _stop();
                              } else {
                                _play(_songs.elementAt(index).path.toString());
                              }
                              setState(() {
                                _isPlaying = !_isPlaying;
                              });
                            }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
