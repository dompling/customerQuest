//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:loverquest/l10n/app_localization.dart';

// CUSTOM FILES
import 'package:loverquest/logics/decks_logics/deck_and_quests_reader.dart';
import 'package:loverquest/logics/decks_logics/deck_ui_conversion.dart';
import 'package:loverquest/logics/decks_logics/save_deck.dart';
import 'package:loverquest/logics/decks_logics/translate_tags.dart';
import 'package:loverquest/pages/decks_pages/deck_editor_main_page.dart';
import 'package:loverquest/logics/settings_logics/utility.dart';


//------------------------------------------------------------------------------



// DECK SELECTION PAGE DEFINITION
class DeckSummaryEditPage extends StatefulWidget {

  // CLASS ATTRIBUTES
  final DeckReader? selected_deck;

  // CLASS CONSTRUCTOR
  const DeckSummaryEditPage({
    this.selected_deck,
    super.key,
  });

  // LINK TO CLASS STATE / WIDGET CONTENT
  @override
  State<DeckSummaryEditPage> createState() {
    return _DeckSummaryEditPageState();
  }

}



//------------------------------------------------------------------------------



// CLASS STATE / WIDGET CONTENT
class _DeckSummaryEditPageState extends State<DeckSummaryEditPage> {

  //------------------------------------------------------------------------------

  // INITIALIZING THE DECK FILE PATH
  String saved_file_path = "";

  //------------------------------------------------------------------------------

  // DEFINING PLAYERS NAMES TEXT FIELD TEXT CONTROLLER
  late TextEditingController _deck_name_controller;
  late TextEditingController _deck_language_controller;
  late TextEditingController _deck_description_controller;
  late TextEditingController _deck_tag_controller;

  //------------------------------------------------------------------------------

  // DEFINING THE LANGUAGE LABEL VAR
  late LanguageInfo language_object = get_language_info(context, "en");

  //------------------------------------------------------------------------------

  // SETTING THE COUPLE TYPE AND GAME TYPE INITIAL VALUE
  String selected_option_couple_type = 'hetero';
  bool selected_option_game_type = false;

  //------------------------------------------------------------------------------

  // DEFINING THE TAGS LIST VAR
  List<String> tag_list = [];

  // DEFINING THE TRANSLATED TAGS LIST VAR
  List<String> translated_tags_list = [];
  
  //------------------------------------------------------------------------------

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

  // RELEASING CONTROLLERS WHEN THE PAGE IS DISMISSED
  @override
  void initState() {
    super.initState();

    // SET-UPPING THE TEXT FIELD CONTROLLERS
    _deck_name_controller = TextEditingController();
    _deck_language_controller = TextEditingController();
    _deck_description_controller = TextEditingController();
    _deck_tag_controller = TextEditingController();

  }

  @override
  void dispose() {
    _deck_name_controller.dispose();
    _deck_language_controller.dispose();
    _deck_description_controller.dispose();
    _deck_tag_controller.dispose();
    super.dispose();
  }

  //------------------------------------------------------------------------------

  // CLASS INITIAL STATE
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.selected_deck != null) {

      // GETTING THE CORRECT LANGUAGE LABEL
      language_object = get_language_info(context, widget.selected_deck?.summary.language ?? "");

      // SET-UPPING THE TEXT FIELD CONTROLLERS
      _deck_name_controller.text = widget.selected_deck?.summary.name ?? "";
      _deck_language_controller.text = language_object.label;
      _deck_description_controller.text =  widget.selected_deck?.summary.description ?? "";
      //_deck_tag_controller.text = widget.selected_deck?.summary.tags.join(", ") ?? "";

      // GETTING THE TAGS INFO
      tag_list = widget.selected_deck?.summary.tags ?? [];

    }


    // TRANSLATING THE TAG LIST
    translated_tags_list = translate_tags(context, tag_list);

    // MAKING THE FIRST LETTER OF THE FIRST WORD UPPERCASE
    translated_tags_list[0] = translated_tags_list[0][0].toUpperCase() + translated_tags_list[0].substring(1);

    // WRITING THE TAG LIST IN THE FIELD
    _deck_tag_controller.text = translated_tags_list.join(", ");

  }

  //------------------------------------------------------------------------------

  // CHECKING CONTINUE TO NEXT PAGE CONDITION
  Future<bool> data_check_to_go() async {

    // INITIALIZING THE NECESSARY VARIABLES
    String deck_name_field = _deck_name_controller.text.trim();
    String deck_description_field = _deck_description_controller.text.trim();

    // CHECKING IF ALL THE FIELD HAVE BEEN COMPILED
    if ((deck_name_field == "") && (deck_description_field == "")) {

      return true;

    } else if (((deck_name_field == "") || (deck_description_field == ""))) {

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

        // LOADING THE MODIFIED DECK FILE
        saved_file_path = await DeckSaver.save_deck(
          deck_name: deck_name_field,
          deck_description: deck_description_field,
          deck_language: language_object.language_code,
          couple_type: selected_option_couple_type,
          play_presence: selected_option_game_type,
          deck_tags: tag_list,
          selected_deck: widget.selected_deck,
        );

        // CHECKING IF THERE IS A PREVIOUS PASSED DECK
        if (widget.selected_deck == null) {

          // LOADING THE NEW DECK INFO
          DeckReader new_deck = DeckReader(saved_file_path);
          await new_deck.load_deck();

          // CHECKING IF THE INTERFACE IS STILL MOUNTED
          if (!mounted) return false;

          // GOING TO THE MAIN EDIT PAGE WITH THE NEW DECK INFO
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DeckEditMainPage(selected_deck: new_deck)),
          );

          return false;

        }
        return true;


      } catch (e) {
        // SHOWING AN ERROR
        return false;
      }

    }

  }

  //------------------------------------------------------------------------------



    @override
  Widget build(BuildContext context) {

    //------------------------------------------------------------------------------

    // CHOOSE LANGUAGE DIALOG CONTENT
    void show_language_dialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) {

          // DIALOG CONTENT
          return AlertDialog(

            // DIALOG TITLE
            title: Text(AppLocalizations.of(context)!.settings_main_page_language_button_label, textAlign: TextAlign.center,),

            // DIALOG CONTENT
            content: SingleChildScrollView(

              // SCROLLABLE VIEW CONTENT
              child: Column(

                // SIZE
                mainAxisSize: MainAxisSize.min,

                //COLUMN CONTENT
                children: [

                  //------------------------------------------------------------------------------

                  // ENGLISH OPTION
                  ListTile(

                    // LANGUAGE LABEL
                    title: Text(AppLocalizations.of(context)!.deck_language_en, textAlign: TextAlign.center,),

                    // ON TAP FUNCTION CALL
                    onTap: () {

                      setState(() {

                        // SETTING THE LANGUAGE LABEL
                        language_object = get_language_info(context, "en");
                        _deck_language_controller = TextEditingController(text: language_object.label);

                      });

                      Navigator.pop(context);

                      },

                  ),

                  //------------------------------------------------------------------------------

                  // ITALIAN OPTION
                  ListTile(

                    // LANGUAGE LABEL
                    title: Text(AppLocalizations.of(context)!.deck_language_it, textAlign: TextAlign.center,),

                    // ON TAP FUNCTION CALL
                    onTap: () {

                      setState(() {

                        // SETTING THE LANGUAGE LABEL
                        language_object = get_language_info(context, "it");
                        _deck_language_controller = TextEditingController(text: language_object.label);

                      });

                      Navigator.pop(context);

                    },

                  ),

                  //------------------------------------------------------------------------------

                  // FRENCH OPTION
                  ListTile(

                    // LANGUAGE LABEL
                    title: Text(AppLocalizations.of(context)!.deck_language_fr, textAlign: TextAlign.center,),

                    // ON TAP FUNCTION CALL
                    onTap: () {

                      setState(() {

                        // SETTING THE LANGUAGE LABEL
                        language_object = get_language_info(context, "fr");
                        _deck_language_controller = TextEditingController(text: language_object.label);

                      });

                      Navigator.pop(context);

                    },

                  ),

                  //------------------------------------------------------------------------------

                  // SPANISH OPTION
                  ListTile(

                    // LANGUAGE LABEL
                    title: Text(AppLocalizations.of(context)!.deck_language_es, textAlign: TextAlign.center,),

                    // ON TAP FUNCTION CALL
                    onTap: () {

                      setState(() {

                        // SETTING THE LANGUAGE LABEL
                        language_object = get_language_info(context, "es");
                        _deck_language_controller = TextEditingController(text: language_object.label);

                      });

                      Navigator.pop(context);

                    },

                  ),

                  //------------------------------------------------------------------------------

                  // GERMAN OPTION
                  ListTile(

                    // LANGUAGE LABEL
                    title: Text(AppLocalizations.of(context)!.deck_language_de, textAlign: TextAlign.center,),

                    // ON TAP FUNCTION CALL
                    onTap: () {

                      setState(() {

                        // SETTING THE LANGUAGE LABEL
                        language_object = get_language_info(context, "de");
                        _deck_language_controller = TextEditingController(text: language_object.label);

                      });

                      Navigator.pop(context);

                    },

                  ),

                  //------------------------------------------------------------------------------

                  // DUTCH OPTION
                  ListTile(

                    // LANGUAGE LABEL
                    title: Text(AppLocalizations.of(context)!.deck_language_nl, textAlign: TextAlign.center,),

                    // ON TAP FUNCTION CALL
                    onTap: () {

                      setState(() {

                        // SETTING THE LANGUAGE LABEL
                        language_object = get_language_info(context, "nl");
                        _deck_language_controller = TextEditingController(text: language_object.label);

                      });

                      Navigator.pop(context);

                    },

                  ),

                  //------------------------------------------------------------------------------

                ],

              ),

            ),

          );

        },

      );

    }

    //------------------------------------------------------------------------------
    
    // SHOW TOOLS SELECTION DIALOG
    Future<void> show_tags_dialog(BuildContext context) async {
      return showDialog<void>(
        context: context,
        builder: (context) {

          //------------------------------------------------------------------------------

          // SYNCHRONIZING THE SWITCH LIST
          item_1 = tag_list.contains("oral_sex");
          item_2 = tag_list.contains("anal_sex");
          item_3 = tag_list.contains("vaginal_sex");
          item_4 = tag_list.contains("bondage");
          item_5 = tag_list.contains("bdsm");

          //------------------------------------------------------------------------------

          // USING A STATEFUL BUILDER IN ORDER TO CORRECTLY RENDER THE PAGE CHANGES
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateDialog) {

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
                              title: Text(AppLocalizations.of(context)!.tags_list_oral_sex_tag.capitalize_first()),

                              // SWITCH VALUE
                              value: item_1,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_1 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tag_list.contains("oral_sex")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tag_list.remove("oral_sex");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tag_list.add("oral_sex");

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
                              title: Text(AppLocalizations.of(context)!.tags_list_anal_sex_tag.capitalize_first()),

                              // SWITCH VALUE
                              value: item_2,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_2 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tag_list.contains("anal_sex")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tag_list.remove("anal_sex");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tag_list.add("anal_sex");

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
                              title: Text(AppLocalizations.of(context)!.tags_list_vaginal_sex_tag.capitalize_first()),

                              // SWITCH VALUE
                              value: item_3,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_3 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tag_list.contains("vaginal_sex")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tag_list.remove("vaginal_sex");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tag_list.add("vaginal_sex");

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
                              title: Text(AppLocalizations.of(context)!.tags_list_bondage_tag.capitalize_first()),

                              // SWITCH VALUE
                              value: item_4,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_4 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tag_list.contains("bondage")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tag_list.remove("bondage");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tag_list.add("bondage");

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
                              title: Text(AppLocalizations.of(context)!.tags_list_bdsm_tag.capitalize_first()),

                              // SWITCH VALUE
                              value: item_5,

                              // SWITCH FUNCTION
                              onChanged: (bool value) {
                                setStateDialog(() {
                                  item_5 = value;

                                  // CHECKING IF THE TOOL IS ALREADY INSIDE THE TOOL LIST
                                  if (tag_list.contains("bdsm")) {

                                    // DELETING THE TOOL FROM TO THE TOOL LIST
                                    tag_list.remove("bdsm");

                                  } else {

                                    // ADDING THE TOOL TO THE TOOL LIST
                                    tag_list.add("bdsm");

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
                                  translated_tags_list = translate_tags(context, tag_list);

                                  // MAKING THE FIRST LETTER OF THE FIRST WORD UPPERCASE
                                  translated_tags_list[0] = translated_tags_list[0][0].toUpperCase() + translated_tags_list[0].substring(1);

                                  // UPDATING THE TEXT FIELD
                                  _deck_tag_controller.text = translated_tags_list.join(", ");

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
        bool success = await data_check_to_go();

        // CHECKING IF THE INTERFACE IS STILL MOUNTED
        if (!mounted) return;

        // GOING BACK TO THE EDITOR MAIN PAGE
        if (success) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop(saved_file_path);
        }

      },

      child: Scaffold(

        appBar: AppBar(),

        // SCAFFOLD CONTENT
        body: SafeArea(

          // SAFE AREA CONTENT
          child: Container(

            // PAGE PADDING
            padding: EdgeInsets.all(15),

            // PAGE ALIGNMENT
            alignment: Alignment.topCenter,

            // CONTAINER CONTENT
            child: SingleChildScrollView(

              // SCROLLABLE CONTAINER CONTENT
              child: Container(

                // SETTING THE WIDTH LIMIT
                constraints: BoxConstraints(maxWidth: 600),

                // CONTAINER CONTENT
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
                        AppLocalizations.of(context)!.deck_summary_editor_title,

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

                    // DECK NAME LABEL AND DECK NAME TEXTBOX CONTAINER
                    Column(

                      // ALIGNMENT
                      crossAxisAlignment: CrossAxisAlignment.start,

                      // COLUMN CONTENT
                      children: [

                        // CARD TEXT
                        Text(
                          // TEXT
                          AppLocalizations.of(context)!.deck_info_information_name_label,

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
                          controller: _deck_name_controller,

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

                    // DECK LANGUAGE LABEL AND DECK LANGUAGE TEXTBOX CONTAINER
                    Column(

                      // ALIGNMENT
                      crossAxisAlignment: CrossAxisAlignment.start,

                      // COLUMN CONTENT
                      children: [

                        // CARD TEXT
                        Text(
                          // TEXT
                          AppLocalizations.of(context)!.deck_info_information_language_label,

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
                          controller: _deck_language_controller,

                          // SETTING THE TEXT FIELD AD READ-ONLY
                          readOnly: true,

                          // ON TAP FUNCTION
                          onTap: () => show_language_dialog(context),

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

                    // DECK COUPLE TYPE LABEL AND DECK COUPLE TYPE SEGMENTED BUTTON
                    Column(

                      // ALIGNMENT
                      crossAxisAlignment: CrossAxisAlignment.start,

                      // COLUMN CONTENT
                      children: [

                        // CARD TEXT
                        Text(
                          // TEXT
                          AppLocalizations.of(context)!.deck_info_information_couple_type_label,

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
                              ButtonSegment(value: 'hetero', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_hetero_tag, style: TextStyle(fontSize: 12))),
                              ButtonSegment(value: 'lesbian', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_lesbian_tag, style: TextStyle(fontSize: 12))),
                              ButtonSegment(value: 'gay', label: Text(AppLocalizations.of(context)!.deck_filter_dialog_gay_tag, style: TextStyle(fontSize: 12))),
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

                        ),

                        //------------------------------------------------------------------------------

                      ],

                    ),

                    //------------------------------------------------------------------------------

                    // SPACER
                    const SizedBox(height: 15),

                    //------------------------------------------------------------------------------

                    // DECK GAME TYPE LABEL AND DECK GAME TYPE SEGMENTED BUTTON
                    Column(

                      // ALIGNMENT
                      crossAxisAlignment: CrossAxisAlignment.start,

                      // COLUMN CONTENT
                      children: [

                        // CARD TEXT
                        Text(
                          // TEXT
                          AppLocalizations.of(context)!.deck_info_information_game_type_label,

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

                        // GAME TYPE FILTER SELECTOR
                        SizedBox(

                          // WIDTH
                          width: double.infinity,

                          // CONTAINER CONTENT
                          child: SegmentedButton<bool>(

                            // DEFINING THE OPTIONS
                            segments: <ButtonSegment<bool>>[
                              ButtonSegment(value: false, label: Text(AppLocalizations.of(context)!.deck_filter_dialog_presence_tag, style: TextStyle(fontSize: 12))),
                              ButtonSegment(value: true, label: Text(AppLocalizations.of(context)!.deck_filter_dialog_distance_tag, style: TextStyle(fontSize: 12))),
                            ],

                            // SETTING THE SELECTED OPTION
                            selected: {selected_option_game_type},

                            // HIDING THE SELECTED ICON
                            showSelectedIcon: false,

                            // GETTING THE USER CHOICE
                            onSelectionChanged: (Set<bool> newSelection) {
                              setState(() {
                                selected_option_game_type = newSelection.first;
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

                    // DECK TAG LIST LABEL AND TAG LIST TEXTBOX CONTAINER
                    Column(

                      // ALIGNMENT
                      crossAxisAlignment: CrossAxisAlignment.start,

                      // COLUMN CONTENT
                      children: [

                        // CARD TEXT
                        Text(
                          // TEXT
                          AppLocalizations.of(context)!.deck_info_tags_list_label,

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
                          controller: _deck_tag_controller,

                          // SETTING THE TEXT FIELD AD READ-ONLY
                          readOnly: true,

                          // ALLOWING THE TEXT FIELD DO GO MULTILINE
                          keyboardType: TextInputType.multiline,
                          maxLines: null,

                          // ON TAP FUNCTION
                          onTap: () {

                            show_tags_dialog(context).then((_) {

                              setState(() {

                                // GETTING THE TRANSLATED TOOLS LIST
                                translated_tags_list = translate_tags(context, tag_list);

                                // MAKING THE FIRST LETTER OF THE FIRST WORD UPPERCASE
                                translated_tags_list[0] = translated_tags_list[0][0].toUpperCase() + translated_tags_list[0].substring(1);

                                // UPDATING THE TEXT FIELD
                                _deck_tag_controller.text = translated_tags_list.join(", ");

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

                    // DECK DESCRIPTION LABEL AND DECK DESCRIPTION TEXTBOX CONTAINER
                    Column(

                      // ALIGNMENT
                      crossAxisAlignment: CrossAxisAlignment.start,

                      // COLUMN CONTENT
                      children: [

                        // CARD TEXT
                        Text(
                          // TEXT
                          AppLocalizations.of(context)!.deck_info_information_description_label,

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
                          controller: _deck_description_controller,

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
                          bool success = await data_check_to_go();

                          // CHECKING IF THE INTERFACE IS STILL MOUNTED
                          if (!mounted) return;

                          if (success) {

                            // PAGE LINKER
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context, saved_file_path);

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

  }

}

//------------------------------------------------------------------------------