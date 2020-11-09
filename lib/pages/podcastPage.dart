import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:podcastplayer/widget/EpisodeList.dart';
import 'package:webfeed/webfeed.dart';
import 'package:hive/hive.dart';

class PodcastPage extends StatefulWidget {
  final feedUrl;
  PodcastPage({Key key, this.feedUrl}) : super(key: key);

  @override
  _PodcastPageState createState() => _PodcastPageState();
}

class _PodcastPageState extends State<PodcastPage> {
  RssFeed data;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void setErrorBuilder() {
    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    };
  }

  fetchData() async {
    var res = await http.get(widget.feedUrl);
    data = RssFeed.parse(res.body);
    setState(() {});
  }

  void addSubscription() {
    Hive.box("subscription").add(widget.feedUrl);
    print("Subscription added");
  }

  void unSubscribe() {
    print("Before unsubscribe ${Hive.box("subscription").length}");
    List subs = Hive.box("subscription").values.toList();
    for (int i = 0; i < subs.length; i++) {
      if (subs[i].contains(widget.feedUrl)) {
        subs.removeAt(i);
        Hive.box("subscription").deleteAt(i);
      }
    }
    print("After unsubscribe ${Hive.box("subscription").length}");
  }

  String info() {
    String description = data.description.replaceAll("<p>", "");
    return description.replaceAll("</p>", "");
  }

  bool isSubscribed() {
    bool subsstate = Hive.box("subscription").values.contains(widget.feedUrl);
    print(subsstate);
    setState(() {});
    return subsstate;
  }

  @override
  Widget build(BuildContext context) {
    setErrorBuilder();
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.teal,
            pinned: true,
            expandedHeight: 400.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(data.title),
              centerTitle: true,
              titlePadding: EdgeInsets.all(15),
              background: Image.network(
                data.image.url,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.5),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                ButtonBar(children: <Widget>[
                  RaisedButton.icon(
                    icon: Icon(
                      !isSubscribed() ? Icons.add_box : Icons.done_rounded,
                      color: Colors.white,
                    ),
                    label: Text(
                      isSubscribed() ? "Unsubscribe" : "Subscribe",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    color: isSubscribed() ? Colors.red : Colors.teal,
                    onPressed: () {
                      if (isSubscribed()) {
                        unSubscribe();
                      } else {
                        addSubscription();
                      }
                    },
                  ),
                  Text(
                    info(),
                    style: TextStyle(fontSize: 18),
                    maxLines: 14,
                    overflow: TextOverflow.visible,
                  ),
                ]),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          SliverFillRemaining(
              hasScrollBody: true,
              child: Container(
                child: EpisodeList(
                  data: data,
                ),
              ))
        ],
      ),
    );
  }
}
