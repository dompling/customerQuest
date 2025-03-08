//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'dart:io';

//------------------------------------------------------------------------------



// FUNCTION TO DELETE A SELECTED CUSTOM DECK FROM THE APP DOCUMENTS DIRECTORY
Future<bool> deleteFile(String filePath) async {
  try {

    //------------------------------------------------------------------------------

    // GETTING THEE FILE
    final File file = File(filePath);

    //------------------------------------------------------------------------------

    // CHECKING IF THE FILE EXIST
    if (await file.exists()) {

      // DELETING THE FILE
      await file.delete();

      // RETURNING A SUCCESSFUL STATEMENT
      return true;

    } else {
      return false; // Il file non esiste
    }
  } catch (e) {
    return false;
  }

  //------------------------------------------------------------------------------

}



//------------------------------------------------------------------------------