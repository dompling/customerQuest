//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:loverquest/l10n/app_localization.dart';

//------------------------------------------------------------------------------

// FUNCTION TO TRANSLATE IN MULTIPLE LANGUAGES THE DECKS/QUESTS TOOLS
List<String> translate_tools (BuildContext context,List<String> required_tools) {

  // GETTING THE LANGUAGE IN USE
  final localizations = AppLocalizations.of(context)!;

  // TRANSLATING THE TOOLS
  List<String> translated_tools_list = required_tools.map((tool) {

    switch (tool) {

      case 'female_lingerie':
        return localizations.quest_tool_female_lingerie;
      case 'male_lingerie':
        return localizations.quest_tool_male_lingerie;
      case 'blindfold':
        return localizations.quest_tool_blindfold;
      case 'rope':
        return localizations.quest_tool_rope;
      case 'handcuffs':
        return localizations.quest_tool_handcuffs;
      case 'dice':
        return localizations.quest_tool_dice;
      case 'vibrator':
        return localizations.quest_tool_vibrator;
      case 'remote_vibrator':
        return localizations.quest_tool_remote_vibrator;
      case 'anal_beads':
        return localizations.quest_tool_anal_beads;
      case 'dildo':
        return localizations.quest_tool_dildo;
      case 'inflatable_dildo':
        return localizations.quest_tool_inflatable_dildo;
      case 'suction_cup_dildo':
        return localizations.quest_tool_suction_cup_dildo;
      case 'vibrating_dildo':
        return localizations.quest_tool_vibrating_dildo;
      case 'gag':
        return localizations.quest_tool_gag;
      case 'feather':
        return localizations.quest_tool_feather;
      case 'plug':
        return localizations.quest_tool_plug;
      case 'inflatable_plug':
        return localizations.quest_tool_inflatable_plug;
      case 'vibrating_plug':
        return localizations.quest_tool_vibrating_plug;
      case 'candle':
        return localizations.quest_tool_candle;
      case 'collar_and_leash':
        return localizations.quest_tool_collar_and_leash;
      case 'massage_oil':
        return localizations.quest_tool_massage_oil;
      case 'lubricants':
        return localizations.quest_tool_lubricants;
      case 'strap_on':
        return localizations.quest_tool_strap_on;
      case 'nipple_clamps':
        return localizations.quest_tool_nipple_clamps;
      case 'nipple_pump':
        return localizations.quest_tool_nipple_pump;
      case 'riding_crop':
        return localizations.quest_tool_riding_crop;
      case 'flogger':
        return localizations.quest_tool_flogger;
      case 'spanking_paddle':
        return localizations.quest_tool_spanking_paddle;
      case 'male_chastity_cage':
        return localizations.quest_tool_male_chastity_cage;
      case 'female_chastity_cage':
        return localizations.quest_tool_female_chastity_cage;
      case 'ice':
        return localizations.quest_tool_ice;
      default:
        return tool;

    }
  }).toList();

  // IF THERE ARE NOT TOOLS INSIDE THE DECK/QUEST, SHOW A PROPER LABEL
  if (translated_tools_list.isEmpty) {
    translated_tools_list.add(localizations.deck_info_no_tools_label);
  }

  return translated_tools_list;

}













//------------------------------------------------------------------------------