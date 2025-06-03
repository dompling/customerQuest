//------------------------------------------------------------------------------
// Loverquest - https://github.com/H3rz3n/loverquest/
//
// Copyright (C) 2025 Lorenzo Maiuri & Contributors
//
// This file is part of Loverquest.
//
// Loverquest is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Loverquest is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Loverquest.  If not, see <https://www.gnu.org/licenses/>.
//
//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:loverquest/l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// CUSTOM FILES
import 'package:loverquest/pages/snackbars/01_snackbar_templates.dart';

import 'package:loverquest/logics/play_logics/01_match_data_class.dart';

import 'package:loverquest/logics/decks_logics/03_quest_class.dart';
import 'package:loverquest/logics/ui_logics/03_translate_tools_labels.dart';
import 'package:loverquest/logics/ui_logics/02_translate_tags_labels.dart';
import 'package:loverquest/logics/ui_logics/01_tags_ui_class.dart';

//------------------------------------------------------------------------------


// DECK SELECTION PAGE DEFINITION
class PlayDeckInfoPage extends StatefulWidget {

  // CLASS CONSTRUCTOR
  const PlayDeckInfoPage({super.key});

  // LINK TO CLASS STATE / WIDGET CONTENT
  @override
  State<PlayDeckInfoPage> createState() => _PlayDeckInfoPageState();

}



//------------------------------------------------------------------------------



// CLASS STATE / WIDGET CONTENT
class _PlayDeckInfoPageState extends State<PlayDeckInfoPage> {

  //------------------------------------------------------------------------------

  // INITIALIZING THE MATCH DATA OBJECT
  MatchData match_data = MatchData();

  // INITIALIZING QUEST LISTS
  List<Quest> early_quests_list = [];
  List<Quest> mid_quests_list = [];
  List<Quest> late_quests_list = [];
  List<Quest> end_quests_list = [];
  List<Quest> all_quests_list = [];

  // INITIALIZING GAME TYPE TAG
  String deck_game_type = "";

  // INITIALIZING TOOLS NEEDED
  String deck_needed_tools = "";

  // INITIALIZING TOOLS TRANSLATION
  late List<String> deck_translated_tools;

  // INITIALIZING TAGS LIST TRANSLATION
  late List<String> deck_translated_tags;

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

    // SHOWING THE FIELD ERROR SNACKBAR
    show_error_snackbar(context, AppLocalizations.of(context)!.deck_info_deck_unplayable_error);

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

    // GETTING THE DATA FROM THE PROVIDER
    match_data = Provider.of<MatchDataProvider>(context, listen: false).matchData!;

    // LAUNCH THE FUNCTION TO LOAD ALL DEFAULT DECKS
    load_all_quest();

  }

  // INITIAL STATE FUNCTION TO LOAD ALL DEFAULTS DECKS
  Future<void> load_all_quest() async {

    //------------------------------------------------------------------------------

    // ACQUIRING THE CORRECT QUESTS FOR EVERY LIST
    for (Quest element in match_data.selected_deck.quests) {

      if (element.moment == "early") {

        // ADDING THE ELEMENT TO THE LIST
        early_quests_list.add(element);

      } else if (element.moment == "mid") {

        // ADDING THE ELEMENT TO THE LIST
        mid_quests_list.add(element);

      } else if (element.moment == "late") {

        // ADDING THE ELEMENT TO THE LIST
        late_quests_list.add(element);

      } else {

        // ADDING THE ELEMENT TO THE LIST
        end_quests_list.add(element);

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
    deck_translated_tools = translate_tools(context, match_data.selected_deck.summary.required_tools);

    // MAKING THE FIRST LETTER OF THE FIRST WORD UPPERCASE
    deck_translated_tools[0] = deck_translated_tools[0][0].toUpperCase() + deck_translated_tools[0].substring(1);

    // TRANSLATING THE SUMMARY TAGS
    deck_translated_tags = translate_tags(context, match_data.selected_deck.summary.tags);

    // MAKING THE FIRST LETTER OF THE FIRST WORD UPPERCASE
    deck_translated_tags[0] = deck_translated_tags[0][0].toUpperCase() + deck_translated_tags[0].substring(1);

    // GETTING THE CORRECT LABEL FOR THE COUPLE TYPE LABEL
    if (match_data.selected_deck.summary.couple_type == "hetero") {

    // SETTING THE COUPLE TYPE LABEL
    deck_couple_type_label = AppLocalizations.of(context)!.deck_info_couple_type_hetero;

    } else if (match_data.selected_deck.summary.couple_type == "lesbian") {

    // SETTING THE COUPLE TYPE LABEL
    deck_couple_type_label = AppLocalizations.of(context)!.deck_info_couple_type_lesbian;

    } else {

    // SETTING THE COUPLE TYPE LABEL
    deck_couple_type_label = AppLocalizations.of(context)!.deck_info_couple_type_gay;

    }

    setState(() {

      // CONVERTING TO STRING TAG THE GAME TYPE
      if (match_data.selected_deck.summary.play_presence) {deck_game_type = AppLocalizations.of(context)!.deck_info_presence_label;} else {deck_game_type = AppLocalizations.of(context)!.deck_info_distance_label;}

      // GETTING THE LANGUAGE INFO
      deck_language_label = get_language_info(context, match_data.selected_deck.summary.language);

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

                                      text : match_data.selected_deck.summary.name,
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
                                      text : '${match_data.selected_deck.summary.total_quests}',

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

                                  text : AppLocalizations.of(context)!.deck_info_information_description_label,
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),

                                  children: [

                                    TextSpan (

                                      text : match_data.selected_deck.summary.description,
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
                            Container(

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

                                    // SETTING THE DECKS INSIDE MATCH DATA
                                    match_data.deck_early_quest_list = early_quests_list;
                                    match_data.deck_mid_quest_list = mid_quests_list;
                                    match_data.deck_late_quest_list = late_quests_list;
                                    match_data.deck_end_quest_list = end_quests_list;

                                    // CHECKING IF THE INTERFACE IS STILL MOUNTED
                                    if (!mounted) return;

                                    // CHECKING IF THE DECK IS PLAYABLE
                                    if(is_playable) {

                                      // SAVING THE MATCH DATA CONTENT INSIDE THE PROVIDER
                                      Provider.of<MatchDataProvider>(context, listen: false).updateMatchData(match_data);

                                      // PAGE LINKER
                                      context.push('/play/game_pace');

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

                            ),

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




