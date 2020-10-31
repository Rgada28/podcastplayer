import 'package:flutter/material.dart';

class ShowInfo extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String title;
  final String subtitle;
  const ShowInfo(
      {Key key, this.imageUrl, this.description, this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
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
                        image: (imageUrl == null)
                            ? AssetImage("Asset/download.png")
                            : NetworkImage(imageUrl),
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
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      OutlineButton.icon(
                        onPressed: () => Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Subscribed to : $title",
                                style: TextStyle(fontSize: 16)),
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.teal,
                          ),
                        ),
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
                            BottomSheet(
                                onClosing: () {},
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 200,
                                    width: 100,
                                    child: Text("Works"),
                                  );
                                });
                          })
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
