//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';

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
  final DifficultyInfo difficulty_info_object;
  final bool can_edit;

  // CLASS CONSTRUCTOR
  DeckInfoPage({
    Players? player_1_object,
    Players? player_2_object,
    Players? first_player,
    required this.selected_deck,
    required this.difficulty_info_object,
    required this.can_edit,
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

  // INITIALIZING GME TYPE TAG
  String deck_game_type = "";

  // INITIALIZING TOOLS NEEDED
  String deck_needed_tools = "";



  // DEFINING IS LOADING VARIABLE
  bool is_loading = true;

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
        early_quests_total_score = early_quests_total_score + 5;

      } else if (element.moment == "mid") {

        // ADDING THE ELEMENT TO THE LIST
        mid_quests_list.add(element);

        // ADDING THE ELEMENT SCORE TO THE CATEGORY TOTAL
        mid_quests_total_score = mid_quests_total_score + 10;

      } else if (element.moment == "late") {

        // ADDING THE ELEMENT TO THE LIST
        late_quests_list.add(element);

        // ADDING THE ELEMENT SCORE TO THE CATEGORY TOTAL
        late_quests_total_score = late_quests_total_score + 15;

      } else {

        // ADDING THE ELEMENT TO THE LIST
        end_quests_list.add(element);

        // ADDING THE ELEMENT SCORE TO THE CATEGORY TOTAL
        end_quests_total_score = end_quests_total_score + 20;

      }

    }

    // ADDING ALL THE LISTS INSIDE THE MAIN LIST
    all_quests_list = early_quests_list + mid_quests_list + late_quests_list + end_quests_list;

    // CONVERTING TO STRING THE NEEDED TOOLS
    deck_needed_tools = widget.selected_deck.summary.required_tools.join(", ");

    // IF THERE ARE NO TOOLS NEEDED, WRITHE NOTHING
    if (deck_needed_tools == "") {deck_needed_tools = "Nessuno";}

    // CONVERTING TO STRING TAG THE GAME TYPE
    if (widget.selected_deck.summary.play_distance) {deck_game_type = "A distanza";} else {deck_game_type = "In presenza";}

    // UPDATING THE WIDGET STATUS WITH THE LOADED DATA
    setState(() {
      //loaded_decks_list = tempList;
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
                        "Informazioni sul mazzo",

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

                                text : "Nome : ",
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

                          // DIFFICULTY TEXT
                          Text.rich(
                            TextSpan (

                                text : "Difficoltà : ",
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),

                                children: [

                                  TextSpan (

                                    text : widget.difficulty_info_object.label,
                                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),

                                  ),

                                ]

                            ),
                          ),

                          //------------------------------------------------------------------------------

                          // SPACER
                          const SizedBox(height: 5),

                          //------------------------------------------------------------------------------

                          // ESTIMATED TIME TEXT
                          Text.rich(
                            TextSpan (

                                text : "Tempo stimato : ",
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),

                                children: [

                                  TextSpan (

                                    text : "${widget.selected_deck.summary.average_duration} minuti",
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

                                text : "Tipologia di gioco : ",
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

                                text : "Strumenti richiesti : ",
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),

                                children: [

                                  TextSpan (

                                    text : deck_needed_tools,
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

                                text : "Descrizione : ",
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
                                  /*
                                  // PAGE LINKER
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => PlayPage(
                                      
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
                                    
                                    )
                                    
                                    ),
                                      
                                      
                                      
                                        (Route<dynamic> route) => false,
                                  );
                                  */

                                  // PAGE LINKER
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(

                                      // OPEN NEW PAGE
                                      builder: (context) => PlayPage(

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

                                      )
                                    )
                                  );

                                },

                                // BUTTON CONTENT
                                child: const Text(

                                  // TEXT
                                  'Avvia il gioco',

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
                      "Lista delle quest",

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

                    // CONVERTING TO STRING THE NEEDED TOOLS
                    String quest_needed_tools = all_quests_list[index].required_tools.join(", ");

                    // IF THERE ARE NO TOOLS NEEDED, WRITHE NOTHING
                    if (quest_needed_tools == "") {quest_needed_tools = "Nessuno";}

                    // INITIALIZING THE QUEST TYPE VAR
                    String quest_type;

                    // CONVERTING THE QUEST TYPE TAG
                    if (all_quests_list[index].moment.toLowerCase() == "early") {

                      // DEFINING QUEST TYPE TEXT
                      quest_type = "Quest iniziali";

                    } else if (all_quests_list[index].moment.toLowerCase() == "mid") {

                      // DEFINING QUEST TYPE TEXT
                      quest_type = "Quest intermedie";

                    } else if (all_quests_list[index].moment.toLowerCase() == "late") {

                      // DEFINING QUEST TYPE TEXT
                      quest_type = "Quest avanzate";

                    } else {

                      // DEFINING QUEST TYPE TEXT
                      quest_type = "Quest finali";

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

                                            text : "Tipologia : ",
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

                                            text : "Strumenti richiesti : ",
                                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),

                                            children: [

                                              TextSpan (

                                                text : quest_needed_tools,
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

                                            text : "Descrizione : ",
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

                                // CHECKING IF THE QUEST IS EDITABLE
                                !widget.selected_deck.summary.protected ?Icon(

                                    // ICON IMAGE
                                    Icons.edit,

                                    // ICON COLOR
                                    color: Theme.of(context).colorScheme.onPrimary,

                                  )
                              : SizedBox.shrink(),




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




