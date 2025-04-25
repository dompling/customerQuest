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

  // SUPPORTED LANGUAGES
  final List<String> supportedLanguages = ['it', 'fr', 'de', 'es'];

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

    savedLanguage ??= "en";

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
