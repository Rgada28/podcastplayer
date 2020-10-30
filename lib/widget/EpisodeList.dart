import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:podcastplayer/pages/episodePage.dart';

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
      child: widget.data != null
          ? ListView.builder(
              itemCount: widget.data.items.length,
              itemBuilder: (context, index) {
                return
                    // data["body"]["audio_clips"].toString() == null
                    //     ? Text("Some text") :

                    InkWell(
                  onTap: () {
                    var route = MaterialPageRoute(
                      builder: (BuildContext context) => EpisodePage(
                        episodeUrl:
                            widget.data.items.elementAt(index).enclosure.url,
                        episodeImage: widget.data.items
                            .elementAt(index)
                            .itunes
                            .image
                            .href,
                        episodeTitle: widget.data.items.elementAt(index).title,
                      ),
                    );
                    Navigator.of(context).push(route);
                  },
                  child: Card(
                    elevation: 20,
                    shadowColor: Colors.blue.withOpacity(0.3),
                    margin:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
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
                                    children: [
                                      Spacer(),
                                      OutlineButton.icon(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.access_time_outlined,
                                          color: Colors.black,
                                        ),
                                        label: Text(
                                          widget.data.items
                                              .elementAt(index)
                                              .itunes
                                              .duration
                                              .toString()
                                              .substring(0, 7),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
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
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
