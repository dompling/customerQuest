//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:loverquest/l10n/app_localization.dart';

//------------------------------------------------------------------------------



// FILTER DIALOG WIDGET INITIALIZATION
class DeckFilterDialog extends StatefulWidget {

  // SETTING FILTERS CALLBACK
  final Function(String, String) on_filter_selected;

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

  //------------------------------------------------------------------------------

  // ALERT DIALOG CONTENT
  @override
  Widget build(BuildContext context) {

    // DIALOG CONTENT
    return AlertDialog(

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
              widget.on_filter_selected(selected_option_couple_type, selected_option_game_type);
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





















