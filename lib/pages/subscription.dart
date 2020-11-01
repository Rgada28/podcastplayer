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
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    Hive.openBox("subscription");
    subs = Hive.box("subscription");
    print("Subscription:Length:${subs.length}");
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
              child: Text("Not subscribed to any show"),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: subs.length,
                    itemBuilder: (context, index) {
                      return SubsList(
                        feedUrl: subs.getAt(index),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
