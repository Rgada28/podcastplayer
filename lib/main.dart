import 'package:flutter/material.dart';
import 'package:podcastplayer/indexview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  var appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  await Hive.openBox("subscription");
  runApp(MaterialApp(
    home: IndexView(),
  ));
}
