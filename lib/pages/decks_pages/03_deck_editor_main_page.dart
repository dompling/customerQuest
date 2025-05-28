//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:loverquest/l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// CUSTOM FILES
import 'package:loverquest/pages/decks_pages/dialogs/02_delete_deck_dialog.dart';
import 'package:loverquest/pages/decks_pages/dialogs/03_delete_quest_dialog.dart';

import 'package:loverquest/logics/decks_logics/01_deck_reader_class.dart';
import 'package:loverquest/logics/decks_logics/03_quest_class.dart';
import 'package:loverquest/logics/decks_logics/04_deck_management_class.dart';
import 'package:loverquest/logics/decks_logics/08_quest_filters.dart';

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

  // DEFINING IS LOADING VARIABLE
  bool is_loading = true;

  // DEFINING THE DECK VAR
  late DeckReader deck;

  // DEFINING THE QUEST LIST VAR
  late List<Quest> quest_list;

  // DEFINING THE SELECTED QUEST VAR
  late Quest selected_quest;
  
  // INITIALIZING THE QUEST FILTERS VARS
  String? sorting_type;
  String? tools_filter;
  String? moment_filter;

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
  
  //------------------------------------------------------------------------------

  // FUNCTION TO SHOW THE DELETE CONFIRMATION DIALOG
  void show_deck_delete_dialog() {

    // SHOWING THE DIALOG
    showDialog(

      context: context,
      builder: (context) => DeckDeleteDialog(deck_key: deck.deck_key, deck_name: deck.summary.name,),

    ).then((result) async {

      // CHECKING IF THE WIDGET IS STILL MOUNTED
      if (!mounted) return;

      // RELOADING PAGE DATA
      await page_data_loading();

      // GOING TO THE PREVIOUS PAGE
      context.pop();

    });

  }

  //------------------------------------------------------------------------------

  // SHOWING THE CONFIRMATION OF QUEST DELETION
  void show_quest_delete_dialog(BuildContext context, Quest selected_quest) {

    // SHOWING THE DIALOG
    showDialog(

      context: context,
      builder: (context) => DeleteQuestDialog(deck: deck, selected_quest: selected_quest,),

    ).then((result) async {

      // CHECKING IF THE WIDGET IS STILL MOUNTED
      if (!mounted) return;

      // RELOADING PAGE DATA
      await page_data_loading();

    });

  }

  //------------------------------------------------------------------------------

  // LOADING DECK SUMMARY INFO
  Future<void> deck_summary_info_loading() async {

    setState(() {

      // TRANSLATING THE SUMMARY TOOLS
      deck_translated_tools = translate_tools(context, deck.summary.required_tools);

      // MAKING THE FIRST LETTER OF THE FIRST WORD UPPERCASE
      deck_translated_tools[0] = deck_translated_tools[0][0].toUpperCase() + deck_translated_tools[0].substring(1);
      
      //------------------------------------------------------------------------------

      // TRANSLATING THE SUMMARY TAGS
      deck_translated_tags = translate_tags(context, deck.summary.tags);

      // MAKING THE FIRST LETTER OF THE FIRST WORD UPPERCASE
      deck_translated_tags[0] = deck_translated_tags[0][0].toUpperCase() + deck_translated_tags[0].substring(1);
      
      //------------------------------------------------------------------------------

      // GETTING THE CORRECT LABEL FOR THE COUPLE TYPE LABEL
      if (deck.summary.couple_type == "hetero") {

        // SETTING THE COUPLE TYPE LABEL
        deck_couple_type_label = AppLocalizations.of(context)!.deck_info_couple_type_hetero;

      } else if (deck.summary.couple_type == "lesbian") {

        // SETTING THE COUPLE TYPE LABEL
        deck_couple_type_label = AppLocalizations.of(context)!.deck_info_couple_type_lesbian;

      } else {

        // SETTING THE COUPLE TYPE LABEL
        deck_couple_type_label = AppLocalizations.of(context)!.deck_info_couple_type_gay;

      }
      
      //------------------------------------------------------------------------------

      // CONVERTING TO STRING TAG THE GAME TYPE
      if (deck.summary.play_presence) {deck_game_type = AppLocalizations.of(context)!.deck_info_presence_label;} else {deck_game_type = AppLocalizations.of(context)!.deck_info_distance_label;}

      //------------------------------------------------------------------------------
      
      // GETTING THE LANGUAGE INFO
      deck_language_label = get_language_info(context, deck.summary.language);

    });

  }

  // SETTING UP PAGE DATA
  Future<void> page_data_loading() async {

    // SHOWING THE LOADER
    setState(() {
      is_loading = true;
    });
    
    //------------------------------------------------------------------------------

    // GETTING THE DATA FROM THE PROVIDER
    deck_wrapper_object = Provider.of<DeckWrapperProvider>(context, listen: false).wrapperData!;

    // SETTING THE DECK TO SHOW
    deck = deck_wrapper_object.selected_deck ?? DeckReader.empty();
    
    //------------------------------------------------------------------------------

    // RELOADING THE DECK SUMMARY INFO
    await deck_summary_info_loading();

    // SETTING THE QUEST LIST
    quest_list = await quest_filter_sorting(deck, sorting_type: sorting_type, moment_filter: moment_filter,tools_filter: tools_filter);
    
    //------------------------------------------------------------------------------

    // HIDING THE LOADER
    setState(() {
      is_loading = false;
    });

  }

  //------------------------------------------------------------------------------

  // CLASS INITIAL STATE
  @override
  void initState() {
    super.initState();

    // SHOWING THE LOADER
    setState(() {
      is_loading = true;
    });

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // LOADING ALL THE PAGE DATA
    page_data_loading();

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
    return Scaffold(

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
                  already_existing_deck: deck_wrapper_object.selected_deck,
                  deck_duplication: true,

                );

                // CHECKING IF THE INTERFACE IS STILL MOUNTED
                if (!mounted) return;

                // EDITING THE WRAPPER WITH THE CORRECT VALUES
                deck_wrapper_object.load_default_decks_flag = false ;
                deck_wrapper_object.show_delete_button = null;
                deck_wrapper_object.selected_quest = null;
                deck_wrapper_object.selected_deck = null;
                deck_wrapper_object.new_deck_creation = false;

                // SAVING THE WRAPPER DATA CONTENT INSIDE THE PROVIDER
                Provider.of<DeckWrapperProvider>(context, listen: false).updateWrapperData(deck_wrapper_object);

                // PAGE LINKER
                context.pop();

              },

            ),

            // EXPORT ICON BUTTON
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () async { await DeckManagement.export_json_file_from_hive(deck.summary.name); },
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
                                  deck_wrapper_object.new_deck_creation = false;

                                  // SAVING THE WRAPPER DATA CONTENT INSIDE THE PROVIDER
                                  Provider.of<DeckWrapperProvider>(context, listen: false).updateWrapperData(deck_wrapper_object);

                                  // PAGE LINKER
                                  await context.push('/decks/user/custom_decks_list/edit/deck_main_editor/deck_summary_editor');

                                  // UPDATING THE DECK WRAPPER
                                  setState(() {
                                    deck_wrapper_object = Provider.of<DeckWrapperProvider>(context, listen: false).wrapperData!;
                                    deck = deck_wrapper_object.selected_deck!;
                                  });

                                  // RELOADING DECK DATA AFTER EDITING
                                  await page_data_loading();

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
                                            text : deck.summary.name,

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
                                            text : '${deck.summary.total_quests}',

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
                                            text : deck.summary.description,

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
                                          deck_wrapper_object.new_deck_creation = false;

                                          // SAVING THE WRAPPER DATA CONTENT INSIDE THE PROVIDER
                                          Provider.of<DeckWrapperProvider>(context, listen: false).updateWrapperData(deck_wrapper_object);

                                          // PAGE LINKER
                                          await context.push('/decks/user/custom_decks_list/edit/deck_main_editor/deck_quest_editor');

                                          // RELOADING DECK DATA AFTER EDITING
                                          await page_data_loading();

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
                        selected_quest = quest_list[index];

                        // TRANSLATING THE NEEDED TOOLS
                        List<String> translated_quest_tools_list = translate_tools(context, quest_list[index].required_tools);

                        // MAKING THE FIRST LETTER OF THE FIRST WORD UPPERCASE
                        translated_quest_tools_list[0] = translated_quest_tools_list[0][0].toUpperCase() + translated_quest_tools_list[0].substring(1);

                        // GETTING THE CORRECT TIMER STRING
                        String quest_timer = '';
                        if (quest_list[index].timer != 0) {

                          quest_timer = '${quest_list[index].timer} ${AppLocalizations.of(context)!.deck_info_information_minute_label}';

                        } else {

                          quest_timer = AppLocalizations.of(context)!.deck_info_no_tools_label;

                        }

                        // INITIALIZING THE QUEST TYPE VAR
                        String quest_type;

                        // CONVERTING THE QUEST TYPE TAG
                        if (quest_list[index].moment.toLowerCase() == "early") {

                          // DEFINING QUEST TYPE TEXT
                          quest_type = AppLocalizations.of(context)!.deck_info_quest_info_early_quest_type;

                        } else if (quest_list[index].moment.toLowerCase() == "mid") {

                          // DEFINING QUEST TYPE TEXT
                          quest_type = AppLocalizations.of(context)!.deck_info_quest_info_mid_quest_type;

                        } else if (quest_list[index].moment.toLowerCase() == "late") {

                          // DEFINING QUEST TYPE TEXT
                          quest_type = AppLocalizations.of(context)!.deck_info_quest_info_late_quest_type;

                        } else {

                          // DEFINING QUEST TYPE TEXT
                          quest_type = AppLocalizations.of(context)!.deck_info_quest_info_end_quest_type;

                        }

                        // CONVERTING THE DESIGNATED PLAYER TAG
                        String designated_player = "";
                        if (quest_list[index].player_type.toLowerCase() == "both") {

                          // DEFINING QUEST TYPE TEXT
                          designated_player = AppLocalizations.of(context)!.quest_editor_page_player_type_both;

                        } else if (quest_list[index].player_type.toLowerCase() == "male") {

                          // DEFINING QUEST TYPE TEXT
                          designated_player = AppLocalizations.of(context)!.quest_editor_page_player_type_male;

                        } else if (quest_list[index].player_type.toLowerCase() == "female") {

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
                                        show_quest_delete_dialog(context, quest_list[index]);

                                      } else if (value == "duplicate") {

                                        // CREATING THE NEW DUPLICATED QUEST
                                        Quest duplicated_quest = Quest(moment: quest_list[index].moment, required_tools: quest_list[index].required_tools, player_type: quest_list[index].player_type, timer: quest_list[index].timer, content: "${quest_list[index].content}_2");

                                        // ADDING THE QUEST TO THE QUEST LIST
                                        deck.quests.add(duplicated_quest);

                                        // REPLACING INSIDE THE DECK THE OLD QUEST LIST WITH THE NEW QUEST LIST
                                        deck.quests = deck.quests;

                                        // SAVING THE EDITED DECK
                                        await DeckManagement.save_deck(

                                          deck_name: deck.summary.name,
                                          deck_description: deck.summary.description,
                                          deck_language: deck.summary.language,
                                          couple_type: deck.summary.couple_type,
                                          play_presence: deck.summary.play_presence,
                                          deck_tags: deck.summary.tags,
                                          already_existing_deck: deck,

                                        );

                                        // UPDATING THE PAGE LIST
                                        await page_data_loading();

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
                                      deck_wrapper_object.selected_quest = quest_list[index];
                                      deck_wrapper_object.show_delete_button = true;
                                      deck_wrapper_object.new_deck_creation = false;

                                      // SAVING THE WRAPPER DATA CONTENT INSIDE THE PROVIDER
                                      Provider.of<DeckWrapperProvider>(context, listen: false).updateWrapperData(deck_wrapper_object);

                                      // PAGE LINKER
                                      await context.push('/decks/user/custom_decks_list/edit/deck_main_editor/deck_quest_editor');

                                      //
                                      setState(() {
                                        deck_wrapper_object = Provider.of<DeckWrapperProvider>(context, listen: false).wrapperData!;
                                        deck = deck_wrapper_object.selected_deck!;
                                      });

                                      // RELOADING DECK DATA AFTER EDITING
                                      await page_data_loading();

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

                                                        text : quest_list[index].content,
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
                      childCount: quest_list.length,

                    ),

                    //------------------------------------------------------------------------------

                  ),

                  //------------------------------------------------------------------------------

                ],

              ),

            ),

          ),


        ),


      );

  }

}



//------------------------------------------------------------------------------




