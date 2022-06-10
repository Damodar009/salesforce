// ignore: file_names

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExcelFile {
  static generateExcel(dynamic data, String fileName) async {
    final Workbook workbook = Workbook();

    final List<int> bytes = workbook.saveAsStream();
    final path = Directory((await getExternalStorageDirectory())!.path);
    final String saveFileTo = "/salesforce/$fileName.json";

    if (await path.exists()) {
      File file =
          await File("${path.path}" + "$saveFileTo").create(recursive: true);

      await file
          .writeAsBytes(bytes)
          .whenComplete(() => print("hahahhhahahahah"));
    } else {
      print("you are in else of excel");
    }

    workbook.dispose();
  }
}
