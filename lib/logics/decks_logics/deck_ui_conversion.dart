//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:loverquest/l10n/app_localization.dart';

//------------------------------------------------------------------------------

// DEFINING THE CLASS TO CONVERT ALL THE LANGUAGE INFO IN AN OBJECT
class LanguageInfo {

  // CLASS ATTRIBUTES
  final String label;
  final Color background_color;
  final Color border_color;
  final String language_code;

  // CLASS CONSTRUCTOR
  LanguageInfo(this.label, this.background_color, this.border_color, this.language_code);

}

// FUNCTION TO GET ALL THE INFO FROM THE DECK DIFFICULTY
LanguageInfo get_language_info(BuildContext context, String deck_lang) {

  // GETTING THE CASE USING DIFFICULTY NUMBER
  switch (deck_lang) {
    case "it":
      return LanguageInfo(AppLocalizations.of(context)!.deck_language_it, Color(0xff6b6b6b), Color(0xff8b8b8b), "it");
    case "es":
      return LanguageInfo(AppLocalizations.of(context)!.deck_language_es, Color(0xff6b6b6b), Color(0xff8b8b8b), "es");
    case "de":
      return LanguageInfo(AppLocalizations.of(context)!.deck_language_de, Color(0xff6b6b6b), Color(0xff8b8b8b), "de");
    case "fr":
      return LanguageInfo(AppLocalizations.of(context)!.deck_language_fr, Color(0xff6b6b6b), Color(0xff8b8b8b), "fr");
    default:
      return LanguageInfo(AppLocalizations.of(context)!.deck_language_en, Color(0xff6b6b6b), Color(0xff8b8b8b), "en");
  }

}

//------------------------------------------------------------------------------



// DEFINING THE CLASS TO CONVERT ALL THE COUPLE TYPE INFO IN AN OBJECT
class CoupleTypeInfo {

  // CLASS ATTRIBUTES
  final String label;
  final Color background_color;
  final Color border_color;

  CoupleTypeInfo(this.label, this.background_color, this.border_color);

}

// FUNCTION TO GET ALL THE INFO FROM THE DECK COUPLE TYPE INFO
CoupleTypeInfo get_couple_type_info(BuildContext context, String couple_type) {

  // GETTING THE CASE USING COUPLE TYPE TEXT
  switch (couple_type) {
    case "hetero":
      return CoupleTypeInfo(AppLocalizations.of(context)!.deck_couple_type_tag_label_hetero, Color(0xb3a29c5b), Color(0xffeae882));
    case "lesbian":
      return CoupleTypeInfo(AppLocalizations.of(context)!.deck_couple_type_tag_label_lesbian, Color(0xff6a4175), Color(0x9ed382ea));
    case "gay":
      return CoupleTypeInfo(AppLocalizations.of(context)!.deck_couple_type_tag_label_gay, Color(0xb3324059), Color(0xff82acea));
    default:
      return CoupleTypeInfo(AppLocalizations.of(context)!.deck_couple_type_tag_label_not_spec, Color(0xff4e4e4e), Color(0xff909090));
  }

}



//------------------------------------------------------------------------------



// DEFINING THE CLASS TO CONVERT ALL THE GAME TYPE INFO IN AN OBJECT
class GameTypeInfo {

  // CLASS ATTRIBUTES
  final String label;
  final Color background_color;
  final Color border_color;

  GameTypeInfo(this.label, this.background_color, this.border_color);

}

// FUNCTION TO GET ALL THE INFO FROM THE DECK GAME TYPE
GameTypeInfo get_game_type_type_info(BuildContext context, bool play_distance) {

  // GETTING THE CASE OF PLAY DISTANCE - TRUE - FALSE
  switch (play_distance) {
    case  false:
      return GameTypeInfo(AppLocalizations.of(context)!.deck_game_type_tag_label_presence, Color(
          0xb3a25b7b), Color(0xffea82ad));
    case true:
      return GameTypeInfo(AppLocalizations.of(context)!.deck_game_type_tag_label_distance, Color(
          0xff415875), Color(0x9e82c2ea));
  }

}



//------------------------------------------------------------------------------



// DEFINING THE CLASS TO CONVERT ALL THE TOOLS INFO IN AN OBJECT
class ToolsInfo {

  // CLASS ATTRIBUTES
  final String label;
  final Color background_color;
  final Color border_color;

  ToolsInfo(this.label, this.background_color, this.border_color);

}

// FUNCTION TO GET ALL THE INFO FROM THE DECK DIFFICULTY
ToolsInfo get_tools_info(BuildContext context, List<String> deck_tools_list) {

  // CHECKING IF THERE ARE REQUIRED TOOLS
  if (deck_tools_list.isEmpty) {

    return ToolsInfo(AppLocalizations.of(context)!.no_tools_label, Color(
        0xff453762), Color(0xff695e8b));

  } else {

    return ToolsInfo(AppLocalizations.of(context)!.tools_label, Color(
        0xff7b4465), Color(0xff946193));

  }

}




//------------------------------------------------------------------------------



// DEFINING THE CLASS TO CONVERT ALL THE TOOLS INFO IN AN OBJECT
class OralSexTagInfo {

  // CLASS ATTRIBUTES
  final String label;
  final Color background_color;
  final Color border_color;
  final bool show_tag;

  OralSexTagInfo(this.label, this.background_color, this.border_color, this.show_tag);

}

// FUNCTION TO GET ALL THE INFO FROM THE DECK DIFFICULTY
OralSexTagInfo get_oral_tag_info(BuildContext context, List<String> deck_tags_list) {

  // CHECKING IF THE TAG HAS TO BE SHOWN
  if (deck_tags_list.contains("oral_sex")) {

    return OralSexTagInfo(AppLocalizations.of(context)!.no_tools_label, Color(0xff61823d), Color(0xff5e8b64), true);

  } else {

    return OralSexTagInfo(AppLocalizations.of(context)!.no_tools_label, Color(0xff61823d), Color(0xff5e8b64), false);

  }

}



//------------------------------------------------------------------------------



// DEFINING THE CLASS TO CONVERT ALL THE TOOLS INFO IN AN OBJECT
class VaginalSexTagInfo {

  // CLASS ATTRIBUTES
  final String label;
  final Color background_color;
  final Color border_color;
  final bool show_tag;

  VaginalSexTagInfo(this.label, this.background_color, this.border_color, this.show_tag);

}

// FUNCTION TO GET ALL THE INFO FROM THE DECK DIFFICULTY
VaginalSexTagInfo get_vaginal_tag_info(BuildContext context, List<String> deck_tags_list) {

  // CHECKING IF THE TAG HAS TO BE SHOWN
  if (deck_tags_list.contains("vaginal_sex")) {

    return VaginalSexTagInfo(AppLocalizations.of(context)!.no_tools_label, Color(0xff793d82), Color(
        0xff8b5e7e), true);

  } else {

    return VaginalSexTagInfo(AppLocalizations.of(context)!.no_tools_label, Color(0xff793d82), Color(
        0xff8b5e7e), false);

  }

}



//------------------------------------------------------------------------------



// DEFINING THE CLASS TO CONVERT ALL THE TOOLS INFO IN AN OBJECT
class AnalSexTagInfo {

  // CLASS ATTRIBUTES
  final String label;
  final Color background_color;
  final Color border_color;
  final bool show_tag;

  AnalSexTagInfo(this.label, this.background_color, this.border_color, this.show_tag);

}

// FUNCTION TO GET ALL THE INFO FROM THE DECK DIFFICULTY
AnalSexTagInfo get_anal_tag_info(BuildContext context, List<String> deck_tags_list) {

  // CHECKING IF THE TAG HAS TO BE SHOWN
  if (deck_tags_list.contains("anal_sex")) {

    return AnalSexTagInfo(AppLocalizations.of(context)!.no_tools_label, Color(
        0xff823d3d), Color(
        0xff8b5e5e), true);

  } else {

    return AnalSexTagInfo(AppLocalizations.of(context)!.no_tools_label, Color(
        0xff823d3d), Color(
        0xff8b5e5e), false);

  }

}



//------------------------------------------------------------------------------













