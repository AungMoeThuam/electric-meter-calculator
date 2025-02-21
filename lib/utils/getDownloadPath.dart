import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> getDownloadsPath() async {
  Directory? directory;
  if (Platform.isAndroid) {
    directory = Directory(
        '/storage/emulated/0/Download'); // Direct Download folder on Android
  } else {
    directory = await getApplicationDocumentsDirectory();
  }
  return directory.path;
}