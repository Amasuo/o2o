
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class HistoryController {

  static void storeAction(String idProduct, String screen, String clientCode, String screenTimer) {

  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/history.txt');
  }

  Future<String> readActions() async {
    final file = await _localFile;
    String body = await file.readAsString();
    return body;
  }

  Future<File> writeAction(String idProduct, String screen, String clientCode, String screenTimer) async {
    final file = await _localFile;
    return file.writeAsString('$idProduct,$screen,$clientCode,$screenTimer\n');
  }

}




