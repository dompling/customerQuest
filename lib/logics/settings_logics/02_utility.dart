//------------------------------------------------------------------------------
// Loverquest - https://github.com/H3rz3n/loverquest/
//
// Copyright (C) 2025 Lorenzo Maiuri & Contributors
//
// This file is part of Loverquest.
//
// Loverquest is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Loverquest is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Loverquest.  If not, see <https://www.gnu.org/licenses/>.
//
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

