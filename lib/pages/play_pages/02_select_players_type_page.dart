//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:loverquest/l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';



// CUSTOM FILES
import 'package:loverquest/logics/play_logics/01_match_data_class.dart';
import 'package:loverquest/logics/play_logics/02_players_class.dart';



//------------------------------------------------------------------------------



// SELECT PLAYER PAGE DEFINITION
class SelectPlayersTypePage extends StatefulWidget {

  // DEFINING THE PREVIOUS PAGE IMPORTED INFO
  final MatchData match_data;

  // CLASS CONSTRUCTOR
  const SelectPlayersTypePage ({required this.match_data, super.key});

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
    if (!widget.match_data.play_local) {

      // CHECKING IF IS NECESSARY TO SHOW THE WARNING
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
                          if (widget.match_data.play_local == true) {

                            // SETTING THE MATCH DATA COUPLE TYPE
                            widget.match_data.couple_type = "hetero";

                            // SAVING THE MATCH DATA CONTENT INSIDE THE PROVIDER
                            Provider.of<MatchDataProvider>(context, listen: false).updateMatchData(widget.match_data);

                            // PAGE LINKER
                            context.push('/play/players_alias', extra: widget.match_data);

                            // GOING DIRECTLY TO DECK SELECTION IF PLAYING AT DISTANCE
                          } else {

                            // SETTING THE MATCH DATA COUPLE TYPE
                            widget.match_data.couple_type = "hetero";
                            widget.match_data.player_one = Players.empty();
                            widget.match_data.player_two = Players.empty();
                            widget.match_data.current_player_alias = "";

                            // SAVING THE MATCH DATA CONTENT INSIDE THE PROVIDER
                            Provider.of<MatchDataProvider>(context, listen: false).updateMatchData(widget.match_data);

                            // PAGE LINKER
                            context.push('/play/players_alias', extra: widget.match_data);

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
                          if (widget.match_data.play_local == true) {

                            // SETTING THE MATCH DATA COUPLE TYPE
                            widget.match_data.couple_type = "lesbian";

                            // SAVING THE MATCH DATA CONTENT INSIDE THE PROVIDER
                            Provider.of<MatchDataProvider>(context, listen: false).updateMatchData(widget.match_data);

                            // PAGE LINKER
                            context.push('/play/players_alias', extra: widget.match_data);

                            // GOING DIRECTLY TO DECK SELECTION IF PLAYING AT DISTANCE
                          } else {

                            // SETTING THE MATCH DATA COUPLE TYPE
                            widget.match_data.couple_type = "lesbian";
                            widget.match_data.player_one = Players.empty();
                            widget.match_data.player_two = Players.empty();
                            widget.match_data.current_player_alias = "user";

                            // SAVING THE MATCH DATA CONTENT INSIDE THE PROVIDER
                            Provider.of<MatchDataProvider>(context, listen: false).updateMatchData(widget.match_data);

                            // PAGE LINKER
                            context.push('/play/players_alias', extra: widget.match_data);

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
                          if (widget.match_data.play_local == true) {

                            // SETTING THE MATCH DATA COUPLE TYPE
                            widget.match_data.couple_type = "gay";

                            // SAVING THE MATCH DATA CONTENT INSIDE THE PROVIDER
                            Provider.of<MatchDataProvider>(context, listen: false).updateMatchData(widget.match_data);

                            // PAGE LINKER
                            context.push('/play/players_alias', extra: widget.match_data);

                            // GOING DIRECTLY TO DECK SELECTION IF PLAYING AT DISTANCE
                          } else {

                            // SETTING THE MATCH DATA COUPLE TYPE
                            widget.match_data.couple_type = "gay";
                            widget.match_data.player_one = Players.empty();
                            widget.match_data.player_two = Players.empty();
                            widget.match_data.current_player_alias = "";

                            // SAVING THE MATCH DATA CONTENT INSIDE THE PROVIDER
                            Provider.of<MatchDataProvider>(context, listen: false).updateMatchData(widget.match_data);

                            // PAGE LINKER
                            context.push('/play/players_alias', extra: widget.match_data);

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