//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';

// CUSTOM FILES
import 'package:loverquest/pages/play_pages/select_deck_to_play_page.dart';
import 'package:loverquest/logics/play_logics/select_random_player.dart';
import 'package:loverquest/logics/play_logics/player_class.dart';

//------------------------------------------------------------------------------



// PLAY PAGE DEFINITION
class SelectStartPlayerPage extends StatelessWidget {

  // DEFINING PREVIOUS PAGE INFO
  final String couple_type;
  final bool game_type;
  final Players player_1_object;
  final Players player_2_object;

  // CLASS CONSTRUCTOR
  const SelectStartPlayerPage({required this.couple_type, required this. game_type, required this.player_1_object, required this.player_2_object, super.key});

  @override
  Widget build(BuildContext context) {

    // PAGE CONTENT
    return Scaffold(

      // APP BAR
      appBar: AppBar(),

      // SCAFFOLD CONTENT
      body: SafeArea(

        // SAFE AREA CONTENT
        child: SingleChildScrollView(

          // ALIGN CONTENT
          child: Container(

            // PAGE PADDING
            padding: EdgeInsets.all(10),

            // PAGE ALIGNMENT
            alignment: Alignment.topCenter,

            // CONTAINER CONTENT
            child: Column(

              // COLUMN CONTENT
              children: [

                //------------------------------------------------------------------------------

                // PAGE LOGO
                Image.asset(
                  'assets/images/coin_flip_icon.png',
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
                    'Seleziona chi sarà il primo giocatore',

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

                // FIRST CATEGORY BUTTON BOX
                SizedBox(

                  // WIDTH LARGE AS SCREEN
                  width: double.infinity,

                  // FIRST GAME MODE BUTTON
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
                    onPressed: () {

                      // PAGE LINKER
                      Navigator.push(
                        context,
                        MaterialPageRoute(

                          // OPEN NEW PAGE
                            builder: (context) => DeckSelectionPage(couple_type: couple_type, game_type: game_type, player_1_object: player_1_object, player_2_object: player_2_object, first_player: player_1_object)),

                      );

                    },

                    //------------------------------------------------------------------------------

                    // BUTT0N CONTENT
                    child: Row(

                      // ROW CONTENT
                      children: [

                        //------------------------------------------------------------------------------

                        // CARD ICON
                        Image.asset(
                          player_1_object.player_icon_path,
                          width: 40,
                          height: 40,
                          fit: BoxFit.contain,
                        ),

                        //------------------------------------------------------------------------------

                        // SPACER
                        const SizedBox(width: 25),

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
                                'Inizierà ${player_1_object.player_alias}',

                                // TEXT STYLE
                                style: TextStyle(
                                  fontSize: 18.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              //------------------------------------------------------------------------------

                              // SPACER
                              const SizedBox(height: 3),

                              //------------------------------------------------------------------------------

                            ],

                          ),

                        ),

                        //------------------------------------------------------------------------------

                        // SPACER
                        const SizedBox(width: 10),

                        //------------------------------------------------------------------------------

                        // ARROW ICON
                        Icon(

                          // ICON IMAGE
                          Icons.arrow_forward,

                          // ICON COLOR
                          color: Theme.of(context).colorScheme.onPrimary,

                        )

                        //------------------------------------------------------------------------------

                      ],

                    ),

                    //------------------------------------------------------------------------------

                  ),

                ),

                //------------------------------------------------------------------------------

                // SPACER
                const SizedBox(height: 15),

                //------------------------------------------------------------------------------

                // SECOND CATEGORY BUTTON BOX
                SizedBox(

                  // WIDTH LARGE AS SCREEN
                  width: double.infinity,

                  // FIRST GAME MODE BUTTON
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
                    onPressed: () {

                      // PAGE LINKER
                      Navigator.push(
                        context,
                        MaterialPageRoute(

                          // OPEN NEW PAGE
                            builder: (context) => DeckSelectionPage(couple_type: couple_type, game_type: game_type, player_1_object: player_1_object, player_2_object: player_2_object, first_player: player_2_object)),

                      );

                    },

                    //------------------------------------------------------------------------------

                    // BUTT0N CONTENT
                    child: Row(

                      // ROW CONTENT
                      children: [

                        //------------------------------------------------------------------------------

                        // CARD ICON
                        Image.asset(
                          player_2_object.player_icon_path,
                          width: 40,
                          height: 40,
                          fit: BoxFit.contain,
                        ),

                        //------------------------------------------------------------------------------

                        // SPACER
                        const SizedBox(width: 25),

                        //------------------------------------------------------------------------------

                        // COLUMN
                        Expanded(
                          child: Column(

                            // COLUMN ALIGNMENT
                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              //------------------------------------------------------------------------------

                              // CARD TEXT
                              Text(
                                // TEXT
                                'Inizierà ${player_2_object.player_alias}',

                                // TEXT STYLE
                                style: TextStyle(
                                  fontSize: 18.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              // SPACER
                              const SizedBox(height: 3),

                              //------------------------------------------------------------------------------

                            ],

                          ),

                        ),

                        //------------------------------------------------------------------------------

                        // SPACER
                        const SizedBox(width: 10),

                        //------------------------------------------------------------------------------

                        // ARROW ICON
                        Icon(

                          // ICON IMAGE
                          Icons.arrow_forward,

                          // ICON COLOR
                          color: Theme.of(context).colorScheme.onPrimary,

                        )

                        //------------------------------------------------------------------------------

                      ],

                    ),

                    //------------------------------------------------------------------------------

                  ),

                ),

                //------------------------------------------------------------------------------

                // SPACER
                const SizedBox(height: 15),

                //------------------------------------------------------------------------------

                // THIRD CATEGORY BUTTON BOX
                SizedBox(

                  // WIDTH LARGE AS SCREEN
                  width: double.infinity,

                  // FIRST GAME MODE BUTTON
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
                    onPressed: () {

                      // SELECTING PLAYER RANDOMLY
                      Players first_player = select_random_player(player_1_object, player_2_object);

                      // PAGE LINKER
                      Navigator.push(
                          context,
                          MaterialPageRoute(

                          // OPEN NEW PAGE
                          builder: (context) => DeckSelectionPage(couple_type: couple_type, game_type: game_type, player_1_object: player_1_object, player_2_object: player_2_object, first_player: first_player)),

                      );

                    },

                    //------------------------------------------------------------------------------

                    // BUTT0N CONTENT
                    child: Row(

                      // ROW CONTENT
                      children: [

                        //------------------------------------------------------------------------------

                        // CARD ICON
                        Image.asset(
                          'assets/images/shuffle_icon.png',
                          width: 40,
                          height: 40,
                          fit: BoxFit.contain,
                        ),

                        //------------------------------------------------------------------------------

                        // SPACER
                        const SizedBox(width: 25),

                        //------------------------------------------------------------------------------

                        // COLUMN
                        Expanded(
                          child: Column(

                            // COLUMN ALIGNMENT
                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              //------------------------------------------------------------------------------

                              // CARD TEXT
                              Text(
                                // TEXT
                                'Casuale',

                                // TEXT STYLE
                                style: TextStyle(
                                  fontSize: 18.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              // SPACER
                              const SizedBox(height: 3),

                              //------------------------------------------------------------------------------

                            ],

                          ),

                        ),

                        //------------------------------------------------------------------------------

                        // SPACER
                        const SizedBox(width: 10),

                        //------------------------------------------------------------------------------

                        // ARROW ICON
                        Icon(

                          // ICON IMAGE
                          Icons.arrow_forward,

                          // ICON COLOR
                          color: Theme.of(context).colorScheme.onPrimary,

                        )

                        //------------------------------------------------------------------------------

                      ],

                    ),

                    //------------------------------------------------------------------------------

                  ),

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