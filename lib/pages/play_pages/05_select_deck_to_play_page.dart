//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:loverquest/l10n/app_localization.dart';

// CUSTOM FILES
import 'package:loverquest/logics/play_logics/01_match_data_class.dart';

import 'package:loverquest/logics/decks_logics/01_deck_reader_class.dart';
import 'package:loverquest/logics/decks_logics/06_reed_deck_list_getter.dart';
import 'package:loverquest/logics/ui_logics/01_tags_ui_class.dart';
import 'package:loverquest/logics/decks_logics/deck_filters.dart';

import 'package:loverquest/pages/play_pages/06_deck_info_page.dart';

//------------------------------------------------------------------------------


// DECK SELECTION PAGE DEFINITION
class DeckSelectionPage extends StatefulWidget {

  // CLASS ATTRIBUTES
  final MatchData match_data;

  // CLASS CONSTRUCTOR
  const DeckSelectionPage({required this.match_data, super.key,});

  // LINK TO CLASS STATE / WIDGET CONTENT
  @override
  State<DeckSelectionPage> createState() => _DeckSelectionPageState();

}



//------------------------------------------------------------------------------



// CLASS STATE / WIDGET CONTENT
class _DeckSelectionPageState extends State<DeckSelectionPage> {

  //------------------------------------------------------------------------------

  // DEFINING LOADED DECKS LIST
  List<DeckReader> loaded_decks_list = [];

  // DEFINING IS LOADING VARIABLE
  bool is_loading = true;

  // DEFINING THE IS INITIALIZED VARIABLE
  bool _isInitialized = false;

  //------------------------------------------------------------------------------

  // CLASS INITIAL STATE
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // CHECKING IF THE LIST HAS BEEN ALREADY LOADED IN ORDER TO AVOID MULTIPLE LOADING
    if (!_isInitialized) {
      _isInitialized = true;
      load_all_decks();

    }

  }

  //------------------------------------------------------------------------------

  // INITIAL STATE FUNCTION TO LOAD ALL DEFAULTS DECKS
  Future<void> load_all_decks() async {

    //------------------------------------------------------------------------------

    // GETTING THE DEFAULT REED DECK LIST
    List<DeckReader> default_reed_deck_list = await get_default_reed_decks(context, is_presence: widget.match_data.play_local);

    //------------------------------------------------------------------------------

    // GETTING THE CUSTOM HIVE REED DECK LIST
    List<DeckReader> custom_reed_deck_list = await get_custom_hive_reed_decks();

    //------------------------------------------------------------------------------

    // UPDATING THE WIDGET STATUS WITH THE LOADED DATA
    setState(() {
      loaded_decks_list = custom_reed_deck_list + default_reed_deck_list;
      is_loading = false;
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

    // FILTERING THE LOADED DECK LIST USING THE COUPLE TYPE
    List<DeckReader> filtered_deck_managers = filter_decks_for_couple_type_and_game_type(loaded_decks_list, widget.match_data.couple_type, widget.match_data.play_local);

    //------------------------------------------------------------------------------

    return Scaffold(

      // APP BAR
      appBar: AppBar(),

      // SCAFFOLD CONTENT
      body: SafeArea(

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
            child: filtered_deck_managers.isEmpty ? Center(

              child: Text(

                widget.match_data.play_local ? AppLocalizations.of(context)!.deck_management_page_no_decks_text: AppLocalizations.of(context)!.deck_management_page_not_done_yet,
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

                      // PAGE LOGO
                      Image.asset(
                        'assets/images/deck_choice_icon.png',
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
                          AppLocalizations.of(context)!.select_deck_page_title,

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

                // DYNAMIC PART OF THE PAGE
                SliverList(

                  // DYNAMIC PART OF THE WIDGET
                  delegate: SliverChildBuilderDelegate(

                        (context, index) {
                      //String deck_path = filtered_deck_managers[index].deck_file_path;
                      String deck_name = filtered_deck_managers[index].summary.name;
                      int deck_quest_number = filtered_deck_managers[index].summary.total_quests;
                      List<String> deck_tools = filtered_deck_managers[index].summary.required_tools;

                      // GETTING DECK DIFFICULTY INFO
                      LanguageInfo language_info_object = get_language_info(context, filtered_deck_managers[index].summary.language);
                      ToolsInfo tools_info_object = get_tools_info(context, deck_tools);

                      OralSexTagInfo oral_sex_tag_object = get_oral_tag_info(context, filtered_deck_managers[index].summary.tags);
                      AnalSexTagInfo anal_sex_tag_object = get_anal_tag_info(context, filtered_deck_managers[index].summary.tags);
                      VaginalSexTagInfo vaginal_sex_tag_object = get_vaginal_tag_info(context, filtered_deck_managers[index].summary.tags);
                      BondageTagInfo bondage_tag_object = get_bondage_tag_info(context, filtered_deck_managers[index].summary.tags);
                      BdsmTagInfo bdsm_tag_object = get_bdsm_tag_info(context, filtered_deck_managers[index].summary.tags);

                      ChatTagInfo chat_tag_object = get_chat_tag_info(context, filtered_deck_managers[index].summary.tags);
                      VideoCallTagInfo video_call_tag_object = get_video_call_tag_info(context, filtered_deck_managers[index].summary.tags);

                      // DYNAMIC LIST CONTENT
                      return Align(

                        // ALIGNMENT
                        alignment: Alignment.center,

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

                                // SETTING THE SELECTED DECK IN THE MATCH DATA
                                widget.match_data.selected_deck = filtered_deck_managers[index];

                                // PAGE LINKER
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(

                                    // OPEN NEW PAGE
                                    builder: (context) => DeckInfoPage(match_data: widget.match_data),

                                  ),

                                );

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
                                                  color: language_info_object.border_color,
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
                                                  color: tools_info_object.border_color,
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

                            // SPACER
                            const SizedBox(height: 15),

                          ],

                        ),

                      );

                    },

                    // GETTING THE LIST ELEMENT
                    childCount: filtered_deck_managers.length,

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




