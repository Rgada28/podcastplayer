import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:podcastplayer/widget/EpisodeList.dart';
import 'package:podcastplayer/widget/ShowInfo.dart';
import 'package:webfeed/webfeed.dart';

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

  @override
  Widget build(BuildContext context) {
    setErrorBuilder();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          ShowInfo(
            imageUrl:
                data.image.url == null ? "Asset/download.png" : data.image.url,
            description: data.description,
            title: data.title,
            subtitle: data.author,
            feedUrl: widget.feedUrl,
          ),
          Expanded(
            child: EpisodeList(
              data: data,
            ),
          ),
        ],
      ),
    );
  }
}
