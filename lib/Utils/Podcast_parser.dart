import 'package:webfeed/webfeed.dart';
import 'package:flutter/material.dart';

class PodcastParser extends StatefulWidget {
  final RssFeed data;
  PodcastParser({Key key, this.data}) : super(key: key);

  @override
  _PodcastParserState createState() => _PodcastParserState();
}

class _PodcastParserState extends State<PodcastParser> {
  String prevImage([int index]) {
    return widget.data.items.elementAt(index).itunes.image.href.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(""),
    );
  }
}
