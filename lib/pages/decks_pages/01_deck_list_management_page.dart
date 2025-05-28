//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loverquest/l10n/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';


// CUSTOM FILES
import 'package:loverquest/pages/decks_pages/dialogs/01_deck_filters_ui_page.dart';
import 'package:loverquest/pages/decks_pages/dialogs/02_delete_deck_dialog.dart';

import 'package:loverquest/logics/decks_logics/01_deck_reader_class.dart';
import 'package:loverquest/logics/decks_logics/04_deck_management_class.dart';
import 'package:loverquest/logics/decks_logics/06_reed_deck_list_getter.dart';
import 'package:loverquest/logics/decks_logics/07_deck_filters.dart';

import 'package:loverquest/logics/ui_logics/01_tags_ui_class.dart';

import 'package:loverquest/logics/general/app_router_wrapper_classes.dart';

// HIVE
import 'package:hive_flutter/hive_flutter.dart';


//------------------------------------------------------------------------------



// DECK MANAGEMENT PAGE DEFINITION
class DeckManagementPage extends StatefulWidget {

  // CLASS CONSTRUCTOR
  const DeckManagementPage({super.key});

  @override
  State<DeckManagementPage> createState() => _DeckManagementPageState();

}

// DECK MANAGEMENT PAGE CONTENT
class _DeckManagementPageState extends State<DeckManagementPage> {

  //------------------------------------------------------------------------------

  // DEFINING THE APP PREFERENCE VAR
  late SharedPreferences prefs;

  // INITIALIZING THE DECK WRAPPER OBJECT VAR
  DeckPagesWrapper deck_wrapper_object = DeckPagesWrapper();

  // DEFINING LOADED DECKS LIST AND FILTERED DECKS LIST
  List<DeckReader> decks_list = [];

  // DEFINING IS LOADING VARIABLE
  bool is_loading = true;

  // DEFINING THE FILTERS VAR
  String selected_option_couple_type = 'all';
  String selected_option_game_type = 'both';

  //------------------------------------------------------------------------------

  // CLASS INITIAL STATE
  @override
  void initState() {
    super.initState();

    // WAITING FOR THE END OF THE FIRST FRAME
    WidgetsBinding.instance.addPostFrameCallback((_) {
      
      // EXECUTING THE MICRO TASK
      Future.microtask(() async {

        // LOADING THE APP PREFERENCE
        prefs = await SharedPreferences.getInstance();

        // CHECKING IF IS NECESSARY TO SHOW THE SPLASH SCREEN
        await check_warning_screen();

      });

    });

  }

  // CLASS CODE EXECUTED AFTER EVERY RELOADING
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    // LOADING PAGE DATA
    await page_data_loading();

  }

  //------------------------------------------------------------------------------

  // CHECKING IF IS THE FIRST TIME THAT THE APP IS OPENED IN ORDER TO SHOW THE SPLASH SCREEN
  Future<void> check_warning_screen () async {

    // GETTING THE SPLASH SCREEN PREFERENCE, IF THERE ARE NOT SETTING IT TO ZERO
    bool show_warning_screen = prefs.getBool('show_warning_screen') ?? true;

    // CHECKING IF IS NECESSARY TO SHOW THE SPLASH SCREEN
    if ((show_warning_screen) && (kIsWeb) && !(deck_wrapper_object.load_default_decks_flag ?? false)) {

      // SHOWING THE SPLASH SCREEN
      show_warning_screen_dialog(context);

      // SETTING THE SPLASH SCREEN AS SHOWED
      await prefs.setBool('show_warning_screen', false);

    }

  }

  // APP SPLASH SCREEN DIALOG
  void show_warning_screen_dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {

        //------------------------------------------------------------------------------

        // DIALOG
        return AlertDialog(

          // DIALOG TITLE
          title: Text(

            // TEXT
            AppLocalizations.of(context)!.deck_management_page_warning_dialog_title,

            // ALIGNMENT
            textAlign: TextAlign.center,

            // STYLE
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),

          ),

          // DIALOG CONTENT
          content: Container(

            // SETTING THE WIDTH LIMIT
            constraints: BoxConstraints(maxWidth: 500),

            // CONTAINER CONTENT
            child: SingleChildScrollView(

              child: Text(

                // TEXT
                AppLocalizations.of(context)!.deck_management_page_warning_dialog_content,

                // ALIGNMENT
                textAlign: TextAlign.center,

                // STYLE
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                ),

              ),

            ),

          ),

          // DIALOG BUTTONS
          actions: [

            // BUTTON ROW
            Row(

              // ALIGN
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              // ROW CONTENT
              children: [

                // EXIT BUTTON
                TextButton(

                  // STYLE
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.onPrimary),
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.primary),
                    padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),

                  // FUNCTION
                  onPressed: () => Navigator.of(context).pop(),

                  // BUTTON CONTENT
                  child: Text(

                    // TEXT
                    AppLocalizations.of(context)!.deck_management_page_warning_dialog_ok_button,

                  ),

                ),



              ],

            ),

          ],


        );

      },

    );

  }

  //------------------------------------------------------------------------------

  // INITIAL STATE FUNCTION TO LOAD ALL DEFAULTS DECKS
  Future<void> load_all_default_decks() async {

    //------------------------------------------------------------------------------

    // GETTING THE DEFAULT REED DECK LIST
    List<DeckReader> default_reed_deck_list = await get_default_reed_decks(context);
    
    // SETTING THE CORRECT LIST WITH THE DATA
    decks_list = default_reed_deck_list;
    decks_list = decks_list;
    
  }

  //------------------------------------------------------------------------------

  // INITIAL STATE FUNCTION TO LOAD ALL CUSTOM DECKS FROM HIVE
  Future<void> load_all_custom_decks() async {

    //------------------------------------------------------------------------------

    // OPENING THE CUSTOM DECK HIVE BOX
    final box = await Hive.openBox('customDecks');

    // GETTING ALL THE DECKS KEYS
    List<String> decks_keys = box.keys.cast<String>().toList();

    //------------------------------------------------------------------------------

    // INITIALIZING THE TEMP CUSTOM DECKS LIST
    List<DeckReader> temp_list = [];

   // LOADING AND READING ALL THE CUSTOM DECKS 
    for (String deck_key in decks_keys) {
      
      // LOADING THE DECK
      DeckReader deckManager = DeckReader(deck_key);
      
      // READING THE DECK
      await deckManager.load_deck();
      
      // ADDING THE DECK TO THE TEMP LIST
      temp_list.add(deckManager);
    }

    // SETTING THE CORRECT LIST WITH THE DATA
    decks_list = temp_list;
    decks_list = decks_list;
    
  }

  //------------------------------------------------------------------------------

  // FUNCTION TO APPLY FILTERS SELECTED IN THE FILTERS DIALOG
  void apply_deck_filters() {

    // CHANGING PAGE STATE
    setState(() {

      // GETTING THE LIST OF ALL DECKS
      List<DeckReader> temp_filtered_list = List.from(decks_list);

      // DEFINING THE PLAY DISTANCE VAR
      bool play_presence = true;

      // CHECKING IF THE COUPLE FILTER HAS BEEN SET
      if (selected_option_couple_type != 'all') {

        // FILTERING THE LIST FOR COUPLE TYPE
        temp_filtered_list = filter_decks_for_couple_type(temp_filtered_list, selected_option_couple_type);

      }

      // CHECKING IF THE GAME TYPE FILTER HAS BEEN SET
      if (selected_option_game_type != 'both') {

        // CHECKING IF WHICH IS THE SELECTED FILTER
        if (selected_option_game_type != "distance") {

          // SETTING THE FILTER AS PRESENCE ONLY
          play_presence = true;

          // SETTING THE FILTER AS LOCAL ONLY
        } else {play_presence = false;}

        // GETTING THE FILTERED LIST
        temp_filtered_list = filter_decks_for_presence_distance(temp_filtered_list, play_presence);

      }

      // SETTING THE FILTERED DECK LIST
      decks_list = temp_filtered_list;

    });
  }

  //------------------------------------------------------------------------------

  // FUNCTION TO SHOW THE FILTER DIALOG
  void show_deck_filter_dialog() {
    showDialog(
      context: context,
      builder: (context) => DeckFilterDialog(
        on_filter_selected: (String newCoupleType, String newGameType) {
          setState(() {

            // SETTING THE CHOOSE OPTION
            selected_option_couple_type = newCoupleType;

            // SETTING THE CHOOSE OPTION
            selected_option_game_type = newGameType;

            // APPLYING THE FILTERS TO THE VIEW
            apply_deck_filters();

          });
        },
      ),
    );
  }

  //------------------------------------------------------------------------------

  // FUNCTION TO SHOW THE DELETE CONFIRMATION DIALOG
  void show_deck_delete_dialog(String deck_key, String deck_name) {
    showDialog(
      context: context,
      builder: (context) => DeckDeleteDialog(
        deck_key: deck_key,
        deck_name: deck_name,
      ),
    ).then((result) async {

      // RELOADING THE INTERFACE
      await page_data_loading();

    });

  }

  //------------------------------------------------------------------------------

  // FUNCTION TO RELOAD ALL PAGE DATA
  Future<void> page_data_loading() async {

    // UPDATING THE WIDGET STATUS
    setState(() {
      is_loading = true;
    });

    // GETTING THE DATA FROM THE PROVIDER
    deck_wrapper_object = Provider.of<DeckWrapperProvider>(context, listen: false).wrapperData!;

    // LAUNCH THE FUNCTION TO LOAD ALL DEFAULT DECKS
    if (deck_wrapper_object.load_default_decks_flag == true) {

      // LOADING ALL THE STOCK DECKS
      await load_all_default_decks();

    } else {

      // LOADING ALL THE CUSTOM DECKS
      await load_all_custom_decks();

    }

    // UPDATING THE WIDGET STATUS
    setState(() {
      is_loading = false;
    });

  }

  //------------------------------------------------------------------------------

  // PAGE CONTENT
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

      // APP BAR CONTENT
      appBar: AppBar(

        // DEFINING THE ACTION BUTTONS
        actions: [

          // NEW DECK ICON BUTTON
          !(deck_wrapper_object.load_default_decks_flag ?? false) ?IconButton(
            icon: Icon(Icons.add),

            onPressed: () async {

              // EDITING THE WRAPPER WITH THE CORRECT VALUES
              deck_wrapper_object.load_default_decks_flag = false;
              deck_wrapper_object.new_deck_creation = true;
              deck_wrapper_object.selected_quest = null;
              deck_wrapper_object.selected_deck = null;
              deck_wrapper_object.show_delete_button = null;

              // SAVING THE WRAPPER DATA CONTENT INSIDE THE PROVIDER
              Provider.of<DeckWrapperProvider>(context, listen: false).updateWrapperData(deck_wrapper_object);

              // PAGE LINKER
              await context.push('/decks/user/custom_decks_list/create/new_deck_editor');

              // OPENING THE DECK EDITOR AFTER THE DECK CREATION
              if (deck_wrapper_object.selected_deck != null) {

                // PAGE LINKER
                await context.push('/decks/user/custom_decks_list/edit/deck_main_editor');

              }

              // RELOADING PAGE DATA
              await page_data_loading();

            },

          ): SizedBox.shrink(),

          // FILTER ICON BUTTON
          IconButton(
            icon: Icon(Icons.filter_alt_rounded),
            onPressed: () => show_deck_filter_dialog(),
          ),

          // IMPORT DECK ICON BUTTON
          !(deck_wrapper_object.load_default_decks_flag ?? false) ?IconButton(
            icon: Icon(Icons.download_rounded),
            onPressed: () async {

              // IMPORTING THE CUSTOM DECK
              bool deck_correct_imported = await DeckManagement.import_json_file_to_hive();

              // CHECKING IF THE INTERFACE IS STILL MOUNTED
              if (!mounted) return;

              // CHECKING IF THE CUSTOM DECK WAS CORRECTLY IMPORTED
              if (!deck_correct_imported) {

                // SHOWING ERROR POPUP
                // ignore: use_build_context_synchronously
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
                            // ignore: use_build_context_synchronously
                            AppLocalizations.of(context)!.deck_management_page_import_error_text,

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

              }

              // RELOADING THE PAGE
              await page_data_loading();

            },
          ): SizedBox.shrink(),

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

            // TEXT TO DISPLAY IF THERE ARE NO DECKS
            child: decks_list.isEmpty ? Center(

              child: Text(

                AppLocalizations.of(context)!.deck_management_page_no_decks_text,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),

            )

            // DYNAMIC PART OF THE PAGE
            : CustomScrollView (

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

                      // PAGE TITLE CONTAINER
                      FractionallySizedBox(

                        // DYNAMIC WIDTH
                        widthFactor: 0.8,

                        // TITLE
                        child: Text(
                          // TEXT
                          (deck_wrapper_object.load_default_decks_flag ?? false) ?AppLocalizations.of(context)!.deck_management_page_default_deck_list: AppLocalizations.of(context)!.deck_management_page_custom_deck_list,

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
                      const SizedBox(height: 30),

                      //------------------------------------------------------------------------------

                    ],

                  ),

                ),

                //------------------------------------------------------------------------------

                 SliverList(

                  // DYNAMIC PART OF THE WIDGET
                  delegate: SliverChildBuilderDelegate( (context, index) {

                      //------------------------------------------------------------------------------

                      String deck_key = decks_list[index].deck_key;
                      String deck_name = decks_list[index].summary.name;
                      int deck_quest_number = decks_list[index].summary.total_quests;

                      //------------------------------------------------------------------------------

                      // GETTING DECK TAG INFO
                      LanguageInfo language_info_object = get_language_info(context, decks_list[index].summary.language);
                      CoupleTypeInfo couple_type_info_object = get_couple_type_info(context, decks_list[index].summary.couple_type);
                      GameTypeInfo game_type_info_object = get_game_type_type_info(context, decks_list[index].summary.play_presence);
                      ToolsInfo tools_info_object = get_tools_info(context, decks_list[index].summary.required_tools);

                      OralSexTagInfo oral_sex_tag_object = get_oral_tag_info(context, decks_list[index].summary.tags);
                      AnalSexTagInfo anal_sex_tag_object = get_anal_tag_info(context, decks_list[index].summary.tags);
                      VaginalSexTagInfo vaginal_sex_tag_object = get_vaginal_tag_info(context, decks_list[index].summary.tags);
                      BondageTagInfo bondage_tag_object = get_bondage_tag_info(context, decks_list[index].summary.tags);
                      BdsmTagInfo bdsm_tag_object = get_bdsm_tag_info(context, decks_list[index].summary.tags);

                      ChatTagInfo chat_tag_object = get_chat_tag_info(context, decks_list[index].summary.tags);
                      VideoCallTagInfo video_call_tag_object = get_video_call_tag_info(context, decks_list[index].summary.tags);

                      //------------------------------------------------------------------------------

                      // DYNAMIC LIST CONTENT
                      return Align(

                        // ALIGNMENT
                        alignment: Alignment.center,

                        // ALIGNMENT CONTENT
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

                                    if (!(deck_wrapper_object.load_default_decks_flag ?? false))

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

                                    // EXPORT ENTRY
                                    PopupMenuItem(

                                      // ENTRY VALUE
                                      value: 'export',

                                      // ENTRY CONTENT
                                      child: Row(

                                        // ROW CONTENT
                                        children: [

                                          // ENTRY ICON
                                          Icon(

                                            // ICON
                                            Icons.share,

                                            // ICON SIZE
                                            size: 18,

                                          ),

                                          // SPACER
                                          SizedBox(width: 5),

                                          // ENTRY TEXT
                                          Expanded(child: Text(AppLocalizations.of(context)!.deck_management_press_menu_export)),

                                        ],

                                      ),

                                    ),

                                    if (!(deck_wrapper_object.load_default_decks_flag ?? false))

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

                                    if (deck_wrapper_object.load_default_decks_flag ?? false)

                                      // EDIT ENTRY
                                      PopupMenuItem(

                                        // ENTRY VALUE
                                        value: 'edit',

                                        // ENTRY CONTENT
                                        child: Row(

                                          // ROW CONTENT
                                          children: [

                                            // ENTRY ICON
                                            Icon(

                                              // ICON
                                              Icons.edit,

                                              // ICON SIZE
                                              size: 18,

                                            ),

                                            // SPACER
                                            SizedBox(width: 5),

                                            // ENTRY TEXT
                                            Expanded(child: Text(AppLocalizations.of(context)!.deck_management_press_menu_edit)),

                                          ],

                                        ),

                                      ),

                                  ],

                                  // MENU CONDITION ON ANY BUTTON PRESSED
                                ).then((value) async {

                                  // CHECKING WHICH OPTION WAS CHOOSE
                                  if (value == "export") {

                                    if (deck_wrapper_object.load_default_decks_flag ?? false) {

                                      // EXPORTING THE DECK
                                      await DeckManagement.export_json_file(deck_key, deck_name, isAsset: true);

                                    } else {

                                      // EXPORTING THE DECK
                                      await DeckManagement.export_json_file_from_hive(deck_name);

                                    }

                                  } else if (value == "delete") {

                                    // SHOWING THE DELETE DIALOG
                                    show_deck_delete_dialog(deck_key, deck_name);

                                    // UPDATING PAGE DATA
                                    await page_data_loading();

                                  } else if (value == "duplicate") {

                                    // SAVING THE DECK
                                    await DeckManagement.save_deck(

                                      deck_name: "${decks_list[index].summary.name}_2",
                                      deck_description: decks_list[index].summary.description,
                                      deck_language: decks_list[index].summary.language,
                                      couple_type: decks_list[index].summary.couple_type,
                                      play_presence: decks_list[index].summary.play_presence,
                                      deck_tags: decks_list[index].summary.tags,
                                      already_existing_deck: decks_list[index],
                                      deck_duplication: true,

                                    );

                                    // UPDATING PAGE DATA
                                    await page_data_loading();

                                  } else if (value == "edit") {

                                    // SAVING THE DECK
                                   String new_duplicated_deck_key = await DeckManagement.save_deck(

                                        deck_name: "${decks_list[index].summary.name}_2",
                                        deck_description: decks_list[index].summary.description,
                                        deck_language: decks_list[index].summary.language,
                                        couple_type: decks_list[index].summary.couple_type,
                                        play_presence: decks_list[index].summary.play_presence,
                                        deck_tags: decks_list[index].summary.tags,
                                        already_existing_deck: decks_list[index],
                                        deck_duplication: true,

                                    );

                                   // INITIALIZING THE DUPLICATED DECK
                                   DeckReader new_duplicated_deck = DeckReader(new_duplicated_deck_key);

                                   // LOADING THE DUPLICATED DECK
                                   await new_duplicated_deck.load_deck();

                                   // CHECKING IF THE INTERFACE IS STILL MOUNTED
                                   if (!mounted) return;

                                   // EDITING THE WRAPPER WITH THE CORRECT VALUES
                                   deck_wrapper_object.load_default_decks_flag = false;
                                   deck_wrapper_object.selected_deck = new_duplicated_deck;
                                   deck_wrapper_object.show_delete_button = null;
                                   deck_wrapper_object.selected_quest = null;
                                   deck_wrapper_object.new_deck_creation = false;

                                   // SAVING THE WRAPPER DATA CONTENT INSIDE THE PROVIDER
                                   Provider.of<DeckWrapperProvider>(context, listen: false).updateWrapperData(deck_wrapper_object);

                                   // PAGE LINKER
                                   await context.push('/decks/user/custom_decks_list/edit/deck_main_editor');

                                   // RELOADING PAGE DATA
                                   await page_data_loading();

                                  }


                                });

                              },

                              //------------------------------------------------------------------------------

                              // DECK BUTTON
                              child:  ElevatedButton(

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
                                  deck_wrapper_object.selected_deck = decks_list[index];
                                  deck_wrapper_object.show_delete_button = null;
                                  deck_wrapper_object.selected_quest = null;
                                  deck_wrapper_object.new_deck_creation = false;

                                  // SAVING THE WRAPPER DATA CONTENT INSIDE THE PROVIDER
                                  Provider.of<DeckWrapperProvider>(context, listen: false).updateWrapperData(deck_wrapper_object);

                                  // IF WAS OPENED THE DEFAULT DECKS VIEW
                                  if (deck_wrapper_object.load_default_decks_flag ?? true) {

                                    // PAGE LINKER
                                    final editing_stock = await context.push('/decks/stock/default_decks_list/deck_inspector');

                                    // CHECKING IF WE ARE COMING BACK TO CLONE AND EDIT A STOCK DECK
                                    if (editing_stock == true) {

                                      // PAGE LINKER
                                      await context.push('/decks/user/custom_decks_list/edit/deck_main_editor');

                                    }

                                  } else {

                                    // PAGE LINKER
                                    await context.push('/decks/user/custom_decks_list/edit/deck_main_editor');

                                  }

                                  // RELOADING PAGE DATA
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

                                          // CARD TEXT
                                          Text(
                                            // TEXT
                                            deck_name,

                                            // TEXT STYLE
                                            style: TextStyle(
                                              fontSize: 18.5,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),

                                          //------------------------------------------------------------------------------

                                          // SPACER
                                          const SizedBox(height: 15),

                                          //------------------------------------------------------------------------------

                                          // TAGS BOX
                                          Wrap(

                                            // ELEMENTS HORIZONTAL SPACING
                                            spacing: 5,

                                            // ELEMENTS VERTICAL SPACING
                                            runSpacing: 7,

                                            children: [

                                              //------------------------------------------------------------------------------

                                              // LANGUAGE TAG
                                              Container(

                                                // PADDING
                                                padding: EdgeInsets.all(7),

                                                //CONTAINER STYLE
                                                decoration: BoxDecoration(

                                                  // BACKGROUND COLOR
                                                  color: language_info_object.background_color,

                                                  // BORDER RADIUS
                                                  borderRadius: BorderRadius.circular(16),

                                                  // BORDER STYLE
                                                  border: Border.all(
                                                    color: language_info_object.background_color,
                                                    width: 1,
                                                  ),

                                                ),

                                                // CONTAINER CONTENT
                                                child: Text(

                                                  // TEXT
                                                  language_info_object.label,

                                                  // TEXT STYLE
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                  ),

                                                ),

                                              ),

                                              //------------------------------------------------------------------------------

                                              // COUPLE TYPE TAG
                                              Container(

                                                // PADDING
                                                padding: EdgeInsets.all(7),

                                                //CONTAINER STYLE
                                                decoration: BoxDecoration(

                                                  // BACKGROUND COLOR
                                                  color: couple_type_info_object.background_color,

                                                  // BORDER RADIUS
                                                  borderRadius: BorderRadius.circular(16),

                                                  // BORDER STYLE
                                                  border: Border.all(
                                                    color: couple_type_info_object.background_color,
                                                    width: 1,
                                                  ),

                                                ),

                                                // CONTAINER CONTENT
                                                child: Text(

                                                  // TEXT
                                                  couple_type_info_object.label,

                                                  // TEXT STYLE
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                  ),

                                                ),

                                              ),

                                              //------------------------------------------------------------------------------

                                              // GAME TYPE TAG
                                              Container(

                                                // PADDING
                                                padding: EdgeInsets.all(7),

                                                //CONTAINER STYLE
                                                decoration: BoxDecoration(

                                                  // BACKGROUND COLOR
                                                  color: game_type_info_object.background_color,

                                                  // BORDER RADIUS
                                                  borderRadius: BorderRadius.circular(16),

                                                  // BORDER STYLE
                                                  border: Border.all(
                                                    color: game_type_info_object.background_color,
                                                    width: 1,
                                                  ),

                                                ),

                                                // CONTAINER CONTENT
                                                child: Text(

                                                  // TEXT
                                                  game_type_info_object.label,

                                                  // TEXT STYLE
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                  ),

                                                ),

                                              ),

                                              //------------------------------------------------------------------------------

                                              // TOOLS TAG
                                              Container(

                                                // PADDING
                                                padding: EdgeInsets.all(7),

                                                //CONTAINER STYLE
                                                decoration: BoxDecoration(

                                                  // BACKGROUND COLOR
                                                  color: tools_info_object.background_color,

                                                  // BORDER RADIUS
                                                  borderRadius: BorderRadius.circular(16),

                                                  // BORDER STYLE
                                                  border: Border.all(
                                                    color: tools_info_object.background_color,
                                                    width: 1,
                                                  ),

                                                ),

                                                // CONTAINER CONTENT
                                                child: Text(

                                                  // TEXT
                                                  tools_info_object.label,

                                                  // TEXT STYLE
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                  ),

                                                ),

                                              ),

                                              //------------------------------------------------------------------------------

                                              // QUEST NUMBER TAG
                                              Container(

                                                // PADDING
                                                padding: EdgeInsets.all(7),

                                                //CONTAINER STYLE
                                                decoration: BoxDecoration(

                                                  // BACKGROUND COLOR
                                                  color: Color(0xff376255),

                                                  // BORDER RADIUS
                                                  borderRadius: BorderRadius.circular(16),

                                                  // BORDER STYLE
                                                  border: Border.all(
                                                    color: Color(0xff376255),
                                                    width: 1,
                                                  ),

                                                ),

                                                // CONTAINER CONTENT
                                                child: Text(

                                                  // TEXT
                                                  '$deck_quest_number quest',

                                                  // TEXT STYLE
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                  ),

                                                ),

                                              ),

                                              //------------------------------------------------------------------------------

                                              // ORAL SEX TAG
                                              if (oral_sex_tag_object.show_tag)

                                                Container(

                                                  // PADDING
                                                  padding: EdgeInsets.all(7),

                                                  //CONTAINER STYLE
                                                  decoration: BoxDecoration(

                                                    // BACKGROUND COLOR
                                                    color: oral_sex_tag_object.background_color,

                                                    // BORDER RADIUS
                                                    borderRadius: BorderRadius.circular(16),

                                                    // BORDER STYLE
                                                    border: Border.all(
                                                      color: oral_sex_tag_object.background_color,
                                                      width: 1,
                                                    ),

                                                  ),

                                                  // CONTAINER CONTENT
                                                  child: Text(

                                                    // TEXT
                                                    oral_sex_tag_object.label,

                                                    // TEXT STYLE
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),

                                                  ),

                                                ),

                                              //------------------------------------------------------------------------------

                                              // ANAL SEX TAG
                                              if (anal_sex_tag_object.show_tag)
                                                Container(

                                                  // PADDING
                                                  padding: EdgeInsets.all(7),

                                                  //CONTAINER STYLE
                                                  decoration: BoxDecoration(

                                                    // BACKGROUND COLOR
                                                    color: anal_sex_tag_object.background_color,

                                                    // BORDER RADIUS
                                                    borderRadius: BorderRadius.circular(16),

                                                    // BORDER STYLE
                                                    border: Border.all(
                                                      color: anal_sex_tag_object.background_color,
                                                      width: 1,
                                                    ),

                                                  ),

                                                  // CONTAINER CONTENT
                                                  child: Text(

                                                    // TEXT
                                                    anal_sex_tag_object.label,

                                                    // TEXT STYLE
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),

                                                  ),

                                                ),

                                              //------------------------------------------------------------------------------

                                              // VAGINAL SEX TAG
                                              if (vaginal_sex_tag_object.show_tag)
                                                Container(

                                                  // PADDING
                                                  padding: EdgeInsets.all(7),

                                                  //CONTAINER STYLE
                                                  decoration: BoxDecoration(

                                                    // BACKGROUND COLOR
                                                    color: vaginal_sex_tag_object.background_color,

                                                    // BORDER RADIUS
                                                    borderRadius: BorderRadius.circular(16),

                                                    // BORDER STYLE
                                                    border: Border.all(
                                                      color: vaginal_sex_tag_object.background_color,
                                                      width: 1,
                                                    ),

                                                  ),

                                                  // CONTAINER CONTENT
                                                  child: Text(

                                                    // TEXT
                                                    vaginal_sex_tag_object.label,

                                                    // TEXT STYLE
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),

                                                  ),

                                                ),

                                              //------------------------------------------------------------------------------

                                              // BONDAGE SEX TAG
                                              if (bondage_tag_object.show_tag)
                                                Container(

                                                  // PADDING
                                                  padding: EdgeInsets.all(7),

                                                  //CONTAINER STYLE
                                                  decoration: BoxDecoration(

                                                    // BACKGROUND COLOR
                                                    color: bondage_tag_object.background_color,

                                                    // BORDER RADIUS
                                                    borderRadius: BorderRadius.circular(16),

                                                    // BORDER STYLE
                                                    border: Border.all(
                                                      color: bondage_tag_object.background_color,
                                                      width: 1,
                                                    ),

                                                  ),

                                                  // CONTAINER CONTENT
                                                  child: Text(

                                                    // TEXT
                                                    bondage_tag_object.label,

                                                    // TEXT STYLE
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),

                                                  ),

                                                ),

                                              //------------------------------------------------------------------------------

                                              // BDSM SEX TAG
                                              if (bdsm_tag_object.show_tag)
                                                Container(

                                                  // PADDING
                                                  padding: EdgeInsets.all(7),

                                                  //CONTAINER STYLE
                                                  decoration: BoxDecoration(

                                                    // BACKGROUND COLOR
                                                    color: bdsm_tag_object.background_color,

                                                    // BORDER RADIUS
                                                    borderRadius: BorderRadius.circular(16),

                                                    // BORDER STYLE
                                                    border: Border.all(
                                                      color: bdsm_tag_object.background_color,
                                                      width: 1,
                                                    ),

                                                  ),

                                                  // CONTAINER CONTENT
                                                  child: Text(

                                                    // TEXT
                                                    bdsm_tag_object.label,

                                                    // TEXT STYLE
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),

                                                  ),

                                                ),

                                              //------------------------------------------------------------------------------

                                              // CHAT SEX TAG
                                              if (chat_tag_object.show_tag)
                                                Container(

                                                  // PADDING
                                                  padding: EdgeInsets.all(7),

                                                  //CONTAINER STYLE
                                                  decoration: BoxDecoration(

                                                    // BACKGROUND COLOR
                                                    color: chat_tag_object.background_color,

                                                    // BORDER RADIUS
                                                    borderRadius: BorderRadius.circular(16),

                                                    // BORDER STYLE
                                                    border: Border.all(
                                                      color: chat_tag_object.background_color,
                                                      width: 1,
                                                    ),

                                                  ),

                                                  // CONTAINER CONTENT
                                                  child: Text(

                                                    // TEXT
                                                    chat_tag_object.label,

                                                    // TEXT STYLE
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),

                                                  ),

                                                ),

                                              //------------------------------------------------------------------------------

                                              // VIDEO SEX TAG
                                              if (video_call_tag_object.show_tag)
                                                Container(

                                                  // PADDING
                                                  padding: EdgeInsets.all(7),

                                                  //CONTAINER STYLE
                                                  decoration: BoxDecoration(

                                                    // BACKGROUND COLOR
                                                    color: video_call_tag_object.background_color,

                                                    // BORDER RADIUS
                                                    borderRadius: BorderRadius.circular(16),

                                                    // BORDER STYLE
                                                    border: Border.all(
                                                      color: video_call_tag_object.background_color,
                                                      width: 1,
                                                    ),

                                                  ),

                                                  // CONTAINER CONTENT
                                                  child: Text(

                                                    // TEXT
                                                    video_call_tag_object.label,

                                                    // TEXT STYLE
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),

                                                  ),

                                                ),

                                              //------------------------------------------------------------------------------


                                            ],

                                          ),

                                          //------------------------------------------------------------------------------

                                        ],

                                      ),

                                    ),

                                    // ARROW ICON
                                    Icon(

                                      // ICON IMAGE
                                      Icons.arrow_forward,

                                      // ICON COLOR
                                      color: Theme.of(context).colorScheme.onPrimary,

                                    )

                                  ],

                                ),

                              ),

                              //------------------------------------------------------------------------------

                            ),

                            // SPACER
                            const SizedBox(height: 15),

                          ],

                        ),

                      );



                    },

                    // GETTING THE LIST ELEMENT
                    childCount: decks_list.length,

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












