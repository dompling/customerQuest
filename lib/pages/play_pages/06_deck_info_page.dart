//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:loverquest/l10n/app_localization.dart';

// CUSTOM FILES
import 'package:loverquest/logics/decks_logics/translate_tools.dart';
import 'package:loverquest/logics/decks_logics/deck_and_quests_reader.dart';
import 'package:loverquest/logics/decks_logics/deck_ui_conversion.dart';
import 'package:loverquest/logics/play_logics/player_class.dart';
import 'package:loverquest/pages/play_pages/07_select_game_speed.dart';

//------------------------------------------------------------------------------


// DECK SELECTION PAGE DEFINITION
class DeckInfoPage extends StatefulWidget {

  // CLASS ATTRIBUTES
  final bool game_type;
  final Players player_1_object;
  final Players player_2_object;
  final Players first_player;
  final DeckReader selected_deck;
  final bool can_edit;

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
    player_early_quest_list: [],
    player_mid_quest_list: [],
    player_late_quest_list: [],
    player_end_quest_list: [],
  ),

    // PLAYER 2 PLACEHOLDER
    player_2_object = player_2_object ?? Players(
      player_icon_path: "assets/default_avatar.png",
      player_alias: "Guest 2",
      player_sex: true,
      player_early_quest_list: [],
      player_mid_quest_list: [],
      player_late_quest_list: [],
      player_end_quest_list: [],
    ),

    // FIRST PLAYER PLACEHOLDER
    first_player = first_player ?? Players(
      player_icon_path: "assets/default_avatar.png",
      player_alias: "First Player",
      player_sex: false,
      player_early_quest_list: [],
      player_mid_quest_list: [],
      player_late_quest_list: [],
      player_end_quest_list: [],
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

  // INITIALIZING COUPLE TYPE LABEL
  late String deck_couple_type_label;

  // INITIALIZING LANGUAGE LABEL
  late LanguageInfo deck_language_label;

  // INITIALING THE PLAYABLE TAG
  bool is_playable = false;

  // DEFINING IS LOADING VARIABLE
  bool is_loading = true;

  //------------------------------------------------------------------------------

  // FUNCTION THAT WILL CHECK IF THE DECK IS PLAYABLE COUNTING THE QUEST NUMBER
  Future<void> check_deck_quest_number() async {

    // CHECKING IF IS NECESSARY TO SHOW THE ERROR BANNER
    if (early_quests_list.isEmpty && mid_quests_list.isEmpty && late_quests_list.isEmpty && end_quests_list.isEmpty) {

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
                  AppLocalizations.of(context)!.deck_info_deck_unplayable_error,

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

      // SETTING THE DECK AS PLAYABLE
      is_playable = true;

    }

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
    deck_translated_tools = translate_tools(context, widget.selected_deck.summary.required_tools);

    // MAKING THE FIRST LETTER OF THE FIRST WORD UPPERCASE
    deck_translated_tools[0] = deck_translated_tools[0][0].toUpperCase() + deck_translated_tools[0].substring(1);

    // GETTING THE CORRECT LABEL FOR THE COUPLE TYPE LABEL
    if (widget.selected_deck.summary.couple_type == "hetero") {

    // SETTING THE COUPLE TYPE LABEL
    deck_couple_type_label = AppLocalizations.of(context)!.deck_info_couple_type_hetero;

    } else if (widget.selected_deck.summary.couple_type == "lesbian") {

    // SETTING THE COUPLE TYPE LABEL
    deck_couple_type_label = AppLocalizations.of(context)!.deck_info_couple_type_lesbian;

    } else {

    // SETTING THE COUPLE TYPE LABEL
    deck_couple_type_label = AppLocalizations.of(context)!.deck_info_couple_type_gay;

    }

    setState(() {

      // CONVERTING TO STRING TAG THE GAME TYPE
      if (widget.selected_deck.summary.play_presence) {deck_game_type = AppLocalizations.of(context)!.deck_info_distance_label;} else {deck_game_type = AppLocalizations.of(context)!.deck_info_presence_label;}

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

    // PAGE UI CONTAINER
    return Scaffold(

      // APP BAR
      appBar: AppBar(),

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

                        // SETTING CONTAINER MAX SIZE
                        constraints: BoxConstraints(maxWidth: 600,),

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
                                      text : '${widget.selected_deck.summary.total_quests}',

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
                                  onPressed: () async {

                                    // CHECKING IF THE DECK IS PLAYABLE
                                    await check_deck_quest_number();

                                    // CHECKING IF THE DECK IS PLAYABLE
                                    if(is_playable) {

                                      // PAGE LINKER
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SelectGameSpeed(

                                          game_type: widget.game_type,
                                          player_1_object: widget.player_1_object,
                                          player_2_object: widget.player_2_object,
                                          first_player_object: widget.first_player,
                                          early_quests_list: early_quests_list,
                                          mid_quests_list: mid_quests_list,
                                          late_quests_list: late_quests_list,
                                          end_quests_list: end_quests_list,

                                        )

                                        ),

                                      );

                                    }

                                  },

                                  // BUTTON CONTENT
                                  child: Text(

                                    // TEXT
                                    AppLocalizations.of(context)!.deck_info_select_deck_button_label,

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
                      List<String> translated_quest_tools_list = translate_tools(context, all_quests_list[index].required_tools);

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

                      // GETTING THE CORRECT TIMER STRING
                      String quest_timer = '';
                      if (all_quests_list[index].timer != 0) {

                        quest_timer = '${all_quests_list[index].timer} ${AppLocalizations.of(context)!.deck_info_information_minute_label}';

                      } else {

                        quest_timer = AppLocalizations.of(context)!.deck_info_no_tools_label;

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

                        // ALIGNMENT
                        alignment: Alignment.center,

                        // ALIGNMENT CONTENT
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
                              onPressed: () {},

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

      ),

    );

  }

}



//------------------------------------------------------------------------------




