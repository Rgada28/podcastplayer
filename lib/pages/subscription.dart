import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:podcastplayer/widget/SubsList.dart';

class Subscription extends StatefulWidget {
  const Subscription({Key key}) : super(key: key);

  @override
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  var subs;
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    Hive.openBox("subscription");
    subs = Hive.box("subscription");
    print("Subscription:Length:${subs.length}");
    super.initState();
  }

  void setErrorBuilder() {
    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      return Container(
        height: 200,
        width: 200,
        child: Center(
          child: Text("Not subscribed to any show "),
        ),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subscriptions"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: subs.length == 0
          ? Center(
              child: Text(
                "Not subscribed to any show",
                style: TextStyle(fontSize: 28),
              ),
            )
          : Column(
              children: [
                RaisedButton(
                    child: Text("Unsubscribe from all"),
                    onPressed: () {
                      subs.clear();
                      setState(() {});
                    }),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: subs.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: SubsList(
                          feedUrl: subs.getAt(index),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
