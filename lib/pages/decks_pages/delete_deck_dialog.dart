//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:loverquest/l10n/app_localization.dart';

// CUSTOM FILES
import 'package:loverquest/logics/decks_logics/delete_decks.dart';
//import 'package:loverquest/pages/decks_pages/deck_management_page.dart';

//------------------------------------------------------------------------------



// FILTER DIALOG WIDGET INITIALIZATION
class DeckDeleteDialog extends StatefulWidget {

  // CLASS ATTRIBUTES
  final String deck_file_path;
  final String deck_name;

  // CLASS CONSTRUCTOR
  const DeckDeleteDialog({required this.deck_file_path, required this.deck_name, super.key});

  @override
  DeckDeleteDialogState createState() => DeckDeleteDialogState();

}



//------------------------------------------------------------------------------



// FILTER DIALOG CONTENT
class DeckDeleteDialogState extends State<DeckDeleteDialog> {

  //------------------------------------------------------------------------------

  // ALERT DIALOG CONTENT
  @override
  Widget build(BuildContext context) {

    // DIALOG CONTENT
    return AlertDialog(

      //DIALOG TITLE
      title: Text(

        // TEXT
        AppLocalizations.of(context)!.deck_management_delete_dialog_title,

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

            // DECK DELETION MESSAGE
            Text(AppLocalizations.of(context)!.deck_management_delete_dialog_subtitle, style: TextStyle(fontSize: 16,),),

            //------------------------------------------------------------------------------

            // SPACER
            SizedBox(height: 5,),

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

                // CLOSING THE DIALOG
                Navigator.of(context).pop();

                // DELETING THE DECK
                await deleteFile(widget.deck_file_path);

              },
  
              // BUTTON CONTENT
              child: Text(AppLocalizations.of(context)!.deck_management_delete_dialog_yes_button_label),

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
                Navigator.of(context).pop();
              },

              // BUTTON CONTENT
              child: Text(AppLocalizations.of(context)!.deck_management_delete_dialog_no_button_label),

            ),

          ],
    
        ),

      ],

    );

  }

}



//------------------------------------------------------------------------------





















