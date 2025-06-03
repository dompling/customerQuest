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
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//------------------------------------------------------------------------------

// CLASS FOR CHANGING APP LANGUAGE
class LocaleProvider extends ChangeNotifier {

  //------------------------------------------------------------------------------

  // DEFINING CLASS ATTRIBUTES
  Locale? _locale;

  // SUPPORTED LANGUAGES
  final List<String> supportedLanguages = ['it', 'fr', 'de', 'es', 'en', 'nl'];

  //------------------------------------------------------------------------------

  // CLASS CONSTRUCTOR
  Locale? get locale => _locale;

  //------------------------------------------------------------------------------

  // LOADING SAVED LANGUAGE PREFERENCE FUNCTION
  Future<void> loadLocale() async {

    // GETTING THE SAVED PREFERENCE
    final prefs = await SharedPreferences.getInstance();

    // GETTING THE SAVED LANGUAGE
    String? savedLanguage = prefs.getString('selected_language');

    // IF THERE IS NO SAVED PREFERENCE TRY TO USE SYSTEM LANGUAGE
    savedLanguage ??= PlatformDispatcher.instance.locale.languageCode;

    // CHECKING IF THE SYSTEM LANGUAGE IS ACTUALLY SUPPORTED
    if (!supportedLanguages.contains(savedLanguage)) {
      savedLanguage = 'en';
    }

    // IF A LANGUAGE IS SAVED, USE IT
    _locale = Locale(savedLanguage, '');
  
    // NOTIFY LISTENERS TO UPDATE UI
    notifyListeners();
  }

  //------------------------------------------------------------------------------

  // FUNCTION FOR SETTING A SPECIFIC LANGUAGE
  Future<void> setLocale(Locale locale) async {
    // SETTING THE USER CHOSEN LANGUAGE
    _locale = locale;

    // UPDATING THE UI
    notifyListeners();

    // SAVING THE LANGUAGE IN THE PREFERENCES
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', locale.languageCode);
  }

  //------------------------------------------------------------------------------

  // FUNCTION FOR CLEARING THE SELECTED LANGUAGE
  Future<void> clearLocale() async {
    // SETTING THE STOCK LANGUAGE TO ENGLISH
    _locale = Locale('en', '');
    notifyListeners();

    // REMOVING THE PREFERRED LANGUAGE SAVED SETTINGS
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('selected_language');
  }

//------------------------------------------------------------------------------
}
