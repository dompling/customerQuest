import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'dart:typed_data';

Future<void> export_json_file(
    String originalFilePath,
    String fileName, {
      bool isAsset = false,
    }) async {
  Uint8List bytes;

  if (isAsset) {
    // Carica da asset
    final data = await rootBundle.load(originalFilePath);
    bytes = data.buffer.asUint8List();
  } else {
    // Carica da file system
    bytes = await File(originalFilePath).readAsBytes();
  }

  await FlutterFileSaver().writeFileAsBytes(
    fileName: '$fileName.json',
    bytes: bytes,
  );
}
