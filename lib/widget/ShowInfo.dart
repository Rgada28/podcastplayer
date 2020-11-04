import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ShowInfo extends StatefulWidget {
  final String imageUrl;
  final String description;
  final String title;
  final String subtitle;
  final String feedUrl;
  const ShowInfo(
      {Key key,
      this.imageUrl,
      this.feedUrl,
      this.description,
      this.title,
      this.subtitle})
      : super(key: key);

  @override
  _ShowInfoState createState() => _ShowInfoState();
}

class _ShowInfoState extends State<ShowInfo> {
  void addSubscription() {
    Hive.box("subscription").add(widget.feedUrl);
    print("Subscription added");
  }

  String info() {
    String description = widget.description.replaceAll("<p>", "");
    print(description);
    return description.replaceAll("</p>", "");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 20,
              shadowColor: Colors.blue.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                      image: (widget.imageUrl == null)
                          ? AssetImage("Asset/download.png")
                          : NetworkImage(widget.imageUrl),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            width: 250,
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    OutlineButton.icon(
                      onPressed: () {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Subscribed to : ${widget.title}",
                                style: TextStyle(fontSize: 16)),
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.teal,
                          ),
                        );
                        addSubscription();
                      },
                      icon: Icon(
                        Icons.add_box,
                        color: Colors.teal[700],
                      ),
                      label: Text(
                        "Subscribe",
                        style: TextStyle(color: Colors.black87, fontSize: 16),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      borderSide: BorderSide(
                        color: Colors.teal[700],
                        width: 2,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.info,
                        size: 30,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 20,
                          context: context,
                          builder: (builder) {
                            return Container(
                              height: 350,
                              child: Column(
                                children: [
                                  Text(
                                    widget.title,
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    thickness: 2,
                                  ),
                                  Text(
                                    "Shows description",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Center(
                                    child: Text(
                                      info(),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
