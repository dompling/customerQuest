//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:loverquest/l10n/app_localization.dart';

//------------------------------------------------------------------------------



// FILTER DIALOG WIDGET INITIALIZATION
class QuestFilterDialog extends StatefulWidget {

  // SETTING FILTERS CALLBACK
  final Function(String, String, String) on_filter_selected;

  // CLASS CONSTRUCTOR
  const QuestFilterDialog({required this.on_filter_selected, super.key});

  @override
  QuestFilterDialogState createState() => QuestFilterDialogState();

}



//------------------------------------------------------------------------------



// FILTER DIALOG CONTENT
class QuestFilterDialogState extends State<QuestFilterDialog> {

  //------------------------------------------------------------------------------

  // SETTING THE ORDER, MOMENT TYPE AND TOOLS FILTER INITIAL VALUE
  String selected_option_order_type = 'ascending';
  String selected_option_moment_type = 'all';
  String selected_option_tools_filter = 'all';

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

            // ORDER TYPE FILTER SELECTOR
            SegmentedButton<String>(

              // DEFINING THE OPTIONS
              segments: <ButtonSegment<String>>[
                ButtonSegment(value: 'ascending', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_order_ascending_tag, textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
                ButtonSegment(value: 'descending', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_order_descending_tag, textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
              ],

              // SETTING THE SELECTED OPTION
              selected: {selected_option_order_type},

              // HIDING THE SELECTED ICON
              showSelectedIcon: false,

              // GETTING THE USER CHOICE
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  selected_option_order_type = newSelection.first;
                });
              },

            ),

            //------------------------------------------------------------------------------

            // SPACER
            SizedBox(height: 15),

            //------------------------------------------------------------------------------

            // MOMENT TYPE FILTER SELECTOR
            SegmentedButton<String>(

              // DEFINING THE OPTIONS
              segments: <ButtonSegment<String>>[
                ButtonSegment(value: 'all', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_all_tag, textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
                ButtonSegment(value: 'only_early', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_moment_early_tag, textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
                ButtonSegment(value: 'only_mid', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_moment_mid_tag, textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
                ButtonSegment(value: 'only_late', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_moment_late_tag, textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
                ButtonSegment(value: 'only_end', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_moment_end_tag, textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
              ],

              // SETTING THE SELECTED OPTION
              selected: {selected_option_moment_type},

              // HIDING THE SELECTED ICON
              showSelectedIcon: false,

              // GETTING THE USER CHOICE
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  selected_option_moment_type = newSelection.first;
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
                ButtonSegment(value: 'all', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_all_tag, textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
                ButtonSegment(value: 'with_tools', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_tools_with_tools_tag, textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
                ButtonSegment(value: 'without_tools', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_moment_without_tools_tag, textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
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
              widget.on_filter_selected(selected_option_order_type, selected_option_moment_type, selected_option_tools_filter);
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





















