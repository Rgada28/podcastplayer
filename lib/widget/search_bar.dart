import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18.0),
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0), color: Colors.white),
      child: TextField(
        cursorColor: Colors.blue[800],
        decoration: InputDecoration(
            hintText: "Search for podcasts...",
            border: InputBorder.none,
            suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: () {})),
      ),
    );
  }
}
