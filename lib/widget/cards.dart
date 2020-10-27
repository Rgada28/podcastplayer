import 'package:flutter/material.dart';
import '../constants.dart';

class RecommendedCard extends StatefulWidget {
  @override
  _RecommendedCardState createState() => _RecommendedCardState();
}

class _RecommendedCardState extends State<RecommendedCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      margin: EdgeInsets.only(right: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 8.0,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                image: DecorationImage(
                  image: NetworkImage(""),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Spacer(),
          Text(
            "podcast.title",
            overflow: TextOverflow.ellipsis,
            style: kTitleStyle,
          ),
          SizedBox(height: 5.0),
          Text("", style: kSubtitleStyle)
        ],
      ),
    );
  }
}
