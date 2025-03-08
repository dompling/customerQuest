//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

//------------------------------------------------------------------------------



// FUNCTION FOR IMPORTING A CUSTOM DECK JSON FILE INSIDE THE APP DIRECTORY
Future<void> importJsonFile() async {

  //------------------------------------------------------------------------------

  // OPENING THE FILE PICKER PAGE FILTERING FOR ONLY JSON FILES
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['json'],
  );

  //------------------------------------------------------------------------------

  // CHECKING THAT A FILE WAS ACTUALLY CHOSEN
  if (result == null) {
    return;
  }

  //------------------------------------------------------------------------------

  // GETTING THE FILE NAME
  File selected_file = File(result.files.single.path!);
  String original_file_name = result.files.single.name;

  //------------------------------------------------------------------------------

  // GETTING THE APP CUSTOM DECKS DIRECTORY
  Directory appDocDir = await getApplicationDocumentsDirectory();

  // CREATING THE SUBDIRECTORY CUSTOM DECKS IF IT DOESN'T ALREADY EXIST
  Directory custom_decks_dir = Directory('${appDocDir.path}/custom_decks');
  if (!(await custom_decks_dir.exists())) {
  await custom_decks_dir.create(recursive: true);
  }
  
  //------------------------------------------------------------------------------
  
  // DEFINING THE FINAL FILE PATH
  String final_path = '${custom_decks_dir.path}/$original_file_name';

  // INITIALIZING A COUNTER FOR FILE THE FILE APEX NUMBER
  int counter = 1;

  // CHANGING FILE NAME UTILS THERE IS NOT A FILE WITH THE SAME NAME
  while (File(final_path).existsSync()) {
    final_path = '${custom_decks_dir.path}/${counter}_$original_file_name';
    counter++;
  }

  //------------------------------------------------------------------------------

  // COPYING THE FILE INSIDE THE APP CUSTOM DECKS DIRECTORY
  try {

    await selected_file.copy(final_path);

  } catch (e) {
    //
  }

  //------------------------------------------------------------------------------

}



//------------------------------------------------------------------------------






