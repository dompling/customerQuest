import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'dart:io';

Future<void> export_json_file(
    String originalFilePath,
    String fileName,
    ) async {
  final bytes = await File(originalFilePath).readAsBytes();        // Uint8List
  await FlutterFileSaver().writeFileAsBytes(
    fileName: '$fileName.json',                                    // nome completo
    bytes: bytes,
  );
}
