import 'package:flutter/material.dart';
import 'package:podcastplayer/indexview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  await Hive.openBox("subscription");
  runApp(MaterialApp(
    color: Colors.teal,
    home: IndexView(),
  ));
}
