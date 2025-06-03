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

// POSSIBLE COUPLE TYPES:
// all
// hetero
// lesbian
// gay

// POSSIBLE GAME TYPES:
// both
// presence
// distance

// POSSIBLE TOOLS FILTER TYPES:
// all
// with_tools
// without_tools

// POSSIBLE CHAT FILTER TYPES:
// all
// chat
// videochat

// POSSIBLE DIFFICULTY FILTER TYPES:
// all
// beginner
// intermediate
// advanced

//------------------------------------------------------------------------------

// FILTER DIALOG WIDGET INITIALIZATION
class DeckFilterDialog extends StatefulWidget {

  // SETTING FILTERS CALLBACK
  final Function(String, String, String, String, String) on_filter_selected;

  // CLASS CONSTRUCTOR
  const DeckFilterDialog({required this.on_filter_selected, super.key});

  @override
  DeckFilterDialogState createState() => DeckFilterDialogState();

}



//------------------------------------------------------------------------------



// FILTER DIALOG CONTENT
class DeckFilterDialogState extends State<DeckFilterDialog> {

  //------------------------------------------------------------------------------

  // SETTING THE COUPLE TYPE AND GAME TYPE INITIAL VALUE
  String selected_option_couple_type = 'all';
  String selected_option_game_type = 'both';
  String selected_option_tools_filter = 'all';
  String selected_option_chat_filter = 'all';
  String selected_option_difficulty = 'all';

  //------------------------------------------------------------------------------

  // ALERT DIALOG CONTENT
  @override
  Widget build(BuildContext context) {

    // DIALOG CONTENT
    return AlertDialog(

      // SETTING THE CORRECT PADDING
      insetPadding: EdgeInsets.symmetric(horizontal: 10),

      //DIALOG TITLE
      title: Text(

        // TEXT
        AppLocalizations.of(context)!.deck_filter_dialog_title,

        // ALIGNMENT
        textAlign: TextAlign.center,

      ),

      // WIDGET CONTENT
      content: SingleChildScrollView(

        // SCROLLABLE VIEW CONTENT
        child: Column(

          // COLUMN CONTENT
          children: [

            //------------------------------------------------------------------------------

            // COUPLE TYPE FILTER SELECTOR
            SegmentedButton<String>(

              // DEFINING THE OPTIONS
              segments: <ButtonSegment<String>>[
                ButtonSegment(value: 'hetero', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_hetero_tag, style: TextStyle(fontSize: 12))),
                ButtonSegment(value: 'lesbian', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_lesbian_tag, style: TextStyle(fontSize: 12))),
                ButtonSegment(value: 'gay', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_gay_tag, style: TextStyle(fontSize: 12))),
                ButtonSegment(value: 'all', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_all_tag, style: TextStyle(fontSize: 12))),
              ],

              // SETTING THE SELECTED OPTION
              selected: {selected_option_couple_type},

              // HIDING THE SELECTED ICON
              showSelectedIcon: false,

              // GETTING THE USER CHOICE
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  selected_option_couple_type = newSelection.first;
                });
              },

            ),

            //------------------------------------------------------------------------------

            // SPACER
            SizedBox(height: 15),

            //------------------------------------------------------------------------------

            // GAME TYPE FILTER SELECTOR
            SegmentedButton<String>(

              // DEFINING THE OPTIONS
              segments: <ButtonSegment<String>>[
                ButtonSegment(value: 'presence', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_presence_tag, style: TextStyle(fontSize: 12))),
                ButtonSegment(value: 'distance', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_distance_tag, style: TextStyle(fontSize: 12))),
                ButtonSegment(value: 'both', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_all_tag, style: TextStyle(fontSize: 12))),
              ],

              // SETTING THE SELECTED OPTION
              selected: {selected_option_game_type},

              // HIDING THE SELECTED ICON
              showSelectedIcon: false,

              // GETTING THE USER CHOICE
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  selected_option_game_type = newSelection.first;
                });
              },

            ),

            //------------------------------------------------------------------------------

            // SPACER
            SizedBox(height: 15),

            //------------------------------------------------------------------------------

            // TOOLS FILTER SELECTOR
            SegmentedButton<String>(

              // DEFINING THE OPTIONS
              segments: <ButtonSegment<String>>[
                ButtonSegment(value: 'all', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_all_tag, style: TextStyle(fontSize: 12))),
                ButtonSegment(value: 'with_tools', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_with_tools_tag, style: TextStyle(fontSize: 12))),
                ButtonSegment(value: 'without_tools', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_without_tools_tag, style: TextStyle(fontSize: 12))),
              ],

              // SETTING THE SELECTED OPTION
              selected: {selected_option_tools_filter},

              // HIDING THE SELECTED ICON
              showSelectedIcon: false,

              // GETTING THE USER CHOICE
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  selected_option_tools_filter = newSelection.first;
                });
              },

            ),

            //------------------------------------------------------------------------------

            // SPACER
            SizedBox(height: 15),

            //------------------------------------------------------------------------------

            // CHAT FILTER SELECTOR
            SegmentedButton<String>(

              // DEFINING THE OPTIONS
              segments: <ButtonSegment<String>>[
                ButtonSegment(value: 'all', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_all_tag, style: TextStyle(fontSize: 12))),
                ButtonSegment(value: 'chat', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_chat_only_tag, style: TextStyle(fontSize: 12))),
                ButtonSegment(value: 'videochat', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_videochat_only_tag, style: TextStyle(fontSize: 12))),
              ],

              // SETTING THE SELECTED OPTION
              selected: {selected_option_chat_filter},

              // HIDING THE SELECTED ICON
              showSelectedIcon: false,

              // GETTING THE USER CHOICE
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  selected_option_chat_filter = newSelection.first;
                });
              },

            ),

            //------------------------------------------------------------------------------

            // SPACER
            SizedBox(height: 15),

            //------------------------------------------------------------------------------
            /*
            // DIFFICULTY FILTER SELECTOR
            SegmentedButton<String>(

              // DEFINING THE OPTIONS
              segments: <ButtonSegment<String>>[
                ButtonSegment(value: 'all', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_all_tag, style: TextStyle(fontSize: 12))),
                ButtonSegment(value: 'beginner', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_beginner_tag, style: TextStyle(fontSize: 12))),
                ButtonSegment(value: 'intermediate', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_intermediate_tag, style: TextStyle(fontSize: 12))),
                ButtonSegment(value: 'advanced', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_advanced_tag, style: TextStyle(fontSize: 12))),
              ],

              // SETTING THE SELECTED OPTION
              selected: {selected_option_difficulty},

              // HIDING THE SELECTED ICON
              showSelectedIcon: false,

              // GETTING THE USER CHOICE
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  selected_option_difficulty = newSelection.first;
                });
              },

            ),
            */
            //------------------------------------------------------------------------------

          ],

        ),

      ),

      // DIALOG APPLY BUTTON
      actions: [

        // APPLY BUTTON BOX
        Align(

          // ALIGNMENT
          alignment: Alignment.center,

          // ALIGN CONTENT
          child: TextButton(

            // BUTTON STYLE PARAMETERS
            style: ButtonStyle(

              // NORMAL TEXT COLOR
              foregroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onPrimary),

              // NORMAL BACKGROUND COLOR
              backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.secondary),

              // PADDING
              padding: WidgetStateProperty.all(EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5)),

              // BORDER RADIUS
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),

            ),

            // BUTTON ACTION
            onPressed: () {
              widget.on_filter_selected(selected_option_couple_type, selected_option_game_type, selected_option_tools_filter, selected_option_chat_filter, selected_option_difficulty);
              Navigator.of(context).pop();
            },

            // BUTTON CONTENT
            child: Text(AppLocalizations.of(context)!.deck_filter_apply_filter_button),

          ),

        ),

      ],

    );

  }

}



//------------------------------------------------------------------------------





















