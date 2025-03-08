//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:loverquest/l10n/app_localization.dart';

// CUSTOM FILES
import 'package:loverquest/logics/decks_logics/quests_reader.dart';
import 'package:loverquest/logics/decks_logics/deck_ui_conversion.dart';
import 'package:loverquest/logics/play_logics/player_class.dart';
import 'package:loverquest/pages/play_pages/play_page.dart';

//------------------------------------------------------------------------------


// DECK SELECTION PAGE DEFINITION
class DeckInfoPage extends StatefulWidget {

  // CLASS ATTRIBUTES
  final Players player_1_object;
  final Players player_2_object;
  final Players first_player;
  final DeckReader selected_deck;
  final bool can_edit;
  final bool game_type;

  // CLASS CONSTRUCTOR
  DeckInfoPage({
    Players? player_1_object,
    Players? player_2_object,
    Players? first_player,
    required this.selected_deck,
    required this.can_edit,
    required this.game_type,
    super.key,

    // PLAYER 1 PLACEHOLDER
  })  :player_1_object = player_1_object ?? Players(
    player_icon_path: "assets/default_avatar.png",
    player_alias: "Guest 1",
    player_sex: false,
  ),

    // PLAYER 2 PLACEHOLDER
    player_2_object = player_2_object ?? Players(
      player_icon_path: "assets/default_avatar.png",
      player_alias: "Guest 2",
      player_sex: true,
    ),

    // FIRST PLAYER PLACEHOLDER
    first_player = first_player ?? Players(
      player_icon_path: "assets/default_avatar.png",
      player_alias: "First Player",
      player_sex: false,
    );

  // LINK TO CLASS STATE / WIDGET CONTENT
  @override
  State<DeckInfoPage> createState() => _DeckInfoPageState();

}



//------------------------------------------------------------------------------



// CLASS STATE / WIDGET CONTENT
class _DeckInfoPageState extends State<DeckInfoPage> {

  //------------------------------------------------------------------------------

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


  // INITIALIZING LANGUAGE LABEL
  late LanguageInfo deck_language_label;

  // DEFINING IS LOADING VARIABLE
  bool is_loading = true;

  //------------------------------------------------------------------------------

  // FUNCTION TO TRANSLATE IN MULTIPLE LANGUAGES THE DECKS/QUESTS TOOLS
  List<String> translate_tools (List<String> required_tools) {

    // GETTING THE LANGUAGE IN USE
    final localizations = AppLocalizations.of(context)!;

    // TRANSLATING THE TOOLS
    List<String> translated_tools_list = required_tools.map((tool) {

      switch (tool) {

        case 'female_lingerie':
          return localizations.quest_tool_female_lingerie;
        case 'male_lingerie':
          return localizations.quest_tool_male_lingerie;
        case 'blindfold':
          return localizations.quest_tool_blindfold;
        case 'rope':
          return localizations.quest_tool_rope;
        case 'handcuffs':
          return localizations.quest_tool_handcuffs;
        case 'dice':
          return localizations.quest_tool_dice;
        case 'vibrator':
          return localizations.quest_tool_vibrator;
        case 'remote_vibrator':
          return localizations.quest_tool_remote_vibrator;
        case 'anal_beads':
          return localizations.quest_tool_anal_beads;
        case 'dildo':
          return localizations.quest_tool_dildo;
        case 'inflatable_dildo':
          return localizations.quest_tool_inflatable_dildo;
        case 'suction_cup_dildo':
          return localizations.quest_tool_suction_cup_dildo;
        case 'vibrating_dildo':
          return localizations.quest_tool_vibrating_dildo;
        case 'gag':
          return localizations.quest_tool_gag;
        case 'feather':
          return localizations.quest_tool_feather;
        case 'plug':
          return localizations.quest_tool_plug;
        case 'inflatable_plug':
          return localizations.quest_tool_inflatable_plug;
        case 'vibrating_plug':
          return localizations.quest_tool_vibrating_plug;
        case 'collar_and_leash':
          return localizations.quest_tool_collar_and_leash;
        case 'massage_oil':
          return localizations.quest_tool_massage_oil;
        case 'lubricants':
          return localizations.quest_tool_lubricants;
        case 'strap_on':
          return localizations.quest_tool_strap_on;
        case 'nipple_clamps':
          return localizations.quest_tool_nipple_clamps;
        case 'nipple_pump':
          return localizations.quest_tool_nipple_pump;
        case 'riding_crop':
          return localizations.quest_tool_riding_crop;
        case 'flogger':
          return localizations.quest_tool_flogger;
        case 'spanking_paddle':
          return localizations.quest_tool_spanking_paddle;
        case 'male_chastity_cage':
          return localizations.quest_tool_male_chastity_cage;
        case 'female_chastity_cage':
          return localizations.quest_tool_female_chastity_cage;
        default:
          return tool;

      }
    }).toList();

    // IF THERE ARE NOT TOOLS INSIDE THE DECK/QUEST, SHOW A PROPER LABEL
    if (translated_tools_list.isEmpty) {
      translated_tools_list.add(localizations.deck_info_no_tools_label);
    }

    return translated_tools_list;

  }

  //------------------------------------------------------------------------------

  // CLASS INITIAL STATE
  @override
  void initState() {
    super.initState();

    // LAUNCH THE FUNCTION TO LOAD ALL DEFAULT DECKS
    load_all_quest();

  }

  // INITIAL STATE FUNCTION TO LOAD ALL DEFAULTS DECKS
  Future<void> load_all_quest() async {

    //------------------------------------------------------------------------------

    // ACQUIRING THE CORRECT QUESTS FOR EVERY LIST
    for (Quest element in widget.selected_deck.quests) {

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
      //loaded_decks_list = tempList;
      is_loading = false;
    });
  }

  //------------------------------------------------------------------------------

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // TRANSLATING THE SUMMARY TOOLS
    deck_translated_tools = translate_tools(widget.selected_deck.summary.required_tools);

    // MAKING THE FIRST LETTER OF THE FIRST WORD UPPERCASE
    deck_translated_tools[0] = deck_translated_tools[0][0].toUpperCase() + deck_translated_tools[0].substring(1);

    setState(() {

      // CONVERTING TO STRING TAG THE GAME TYPE
      if (widget.selected_deck.summary.play_distance) {deck_game_type = AppLocalizations.of(context)!.deck_info_distance_label;} else {deck_game_type = AppLocalizations.of(context)!.deck_info_presence_label;}

      // GETTING THE LANGUAGE INFO
      deck_language_label = get_language_info(context, widget.selected_deck.summary.language);

    });
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

    return Scaffold(

      // APP BAR
      appBar: AppBar(),

      // SCAFFOLD CONTENT
      body: SafeArea(

        // SAFE AREA CONTENT
        child: Container(

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

                    // PAGE LOGO
                    Image.asset(
                      'assets/images/deck_info_icon.png',
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
                        AppLocalizations.of(context)!.deck_info_page_title,

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

                    // INFO BOX
                    Container(

                      // SIZE
                      width: double.infinity,

                      // PADDING
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),

                      // ALIGNMENT
                      alignment: Alignment.topRight,

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

                          // DECK NAME TEXT
                          Text.rich(
                            TextSpan (

                                text : AppLocalizations.of(context)!.deck_info_information_name_label,
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),

                                children: [

                                  TextSpan (

                                    text : widget.selected_deck.summary.name,
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

                                text : AppLocalizations.of(context)!.deck_info_information_language_label,
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),

                                children: [

                                  TextSpan (

                                    text : deck_language_label.label,
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

                                text : AppLocalizations.of(context)!.deck_info_information_game_type_label,
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),

                                children: [

                                  TextSpan (

                                    text : deck_game_type,
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

                                    text : deck_translated_tools.join(", "),
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

                                    text : widget.selected_deck.summary.description,
                                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),

                                  ),

                                ]

                            ),
                          ),

                          //------------------------------------------------------------------------------

                          // SPACER
                          const SizedBox(height: 30),

                          //------------------------------------------------------------------------------

                          // BUTTON ALIGNMENT CONTAINER
                          ! widget.can_edit ?Container(

                            // SIZE
                            width: double.infinity,

                            // ALIGNMENT
                            alignment: Alignment.center,

                            // BUTTON BOX
                            child: SizedBox(

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
                                onPressed: () {

                                  // PAGE LINKER
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => PlayPage(

                                      game_type: widget.game_type,
                                      player_1_object: widget.player_1_object,
                                      player_2_object: widget.player_2_object,
                                      first_player: widget.first_player,
                                      early_quests_list: early_quests_list,
                                      early_quests_total_score: early_quests_total_score,
                                      mid_quests_list: mid_quests_list,
                                      mid_quests_total_score: mid_quests_total_score,
                                      late_quests_list: late_quests_list,
                                      late_quests_total_score: late_quests_total_score,
                                      end_quests_list: end_quests_list,
                                      end_quests_total_score: end_quests_total_score,
                                      passed_current_quest: Quest.empty(),
                                      passed_current_quest_list: [],

                                    )

                                    ),

                                        (Route<dynamic> route) => false,
                                  );

                                },

                                // BUTTON CONTENT
                                child: Text(

                                  // TEXT
                                  AppLocalizations.of(context)!.deck_info_start_game_button_label,

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

                          ): SizedBox.shrink(),

                          //------------------------------------------------------------------------------

                        ],

                      ),


                    ),

                    //------------------------------------------------------------------------------

                    // SPACER
                    const SizedBox(height: 45),

                    //------------------------------------------------------------------------------

                    // CARD TEXT
                    Text(
                      // TEXT
                      AppLocalizations.of(context)!.deck_info_quest_list_title,

                      // TEXT STYLE
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
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

              // DYNAMIC PART OF THE PAGE
              SliverList(

                // DYNAMIC PART OF THE WIDGET
                delegate: SliverChildBuilderDelegate(

                  (context, index) {

                    //------------------------------------------------------------------------------

                    // TRANSLATING THE NEEDED TOOLS
                    List<String> translated_quest_tools_list = translate_tools(all_quests_list[index].required_tools);

                    // MAKING THE FIRST LETTER OF THE FIRST WORD UPPERCASE
                    translated_quest_tools_list[0] = translated_quest_tools_list[0][0].toUpperCase() + translated_quest_tools_list[0].substring(1);

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

                    //------------------------------------------------------------------------------

                    // DYNAMIC LIST CONTENT
                    return SizedBox(

                      // WIDTH LARGE AS SCREEN
                      width: double.infinity,

                      // SIZE BOX CONTENT
                      child: Column(

                        // COLUMN CONTENT
                        children: [

                          // FIRST GAME MODE BUTTON
                          ElevatedButton(

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
                            onPressed: () {

                              /* PAGE LINKER
                            Navigator.push(
                              context,
                              MaterialPageRoute(

                                // OPEN NEW PAGE
                                builder: (context) => DefinePlayersNamesPage(couple_type: "hetero"),

                              ),

                            );*/

                            },

                            //------------------------------------------------------------------------------

                            // BUTT0N CONTENT
                            child: Row(

                              // ROW CONTENT
                              children: <Widget>[

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



                                      //------------------------------------------------------------------------------

                                    ],

                                  ),

                                ),

                              ],

                            ),

                          ),

                          // SPACER
                          const SizedBox(height: 15),

                        ],

                      ),

                    );

                    //------------------------------------------------------------------------------

                  },


                  childCount: all_quests_list.length,

                ),

                //------------------------------------------------------------------------------

              ),

            ],

          ),

        ),

      ),

    );

  }

}



//------------------------------------------------------------------------------




