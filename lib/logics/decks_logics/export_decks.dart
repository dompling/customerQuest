//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'dart:io';
import 'package:file_picker/file_picker.dart';

//------------------------------------------------------------------------------

// FUNCTION TO EXPORT THE DECK JSON FILE
Future<void> export_json_file(String file_path, String file_name) async {
  try {
    
    //------------------------------------------------------------------------------
    
    // GETTING THE FILE FROM THE CHOSE PATH
    File file_to_export = File(file_path);

    // CHECKING IF THE FILE EXIST
    if (!file_to_export.existsSync()) {
      return;
    }
    
    //------------------------------------------------------------------------------

    // DEFINING THE EXPORTED FILE NAME
    file_name = "$file_name.json";
    
    //------------------------------------------------------------------------------

    // OPENING THE FILE PICKER TO LET THE USER DEFINE THE EXPORT PATH
    String? selected_directory = await FilePicker.platform.getDirectoryPath();

    // CHECKING IF THE USER CHOSE A DIRECTORY
    if (selected_directory == null) {
      return;
    }
    
    //------------------------------------------------------------------------------

    // DEFINING THE FINAL PATH OF THE FILE
    String destination_path = '$selected_directory/$file_name';
    
    //------------------------------------------------------------------------------

    // COPYING THE CHOSE FILE IN THE FINAL PATH
    await file_to_export.copy(destination_path);
    
    //------------------------------------------------------------------------------

    // FORCING THE ANDROID FILE MANAGER TO REFRESH THE FILE LIST
    if (Platform.isAndroid) {
      try {
        await Process.run(
          'am',
          ['broadcast', '-a', 'android.intent.action.MEDIA_SCANNER_SCAN_FILE', '-d', 'file://$destination_path'],
        );
      } catch (e) {
        // ERROR DURING THE FILE MANAGER REFRESH
      }
    }
  } catch (e) {
    // ERROR DURING THE FILE EXPORT
  }
  
  //------------------------------------------------------------------------------
  
}

//------------------------------------------------------------------------------