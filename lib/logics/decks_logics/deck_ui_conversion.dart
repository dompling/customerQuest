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
      return LanguageInfo(AppLocalizations.of(context)!.deck_language_it, Color(
          0xffa26b58), Color(0xffa26b58), "it");
    case "es":
      return LanguageInfo(AppLocalizations.of(context)!.deck_language_es, Color(0xffa26b58), Color(0xffa26b58), "es");
    case "de":
      return LanguageInfo(AppLocalizations.of(context)!.deck_language_de, Color(0xffa26b58), Color(0xffa26b58), "de");
    case "fr":
      return LanguageInfo(AppLocalizations.of(context)!.deck_language_fr, Color(0xffa26b58), Color(0xffa26b58), "fr");
    default:
      return LanguageInfo(AppLocalizations.of(context)!.deck_language_en, Color(0xffa26b58), Color(0xffa26b58), "en");
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
      return CoupleTypeInfo(AppLocalizations.of(context)!.deck_couple_type_tag_label_hetero, Color(
          0xffa28358), Color(0xffa28358));
    case "lesbian":
      return CoupleTypeInfo(AppLocalizations.of(context)!.deck_couple_type_tag_label_lesbian, Color(0xffa25878),
          Color(0xffa25878));
    case "gay":
      return CoupleTypeInfo(AppLocalizations.of(context)!.deck_couple_type_tag_label_gay, Color(
          0xff587ba2), Color(0xff587ba2));
    default:
      return CoupleTypeInfo(AppLocalizations.of(context)!.deck_couple_type_tag_label_not_spec, Color(0xff4e4e4e),
          Color(0xff4e4e4e));
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
    case  true:
      return GameTypeInfo(AppLocalizations.of(context)!.deck_game_type_tag_label_presence, Color(
          0xffa25858), Color(0xffa25858));
    case false:
      return GameTypeInfo(AppLocalizations.of(context)!.deck_game_type_tag_label_distance, Color(
          0xff8258a2), Color(0xff8258a2));
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
        0xff62a258), Color(0xff62a258));

  } else {

    return ToolsInfo(AppLocalizations.of(context)!.tools_label, Color(
        0xff5883a2), Color(0xff5883a2));

  }

}




//------------------------------------------------------------------------------



// DEFINING THE CLASS TO CONVERT ALL THE TAGS INFO IN AN OBJECT
class OralSexTagInfo {

  // CLASS ATTRIBUTES
  final String label;
  final Color background_color;
  final Color border_color;
  final bool show_tag;

  OralSexTagInfo(this.label, this.background_color, this.border_color, this.show_tag);

}

// FUNCTION TO GET ALL THE INFO FROM THE DECK TAGS
OralSexTagInfo get_oral_tag_info(BuildContext context, List<String> deck_tags_list) {

  // CHECKING IF THE TAG HAS TO BE SHOWN
  if (deck_tags_list.contains("oral_sex")) {

    return OralSexTagInfo(AppLocalizations.of(context)!.deck_oral_sex_tag_label, Color(
        0xffa29558), Color(0xffa29558), true);

  } else {

    return OralSexTagInfo(AppLocalizations.of(context)!.deck_oral_sex_tag_label, Color(0xffa29558), Color(0xffa29558), false);

  }

}



//------------------------------------------------------------------------------



// DEFINING THE CLASS TO CONVERT ALL THE TAGS INFO IN AN OBJECT
class VaginalSexTagInfo {

  // CLASS ATTRIBUTES
  final String label;
  final Color background_color;
  final Color border_color;
  final bool show_tag;

  VaginalSexTagInfo(this.label, this.background_color, this.border_color, this.show_tag);

}

// FUNCTION TO GET ALL THE INFO FROM THE DECK TAGS
VaginalSexTagInfo get_vaginal_tag_info(BuildContext context, List<String> deck_tags_list) {

  // CHECKING IF THE TAG HAS TO BE SHOWN
  if (deck_tags_list.contains("vaginal_sex")) {

    return VaginalSexTagInfo(AppLocalizations.of(context)!.deck_vaginal_sex_tag_label, Color(0xff8758a2), Color(
        0xff8758a2), true);

  } else {

    return VaginalSexTagInfo(AppLocalizations.of(context)!.deck_vaginal_sex_tag_label, Color(0xff8758a2), Color(
        0xff8758a2), false);

  }

}



//------------------------------------------------------------------------------



// DEFINING THE CLASS TO CONVERT ALL THE TAGS INFO IN AN OBJECT
class AnalSexTagInfo {

  // CLASS ATTRIBUTES
  final String label;
  final Color background_color;
  final Color border_color;
  final bool show_tag;

  AnalSexTagInfo(this.label, this.background_color, this.border_color, this.show_tag);

}

// FUNCTION TO GET ALL THE INFO FROM THE DECK TAGS
AnalSexTagInfo get_anal_tag_info(BuildContext context, List<String> deck_tags_list) {

  // CHECKING IF THE TAG HAS TO BE SHOWN
  if (deck_tags_list.contains("anal_sex")) {

    return AnalSexTagInfo(AppLocalizations.of(context)!.deck_anal_sex_tag_label, Color(
        0xff586fa2), Color(
        0xff586fa2), true);

  } else {

    return AnalSexTagInfo(AppLocalizations.of(context)!.deck_anal_sex_tag_label, Color(
        0xff586fa2), Color(
        0xff586fa2), false);

  }

}



//------------------------------------------------------------------------------



// DEFINING THE CLASS TO CONVERT ALL THE TAGS INFO IN AN OBJECT
class BondageTagInfo {

  // CLASS ATTRIBUTES
  final String label;
  final Color background_color;
  final Color border_color;
  final bool show_tag;

  BondageTagInfo(this.label, this.background_color, this.border_color, this.show_tag);

}

// FUNCTION TO GET ALL THE INFO FROM THE DECK TAGS
BondageTagInfo get_bondage_tag_info(BuildContext context, List<String> deck_tags_list) {

  // CHECKING IF THE TAG HAS TO BE SHOWN
  if (deck_tags_list.contains("bondage")) {

    return BondageTagInfo(AppLocalizations.of(context)!.deck_bondage_tag_label, Color(
        0xffa2588a), Color(
        0xffa2588a), true);

  } else {

    return BondageTagInfo(AppLocalizations.of(context)!.deck_bondage_tag_label, Color(
        0xffa2588a), Color(
        0xffa2588a), false);

  }

}



//------------------------------------------------------------------------------



// DEFINING THE CLASS TO CONVERT ALL THE TAGS INFO IN AN OBJECT
class BdsmTagInfo {

  // CLASS ATTRIBUTES
  final String label;
  final Color background_color;
  final Color border_color;
  final bool show_tag;

  BdsmTagInfo(this.label, this.background_color, this.border_color, this.show_tag);

}

// FUNCTION TO GET ALL THE INFO FROM THE DECK TAGS
BdsmTagInfo get_bdsm_tag_info(BuildContext context, List<String> deck_tags_list) {

  // CHECKING IF THE TAG HAS TO BE SHOWN
  if (deck_tags_list.contains("bdsm")) {

    return BdsmTagInfo(AppLocalizations.of(context)!.deck_bdsm_tag_label, Color(
        0xffa26558), Color(
        0xffa26558), true);

  } else {

    return BdsmTagInfo(AppLocalizations.of(context)!.deck_bondage_tag_label, Color(
        0xffa26558), Color(
        0xffa26558), false);

  }

}



//------------------------------------------------------------------------------













