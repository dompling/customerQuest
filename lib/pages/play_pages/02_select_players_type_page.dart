//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:loverquest/l10n/app_localization.dart';

// CUSTOM FILES
import 'package:loverquest/pages/play_pages/03_define_players_names_page.dart';
import 'package:loverquest/logics/play_logics/player_class.dart';
import 'package:loverquest/pages/play_pages/05_select_deck_to_play_page.dart';

//------------------------------------------------------------------------------



// SELECT PLAYER PAGE DEFINITION
class SelectPlayersTypePage extends StatefulWidget {

  // DEFINING THE PREVIOUS PAGE INFO
  final bool game_type;

  // CLASS CONSTRUCTOR
  const SelectPlayersTypePage ({required this.game_type, super.key});

  @override
  State<SelectPlayersTypePage> createState() => _SelectPlayersTypePageState();
}



//------------------------------------------------------------------------------



// PAGE CONTENT / STATE
class _SelectPlayersTypePageState extends State<SelectPlayersTypePage> {

  //------------------------------------------------------------------------------

  // ONLINE SAFETY DIALOG
  void show_disclaimer_dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {

        // DIALOG
        return AlertDialog(

          // DIALOG TITLE
          title: Text(

            // TEXT
            AppLocalizations.of(context)!.online_play_disclaimer_dialog_title,

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
          content: SingleChildScrollView(

            child: Text(

              // TEXT
              AppLocalizations.of(context)!.online_play_disclaimer_dialog_content,

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
                    AppLocalizations.of(context)!.app_splash_screen_close_button_label,

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

  // INITIAL PAGE STATE
  @override
  void initState()  {
    super.initState();

    // IF THE GAME TYPE IS ONLINE, SHOW AN INFORMATIVE DIALOG
    if (widget.game_type) {

      // CHECKING IF IS NECESSARY TO SHOW THE DONATION REMINDER
      WidgetsBinding.instance.addPostFrameCallback((_){show_disclaimer_dialog(context);});

    }

  }

  //------------------------------------------------------------------------------

  // PAGE CONTENT
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

            // SCROLLABLE CONTAINER CONTENT
            child: Align(

              // ALIGNMENT
              alignment: Alignment.center,

              // ALIGN CONTENT
              child: Container(

                // SETTING THE WIDTH LIMIT
                constraints: BoxConstraints(maxWidth: 600),

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
                          if (widget.game_type != true) {

                            // PAGE LINKER
                            Navigator.push(
                              context,
                              MaterialPageRoute(

                                // OPEN NEW PAGE
                                builder: (context) => DefinePlayersNamesPage(couple_type: "hetero", game_type: widget.game_type,),

                              ),

                            );

                            // GOING DIRECTLY TO DECK SELECTION IF PLAYING AT DISTANCE
                          } else {

                            // CREATING TMP DATA
                            Players player_tmp_object = Players(player_icon_path: "assets/images/coin_flip_icon.png", player_alias: "player_alias:_1", player_sex: true, player_early_quest_list: [], player_mid_quest_list: [], player_late_quest_list: [], player_end_quest_list: []);

                            // PAGE LINKER
                            Navigator.push(
                              context,
                              MaterialPageRoute(

                                // OPEN NEW PAGE
                                builder: (context) => DeckSelectionPage(couple_type: "hetero", game_type: widget.game_type, player_1_object: player_tmp_object, player_2_object: player_tmp_object, first_player: player_tmp_object),

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
                          if (widget.game_type != true) {

                            // PAGE LINKER
                            Navigator.push(
                              context,
                              MaterialPageRoute(

                                // OPEN NEW PAGE
                                builder: (context) => DefinePlayersNamesPage(couple_type: "lesbian", game_type: widget.game_type,),

                              ),

                            );

                            // GOING DIRECTLY TO DECK SELECTION IF PLAYING AT DISTANCE
                          } else {

                            // CREATING TMP DATA
                            Players player_tmp_object = Players(player_icon_path: "player_icon_path", player_alias: "player_alias", player_sex: true, player_early_quest_list: [], player_mid_quest_list: [], player_late_quest_list: [], player_end_quest_list: []);


                            // PAGE LINKER
                            Navigator.push(
                              context,
                              MaterialPageRoute(

                                // OPEN NEW PAGE
                                builder: (context) => DeckSelectionPage(couple_type: "lesbian", game_type: widget.game_type, player_1_object: player_tmp_object, player_2_object: player_tmp_object, first_player: player_tmp_object,),

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
                          if (widget.game_type != true) {

                            // PAGE LINKER
                            Navigator.push(
                              context,
                              MaterialPageRoute(

                                // OPEN NEW PAGE
                                builder: (context) => DefinePlayersNamesPage(couple_type: "gay", game_type: widget.game_type,),

                              ),

                            );

                            // GOING DIRECTLY TO DECK SELECTION IF PLAYING AT DISTANCE
                          } else {

                            // CREATING TMP DATA
                            Players player_tmp_object = Players(player_icon_path: "player_icon_path", player_alias: "player_alias", player_sex: true, player_early_quest_list: [], player_mid_quest_list: [], player_late_quest_list: [], player_end_quest_list: []);


                            // PAGE LINKER
                            Navigator.push(
                              context,
                              MaterialPageRoute(

                                // OPEN NEW PAGE
                                builder: (context) => DeckSelectionPage(couple_type: "gay", game_type: widget.game_type, player_1_object: player_tmp_object, player_2_object: player_tmp_object, first_player: player_tmp_object),

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

            ),
          
          )

      ),

    );

  }

  //------------------------------------------------------------------------------

}



//------------------------------------------------------------------------------