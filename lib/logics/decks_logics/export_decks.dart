//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;

//------------------------------------------------------------------------------

// FUNCTION TO EXPORT THE DECK JSON FILE
Future<void> export_json_file(String original_file_path, String file_name) async {
  try {
    //------------------------------------------------------------------------------
    print("[ DEBUG ] - ENTERED EXPORT FUNCTION");

    // CREATING A FILE OBJECT FROM THE GIVEN PATH
    File file_to_export = File(original_file_path);

    // CHECKING IF THE FILE EXISTS
    if (!file_to_export.existsSync()) {
      print("[ ERROR ] - SOURCE FILE DOES NOT EXIST");
      return;
    }

    print("[ DEBUG ] - SOURCE FILE EXISTS");

    //------------------------------------------------------------------------------

    // CLEANING FILE NAME TO EXTRACT ONLY BASE NAME WITHOUT PATH OR EXTENSION
    file_name = p.basenameWithoutExtension(file_name).trim();
    file_name = "$file_name.json";

    print("[ DEBUG ] - FILE NAME CLEANED: $file_name");

    //------------------------------------------------------------------------------

    // LETTING USER PICK A DESTINATION FOLDER
    String? selected_directory = await FilePicker.platform.getDirectoryPath();

    if (selected_directory == null) {
      print("[ DEBUG ] - USER CANCELLED THE DIRECTORY SELECTION");
      return;
    }

    // NORMALIZING PATH TO AVOID DUPLICATES OR MALFORMED RESULTS
    selected_directory = p.normalize(selected_directory);

    print("[ DEBUG ] - DIRECTORY SELECTED: $selected_directory");

    //------------------------------------------------------------------------------

    // CREATING THE FINAL PATH
    String destination_path = p.join(selected_directory, file_name);

    print("[ DEBUG ] - FINAL EXPORT PATH: $destination_path");

    //------------------------------------------------------------------------------

    // ENSURING DESTINATION FOLDER EXISTS
    Directory dest_dir = Directory(selected_directory);
    if (!dest_dir.existsSync()) {
      dest_dir.createSync(recursive: true);
      print("[ DEBUG ] - DESTINATION DIRECTORY CREATED");
    }

    //------------------------------------------------------------------------------

    // COPYING THE FILE
    await file_to_export.copy(destination_path);

    print("[ DEBUG ] - FILE COPIED SUCCESSFULLY");

    //------------------------------------------------------------------------------

    // REFRESHING ANDROID FILES (OPTIONAL)
    if (Platform.isAndroid) {
      try {
        await Process.run(
          'am',
          ['broadcast', '-a', 'android.intent.action.MEDIA_SCANNER_SCAN_FILE', '-d', 'file://$destination_path'],
        );
        print("[ DEBUG ] - ANDROID FILE SCANNER REFRESH SENT");
      } catch (e) {
        print("[ WARNING ] - ANDROID SCANNER FAILED: $e");
      }
    }

    //------------------------------------------------------------------------------

  } catch (e) {
    print("[ ERROR ] - EXPORT FAILED: $e");
  }
}
