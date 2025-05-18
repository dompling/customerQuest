//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loverquest/l10n/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

// CUSTOM FILES
import 'package:loverquest/logics/decks_logics/03_quest_class.dart';
import 'package:loverquest/logics/decks_logics/04_deck_management_class.dart';

import 'package:loverquest/logics/ui_logics/03_translate_tools_labels.dart';

import 'package:loverquest/logics/settings_logics/02_utility.dart';

import 'package:loverquest/logics/general/app_router_wrapper_classes.dart';

//------------------------------------------------------------------------------



// DECK SELECTION PAGE DEFINITION
class QuestEditPage extends StatefulWidget {

  // CLASS CONSTRUCTOR
  const QuestEditPage({super.key});

  // LINK TO CLASS STATE / WIDGET CONTENT
  @override
  State<QuestEditPage> createState() {
    return _QuestEditPageState();
  }

}

// CLASS STATE / WIDGET CONTENT
class _QuestEditPageState extends State<QuestEditPage> {

  //------------------------------------------------------------------------------

  // INITIALIZING THE DECK WRAPPER OBJECT VAR
  DeckPagesWrapper deck_wrapper_object = DeckPagesWrapper();

  // DEFINING PLAYERS NAMES TEXT FIELD TEXT CONTROLLER
  TextEditingController _quest_tool_controller = TextEditingController();
  TextEditingController _quest_timer_controller = TextEditingController();
  TextEditingController _quest_content_controller = TextEditingController();

  // DEFINING THE TOOL LIST VAR
  List<String> tools_list = [];

  // DEFINING THE TRANSLATED TOOL LIST VAR
  List<String> translated_tools_list = [];

  // DEFINING THE QUEST TIMER VAR
  int quest_timer = 0;

  // SETTING THE COUPLE TYPE AND GAME TYPE INITIAL VALUE
  String selected_option_quest_moment = 'early';

  // SETTING THE PLAYER TYPE INITIAL VALUE
  String selected_option_player_type = 'both';

  // INITIALIZING THE GLOBAL SWITCHES VARIABLES
  bool item_1 = false; bool item_2 = false; bool item_3 = false; bool item_4 = false;
  bool item_5 = false; bool item_6 = false; bool item_7 = false; bool item_8 = false;
  bool item_9 = false; bool item_10 = false; bool item_11 = false; bool item_12 = false;
  bool item_13 = false; bool item_14 = false; bool item_15 = false; bool item_16 = false;
  bool item_17 = false; bool item_18 = false; bool item_19 = false; bool item_20 = false;
  bool item_21 = false; bool item_22 = false; bool item_23 = false; bool item_24 = false;
  bool item_25 = false; bool item_26 = false; bool item_27 = false; bool item_28 = false;
  bool item_29 = false; bool item_30 = false; bool item_31 = false;

  //------------------------------------------------------------------------------

  // SHOWING THE CONFIRMATION OF QUEST DELETION
  Future<void> show_confirmation_dialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          // DIALOG TITLE
          title: Text(AppLocalizations.of(context)!.deck_management_delete_dialog_title, style: TextStyle(fontSize: 18.5,), textAlign: TextAlign.center,),

          // DIALOG CONTENT
          content: Text(AppLocalizations.of(context)!.deck_management_delete_dialog_subtitle, style: TextStyle(fontSize: 16,), textAlign: TextAlign.center,),

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
                    deck_wrapper_object.selected_deck!.quests.remove(deck_wrapper_object.selected_quest);

                    // SAVING THE MODIFIED DECK FILE
                    await DeckManagement.save_deck(
                      deck_name: deck_wrapper_object.selected_deck!.summary.name,
                      deck_description: deck_wrapper_object.selected_deck!.summary.description,
                      deck_language: deck_wrapper_object.selected_deck!.summary.language,
                      couple_type: deck_wrapper_object.selected_deck!.summary.couple_type,
                      play_presence: deck_wrapper_object.selected_deck!.summary.play_presence,
                      deck_tags: deck_wrapper_object.selected_deck!.summary.tags,
                      selected_deck: deck_wrapper_object.selected_deck,
                    );

                    // CHECKING IF THE INTERFACE IS STILL MOUNTED
                    if (!mounted) return;

                    // CLOSING THE DIALOG
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();

                  },

                  // BUTTON TEXT
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

                  // FUNCTION
                  onPressed: () {

                    // CLOSING THE DIALOG
                    Navigator.of(context).pop();

                  },

                  // BUTTON TEXT
                  child: Text(AppLocalizations.of(context)!.deck_management_delete_dialog_no_button_label),

                ),

              ],

            ),

          ],

        );

      },

    );

  }

  //------------------------------------------------------------------------------

  //
  @override
  void initState() {
    super.initState();

    // GETTING THE DATA FROM THE PROVIDER
    deck_wrapper_object = Provider.of<DeckWrapperProvider>(context, listen: false).wrapperData!;

    // IMPORTING PREVIOUS DATA IF PRESENT
    tools_list = deck_wrapper_object.selected_quest?.required_tools ?? [];
    selected_option_quest_moment = deck_wrapper_object.selected_quest?.moment ?? 'early';

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // TRANSLATING THE TOOLS LIST
    translated_tools_list = translate_tools(context, tools_list);

    // MAKING THE FIRST LETTER OF THE FIRST WORD UPPERCASE
    translated_tools_list[0] = translated_tools_list[0][0].toUpperCase() + translated_tools_list[0].substring(1);

    // SET-UPPING THE TEXT FIELD CONTROLLERS
    _quest_tool_controller = TextEditingController(text: translated_tools_list.join(", "));
    _quest_timer_controller = TextEditingController(text: deck_wrapper_object.selected_quest?.timer.toString() ?? "0");
    _quest_content_controller = TextEditingController(text: deck_wrapper_object.selected_quest?.content ?? "");

  }

  //RELEASING CONTROLLERS WHEN THE PAGE IS DISMISSED
  @override
  void dispose() {
    _quest_tool_controller.dispose();
    _quest_timer_controller.dispose();
    _quest_content_controller.dispose();
    super.dispose();
  }

  //------------------------------------------------------------------------------

  // CHECKING CONTINUE TO NEXT PAGE CONDITION
  Future<bool> check_and_save_quest() async {

    // INITIALIZING THE FIELDS VARIABLES
    quest_timer = int.tryParse(_quest_timer_controller.text) ?? 0;
    String quest_content = _quest_content_controller.text.trim();

    // CHECKING THAT ALL MANDATORY FIELDS HAS BEEN COMPILED
    if (quest_content == "" && quest_timer == 0 && selected_option_quest_moment == "early" && selected_option_player_type == "both") {

      return true;

    } else if (quest_content == "") {

      // SHOWING ERROR POPUP
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(

          // POP-UP CONTENT
          content: Row(

            // ALIGNMENT
            mainAxisAlignment: MainAxisAlignment.center,

            // SIZE
            mainAxisSize: MainAxisSize.max,

            // ROW CONTENT
            children: [

              // ERROR TEXT
              Flexible(

                child: Text(
                  // TEXT
                  AppLocalizations.of(context)!.define_players_name_error_label,

                  // TEXT STYLE
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color.fromRGBO(226, 226, 226, 1.0),
                  ),

                  // TEXT GO TO NEXT ROW
                  softWrap: true,

                  // MAX NUMBERS OF TEXT LINE
                  maxLines: 3,

                  // WHAT SHOW IF LONGER
                  overflow: TextOverflow.ellipsis,

                ),

              )

            ],

          ),

          // POP-UP DURATION
          duration: Duration(seconds: 4),

          // POP-UP BACKGROUND COLOR
          backgroundColor: Color.fromRGBO(73, 32, 32, 1.0),

        ),
      );

      return false;

    } else {

      try {
        
        // CHECKING IF THE QUEST IS AN EDITED ONE
        if (deck_wrapper_object.selected_quest != null) {
          
          // DELETING THE QUEST FROM THE LIST
          deck_wrapper_object.selected_deck!.quests.remove(deck_wrapper_object.selected_quest);
          
        }

        // CREATING A NEW QUEST
        Quest new_quest = Quest(
          moment: selected_option_quest_moment,
          required_tools: tools_list,
          player_type: selected_option_player_type,
          timer: quest_timer,
          content: quest_content,
        );

        // SAVING THE QUEST AND THE DECK
        await DeckManagement.save_quest(
          selected_deck: deck_wrapper_object.selected_deck!,
          new_quest: new_quest,
        );

        return true;

      } catch (e) {
        // ERROR
        return false;
      }

    }

  }

  //------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    //------------------------------------------------------------------------------

    // SHOW TOOLS SELECTION DIALOG
    Future<void> show_tools_dialog(BuildContext context) async {
      return showDialog<void>(
        context: context,
        builder: (context) {

          //------------------------------------------------------------------------------

          // USING A STATEFUL BUILDER IN ORDER TO CORRECTLY RENDER THE PAGE CHANGES
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateDialog) {

              // SYNCHRONIZING THE SWITCH LIST
              item_1 = tools_list.contains("female_lingerie");
              item_2 = tools_list.contains("male lingerie");
              item_3 = tools_list.contains("blindfold");
              item_4 = tools_list.contains("ropes");
              item_5 = tools_list.contains("handcuffs");
              item_6 = tools_list.contains("dice");
              item_7 = tools_list.contains("vibrator");
              item_8 = tools_list.contains("remote_vibrator");
              item_9 = tools_list.contains("anal_beads");
              item_10 = tools_list.contains("dildo");
              item_11 = tools_list.contains("inflatable_dildo");
              item_12 = tools_list.contains("suction_cup_dildo");
              item_13 = tools_list.contains("vibrating_dildo");
              item_14 = tools_list.contains("gag");
              item_15 = tools_list.contains("feather");
              item_16 = tools_list.contains("plug");
              item_17 = tools_list.contains("inflatable_plug");
              item_18 = tools_list.contains("vibrating_plug");
              item_19 = tools_list.contains("massage_candle");
              item_20 = tools_list.contains("collar_and_leash");
              item_21 = tools_list.contains("massage_oil");
              item_22 = tools_list.contains("lubricants");
              item_23 = tools_list.contains("strap_on");
              item_24 = tools_list.contains("nipple_clamps");
              item_25 = tools_list.contains("nipple_pump");
              item_26 = tools_list.contains("riding_crop");
              item_27 = tools_list.contains("flogger");
              item_28 = tools_list.contains("spanking_paddle");
              item_29 = tools_list.contains("male_chastity_cage");
              item_30 = tools_list.contains("female_chastity_cage");
              item_31 = tools_list.contains("ice");

              // DIALOG
              return Dialog(

                // DIALOG CONTENT
                child: Container(

                  // SETTING THE WIDTH LIMIT
                  constraints: BoxConstraints(maxWidth: 500),

                  // CONTAINER CONTENT
                  child: SingleChildScrollView(

                    // SCROLLABLE CONTAINER CONTENT
                      child: Container(

                        // PAGE PADDING
                        padding: EdgeInsets.all(10),

                        // PAGE ALIGNMENT
                        alignment: Alignment.topCenter,

                        // CONTAINER CONTENT
                        child: Column(

                          // SIZE
                          mainAxisSize: MainAxisSize.min,

                          // ALIGNMENT
                          crossAxisAlignment: CrossAxisAlignment.center,

                          // COLUMN CONTENT
                          children: [

                            //------------------------------------------------------------------------------

                            // SPACER
                            SizedBox(height: 15),

                            //------------------------------------------------------------------------------

                            // DIALOG TITLE
                            Text(

                              // TEXT
                              AppLocalizations.of(context)!.quest_editor_page_tools_dialog_title,

                              // ALIGNMENT
                              textAlign: TextAlign.center,

                              // STYLE
                              style: TextStyle(

                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,

                              ),

                            ),

                            //------------------------------------------------------------------------------

                            // SPACER
                            SizedBox(height: 15),

                            //------------------------------------------------------------------------------

                            // ITEM 1
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_female_lingerie.capitalize_first()),

                              // SWITCH VALUE
                              value: item_1,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_1 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("female_lingerie")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("female_lingerie");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("female_lingerie");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 2
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_male_lingerie.capitalize_first()),

                              // SWITCH VALUE
                              value: item_2,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_2 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("male_lingerie")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("male_lingerie");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("male_lingerie");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 3
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_blindfold.capitalize_first()),

                              // SWITCH VALUE
                              value: item_3,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_3 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("blindfold")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("blindfold");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("blindfold");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 4
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_rope.capitalize_first()),

                              // SWITCH VALUE
                              value: item_4,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_4 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("ropes")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("ropes");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("ropes");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 5
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_handcuffs.capitalize_first()),

                              // SWITCH VALUE
                              value: item_5,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_5 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("handcuffs")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("handcuffs");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("handcuffs");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 6
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_dice.capitalize_first()),

                              // SWITCH VALUE
                              value: item_6,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_6 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("dice")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("dice");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("dice");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 7
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_vibrator.capitalize_first()),

                              // SWITCH VALUE
                              value: item_7,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_7 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("vibrator")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("vibrator");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("vibrator");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 8
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_remote_vibrator.capitalize_first()),

                              // SWITCH VALUE
                              value: item_8,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_8 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("remote_vibrator")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("remote_vibrator");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("remote_vibrator");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 9
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_anal_beads.capitalize_first()),

                              // SWITCH VALUE
                              value: item_9,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_9 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("anal_beads")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("anal_beads");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("anal_beads");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 10
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_dildo.capitalize_first()),

                              // SWITCH VALUE
                              value: item_10,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_10 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("dildo")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("dildo");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("dildo");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 11
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_inflatable_dildo.capitalize_first()),

                              // SWITCH VALUE
                              value: item_11,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_11 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("inflatable_dildo")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("inflatable_dildo");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("inflatable_dildo");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 12
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_suction_cup_dildo.capitalize_first()),

                              // SWITCH VALUE
                              value: item_12,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_12 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("suction_cup_dildo")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("suction_cup_dildo");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("suction_cup_dildo");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 13
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_vibrating_dildo.capitalize_first()),

                              // SWITCH VALUE
                              value: item_13,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_13 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("vibrating_dildo")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("vibrating_dildo");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("vibrating_dildo");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 14
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_gag.capitalize_first()),

                              // SWITCH VALUE
                              value: item_14,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_14 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("gag")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("gag");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("gag");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 15
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_feather.capitalize_first()),

                              // SWITCH VALUE
                              value: item_15,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_15 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("feather")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("feather");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("feather");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 16
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_plug.capitalize_first()),

                              // SWITCH VALUE
                              value: item_16,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_16 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("plug")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("plug");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("plug");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 17
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_inflatable_plug.capitalize_first()),

                              // SWITCH VALUE
                              value: item_17,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_17 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("inflatable_plug")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("inflatable_plug");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("inflatable_plug");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 18
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_vibrating_plug.capitalize_first()),

                              // SWITCH VALUE
                              value: item_18,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_18 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("vibrating_plug")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("vibrating_plug");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("vibrating_plug");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 19
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_candle.capitalize_first()),

                              // SWITCH VALUE
                              value: item_19,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_19 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("candle")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("candle");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("candle");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 20
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_collar_and_leash.capitalize_first()),

                              // SWITCH VALUE
                              value: item_20,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_20 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("collar_and_leash")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("collar_and_leash");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("collar_and_leash");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 21
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_massage_oil.capitalize_first()),

                              // SWITCH VALUE
                              value: item_21,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_21 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("massage_oil")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("massage_oil");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("massage_oil");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 22
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_lubricants.capitalize_first()),

                              // SWITCH VALUE
                              value: item_22,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_22 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("lubricants")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("lubricants");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("lubricants");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 23
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_strap_on.capitalize_first()),

                              // SWITCH VALUE
                              value: item_23,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_23 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("strap_on")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("strap_on");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("strap_on");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 24
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_nipple_clamps.capitalize_first()),

                              // SWITCH VALUE
                              value: item_24,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_24 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("nipple_clamps")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("nipple_clamps");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("nipple_clamps");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 25
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_nipple_pump.capitalize_first()),

                              // SWITCH VALUE
                              value: item_25,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_25 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("nipple_pump")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("nipple_pump");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("nipple_pump");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 26
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_riding_crop.capitalize_first()),

                              // SWITCH VALUE
                              value: item_26,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_26 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("riding_crop")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("riding_crop");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("riding_crop");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 27
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_flogger.capitalize_first()),

                              // SWITCH VALUE
                              value: item_27,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_27 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("flogger")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("flogger");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("flogger");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 28
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_spanking_paddle.capitalize_first()),

                              // SWITCH VALUE
                              value: item_28,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_28 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("spanking_paddle")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("spanking_paddle");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("spanking_paddle");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 29
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_male_chastity_cage.capitalize_first()),

                              // SWITCH VALUE
                              value: item_29,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_29 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("male_chastity_cage")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("male_chastity_cage");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("male_chastity_cage");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 30
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_female_chastity_cage.capitalize_first()),

                              // SWITCH VALUE
                              value: item_30,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_30 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("female_chastity_cage")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("female_chastity_cage");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("female_chastity_cage");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // ITEM 31
                            SwitchListTile(

                              // SWITCH TITLE
                              title: Text(AppLocalizations.of(context)!.quest_tool_ice.capitalize_first()),

                              // SWITCH VALUE
                              value: item_31,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_31 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tools_list.contains("ice")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tools_list.remove("ice");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tools_list.add("ice");

                                  }

                                });
                              },

                              // SWITCH COLOR
                              activeColor: Theme.of(context).colorScheme.onSecondary,
                              activeTrackColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Theme.of(context).colorScheme.onSecondary,
                              inactiveTrackColor: Colors.black45,

                            ),

                            //------------------------------------------------------------------------------

                            // SPACER
                            SizedBox(height: 15),

                            //------------------------------------------------------------------------------

                            // DIALOG EXIT BUTTON
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

                                // UPDATING THE PAGE STATE
                                setState(() {

                                  // GETTING THE TRANSLATED TOOLS LIST
                                  translated_tools_list = translate_tools(context, tools_list);

                                  // MAKING THE FIRST LETTER OF THE FIRST WORD UPPERCASE
                                  translated_tools_list[0] = translated_tools_list[0][0].toUpperCase() + translated_tools_list[0].substring(1);

                                  // UPDATING THE TEXT FIELD
                                  _quest_tool_controller.text = translated_tools_list.join(", ");

                                });

                                // CLOSING THE DIALOG
                                Navigator.of(context).pop();
                              },

                              // BUTTON TEXT
                              child: Text(AppLocalizations.of(context)!.quest_editor_page_tools_dialog_save_button_label),

                            ),

                            //------------------------------------------------------------------------------

                          ],

                        ),


                      )

                  ),

                ),

              );

            },

          );

          //------------------------------------------------------------------------------

        },

      );

    }


    //------------------------------------------------------------------------------

    // PAGE CONTENT
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {

      // IF THE PAGE IS ALREADY CLOSE, DO NOTHING
      if (didPop) return;

      // SAVING DECK DATA
      bool success = await check_and_save_quest();

      // CHECKING IF THE INTERFACE IS STILL MOUNTED
      if (!mounted) return;

      // GOING BACK TO THE EDITOR MAIN PAGE
      if (success) {

        // EDITING THE WRAPPER WITH THE CORRECT VALUES
        deck_wrapper_object.show_delete_button = null;
        deck_wrapper_object.load_default_decks_flag = false;
        deck_wrapper_object.selected_quest = null;

        // SAVING THE WRAPPER DATA CONTENT INSIDE THE PROVIDER
        Provider.of<DeckWrapperProvider>(context, listen: false).updateWrapperData(deck_wrapper_object);

        // PAGE LINKER
        context.pushReplacement("/decks/editor_main");

      }

    },

      child: Scaffold(

        // APP BAR
        appBar: AppBar(

          // DEFINING THE ACTION BUTTONS
          actions: [

            // DELETE ICON BUTTON
            deck_wrapper_object.show_delete_button! ? IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {

                // SHOWING THE DELETE DIALOG
                await show_confirmation_dialog(context);

                // CHECKING IF THE CONTEXT IS STILL VALID
                if (!context.mounted) {return;}

                // EDITING THE WRAPPER WITH THE CORRECT VALUES
                deck_wrapper_object.show_delete_button = null;
                deck_wrapper_object.selected_quest = null;

                // SAVING THE WRAPPER DATA CONTENT INSIDE THE PROVIDER
                Provider.of<DeckWrapperProvider>(context, listen: false).updateWrapperData(deck_wrapper_object);

                // PAGE LINKER
                context.pushReplacement("/decks/editor_main");

              },

            ): SizedBox(),

          ],

        ),


        // SCAFFOLD CONTENT
        body: SafeArea(

          // SAFE AREA CONTENT
          child: Align(

            // ALIGNMENT
            alignment: Alignment.center,

            // ALIGN CONTENT
            child: Container(

              // SETTING THE WIDTH LIMIT
              constraints: BoxConstraints(maxWidth: 600),

              // PAGE PADDING
              padding: EdgeInsets.all(15),

              // PAGE ALIGNMENT
              alignment: Alignment.topCenter,

              // CONTAINER CONTENT
              child: SingleChildScrollView(

                // SCROLLABLE CONTAINER CONTENT
                child: Column(

                  // COLUMN CONTENT
                  children: [

                    //------------------------------------------------------------------------------

                    // SPACER
                    const SizedBox(height: 30),

                    //------------------------------------------------------------------------------

                    // PAGE LOGO
                    Image.asset(
                      'assets/images/deck_editor_icon.png',
                      width: 140,
                      height: 140,
                      fit: BoxFit.contain,
                    ),

                    //------------------------------------------------------------------------------

                    // SPACER
                    const SizedBox(height: 30),

                    //------------------------------------------------------------------------------

                    // PAGE TITLE CONTAINER
                    FractionallySizedBox(

                      // DYNAMIC WIDTH
                      widthFactor: 0.8,

                      // TITLE
                      child: Text(
                        // TEXT
                        AppLocalizations.of(context)!.quest_editor_page_title,

                        // TEXT ALIGNMENT
                        textAlign: TextAlign.center,

                        // TEXT STYLE
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,

                        ),
                      ),

                    ),

                    //------------------------------------------------------------------------------

                    // SPACER
                    const SizedBox(height: 15),

                    //------------------------------------------------------------------------------

                    // QUEST MOMENT LABEL AND QUEST MOMENT SEGMENTED BUTTON
                    Column(

                      // ALIGNMENT
                      crossAxisAlignment: CrossAxisAlignment.start,

                      // COLUMN CONTENT
                      children: [

                        // CARD TEXT
                        Text(
                          // TEXT
                          AppLocalizations.of(context)!.quest_editor_page_quest_type,

                          // TEXT STYLE
                          style: TextStyle(
                            fontSize: 18.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        //------------------------------------------------------------------------------

                        // SPACER
                        const SizedBox(height: 5),

                        //------------------------------------------------------------------------------

                        // COUPLE TYPE FILTER SELECTOR
                        SizedBox(

                          // WIDTH
                          width: double.infinity,

                          // CONTAINER CONTENT
                          child:  SegmentedButton<String>(

                            // DEFINING THE OPTIONS
                            segments: <ButtonSegment<String>>[
                              ButtonSegment(value: 'early', label: Text(AppLocalizations.of(context)!.quest_editor_page_quest_type_early, style: TextStyle(fontSize: 12))),
                              ButtonSegment(value: 'mid', label: Text(AppLocalizations.of(context)!.quest_editor_page_quest_type_mid, style: TextStyle(fontSize: 12))),
                              ButtonSegment(value: 'late', label: Text(AppLocalizations.of(context)!.quest_editor_page_quest_type_late, style: TextStyle(fontSize: 12))),
                              ButtonSegment(value: 'end', label: Text(AppLocalizations.of(context)!.quest_editor_page_quest_type_end, style: TextStyle(fontSize: 12))),
                            ],

                            // SETTING THE SELECTED OPTION
                            selected: {selected_option_quest_moment},

                            // HIDING THE SELECTED ICON
                            showSelectedIcon: false,

                            // GETTING THE USER CHOICE
                            onSelectionChanged: (Set<String> newSelection) {
                              setState(() {
                                selected_option_quest_moment = newSelection.first;
                              });
                            },

                          ),

                        ),

                        //------------------------------------------------------------------------------

                      ],

                    ),

                    //------------------------------------------------------------------------------

                    // SPACER
                    const SizedBox(height: 15),

                    //------------------------------------------------------------------------------

                    // QUEST REQUIRED TOOLS LABEL AND QUEST REQUIRED TOOLS TEXTBOX CONTAINER
                    Column(

                      // ALIGNMENT
                      crossAxisAlignment: CrossAxisAlignment.start,

                      // COLUMN CONTENT
                      children: [

                        // CARD TEXT
                        Text(
                          // TEXT
                          AppLocalizations.of(context)!.deck_info_information_requested_tools_label,

                          // TEXT STYLE
                          style: TextStyle(
                            fontSize: 18.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        //------------------------------------------------------------------------------

                        // SPACER
                        const SizedBox(height: 5),

                        //------------------------------------------------------------------------------

                        // CARD TEXT
                        TextField(

                          // TEXT CONTROLLER
                          controller: _quest_tool_controller,

                          // SETTING THE TEXT FIELD AD READ-ONLY
                          readOnly: true,

                          // ALLOWING THE TEXT FIELD DO GO MULTILINE
                          keyboardType: TextInputType.multiline,
                          maxLines: null,

                          // ON TAP FUNCTION
                          onTap: () {

                            show_tools_dialog(context).then((_) {

                              setState(() {

                                // GETTING THE TRANSLATED TOOLS LIST
                                translated_tools_list = translate_tools(context, tools_list);

                                // MAKING THE FIRST LETTER OF THE FIRST WORD UPPERCASE
                                translated_tools_list[0] = translated_tools_list[0][0].toUpperCase() + translated_tools_list[0].substring(1);

                                // UPDATING THE TEXT FIELD
                                _quest_tool_controller.text = translated_tools_list.join(", ");

                              });

                            });

                          },

                          // INPUT TEXT STYLING
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),

                          // TEXT FIELD STYLING
                          decoration: InputDecoration(

                            // HINT TEXT
                            hintText: AppLocalizations.of(context)!.deck_summary_editor_insert_text_hint,

                            // HINT TEXT STYLE
                            hintStyle: TextStyle(
                              fontSize: 13,
                              fontStyle: FontStyle.normal,
                            ),

                            // BORDER
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none
                            ),

                            // BACKGROUND COLOR
                            filled: true,
                            fillColor: Colors.grey[800],

                            // PADDING
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),

                          ),

                        ),

                        //------------------------------------------------------------------------------

                      ],

                    ),

                    //------------------------------------------------------------------------------

                    // SPACER
                    const SizedBox(height: 15),

                    //------------------------------------------------------------------------------

                    // QUEST PLAYER TYPE LABEL AND QUEST PLAYER TYPE SEGMENTED BUTTON
                    Column(

                      // ALIGNMENT
                      crossAxisAlignment: CrossAxisAlignment.start,

                      // COLUMN CONTENT
                      children: [

                        // CARD TEXT
                        Text(
                          // TEXT
                          AppLocalizations.of(context)!.quest_editor_page_player_type_title,

                          // TEXT STYLE
                          style: TextStyle(
                            fontSize: 18.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        //------------------------------------------------------------------------------

                        // SPACER
                        const SizedBox(height: 5),

                        //------------------------------------------------------------------------------

                        // COUPLE TYPE SELECTOR
                        SizedBox(

                          // WIDTH
                          width: double.infinity,

                          // CONTAINER CONTENT
                          child:  SegmentedButton<String>(

                            // DEFINING THE OPTIONS
                            segments: <ButtonSegment<String>>[
                              ButtonSegment(value: 'both', label: Text(AppLocalizations.of(context)!.quest_editor_page_player_type_both, style: TextStyle(fontSize: 12))),
                              ButtonSegment(value: 'male', label: Text(AppLocalizations.of(context)!.quest_editor_page_player_type_male, style: TextStyle(fontSize: 12))),
                              ButtonSegment(value: 'female', label: Text(AppLocalizations.of(context)!.quest_editor_page_player_type_female, style: TextStyle(fontSize: 12))),
                            ],

                            // SETTING THE SELECTED OPTION
                            selected: {selected_option_player_type},

                            // HIDING THE SELECTED ICON
                            showSelectedIcon: false,

                            // GETTING THE USER CHOICE
                            onSelectionChanged: (Set<String> newSelection) {
                              setState(() {
                                selected_option_player_type = newSelection.first;
                              });
                            },

                          ),

                        ),

                        //------------------------------------------------------------------------------

                      ],

                    ),

                    //------------------------------------------------------------------------------

                    // SPACER
                    const SizedBox(height: 15),

                    //------------------------------------------------------------------------------

                    // QUEST TIMER LABEL AND QUEST TIMER TEXTBOX CONTAINER
                    Column(

                      // ALIGNMENT
                      crossAxisAlignment: CrossAxisAlignment.start,

                      // COLUMN CONTENT
                      children: [

                        // CARD TEXT
                        Text(
                          // TEXT
                          AppLocalizations.of(context)!.quest_editor_page_quest_timer_label,

                          // TEXT STYLE
                          style: TextStyle(
                            fontSize: 18.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        //------------------------------------------------------------------------------

                        // SPACER
                        const SizedBox(height: 5),

                        //------------------------------------------------------------------------------

                        // CARD TEXT
                        TextField(

                          // TEXT CONTROLLER
                          controller: _quest_timer_controller,

                          // SETTING THE USE OF THE NUMBER KEYBOARD
                          keyboardType: TextInputType.number,

                          // ALLOWING ONLY THE INPUT OF INT NUMBERS
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],

                          // INPUT TEXT STYLING
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),

                          // TEXT FIELD STYLING
                          decoration: InputDecoration(

                            // HINT TEXT
                            hintText: AppLocalizations.of(context)!.deck_summary_editor_insert_text_hint,

                            // HINT TEXT STYLE
                            hintStyle: TextStyle(
                              fontSize: 13,
                              fontStyle: FontStyle.normal,
                            ),

                            // BORDER
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none
                            ),

                            // BACKGROUND COLOR
                            filled: true,
                            fillColor: Colors.grey[800],

                            // PADDING
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),

                          ),

                        ),

                        //------------------------------------------------------------------------------

                      ],

                    ),

                    //------------------------------------------------------------------------------

                    // SPACER
                    const SizedBox(height: 15),

                    //------------------------------------------------------------------------------

                    // DECK DESCRIPTION LABEL AND DECK DESCRIPTION TEXTBOX CONTAINER
                    Column(

                      // ALIGNMENT
                      crossAxisAlignment: CrossAxisAlignment.start,

                      // COLUMN CONTENT
                      children: [

                        // CARD TEXT
                        Text(
                          // TEXT
                          AppLocalizations.of(context)!.quest_editor_page_quest_content_label,

                          // TEXT STYLE
                          style: TextStyle(
                            fontSize: 18.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        //------------------------------------------------------------------------------

                        // SPACER
                        const SizedBox(height: 5),

                        //------------------------------------------------------------------------------

                        // CARD TEXT
                        TextField(

                          // TEXT CONTROLLER
                          controller: _quest_content_controller,

                          // ALLOWING THE TEXT FIELD DO GO MULTILINE
                          keyboardType: TextInputType.multiline,
                          maxLines: null,

                          // INPUT TEXT STYLING
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),

                          // TEXT FIELD STYLING
                          decoration: InputDecoration(

                            // HINT TEXT
                            hintText: AppLocalizations.of(context)!.deck_summary_editor_insert_text_hint,

                            // HINT TEXT STYLE
                            hintStyle: TextStyle(
                              fontSize: 13,
                              fontStyle: FontStyle.normal,
                            ),

                            // BORDER
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none
                            ),

                            // BACKGROUND COLOR
                            filled: true,
                            fillColor: Colors.grey[800],

                            // PADDING
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),

                          ),

                        ),

                        //------------------------------------------------------------------------------

                      ],

                    ),

                    //------------------------------------------------------------------------------

                    // SPACER
                    const SizedBox(height: 30),

                    //------------------------------------------------------------------------------

                    // BUTTON BOX
                    SizedBox(

                      // DYNAMIC SIZE
                      width: 180,

                      // BOX CONTENT
                      child: ElevatedButton(

                        // BUTTON STYLE PARAMETERS
                        style: ButtonStyle(

                          // NORMAL TEXT COLOR
                          foregroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onPrimary),

                          // NORMAL BACKGROUND COLOR
                          backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.secondary),

                          // MINIMUM SIZE
                          minimumSize: WidgetStateProperty.all(Size(100, 60)),

                          // PADDING
                          padding: WidgetStateProperty.all(EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15)),

                          // BORDER RADIUS
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),

                        ),

                        // ON PRESSED CALL
                        onPressed: () async {

                          // CHECKING ALIAS BEFORE GOING TO THE NEXT PAGE
                          bool success = await check_and_save_quest();

                          if (success) {

                            // EDITING THE WRAPPER WITH THE CORRECT VALUES
                            deck_wrapper_object.show_delete_button = null;
                            deck_wrapper_object.selected_quest = null;

                            // SAVING THE WRAPPER DATA CONTENT INSIDE THE PROVIDER
                            Provider.of<DeckWrapperProvider>(context, listen: false).updateWrapperData(deck_wrapper_object);

                            // PAGE LINKER
                            context.pushReplacement("/decks/editor_main");

                          }

                        },

                        // BUTTON CONTENT
                        child: Text(

                          // TEXT
                          AppLocalizations.of(context)!.define_players_name_confirm_button,

                          // TEXT ALIGNMENT
                          textAlign: TextAlign.center,

                          // TEXT STYLE
                          style: TextStyle(

                            fontSize: 15,
                            fontWeight: FontWeight.w500,

                          ),

                        ),

                      ),

                    ),

                    //------------------------------------------------------------------------------

                  ],

                ),

              ),

            ),

          ),

        ),

      ),

    );

    //------------------------------------------------------------------------------

  }

}

//------------------------------------------------------------------------------