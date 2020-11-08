import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:podcastplayer/widget/player.dart';

class Download extends StatefulWidget {
  Download({Key key}) : super(key: key);

  @override
  _DownloadState createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  @override
  void initState() {
    fetchDir();
    super.initState();
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Downloads"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: _songs.length == 0
          ? Center(
              child: Text(
                "No Downloads",
                style: TextStyle(fontSize: 28),
              ),
            )
          : ListView.builder(
              itemCount: _songs.length,
              itemBuilder: (context, index) {
                var podTitle = _songs
                    .elementAt(index)
                    .toString()
                    .substring(72)
                    .split(".mp3")[0];
                print("Songs length:${_songs.length}");
                return Dismissible(
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
                  background: Card(
                    color: Colors.red,
                  ),
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 20,
                        child: Container(
                          alignment: Alignment.center,
                          child: ListTile(
                            title: Text(podTitle),
                            trailing: IconButton(
                              icon: Icon(Icons.play_circle_fill),
                              iconSize: 45,
                              color: Colors.teal,
                              onPressed: () async {
                                showBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30))),
                                  context: context,
                                  builder: (builder) {
                                    return Container(
                                      color: Colors.teal[200],
                                      height: 200,
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            podTitle,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Player(
                                            episodeUrl: _songs
                                                .elementAt(index)
                                                .path
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                );
              }),
    );
  }
}
