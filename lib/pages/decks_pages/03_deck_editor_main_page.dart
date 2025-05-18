//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:loverquest/l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// CUSTOM FILES
import 'package:loverquest/pages/decks_pages/dialogs/02_delete_deck_dialog.dart';

import 'package:loverquest/logics/decks_logics/01_deck_reader_class.dart';
import 'package:loverquest/logics/decks_logics/03_quest_class.dart';
import 'package:loverquest/logics/decks_logics/04_deck_management_class.dart';

import 'package:loverquest/logics/ui_logics/03_translate_tools_labels.dart';
import 'package:loverquest/logics/ui_logics/02_translate_tags_labels.dart';
import 'package:loverquest/logics/ui_logics/01_tags_ui_class.dart';

import 'package:loverquest/logics/general/app_router_wrapper_classes.dart';

//------------------------------------------------------------------------------


// DECK SELECTION PAGE DEFINITION
class DeckEditMainPage extends StatefulWidget {

  // CLASS CONSTRUCTOR
  const DeckEditMainPage({super.key});

  // LINK TO CLASS STATE / WIDGET CONTENT
  @override
  State<DeckEditMainPage> createState() {
    return _DeckEditMainPageState();
  }

}

// CLASS STATE / WIDGET CONTENT
class _DeckEditMainPageState extends State<DeckEditMainPage> {

  //------------------------------------------------------------------------------

  // INITIALIZING THE DECK WRAPPER OBJECT VAR
  DeckPagesWrapper deck_wrapper_object = DeckPagesWrapper();

  // INITIALIZING QUEST LISTS
  List<Quest> early_quests_list = [];
  List<Quest> mid_quests_list = [];
  List<Quest> late_quests_list = [];
  List<Quest> end_quests_list = [];
  List<Quest> all_quests_list = [];

  // INITIALIZING QUEST SCORES
  int early_quests_total_score = 0;
  int mid_quests_total_score = 0;
  int late_quests_total_score = 0;
  int end_quests_total_score = 0;

  // INITIALIZING GAME TYPE TAG
  String deck_game_type = "";

  // INITIALIZING TOOLS NEEDED
  String deck_needed_tools = "";

  // INITIALIZING TOOLS TRANSLATION
  late List<String> deck_translated_tools;

  // INITIALIZING TAGS LIST TRANSLATION
  late List<String> deck_translated_tags;

  // INITIALIZING LANGUAGE LABEL
  late LanguageInfo deck_language_label;

  // INITIALIZING COUPLE TYPE LABEL
  late String deck_couple_type_label;

  // DEFINING IS LOADING VARIABLE
  bool is_loading = true;

  // DEFINING THE CURRENT DECK VAR
  late DeckReader current_deck;

  // DEFINING THE CURRENT QUEST VAR
  late Quest current_quest;

  //------------------------------------------------------------------------------

  // FUNCTION TO SHOW THE DELETE CONFIRMATION DIALOG
  void show_deck_delete_dialog() {

    showDialog(
      context: context,
      builder: (context) => DeckDeleteDialog(
        deck_file_path: current_deck.deck_file_path,
        deck_name: current_deck.summary.name,
      ),
    ).then((result) {

      // CHECKING IF THE WIDGET IS STILL MOUNTED
      if (!mounted) return;

      // GOING TO THE PREVIOUS PAGE
      Navigator.pop(context, true);

    });

  }

  //------------------------------------------------------------------------------

  // SHOWING THE CONFIRMATION OF QUEST DELETION
  void show_confirmation_dialog(BuildContext context) {
    showDialog(
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
                    current_deck.quests.remove(current_quest);

                    // SAVING THE MODIFIED DECK FILE
                    String saved_deck_key = await DeckManagement.save_deck(
                      deck_name: current_deck.summary.name,
                      deck_description: current_deck.summary.description,
                      deck_language: current_deck.summary.language,
                      couple_type: current_deck.summary.couple_type,
                      play_presence: current_deck.summary.play_presence,
                      deck_tags: current_deck.summary.tags,
                      selected_deck: current_deck,
                    );

                    // RELOADING THE PAGE AFTER THE EDITING
                    await reload_after_editing(saved_deck_key);

                    // CHECKING IF THE CONTEXT IS STILL VALID
                    if (!context.mounted) {return;}

                    // CLOSING THE DIALOG
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

  // CLASS INITIAL STATE
  @override
  void initState() {
    super.initState();

    // GETTING THE DATA FROM THE PROVIDER
    deck_wrapper_object = Provider.of<DeckWrapperProvider>(context, listen: false).wrapperData!;

    // GETTING THE CURRENT DECK
    current_deck = deck_wrapper_object.selected_deck ?? DeckReader.empty();

    // LAUNCH THE FUNCTION TO LOAD ALL DEFAULT DECKS
    load_all_quest();

  }

  // INITIAL STATE FUNCTION TO LOAD ALL DEFAULTS DECKS
  Future<void> load_all_quest() async {

    //------------------------------------------------------------------------------

    // INITIALIZING QUEST LISTS
    early_quests_list = [];
    mid_quests_list = [];
    late_quests_list = [];
    end_quests_list = [];
    all_quests_list = [];

    // ACQUIRING THE CORRECT QUESTS FOR EVERY LIST
    for (Quest element in current_deck.quests) {

      if (element.moment == "early") {

        // ADDING THE ELEMENT TO THE LIST
        early_quests_list.add(element);

        // ADDING THE ELEMENT SCORE TO THE CATEGORY TOTAL
        early_quests_total_score = early_quests_total_score + 10;

      } else if (element.moment == "mid") {

        // ADDING THE ELEMENT TO THE LIST
        mid_quests_list.add(element);

        // ADDING THE ELEMENT SCORE TO THE CATEGORY TOTAL
        mid_quests_total_score = mid_quests_total_score + 10;

      } else if (element.moment == "late") {

        // ADDING THE ELEMENT TO THE LIST
        late_quests_list.add(element);

        // ADDING THE ELEMENT SCORE TO THE CATEGORY TOTAL
        late_quests_total_score = late_quests_total_score + 10;

      } else {

        // ADDING THE ELEMENT TO THE LIST
        end_quests_list.add(element);

        // ADDING THE ELEMENT SCORE TO THE CATEGORY TOTAL
        end_quests_total_score = end_quests_total_score + 10;

      }

    }

    // ADDING ALL THE LISTS INSIDE THE MAIN LIST
    all_quests_list = early_quests_list + mid_quests_list + late_quests_list + end_quests_list;

    // UPDATING THE WIDGET STATUS WITH THE LOADED DATA
    setState(() {
      is_loading = false;
    });
  }

  //------------------------------------------------------------------------------

  // LOADING DECK DATA
  Future<void> load_deck_data() async {

    setState(() {

      // TRANSLATING THE SUMMARY TOOLS
      deck_translated_tools = translate_tools(context, current_deck.summary.required_tools);

      // TRANSLATING THE SUMMARY TAGS
      deck_translated_tags = translate_tags(context, current_deck.summary.tags);

      // MAKING THE FIRST LETTER OF THE FIRST WORD UPPERCASE
      deck_translated_tools[0] = deck_translated_tools[0][0].toUpperCase() + deck_translated_tools[0].substring(1);

      // MAKING THE FIRST LETTER OF THE FIRST WORD UPPERCASE
      deck_translated_tags[0] = deck_translated_tags[0][0].toUpperCase() + deck_translated_tags[0].substring(1);

      // GETTING THE CORRECT LABEL FOR THE COUPLE TYPE LABEL
      if (current_deck.summary.couple_type == "hetero") {

        // SETTING THE COUPLE TYPE LABEL
        deck_couple_type_label = AppLocalizations.of(context)!.deck_info_couple_type_hetero;

      } else if (current_deck.summary.couple_type == "lesbian") {

        // SETTING THE COUPLE TYPE LABEL
        deck_couple_type_label = AppLocalizations.of(context)!.deck_info_couple_type_lesbian;

      } else {

        // SETTING THE COUPLE TYPE LABEL
        deck_couple_type_label = AppLocalizations.of(context)!.deck_info_couple_type_gay;

      }

      // CONVERTING TO STRING TAG THE GAME TYPE
      if (current_deck.summary.play_presence) {deck_game_type = AppLocalizations.of(context)!.deck_info_presence_label;} else {deck_game_type = AppLocalizations.of(context)!.deck_info_distance_label;}

      // GETTING THE LANGUAGE INFO
      deck_language_label = get_language_info(context, current_deck.summary.language);

    });

  }

  //------------------------------------------------------------------------------

  // RELOAD PAGE AFTER EDITING
  Future<void> reload_after_editing(String saved_deck_key) async {

    // STARTING THE LOADING SCREEN
    setState(() {
      is_loading = true;
    });

    // INITIALIZING THE CURRENT DECK VAR
    current_deck = DeckReader(saved_deck_key);

    // LOADING THE CURRENT DECK OBJECT
    await current_deck.load_deck();

    // RELOADING THE DECK DATA
    await load_deck_data();

    // RELOADING THE DECK QUESTS
    await load_all_quest();

    // RELOADING THE PAGE AND STOPPING THE LOADING SCREEN
    setState(() {
      is_loading = false;
    });

  }

  //------------------------------------------------------------------------------

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // LOADING THE DECK DATA
    load_deck_data();

  }

  //------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    //------------------------------------------------------------------------------

    // IF THE APP IS STILL LOADING THE DECKS, SHOWS A LOADING SCREEN
    if (is_loading) {

      // DEFINING LOADING SCREEN
      return Scaffold(

        // PAGE CONTENT
        body: SafeArea(

          // SAFE AREA CONTENT
            child: Center(

              // LOADING CIRCLE
              child: CircularProgressIndicator(

                // WHEEL COLOR
                color: Theme.of(context).colorScheme.onPrimary,

                // WHEEL WIDTH
                strokeWidth: 4,

              ),

            )

        ),

      );

    }

    //------------------------------------------------------------------------------

    // PAGE CONTENT
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {

      // IF THE PAGE IS ALREADY CLOSE, DO NOTHING
      if (didPop) return;

      // CHECKING IF THE INTERFACE IS STILL MOUNTED
      if (!mounted) return;

      // EDITING THE WRAPPER WITH THE CORRECT VALUES
      deck_wrapper_object.load_default_decks_flag = false;
      deck_wrapper_object.show_delete_button = null;
      deck_wrapper_object.selected_quest = null;
      deck_wrapper_object.selected_deck = null;

      // SAVING THE WRAPPER DATA CONTENT INSIDE THE PROVIDER
      Provider.of<DeckWrapperProvider>(context, listen: false).updateWrapperData(deck_wrapper_object);

      // PAGE LINKER
      context.go('/decks/list');

    },

      child: Scaffold(

        // APP BAR
        appBar: AppBar(

          // DEFINING THE ACTION BUTTONS
          actions: [

            // DUPLICATE DECK ICON BUTTON
            IconButton(
              icon: Icon(Icons.copy),
              onPressed: () async {

                // SAVING THE DECK
                await DeckManagement.save_deck(

                    deck_name: "${deck_wrapper_object.selected_deck?.summary.name ?? "Error"}_2",
                    deck_description: deck_wrapper_object.selected_deck?.summary.description ?? "Error",
                    deck_language: deck_wrapper_object.selected_deck?.summary.language ?? "en",
                    couple_type: deck_wrapper_object.selected_deck?.summary.couple_type ?? "hetero",
                    play_presence: deck_wrapper_object.selected_deck?.summary.play_presence ?? true,
                    deck_tags: deck_wrapper_object.selected_deck?.summary.tags ?? [],
                    selected_deck: deck_wrapper_object.selected_deck,

                );

                // CHECKING IF THE INTERFACE IS STILL MOUNTED
                if (!mounted) return;

                // EDITING THE WRAPPER WITH THE CORRECT VALUES
                deck_wrapper_object.load_default_decks_flag = false ;
                deck_wrapper_object.show_delete_button = null;
                deck_wrapper_object.selected_quest = null;
                deck_wrapper_object.selected_deck = null;

                // SAVING THE WRAPPER DATA CONTENT INSIDE THE PROVIDER
                Provider.of<DeckWrapperProvider>(context, listen: false).updateWrapperData(deck_wrapper_object);

                // PAGE LINKER
                context.pushReplacement('/decks/list');

              },

            ),

            // EXPORT ICON BUTTON
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () async { await DeckManagement.export_json_file_from_hive(current_deck.summary.name); },
            ),

            // DELETE ICON BUTTON
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {

                // SHOWING THE DELETE DIALOG
                show_deck_delete_dialog();

              },

            ),

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
              padding: EdgeInsets.all(10),

              // PAGE ALIGNMENT
              alignment: Alignment.topCenter,

              // SAFE AREA CONTENT
              child: CustomScrollView (

                // PAGE CONTENT
                slivers: [

                  //------------------------------------------------------------------------------

                  // STATIC PART OF THE PAGE
                  SliverToBoxAdapter(

                    // CONTAINER CONTENT
                    child: Column(

                      // SIZE
                      mainAxisSize: MainAxisSize.min,

                      // COLUMN CONTENT
                      children: [

                        //------------------------------------------------------------------------------

                        // DECK INFO HEADER BOX
                        Container(

                          // SIZE
                          width: double.infinity,

                          // PADDING
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),

                          // ALIGNMENT
                          alignment: Alignment.topRight,

                          // DECK INFO TITLE AND EDIT BUTTON CONTAINER
                          child: Row(

                            //ALIGNMENT
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            // ROW CONTENT
                            children: [

                              // PAGE TITLE TEXT
                              Expanded(child:  Text(
                                // TEXT
                                AppLocalizations.of(context)!.deck_info_page_title,

                                // TEXT ALIGNMENT
                                textAlign: TextAlign.start,

                                // TEXT STYLE
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,

                                ),
                              )),

                              // EDIT DECK SUMMARY ICON BUTTON
                              IconButton(

                                icon: Icon(Icons.edit),
                                onPressed: () async {

                                  // EDITING THE WRAPPER WITH THE CORRECT VALUES
                                  deck_wrapper_object.load_default_decks_flag = false;
                                  deck_wrapper_object.selected_quest = null;
                                  deck_wrapper_object.show_delete_button = null;

                                  // SAVING THE WRAPPER DATA CONTENT INSIDE THE PROVIDER
                                  Provider.of<DeckWrapperProvider>(context, listen: false).updateWrapperData(deck_wrapper_object);

                                  // PAGE LINKER
                                  context.push('/decks/editor_summary');

                                  },

                              ),

                            ],

                          ),

                        ),

                        //------------------------------------------------------------------------------

                        // SPACER
                        const SizedBox(height: 10),

                        //------------------------------------------------------------------------------

                        // DECK INFO BOX
                        Container(

                          // SIZE
                          width: double.infinity,

                          // PADDING
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),

                          // ALIGNMENT
                          alignment: Alignment.topLeft,

                          // STYLING
                          decoration: BoxDecoration(

                            // BACKGROUND COLOR
                            color: Theme.of(context).colorScheme.primary,

                            // BORDER RADIUS
                            borderRadius: BorderRadius.circular(20),

                          ),

                          // CONTAINER CONTENT
                          child: Column(

                            // ALIGNMENT
                            crossAxisAlignment: CrossAxisAlignment.start,

                            // COLUMN CONTENT
                            children: [

                              //------------------------------------------------------------------------------

                              // DECK INFO CONTAINER
                              Column(

                                // ALIGNMENT
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [

                                  //------------------------------------------------------------------------------

                                  // DECK NAME TEXT
                                  Text.rich(
                                    TextSpan (

                                      // TEXT
                                        text : AppLocalizations.of(context)!.deck_info_information_name_label,

                                        // TEXT STYLE
                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),

                                        children: [

                                          TextSpan (

                                            // TEXT
                                            text : current_deck.summary.name,

                                            // TEXT STYLE
                                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),

                                          ),

                                        ]

                                    ),
                                  ),

                                  //------------------------------------------------------------------------------

                                  // SPACER
                                  const SizedBox(height: 5),

                                  //------------------------------------------------------------------------------

                                  // DECK LANGUAGE TEXT
                                  Text.rich(
                                    TextSpan (

                                      // TEXT
                                        text : AppLocalizations.of(context)!.deck_info_information_language_label,

                                        // TEXT STYLE
                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),

                                        children: [

                                          TextSpan (

                                            // TEXT
                                            text : deck_language_label.label,

                                            // TEXT STYLE
                                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),

                                          ),

                                        ]

                                    ),
                                  ),

                                  //------------------------------------------------------------------------------

                                  // SPACER
                                  const SizedBox(height: 5),

                                  //------------------------------------------------------------------------------

                                  // GAME TYPE TEXT
                                  Text.rich(
                                    TextSpan (

                                      // TEXT
                                        text : AppLocalizations.of(context)!.deck_info_information_game_type_label,

                                        // TEXT STYLE
                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),

                                        children: [

                                          TextSpan (

                                            // TEXT
                                            text : deck_game_type,

                                            // TEXT STYLE
                                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),

                                          ),

                                        ]

                                    ),
                                  ),

                                  //------------------------------------------------------------------------------

                                  // SPACER
                                  const SizedBox(height: 5),

                                  //------------------------------------------------------------------------------

                                  // COUPLE TYPE TEXT
                                  Text.rich(
                                    TextSpan (

                                      // TEXT
                                        text : AppLocalizations.of(context)!.deck_info_information_couple_type_label,

                                        // TEXT STYLE
                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),

                                        children: [

                                          TextSpan (

                                            // TEXT
                                            text : deck_couple_type_label,

                                            // TEXT STYLE
                                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),

                                          ),

                                        ]

                                    ),
                                  ),

                                  //------------------------------------------------------------------------------

                                  // SPACER
                                  const SizedBox(height: 5),

                                  //------------------------------------------------------------------------------

                                  // QUEST NUMBER TEXT
                                  Text.rich(
                                    TextSpan (

                                      // TEXT
                                        text : AppLocalizations.of(context)!.deck_info_information_quest_number_label,

                                        // TEXT STYLE
                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),

                                        children: [

                                          TextSpan (

                                            // TEXT
                                            text : '${current_deck.summary.total_quests}',

                                            // TEXT STYLE
                                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),

                                          ),

                                        ]

                                    ),
                                  ),

                                  //------------------------------------------------------------------------------

                                  // SPACER
                                  const SizedBox(height: 5),

                                  //------------------------------------------------------------------------------

                                  // TOOLS TEXT
                                  Text.rich(
                                    TextSpan (

                                      // TEXT
                                        text : AppLocalizations.of(context)!.deck_info_information_requested_tools_label,

                                        // TEXT STYLE
                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),

                                        children: [

                                          TextSpan (

                                            // TEXT
                                            text : deck_translated_tools.join(", "),

                                            // TEXT STYLE
                                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),

                                          ),

                                        ]

                                    ),
                                  ),

                                  //------------------------------------------------------------------------------

                                  // SPACER
                                  const SizedBox(height: 5),

                                  //------------------------------------------------------------------------------

                                  // TAGS TEXT
                                  Text.rich(
                                    TextSpan (

                                      // TEXT
                                        text : AppLocalizations.of(context)!.deck_info_tags_list_label,

                                        // TEXT STYLE
                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),

                                        children: [

                                          TextSpan (

                                            // TEXT
                                            text : deck_translated_tags.join(", "),

                                            // TEXT STYLE
                                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),

                                          ),

                                        ]

                                    ),
                                  ),

                                  //------------------------------------------------------------------------------

                                  // SPACER
                                  const SizedBox(height: 5),

                                  //------------------------------------------------------------------------------

                                  // DESCRIPTION TEXT
                                  Text.rich(
                                    TextSpan (

                                      // TEXT
                                        text : AppLocalizations.of(context)!.deck_info_information_description_label,

                                        // TEXT STYLE
                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),

                                        children: [

                                          TextSpan (

                                            // TEXT
                                            text : current_deck.summary.description,

                                            // TEXT STYLE
                                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),

                                          ),

                                        ]

                                    ),
                                  ),

                                  //------------------------------------------------------------------------------

                                ],

                              ),

                              //------------------------------------------------------------------------------

                            ],

                          ),


                        ),

                        //------------------------------------------------------------------------------

                        // SPACER
                        const SizedBox(height: 30),

                        //------------------------------------------------------------------------------

                        // SECTION DIVIDER
                        Divider(

                          // COLOR
                          color: Theme.of(context).colorScheme.primary,

                          // THICKNESS
                          thickness: 3,

                          // SX MARGIN
                          indent: 15,

                          // DX MARGIN
                          endIndent: 15,

                        ),

                        //------------------------------------------------------------------------------

                        // SPACER
                        const SizedBox(height: 30),

                        //------------------------------------------------------------------------------

                        // QUEST LIST HEADER BOX
                        Container(

                          // SIZE
                          width: double.infinity,

                          // PADDING
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),

                          // ALIGNMENT
                          alignment: Alignment.topRight,

                          // CONTAINER CONTENT
                          child: Column(

                            // ALIGNMENT
                            crossAxisAlignment: CrossAxisAlignment.start,

                            // COLUMN CONTENT
                            children: [

                              //------------------------------------------------------------------------------

                              // DECK INFO TITLE AND EDIT BUTTON CONTAINER
                              Row(

                                //ALIGNMENT
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                // ROW CONTENT
                                children: [

                                  // PAGE TITLE TEXT
                                  Expanded(child:  Text(
                                    // TEXT
                                    AppLocalizations.of(context)!.deck_info_quest_list_title,

                                    // TEXT STYLE
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),

                                  // BUTTONS CONTAINER
                                  Wrap(

                                    children: [

                                      // ADD QUEST ICON BUTTON
                                      IconButton(

                                        icon: Icon(Icons.add_circle_rounded),
                                        onPressed: () async {

                                          // EDITING THE WRAPPER WITH THE CORRECT VALUES
                                          deck_wrapper_object.load_default_decks_flag = false;
                                          deck_wrapper_object.show_delete_button = false;
                                          deck_wrapper_object.selected_quest = null;

                                          // SAVING THE WRAPPER DATA CONTENT INSIDE THE PROVIDER
                                          Provider.of<DeckWrapperProvider>(context, listen: false).updateWrapperData(deck_wrapper_object);

                                          // PAGE LINKER
                                          context.push('/decks/editor_quest');

                                          // RELOADING THE PAGE INFO
                                          await reload_after_editing(deck_wrapper_object.selected_deck?.deck_file_path ?? "");

                                        },

                                      ),
                                      /*
                                    // FILTER QUEST LIST ICON BUTTON
                                    IconButton(

                                      icon: Icon(Icons.filter_alt_rounded),
                                      onPressed: () {},

                                    ),
                                    */
                                    ],

                                  ),



                                ],

                              ),

                              //------------------------------------------------------------------------------

                            ],

                          ),


                        ),

                        //------------------------------------------------------------------------------

                        // SPACER
                        const SizedBox(height: 10),

                        //------------------------------------------------------------------------------

                      ],

                    ),

                  ),

                  //------------------------------------------------------------------------------

                  // DYNAMIC PART OF THE PAGE
                  SliverList(

                    // DYNAMIC PART OF THE WIDGET
                    delegate: SliverChildBuilderDelegate(

                          (context, index) {

                        //------------------------------------------------------------------------------

                        // GETTING THE CURRENT QUEST
                        current_quest = all_quests_list[index];

                        // TRANSLATING THE NEEDED TOOLS
                        List<String> translated_quest_tools_list = translate_tools(context, all_quests_list[index].required_tools);

                        // MAKING THE FIRST LETTER OF THE FIRST WORD UPPERCASE
                        translated_quest_tools_list[0] = translated_quest_tools_list[0][0].toUpperCase() + translated_quest_tools_list[0].substring(1);

                        // GETTING THE CORRECT TIMER STRING
                        String quest_timer = '';
                        if (all_quests_list[index].timer != 0) {

                          quest_timer = '${all_quests_list[index].timer} ${AppLocalizations.of(context)!.deck_info_information_minute_label}';

                        } else {

                          quest_timer = AppLocalizations.of(context)!.deck_info_no_tools_label;

                        }

                        // INITIALIZING THE QUEST TYPE VAR
                        String quest_type;

                        // CONVERTING THE QUEST TYPE TAG
                        if (all_quests_list[index].moment.toLowerCase() == "early") {

                          // DEFINING QUEST TYPE TEXT
                          quest_type = AppLocalizations.of(context)!.deck_info_quest_info_early_quest_type;

                        } else if (all_quests_list[index].moment.toLowerCase() == "mid") {

                          // DEFINING QUEST TYPE TEXT
                          quest_type = AppLocalizations.of(context)!.deck_info_quest_info_mid_quest_type;

                        } else if (all_quests_list[index].moment.toLowerCase() == "late") {

                          // DEFINING QUEST TYPE TEXT
                          quest_type = AppLocalizations.of(context)!.deck_info_quest_info_late_quest_type;

                        } else {

                          // DEFINING QUEST TYPE TEXT
                          quest_type = AppLocalizations.of(context)!.deck_info_quest_info_end_quest_type;

                        }

                        // CONVERTING THE DESIGNATED PLAYER TAG
                        String designated_player = "";
                        if (all_quests_list[index].player_type.toLowerCase() == "both") {

                          // DEFINING QUEST TYPE TEXT
                          designated_player = AppLocalizations.of(context)!.quest_editor_page_player_type_both;

                        } else if (all_quests_list[index].player_type.toLowerCase() == "male") {

                          // DEFINING QUEST TYPE TEXT
                          designated_player = AppLocalizations.of(context)!.quest_editor_page_player_type_male;

                        } else if (all_quests_list[index].player_type.toLowerCase() == "female") {

                          // DEFINING QUEST TYPE TEXT
                          designated_player = AppLocalizations.of(context)!.quest_editor_page_player_type_female;

                        }

                        //------------------------------------------------------------------------------

                        // DYNAMIC LIST CONTENT
                        return Align(

                          // ALIGN CONTENT
                          child: Container(

                            // SETTING THE WIDTH LIMIT
                            constraints: BoxConstraints(maxWidth: 800),

                            // SIZE BOX CONTENT
                            child: Column(

                              // COLUMN CONTENT
                              children: [

                                // SETTING GESTURE DETECTOR IN ORDER TO GET LONG PRESS ACTION
                                GestureDetector(

                                  //------------------------------------------------------------------------------

                                  // LONG PRESS CONDITION SETUP
                                  onLongPressStart: (details) {
                                    showMenu(
                                      context: context,

                                      // MENU POSITION
                                      position: RelativeRect.fromLTRB(
                                          details.globalPosition.dx,
                                          details.globalPosition.dy,
                                          details.globalPosition.dx + 1,
                                          details.globalPosition.dy + 1
                                      ),

                                      // MENU CONTENT
                                      items: [

                                        // DELETE ENTRY
                                        PopupMenuItem(

                                          // ENTRY VALUE
                                          value: 'delete',

                                          // ENTRY CONTENT
                                          child: Row(

                                            // ROW CONTENT
                                            children: [

                                              // ENTRY ICON
                                              Icon(

                                                // ICON
                                                Icons.delete,

                                                // ICON SIZE
                                                size: 18,

                                              ),

                                              // SPACER
                                              SizedBox(width: 5),

                                              // ENTRY TEXT
                                              Expanded(child: Text(AppLocalizations.of(context)!.deck_management_press_menu_delete)),

                                            ],

                                          ),

                                        ),

                                        // DUPLICATE ENTRY
                                        PopupMenuItem(

                                          // ENTRY VALUE
                                          value: 'duplicate',

                                          // ENTRY CONTENT
                                          child: Row(

                                            // ROW CONTENT
                                            children: [

                                              // ENTRY ICON
                                              Icon(

                                                // ICON
                                                Icons.copy,

                                                // ICON SIZE
                                                size: 18,

                                              ),

                                              // SPACER
                                              SizedBox(width: 5),

                                              // ENTRY TEXT
                                              Expanded(child: Text(AppLocalizations.of(context)!.deck_management_press_menu_duplicate)),

                                            ],

                                          ),

                                        ),

                                      ],

                                      // MENU CONDITION ON ANY BUTTON PRESSED
                                    ).then((value) async {

                                      if (value == "delete") {

                                        // CHECKING IF THE CONTEXT IS STILL VALID
                                        if (!context.mounted) {return;}

                                        // SHOWING THE DELETE DIALOG
                                        show_confirmation_dialog(context);

                                      } else if (value == "duplicate") {

                                        // CREATING THE NEW DUPLICATED QUEST
                                        Quest duplicated_quest = Quest(moment: all_quests_list[index].moment, required_tools: all_quests_list[index].required_tools, player_type: all_quests_list[index].player_type, timer: all_quests_list[index].timer, content: "${all_quests_list[index].content}_2");

                                        // ADDING THE QUEST TO THE QUEST LIST
                                        all_quests_list.add(duplicated_quest);

                                        // REPLACING INSIDE THE DECK THE OLD QUEST LIST WITH THE NEW QUEST LIST
                                        current_deck.quests = all_quests_list;

                                        // SAVING THE EDITED DECK
                                        String saved_deck_file_path = await DeckManagement.save_deck(

                                            deck_name: current_deck.summary.name,
                                            deck_description: current_deck.summary.description,
                                            deck_language: current_deck.summary.language,
                                            couple_type: current_deck.summary.couple_type,
                                            play_presence: current_deck.summary.play_presence,
                                            deck_tags: current_deck.summary.tags,
                                            selected_deck: current_deck,

                                        );

                                        // UPDATING THE PAGE LIST
                                        await reload_after_editing(saved_deck_file_path);

                                        setState(() {

                                        });

                                      }

                                    });

                                  },

                                  //------------------------------------------------------------------------------

                                  // QUEST BOX
                                  child: ElevatedButton(

                                    //------------------------------------------------------------------------------

                                    // BUTTON STYLE PARAMETERS
                                    style: ButtonStyle(

                                      // NORMAL TEXT COLOR
                                      foregroundColor: WidgetStateProperty.all(
                                          Theme.of(context).colorScheme.onPrimary
                                      ),

                                      // NORMAL BACKGROUND COLOR
                                      backgroundColor: WidgetStateProperty.all(
                                        Theme.of(context).colorScheme.primary,
                                      ),

                                      // CORNERS RADIUS
                                      shape:
                                      WidgetStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),

                                      // PADDING
                                      padding: WidgetStateProperty.all<EdgeInsets>(
                                        EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                                      ),

                                    ),

                                    //------------------------------------------------------------------------------

                                    // ON PRESSED CALL
                                    onPressed: () async {

                                      // EDITING THE WRAPPER WITH THE CORRECT VALUES
                                      deck_wrapper_object.selected_quest = all_quests_list[index];
                                      deck_wrapper_object.show_delete_button = true;
                                      deck_wrapper_object.selected_quest = null;

                                      // SAVING THE WRAPPER DATA CONTENT INSIDE THE PROVIDER
                                      Provider.of<DeckWrapperProvider>(context, listen: false).updateWrapperData(deck_wrapper_object);

                                      // PAGE LINKER
                                      context.push('/decks/editor_quest');

                                    },

                                    //------------------------------------------------------------------------------

                                    // BUTT0N CONTENT
                                    child: Row(

                                      // ROW CONTENT
                                      children: [

                                        //------------------------------------------------------------------------------

                                        // COLUMN
                                        Expanded(
                                          child: Column(

                                            // COLUMN ALIGNMENT
                                            crossAxisAlignment:CrossAxisAlignment.start,

                                            children: [

                                              //------------------------------------------------------------------------------

                                              // QUEST TYPE TEXT
                                              Text.rich(
                                                TextSpan (

                                                    text : AppLocalizations.of(context)!.deck_info_quest_info_quest_type_label,
                                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),

                                                    children: [

                                                      TextSpan (

                                                        text : quest_type,
                                                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),

                                                      ),

                                                    ]

                                                ),
                                              ),

                                              //------------------------------------------------------------------------------

                                              // SPACER
                                              const SizedBox(height: 5),

                                              //------------------------------------------------------------------------------

                                              // TOOLS TEXT
                                              Text.rich(
                                                TextSpan (

                                                    text : AppLocalizations.of(context)!.deck_info_information_requested_tools_label,
                                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),

                                                    children: [

                                                      TextSpan (

                                                        text : translated_quest_tools_list.join(", "),
                                                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),

                                                      ),

                                                    ]

                                                ),
                                              ),

                                              //------------------------------------------------------------------------------

                                              // SPACER
                                              const SizedBox(height: 5),

                                              //------------------------------------------------------------------------------

                                              // PLAYER TYPE TEXT
                                              Text.rich(
                                                TextSpan (

                                                    text : AppLocalizations.of(context)!.deck_info_information_designated_player_label,
                                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),

                                                    children: [

                                                      TextSpan (

                                                        text : designated_player,
                                                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),

                                                      ),

                                                    ]

                                                ),
                                              ),

                                              //------------------------------------------------------------------------------

                                              // SPACER
                                              const SizedBox(height: 5),

                                              //------------------------------------------------------------------------------

                                              // TIMER TEXT
                                              Text.rich(
                                                TextSpan (

                                                    text : AppLocalizations.of(context)!.deck_info_information_timer_label,
                                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),

                                                    children: [

                                                      TextSpan (

                                                        text : quest_timer,
                                                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),

                                                      ),

                                                    ]

                                                ),
                                              ),

                                              //------------------------------------------------------------------------------

                                              // SPACER
                                              const SizedBox(height: 5),

                                              //------------------------------------------------------------------------------

                                              // DESCRIPTION TEXT
                                              Text.rich(
                                                TextSpan (

                                                    text : AppLocalizations.of(context)!.deck_info_information_description_label,
                                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),

                                                    children: [

                                                      TextSpan (

                                                        text : all_quests_list[index].content,
                                                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),

                                                      ),

                                                    ]

                                                ),
                                              ),

                                              //------------------------------------------------------------------------------

                                            ],

                                          ),

                                        ),

                                        //------------------------------------------------------------------------------

                                        // EDIT ICON
                                        Icon(

                                          // ICON
                                          Icons.edit,

                                          // ICON COLOR
                                          color: Theme.of(context).colorScheme.onSecondary,

                                        ),

                                        //------------------------------------------------------------------------------

                                      ],

                                    ),

                                  ),

                                  //------------------------------------------------------------------------------

                                ),

                                // SPACER
                                const SizedBox(height: 15),

                              ],

                            ),

                          ),

                        );


                        //------------------------------------------------------------------------------

                      },

                      // DYNAMIC LIST ITEM NUMBER
                      childCount: all_quests_list.length,

                    ),

                    //------------------------------------------------------------------------------

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




