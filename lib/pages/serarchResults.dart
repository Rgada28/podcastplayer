import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:podcastplayer/widget/searchList.dart';

class SearchResults extends StatefulWidget {
  final queryString;
  SearchResults({Key key, this.queryString}) : super(key: key);

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  String queryBuilder(String queries) {
    List<String> terms = queries.split(" ");
    String search = "";
    for (int i = 0; i < terms.length; i++) {
      if (i == (terms.length) - 1) {
        search += terms[i];
      } else {
        search += terms[i] + "+";
      }
    }
    return search;
  }

  var data;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(linkBuilder());
    data = jsonDecode(res.body);
    setState(() {});
  }

  String linkBuilder() {
    String param = queryBuilder(widget.queryString);
    String url =
        "https://itunes.apple.com/search?term=${param}&country=in&entity=podcast";
    print(url);
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Search Results"),
          backgroundColor: Colors.teal,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Search Results of ${widget.queryString}",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              SearchList(
                feedUrl: linkBuilder(),
              ),
            ],
          ),
        ));
  }
}
