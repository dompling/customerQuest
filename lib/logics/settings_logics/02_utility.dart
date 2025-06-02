//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';

//------------------------------------------------------------------------------

// EXTENSION FOR CAPITALIZE ONLY THE FIRST LETTER OF A STRING
extension CapitalizeFirstExtension on String {

  String capitalize_first() {

    // IF THE STRING IS EMPTY RETURN THE STRING
    if (isEmpty) return this;

    // RETURNING THE EDITED STRING
    return '${this[0].toUpperCase()}${substring(1)}';

  }

}

// FUNCTION TO GET IF THE LANGUAGE IN USE WAS TRANSLATED USING AN AI
bool check_ai_translation (BuildContext context){

  // OBTAINING THE LOCALE IN USE
  Locale my_locale = Localizations.localeOf(context);

  // OBTAINING THE LOCALE LANGUAGE CODE
  String language_code = my_locale.languageCode;

  // CHECKING IF THE LOCALE WAS TRANSLATED USING AN AI
  if (language_code == "es" || language_code == "de" || language_code == "fr" || language_code == "nl") {

    return true;

  } else {

    return false;
  }

}

