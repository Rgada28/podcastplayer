import 'package:flutter/material.dart';
import 'package:podcastplayer/pages/podcastPage.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class SubsList extends StatefulWidget {
  final feedUrl;
  SubsList({Key key, this.feedUrl}) : super(key: key);

  @override
  _SubsListState createState() => _SubsListState();
}

class _SubsListState extends State<SubsList> {
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
    return Column(
      children: <Widget>[
        InkWell(
          enableFeedback: true,
          onTap: () {
            var route = MaterialPageRoute(
              builder: (BuildContext context) => PodcastPage(
                feedUrl: widget.feedUrl,
              ),
            );
            Navigator.of(context).push(route);
          },
          child: Card(
            elevation: 20,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            child: Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                image: DecorationImage(
                    image: NetworkImage(data.image.url), fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          data.title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
