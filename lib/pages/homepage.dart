import 'package:flutter/material.dart';
import 'package:podcastplayer/widget/CardList.dart';
import 'package:podcastplayer/widget/ICardList.dart';
import 'package:podcastplayer/widget/search_bar.dart';
import 'podcastPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Podcast App"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25.0),
              SearchBar(),
              SizedBox(height: 25.0),
              Text(
                "Recomended                                          ",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              CardList(
                feedUrl: "https://api.audioboom.com/channels/recommended",
                page: PodcastPage(),
              ),
              SizedBox(height: 10.0),
              Text(
                "Business                                          ",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              ICardList(
                feedUrl:
                    "https://itunes.apple.com/search?term=podcast&country=in&entity=podcast&genreId=1321&limit=200",
                page: PodcastPage(),
              ),
              SizedBox(height: 10.0),
              Text(
                "Investing                                         ",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              ICardList(
                feedUrl:
                    "https://itunes.apple.com/search?term=podcast&country=in&entity=podcast&genreId=1412&limit=200",
                page: PodcastPage(),
              ),
              SizedBox(height: 10.0),
              Text(
                "Health & fitness                                          ",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              ICardList(
                feedUrl:
                    "https://itunes.apple.com/search?term=podcast&country=in&entity=podcast&genreId=1512&limit=200",
                page: PodcastPage(),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
