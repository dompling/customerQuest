//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:loverquest/l10n/app_localization.dart';

// CUSTOM FILES
import 'package:loverquest/pages/play_pages/define_players_names_page.dart';
import 'package:loverquest/logics/play_logics/player_class.dart';
import 'package:loverquest/pages/play_pages/select_deck_to_play_page.dart';

//------------------------------------------------------------------------------



// SELECT PLAYER PAGE DEFINITION
class SelectPlayersTypePage extends StatelessWidget {

  // DEFINING THE PREVIOUS PAGE INFO
  final bool game_type;

  // CLASS CONSTRUCTOR
  const SelectPlayersTypePage ({required this.game_type, super.key});

  // LINK TO STATUS WIDGET
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
                    'assets/images/player_selection_icon.png',
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
                      AppLocalizations.of(context)!.select_players_type_title,

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

                        // CHECKING IF THE GAME IS IN PRESENCE
                        if (game_type != true) {

                          // PAGE LINKER
                          Navigator.push(
                            context,
                            MaterialPageRoute(

                              // OPEN NEW PAGE
                              builder: (context) => DefinePlayersNamesPage(couple_type: "hetero", game_type: game_type,),

                            ),

                          );

                          // GOING DIRECTLY TO DECK SELECTION IF PLAYING AT DISTANCE
                        } else {

                          // CREATING TMP DATA
                          Players player_tmp_object_1 = Players(player_icon_path: "assets/images/coin_flip_icon.png", player_alias: "player_alias:_1", player_sex: true);
                          Players player_tmp_object_2 = Players(player_icon_path: "assets/images/deck_info.png", player_alias: "player_alias_2", player_sex: true);


                          // PAGE LINKER
                          Navigator.push(
                            context,
                            MaterialPageRoute(

                              // OPEN NEW PAGE
                              builder: (context) => DeckSelectionPage(couple_type: "hetero", game_type: game_type, player_1_object: player_tmp_object_1, player_2_object: player_tmp_object_2, first_player: player_tmp_object_2,),

                            ),

                          );

                        }

                      },

                      //------------------------------------------------------------------------------

                      // BUTT0N CONTENT
                      child: Row(

                        // ROW CONTENT
                        children: [

                          //------------------------------------------------------------------------------

                          // CARD ICON
                          Image.asset(
                            'assets/images/hetero_couple_icon.png',
                            width: 50,
                            height: 50,
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
                                  AppLocalizations.of(context)!.select_players_type_hetero_couple_title,

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

                                // CARD TEXT
                                Text(
                                  // TEXT
                                  AppLocalizations.of(context)!.select_players_type_hetero_couple_subtitle,

                                  // TEXT STYLE
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),

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

                        // CHECKING IF THE GAME IS IN PRESENCE
                        if (game_type != true) {

                          // PAGE LINKER
                          Navigator.push(
                            context,
                            MaterialPageRoute(

                              // OPEN NEW PAGE
                              builder: (context) => DefinePlayersNamesPage(couple_type: "lesbian", game_type: game_type,),

                            ),

                          );

                          // GOING DIRECTLY TO DECK SELECTION IF PLAYING AT DISTANCE
                        } else {

                          // CREATING TMP DATA
                          Players player_tmp_object = Players(player_icon_path: "player_icon_path", player_alias: "player_alias", player_sex: true);


                          // PAGE LINKER
                          Navigator.push(
                            context,
                            MaterialPageRoute(

                              // OPEN NEW PAGE
                              builder: (context) => DeckSelectionPage(couple_type: "lesbian", game_type: game_type, player_1_object: player_tmp_object, player_2_object: player_tmp_object, first_player: player_tmp_object,),

                            ),

                          );

                        }

                      },

                      //------------------------------------------------------------------------------

                      // BUTT0N CONTENT
                      child: Row(

                        // ROW CONTENT
                        children: [

                          //------------------------------------------------------------------------------

                          // CARD ICON
                          Image.asset(
                            'assets/images/lesbian_couple_icon.png',
                            width: 50,
                            height: 50,
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
                                // CARD TEXT
                                Text(
                                  // TEXT
                                  AppLocalizations.of(context)!.select_players_type_lesbian_couple_title,

                                  // TEXT STYLE
                                  style: TextStyle(
                                    fontSize: 18.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                // SPACER
                                const SizedBox(height: 3),

                                // CARD TEXT
                                Text(
                                  // TEXT
                                  AppLocalizations.of(context)!.select_players_type_lesbian_couple_subtitle,

                                  // TEXT STYLE
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),

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

                        // CHECKING IF THE GAME IS IN PRESENCE
                        if (game_type != true) {

                          // PAGE LINKER
                          Navigator.push(
                            context,
                            MaterialPageRoute(

                              // OPEN NEW PAGE
                              builder: (context) => DefinePlayersNamesPage(couple_type: "gay", game_type: game_type,),

                            ),

                          );

                          // GOING DIRECTLY TO DECK SELECTION IF PLAYING AT DISTANCE
                        } else {

                          // CREATING TMP DATA
                          Players player_tmp_object = Players(player_icon_path: "player_icon_path", player_alias: "player_alias", player_sex: true);


                          // PAGE LINKER
                          Navigator.push(
                            context,
                            MaterialPageRoute(

                              // OPEN NEW PAGE
                              builder: (context) => DeckSelectionPage(couple_type: "gay", game_type: game_type, player_1_object: player_tmp_object, player_2_object: player_tmp_object, first_player: player_tmp_object,),

                            ),

                          );

                        }

                      },

                      //------------------------------------------------------------------------------

                      // BUTT0N CONTENT
                      child: Row(

                        // ROW CONTENT
                        children: [

                          //------------------------------------------------------------------------------

                          // CARD ICON
                          Image.asset(
                            'assets/images/gay_couple_icon.png',
                            width: 50,
                            height: 50,
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

                                // CARD TEXT
                                Text(
                                  // TEXT
                                  AppLocalizations.of(context)!.select_players_type_gay_couple_title,

                                  // TEXT STYLE
                                  style: TextStyle(
                                    fontSize: 18.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                // SPACER
                                const SizedBox(height: 3),

                                // CARD TEXT
                                Text(
                                  // TEXT
                                  AppLocalizations.of(context)!.select_players_type_gay_couple_subtitle,

                                  // TEXT STYLE
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),

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

                    ),

                  ),

                  //------------------------------------------------------------------------------

              ],

              ),

            ),

          )

      ),

    );

  }
}



//------------------------------------------------------------------------------