//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';

// CUSTOM FILES
import 'package:loverquest/logics/decks_logics/deck_list_reader.dart';
import 'package:loverquest/logics/decks_logics/quests_reader.dart';
import 'package:loverquest/logics/decks_logics/deck_ui_conversion.dart';
import 'package:loverquest/logics/decks_logics/deck_filters.dart';
import 'package:loverquest/logics/play_logics/player_class.dart';
import 'package:loverquest/pages/decks_pages/deck_info_page.dart';

//------------------------------------------------------------------------------


// DECK SELECTION PAGE DEFINITION
class DeckSelectionPage extends StatefulWidget {

  // CLASS ATTRIBUTES
  final String couple_type;
  final bool game_type;
  final Players player_1_object;
  final Players player_2_object;
  final Players first_player;

  // CLASS CONSTRUCTOR
  const DeckSelectionPage({
    required this.couple_type,
    required this.game_type,
    required this.player_1_object,
    required this.player_2_object,
    required this.first_player,
    super.key,
  });

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

  //------------------------------------------------------------------------------

  // CLASS INITIAL STATE
  @override
  void initState() {
    super.initState();

    // LAUNCH THE FUNCTION TO LOAD ALL DEFAULT DECKS
    load_all_default_decks();

  }

  // INITIAL STATE FUNCTION TO LOAD ALL DEFAULTS DECKS
  Future<void> load_all_default_decks() async {

    //------------------------------------------------------------------------------

    // GETTING THE LIST OF ALL THE DEFAULT DECKS PATH CALLING THE
    List<String> default_decks_path_list = DefaultDeckListReader.get_deck_paths();

    //------------------------------------------------------------------------------

    // CREATING A TEMP LIST OF REED DECKS
    List<DeckReader> tempList = [];

    // FOR EVERY FILE PATH IN THE LIST WILL BE CREATED AN ELEMENT INSIDE A TEMP LIST WHERE LOAD THE DECK ELEMENTS
    for (String deck_path in default_decks_path_list) {

      //print("DEBUG | $deck_path");

      // CREATING DECK READER OBJECT
      DeckReader deckManager = DeckReader(deck_path);

      // LOADING DECK DATA ASYNCHRONOUSLY
      await deckManager.load_deck();

      // ADDING THE LOADED DECK TO THE TMP LIST
      tempList.add(deckManager);
    }

    // UPDATING THE WIDGET STATUS WITH THE LOADED DATA
    setState(() {
      loaded_decks_list = tempList;
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
    List<DeckReader> filtered_deck_managers = filter_decks_for_couple_type_and_game_type(loaded_decks_list, widget.couple_type, widget.game_type);

    //------------------------------------------------------------------------------

    return Scaffold(

      // APP BAR
      appBar: AppBar(),

      // SCAFFOLD CONTENT
      body: SafeArea(

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
                        'Seleziona il mazzo da giocare',

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
                    int deck_difficulty = filtered_deck_managers[index].summary.average_difficulty;
                    int deck_average_duration = filtered_deck_managers[index].summary.average_duration;
                    List<String> deck_tools = filtered_deck_managers[index].summary.required_tools;

                    // GETTING DECK DIFFICULTY INFO
                    DifficultyInfo difficulty_info_object = get_difficulty_info(deck_difficulty);
                    ToolsInfo tools_info_object = get_tools_info(deck_tools);
                    
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

                              // PAGE LINKER
                              Navigator.push(
                                context,
                                MaterialPageRoute(

                                  // OPEN NEW PAGE
                                  builder: (context) => DeckInfoPage(
                                    player_1_object: widget.player_1_object,
                                    player_2_object: widget.player_2_object,
                                    first_player: widget.first_player,
                                    selected_deck: filtered_deck_managers[index],
                                    difficulty_info_object: difficulty_info_object,
                                    can_edit: false,

                                  ),

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

                                          // DIFFICULTY TAG
                                          Container(

                                            // PADDING
                                            padding: EdgeInsets.all(7),

                                            //CONTAINER STYLE
                                            decoration: BoxDecoration(

                                              // BACKGROUND COLOR
                                              color: difficulty_info_object.background_color,

                                              // BORDER RADIUS
                                              borderRadius: BorderRadius.circular(16),

                                              // BORDER STYLE
                                              border: Border.all(
                                                color: difficulty_info_object.border_color,
                                                width: 2,
                                              ),

                                            ),

                                            // CONTAINER CONTENT
                                            child: Text(

                                              // TEXT
                                              difficulty_info_object.label,

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
                                                width: 2,
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
                                                color: Color(0xff6aab92),
                                                width: 2,
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

                                          // DECK ESTIMATED TIME TAG
                                          Container(

                                            // PADDING
                                            padding: EdgeInsets.all(7),

                                            //CONTAINER STYLE
                                            decoration: BoxDecoration(

                                              // BACKGROUND COLOR
                                              color: Color(0xff623754),

                                              // BORDER RADIUS
                                              borderRadius: BorderRadius.circular(16),

                                              // BORDER STYLE
                                              border: Border.all(
                                                color: Color(0xffab6a8f),
                                                width: 2,
                                              ),

                                            ),

                                            // CONTAINER CONTENT
                                            child: Text(

                                              // TEXT
                                              '$deck_average_duration minuti',

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


                  childCount: filtered_deck_managers.length,

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




