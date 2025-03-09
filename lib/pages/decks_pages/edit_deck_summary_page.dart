//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:loverquest/l10n/app_localization.dart';
//import 'package:provider/provider.dart';

// CUSTOM FILES
import 'package:loverquest/logics/decks_logics/quests_reader.dart';
import 'package:loverquest/logics/decks_logics/deck_ui_conversion.dart';
import 'package:loverquest/logics/decks_logics/save_deck.dart';
import 'package:loverquest/pages/decks_pages/deck_editor_main_page.dart';


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

  // DEFINING PLAYERS NAMES TEXT FIELD TEXT CONTROLLER
  late TextEditingController _deck_name_controller;
  late TextEditingController _deck_language_controller;
  late TextEditingController _deck_description_controller;

  //------------------------------------------------------------------------------

  // DEFINING THE LANGUAGE LABEL VAR
  late LanguageInfo language_object = get_language_info(context, "en");

  //------------------------------------------------------------------------------

  // SETTING THE COUPLE TYPE AND GAME TYPE INITIAL VALUE
  String selected_option_couple_type = 'hetero';
  bool selected_option_game_type = false;

  //------------------------------------------------------------------------------

  // RELEASING CONTROLLERS WHEN THE PAGE IS DISMISSED
  @override
  void initState() {
    super.initState();

    // SET-UPPING THE TEXT FIELD CONTROLLERS
    _deck_name_controller = TextEditingController();
    _deck_language_controller = TextEditingController();
    _deck_description_controller = TextEditingController();

  }

  @override
  void dispose() {
    _deck_name_controller.dispose();
    _deck_language_controller.dispose();
    _deck_description_controller.dispose();
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

    }

  }

  //------------------------------------------------------------------------------

  // CHECKING CONTINUE TO NEXT PAGE CONDITION
  void alias_check_to_go() async {

    // INITIALIZING THE NECESSARY VARIABLES
    String deck_name_field = _deck_name_controller.text.trim();
    String deck_description_field = _deck_description_controller.text.trim();

    // CHECKING IF ALL THE FIELD HAVE BEEN COMPILED
    if ((deck_name_field == "") || (deck_description_field == "")) {

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

    } else {
      
      try {

        // LOADING THE MODIFIED DECK FILE
        String saved_file_path = await DeckSaver.save_deck(
          deck_name: deck_name_field,
          deck_description: deck_description_field,
          deck_language: language_object.language_code,
          couple_type: selected_option_couple_type,
          play_distance: selected_option_game_type,
          selected_deck: widget.selected_deck,
        );

        if (widget.selected_deck != null) {

          // PAGE LINKER
          Navigator.pop(context, saved_file_path);

        } else {

          // LOADING THE NEW DECK INFO
          DeckReader new_deck = DeckReader(saved_file_path);
          await new_deck.load_deck();

          // GOING TO THE MAIN EDIT PAGE WITH THE NEW DECK INFO
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DeckEditMainPage(selected_deck: new_deck)),
          );

        }


      } catch (e) {
        // SHOWING AN ERROR
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

                ],

              ),

            ),

          );

        },

      );

    }

    //------------------------------------------------------------------------------

    // PAGE CONTENT
    return Scaffold(

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
                        alias_check_to_go();

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

    );

  }

}

//------------------------------------------------------------------------------