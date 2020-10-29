import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:podcastplayer/pages/episodePage.dart';
import 'package:webfeed/webfeed.dart';

class IPodcastPage extends StatefulWidget {
  final feedUrl;
  IPodcastPage({Key key, this.feedUrl}) : super(key: key);

  @override
  _IPodcastPageState createState() => _IPodcastPageState();
}

class _IPodcastPageState extends State<IPodcastPage> {
  RssFeed data;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(widget.feedUrl);
    data = RssFeed.parse(res.body);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Podcast"),
      ),
      body: data != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                return
                    // data["body"]["audio_clips"].toString() == null
                    //     ? Text("Some text") :
                    Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ListTile(
                        tileColor: Colors.black,
                        onTap: () {
                          var route = MaterialPageRoute(
                            builder: (BuildContext context) => EpisodePage(
                              episodeUrl:
                                  data.items.elementAt(index).enclosure.url,
                              episodeImage:
                                  data.items.elementAt(index).itunes.image.href,
                              episodeTitle: data.items.elementAt(index).title,
                            ),
                          );
                          Navigator.of(context).push(route);
                        },
                        leading: Image(
                          image: (data.items
                                      .elementAt(index)
                                      .itunes
                                      .image
                                      .href ==
                                  null)
                              ? AssetImage('Asset/download.png')
                              : NetworkImage(
                                  data.items.elementAt(index).itunes.image.href,
                                ),
                          height: 100,
                          width: 100,
                          alignment: Alignment.topLeft,
                        ),
                        title: Text(
                          data.items.elementAt(index).title,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                );
              },
              itemCount: data.items.length,
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
