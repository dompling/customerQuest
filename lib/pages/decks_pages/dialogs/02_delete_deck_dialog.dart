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

// CUSTOM FILES
import 'package:loverquest/logics/general/app_router_wrapper_classes.dart';
import 'package:loverquest/logics/decks_logics/04_deck_management_class.dart';
import 'package:provider/provider.dart';

//------------------------------------------------------------------------------

// FILTER DIALOG WIDGET INITIALIZATION
class DeckDeleteDialog extends StatefulWidget {

  // CLASS ATTRIBUTES
  final String deck_key;
  final String deck_name;

  // CLASS CONSTRUCTOR
  const DeckDeleteDialog({required this.deck_key, required this.deck_name, super.key});

  @override
  DeckDeleteDialogState createState() => DeckDeleteDialogState();

}

// FILTER DIALOG CONTENT
class DeckDeleteDialogState extends State<DeckDeleteDialog> {

  //------------------------------------------------------------------------------

  // ALERT DIALOG CONTENT
  @override
  Widget build(BuildContext context) {

    // DIALOG CONTENT
    return AlertDialog(

      // SETTING THE CORRECT PADDING
      insetPadding: EdgeInsets.symmetric(horizontal: 10),

      //DIALOG TITLE
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
              AppLocalizations.of(context)!.deck_management_delete_deck_dialog_title,

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

      // WIDGET CONTENT
      content: SingleChildScrollView(

        // SCROLLABLE VIEW CONTENT
        child: Column(

          // COLUMN CONTENT
          children: [

            //------------------------------------------------------------------------------

            // DECK DELETION MESSAGE
            Text(

              // TEXT
              AppLocalizations.of(context)!.deck_management_delete_deck_dialog_subtitle,

              // TEXT ALIGNMENT
              textAlign: TextAlign.center,

              // TEXT STYLE
              style: TextStyle(fontSize: 16,),),

            //------------------------------------------------------------------------------

            // SPACER
            SizedBox(height: 10),

            //------------------------------------------------------------------------------

            // DECK NAME
            Text(widget.deck_name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

            //------------------------------------------------------------------------------

          ],

        ),

      ),

      // DIALOG APPLY BUTTON
      actions: [

        // APPLY BUTTON BOX
        Row(

          // ALIGNMENT
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          // ALIGN CONTENT
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
  
              // BUTTON ACTION
              onPressed: () async {

                // DELETING THE DECK
                await DeckManagement.delete_custom_deck(widget.deck_key);

                // GETTING THE DATA FROM THE PROVIDER
                DeckPagesWrapper deck_wrapper_object = Provider.of<DeckWrapperProvider>(context, listen: false).wrapperData!;

                // REMOVING THE DECK FROM THE PROVIDER
                deck_wrapper_object.selected_deck = null;
                deck_wrapper_object.new_deck_creation = false;

                // SAVING THE WRAPPER DATA CONTENT INSIDE THE PROVIDER
                Provider.of<DeckWrapperProvider>(context, listen: false).updateWrapperData(deck_wrapper_object);

                // CLOSING THE DIALOG
                context.pop(true);

              },
  
              // BUTTON CONTENT
              child: Text(AppLocalizations.of(context)!.deck_management_delete_deck_dialog_yes_button_label),

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

              // BUTTON ACTION
              onPressed: () {

                // CLOSING THE DIALOG
                context.pop(false);

              },

              // BUTTON CONTENT
              child: Text(AppLocalizations.of(context)!.deck_management_delete_deck_dialog_no_button_label),

            ),

          ],
    
        ),

      ],

    );

  }

}