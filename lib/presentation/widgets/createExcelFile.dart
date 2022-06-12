// ignore: file_names

import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:salesforce/data/models/SalesDataModel.dart';
import 'package:salesforce/domain/entities/SalesData.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExcelFile {
  static generateExcel(SalesData data, String fileName) async {
    final path = Directory((await getExternalStorageDirectory())!.path);
    final String saveFileTo = "/salesforce/$fileName.json";

    if (await path.exists()) {
      File file =
          await File("${path.path}" + "$saveFileTo").create(recursive: true);

      SalesDataModel salesDataModel = SalesDataModel(
        assignedDepot: data.assignedDepot,
        collectionDate: data.collectionDate,
        latitude: data.latitude,
        longitude: data.latitude,
        userId: data.userId,
      );

      var toJsonData = salesDataModel.toJson(salesDataModel);

      var jsonEncodeData = jsonEncode(toJsonData);

      await file.writeAsString(jsonEncodeData);

      // await file
      //     .writeAsBytes(bytes)
      //     .whenComplete(() => print("hahahhhahahahah"));
    } else {
      print("you are in else of excel");
    }

    // workbook.dispose();
  }
}

class JsonFile {
  bool _fileExists = false;
  late File _filePath;
  String kFileName = 'newOrder.json';

  Map<String, dynamic> _json = {};
  late String _jsonString;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$kFileName');
  }

  void _writeJson(String key, dynamic value) async {
    Map<String, dynamic> _newJson = {key: value};
    print('1.(_writeJson) _newJson: $_newJson');

    _json.addAll(_newJson);
    print('2.(_writeJson) _json(updated): $_json');
    _jsonString = jsonEncode(_json);
    print('3.(_writeJson) _jsonString: $_jsonString\n - \n');

    _filePath.writeAsString(_jsonString);
  }

  void _readJson() async {
    _filePath = await _localFile;

    _fileExists = await _filePath.exists();
    print('0. File exists? $_fileExists');

    if (_fileExists) {
      try {
        _jsonString = await _filePath.readAsString();
        print('1.(_readJson) _jsonString: $_jsonString');

        _json = jsonDecode(_jsonString);
        print('2.(_readJson) _json: $_json \n - \n');
      } catch (e) {
        print('Tried reading _file error: $e');
      }
    }
  }
}
