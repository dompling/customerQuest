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
import 'package:go_router/go_router.dart';
import 'package:loverquest/logics/decks_logics/01_deck_reader_class.dart';
import 'package:provider/provider.dart';

// CUSTOM FILES
import 'package:loverquest/logics/decks_logics/03_quest_class.dart';
import 'package:loverquest/logics/decks_logics/04_deck_management_class.dart';

import 'package:loverquest/logics/general/app_router_wrapper_classes.dart';

//------------------------------------------------------------------------------

// FILTER DIALOG WIDGET INITIALIZATION
class DeleteQuestDialog extends StatefulWidget {

  // CLASS ATTRIBUTES
  final DeckReader deck;
  final Quest selected_quest;

  // CLASS CONSTRUCTOR
  const DeleteQuestDialog({required this.deck, required this.selected_quest, super.key});

  @override
  DeleteQuestDialogState createState() => DeleteQuestDialogState();

}

// FILTER DIALOG CONTENT
class DeleteQuestDialogState extends State<DeleteQuestDialog> {

  //------------------------------------------------------------------------------

  // INITIALIZING THE DECK WRAPPER OBJECT VAR
  DeckPagesWrapper deck_wrapper_object = DeckPagesWrapper();

  //------------------------------------------------------------------------------

  // ALERT DIALOG CONTENT
  @override
  Widget build(BuildContext context) {

    // DIALOG CONTENT
    return AlertDialog(

      // SETTING THE CORRECT PADDING
      insetPadding: EdgeInsets.symmetric(horizontal: 10),

      // DIALOG TITLE
      title: Row(

        // ALIGNMENT
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          // ICON
          Icon(Icons.warning_amber, color: Colors.white, size: 25),

          // SPACER
          SizedBox(width: 10),

          // TEXT CONTAINER
          Flexible(

            child: Text(

              // TEXT
              AppLocalizations.of(context)!.deck_management_delete_quest_dialog_title,

              // TEXT ALIGNMENT
              textAlign: TextAlign.center,

              // TEXT STYLE
              style: TextStyle(

                fontSize: 20,
                fontWeight: FontWeight.bold,

              ),

            ),

          ),

        ],

      ),

      // DIALOG CONTENT
      content: SingleChildScrollView(

        // SCROLLABLE VIEW CONTENT
        child: Column(

          // COLUMN CONTENT
          children: [

            //------------------------------------------------------------------------------

            // DECK DELETION MESSAGE
            Text(

              // TEXT
              AppLocalizations.of(context)!.deck_management_delete_quest_dialog_subtitle,

              // TEXT ALIGNMENT
              textAlign: TextAlign.center,

              // TEXT STYLE
              style: TextStyle(fontSize: 16,),),

            //------------------------------------------------------------------------------

            // SPACER
            SizedBox(height: 10),

            //------------------------------------------------------------------------------

            // DECK NAME
            Text(widget.selected_quest.content, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

            //------------------------------------------------------------------------------

          ],

        ),

      ),

      // DIALOG BUTTONS
      actions: [

        // BUTTONS ROW
        Row(

          // ALIGNMENT
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          // ROW CONTENT
          children: [

            // YES BUTTON
            TextButton(

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

              // FUNCTION
              onPressed: () async {

                // REMOVING THE QUEST FROM THE LIST
                widget.deck.quests.remove(widget.selected_quest);

                // SAVING THE MODIFIED DECK FILE
                String new_deck_key = await DeckManagement.save_deck(
                  deck_name: widget.deck.summary.name,
                  deck_description: widget.deck.summary.description,
                  deck_language: widget.deck.summary.language,
                  couple_type: widget.deck.summary.couple_type,
                  play_presence: widget.deck.summary.play_presence,
                  deck_tags: widget.deck.summary.tags,
                  already_existing_deck: widget.deck,
                );

                // LOADING THE NEW DECK INFO
                DeckReader edited_deck = DeckReader(new_deck_key);
                await edited_deck.load_deck();

                // EDITING THE WRAPPER WITH THE CORRECT VALUES
                deck_wrapper_object.load_default_decks_flag = false;
                deck_wrapper_object.selected_deck = edited_deck;
                deck_wrapper_object.show_delete_button = null;
                deck_wrapper_object.selected_quest = null;

                // SAVING THE WRAPPER DATA CONTENT INSIDE THE PROVIDER
                Provider.of<DeckWrapperProvider>(context, listen: false).updateWrapperData(deck_wrapper_object);

                // CLOSING THE DIALOG
                context.pop(true);

              },

              // BUTTON TEXT
              child: Text(AppLocalizations.of(context)!.deck_management_delete_quest_dialog_yes_button_label),

            ),

            // NO BUTTON
            TextButton(

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

              // FUNCTION
              onPressed: () {

                // CLOSING THE DIALOG
                context.pop(false);

              },

              // BUTTON TEXT
              child: Text(AppLocalizations.of(context)!.deck_management_delete_quest_dialog_no_button_label),

            ),

          ],

        ),

      ],

    );

  }

}
