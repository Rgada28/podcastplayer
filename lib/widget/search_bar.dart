import 'package:flutter/material.dart';
import 'package:podcastplayer/pages/serarchResults.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18.0),
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0), color: Colors.white),
      child: TextField(
        controller: controller,
        cursorColor: Colors.blue[800],
        decoration: InputDecoration(
            hintText: "Search for podcasts...",
            border: InputBorder.none,
            suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  print(controller.text);
                  var route = MaterialPageRoute(
                    builder: (BuildContext context) => SearchResults(
                      queryString: controller.text,
                    ),
                  );
                  Navigator.of(context).push(route);
                })),
      ),
    );
  }
}
