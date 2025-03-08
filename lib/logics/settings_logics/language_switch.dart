//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//------------------------------------------------------------------------------

// CLASS FOR CHANGING APP LANGUAGE
class LocaleProvider extends ChangeNotifier {

  //------------------------------------------------------------------------------

  // DEFINING CLASS ATTRIBUTES
  Locale? _locale;

  //------------------------------------------------------------------------------

  // CLASS CONSTRUCTOR
  Locale? get locale => _locale;

  //------------------------------------------------------------------------------

  // LOADING SAVED LANGUAGE PREFERENCE FUNCTION
  Future<void> loadLocale() async {
    // GETTING THE SAVES PREFERENCE
    final prefs = await SharedPreferences.getInstance();

    // GETTING THE SAVED LANGUAGE
    String? savedLanguage = prefs.getString('selected_language');

    // CHECKING IF THERE IS A PREFERRED SAVED LANGUAGE
    if (savedLanguage != null) {
      // LOADING THE SAVED LANGUAGE
      _locale = Locale(savedLanguage, '');
    } else {
      // LOADING THE DEFAULT LANGUAGE
      _locale = Locale('en', '');
    }
  }

  //------------------------------------------------------------------------------

  // FUNCTION FOR SETTING A SPECIFIC LANGUAGE
  Future<void> setLocale(Locale locale) async {

    // SETTING THE USER CHOOSE LANGUAGE
    _locale = locale;

    // UPDATING THE UI
    notifyListeners();

    // SAVING THE LANGUAGE IN THE PREFERENCE
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', locale.languageCode);

  }

  //------------------------------------------------------------------------------

  // FUNCTION FOR CLEARING THE SELECTED LANGUAGE
  Future<void> clearLocale() async {

    // SETTING THE STOCK LANGUAGE
    _locale = Locale('en', '');
    notifyListeners();

    // REMOVING THE PREFERRED LANGUAGE SAVED SETTINGS
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('selected_language');

  }

  //------------------------------------------------------------------------------

}

//------------------------------------------------------------------------------





