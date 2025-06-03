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
import 'package:loverquest/l10n/app_localization.dart';

//------------------------------------------------------------------------------

// FUNCTION TO TRANSLATE IN MULTIPLE LANGUAGES THE DECKS/QUESTS TOOLS
List<String> translate_tags (BuildContext context,List<String> tags) {

  // GETTING THE LANGUAGE IN USE
  final localizations = AppLocalizations.of(context)!;

  // TRANSLATING THE TOOLS
  List<String> translated_tags_list = tags.map((tool) {

    switch (tool) {

      case 'oral_sex':
        return localizations.tags_list_oral_sex_tag;
      case 'anal_sex':
        return localizations.tags_list_anal_sex_tag;
      case 'vaginal_sex':
        return localizations.tags_list_vaginal_sex_tag;
      case 'bondage':
        return localizations.tags_list_bondage_tag;
      case 'bdsm':
        return localizations.tags_list_bdsm_tag;
      case 'chat':
        return localizations.tags_list_chat_tag;
      case 'video_call':
        return localizations.tags_list_video_chat_tag;

      default:
        return tool;

    }
  }).toList();

  // IF THERE ARE NOT TOOLS INSIDE THE DECK/QUEST, SHOW A PROPER LABEL
  if (translated_tags_list.isEmpty) {
    translated_tags_list.add(localizations.deck_info_no_tools_label);
  }

  return translated_tags_list;

}













//------------------------------------------------------------------------------