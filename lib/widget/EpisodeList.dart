import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:podcastplayer/widget/player.dart';
import 'package:webfeed/webfeed.dart';

class EpisodeList extends StatefulWidget {
  final RssFeed data;
  EpisodeList({Key key, this.data}) : super(key: key);

  @override
  _EpisodeListState createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: widget.data.items.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 20,
          shadowColor: Colors.blue.withOpacity(0.3),
          margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Container(
            width: double.infinity,
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        image: (widget.data.items
                                    .elementAt(index)
                                    .itunes
                                    .image
                                    .href ==
                                null)
                            ? AssetImage('Asset/download.png')
                            : NetworkImage(
                                widget.data.items
                                    .elementAt(index)
                                    .itunes
                                    .image
                                    .href,
                              ),
                        fit: BoxFit.cover,
                      )),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.0,
                          ),
                          child: Text(
                            widget.data.items.elementAt(index).title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 80,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.download_outlined,
                                size: 35,
                              ),
                              onPressed: () async {
                                String snackBarText =
                                    "Downloading ${widget.data.items.elementAt(index).title}";
                                final status =
                                    await Permission.storage.request();
                                if (status.isGranted) {
                                  final dir =
                                      await getExternalStorageDirectory();
                                  print(dir.path);
                                  FlutterDownloader.enqueue(
                                      url: widget.data.items
                                          .elementAt(index)
                                          .enclosure
                                          .url,
                                      savedDir: dir.path,
                                      fileName: widget.data.items
                                              .elementAt(index)
                                              .title +
                                          " .mp3",
                                      showNotification: true,
                                      openFileFromNotification: true);
                                } else {
                                  snackBarText = "Permission denied";
                                }
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(snackBarText,
                                        style: TextStyle(fontSize: 16)),
                                    duration: Duration(seconds: 3),
                                    backgroundColor: Colors.teal,
                                  ),
                                );
                              },
                            ),
                            Spacer(),
                            OutlineButton.icon(
                              onPressed: () {
                                showBottomSheet(
                                  backgroundColor: Colors.teal[100],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30))),
                                  context: context,
                                  builder: (builder) {
                                    return Container(
                                      height: 450,
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Image.network(
                                            widget.data.items
                                                .elementAt(index)
                                                .itunes
                                                .image
                                                .href,
                                            width: 200,
                                            height: 200,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 30, top: 8.0),
                                            child: Text(widget.data.items
                                                .elementAt(index)
                                                .title),
                                          ),
                                          Player(
                                            episodeUrl: widget.data.items
                                                .elementAt(index)
                                                .enclosure
                                                .url,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              label: Text(
                                widget.data.items
                                    .elementAt(index)
                                    .itunes
                                    .duration
                                    .toString()
                                    .substring(0, 7),
                                overflow: TextOverflow.ellipsis,
                              ),
                              icon: Icon(
                                Icons.play_circle_fill,
                                color: Colors.teal,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              borderSide: BorderSide(width: 1),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
