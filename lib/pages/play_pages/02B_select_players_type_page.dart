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
import 'package:loverquest/logics/play_logics/01_match_data_class.dart';
import 'package:loverquest/logics/play_logics/02_players_class.dart';

//------------------------------------------------------------------------------

// SELECT PLAYER PAGE DEFINITION
class SelectPlayersTypePage extends StatefulWidget {

  // CLASS CONSTRUCTOR
  const SelectPlayersTypePage ({super.key});

  @override
  State<SelectPlayersTypePage> createState() => _SelectPlayersTypePageState();
}

// PAGE CONTENT / STATE
class _SelectPlayersTypePageState extends State<SelectPlayersTypePage> {

  //------------------------------------------------------------------------------
  
  // INITIALIZING THE MATCH DATA OBJECT VAR
  MatchData match_data = MatchData();

  //------------------------------------------------------------------------------

  // INITIAL PAGE STATE
  @override
  void initState()  {
    super.initState();

    // GETTING THE DATA FROM THE PROVIDER
    match_data = Provider.of<MatchDataProvider>(context, listen: false).matchData!;

    print("DEBUG | Match data play local: ${match_data.play_local}");

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
                          if (match_data.play_local == true) {

                            // SETTING THE MATCH DATA COUPLE TYPE
                            match_data.couple_type = "hetero";

                            // SAVING THE MATCH DATA CONTENT INSIDE THE PROVIDER
                            Provider.of<MatchDataProvider>(context, listen: false).updateMatchData(match_data);

                            // PAGE LINKER
                            context.push('/play/players_alias', extra: match_data);

                            // GOING DIRECTLY TO DECK SELECTION IF PLAYING AT DISTANCE
                          } else {

                            // SETTING THE MATCH DATA COUPLE TYPE
                            match_data.couple_type = "hetero";
                            match_data.player_one = Players.empty();
                            match_data.player_two = Players.empty();
                            match_data.current_player_alias = "";

                            // SAVING THE MATCH DATA CONTENT INSIDE THE PROVIDER
                            Provider.of<MatchDataProvider>(context, listen: false).updateMatchData(match_data);

                            // PAGE LINKER
                            context.push('/play/play_deck_choice', extra: match_data);

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
                          if (match_data.play_local == true) {

                            // SETTING THE MATCH DATA COUPLE TYPE
                            match_data.couple_type = "lesbian";

                            // SAVING THE MATCH DATA CONTENT INSIDE THE PROVIDER
                            Provider.of<MatchDataProvider>(context, listen: false).updateMatchData(match_data);

                            // PAGE LINKER
                            context.push('/play/players_alias', extra: match_data);

                            // GOING DIRECTLY TO DECK SELECTION IF PLAYING AT DISTANCE
                          } else {

                            // SETTING THE MATCH DATA COUPLE TYPE
                            match_data.couple_type = "lesbian";
                            match_data.player_one = Players.empty();
                            match_data.player_two = Players.empty();
                            match_data.current_player_alias = "user";

                            // SAVING THE MATCH DATA CONTENT INSIDE THE PROVIDER
                            Provider.of<MatchDataProvider>(context, listen: false).updateMatchData(match_data);

                            // PAGE LINKER
                            context.push('/play/play_deck_choice', extra: match_data);

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
                          if (match_data.play_local == true) {

                            // SETTING THE MATCH DATA COUPLE TYPE
                            match_data.couple_type = "gay";

                            // SAVING THE MATCH DATA CONTENT INSIDE THE PROVIDER
                            Provider.of<MatchDataProvider>(context, listen: false).updateMatchData(match_data);

                            // PAGE LINKER
                            context.push('/play/players_alias', extra: match_data);

                            // GOING DIRECTLY TO DECK SELECTION IF PLAYING AT DISTANCE
                          } else {

                            // SETTING THE MATCH DATA COUPLE TYPE
                            match_data.couple_type = "gay";
                            match_data.player_one = Players.empty();
                            match_data.player_two = Players.empty();
                            match_data.current_player_alias = "";

                            // SAVING THE MATCH DATA CONTENT INSIDE THE PROVIDER
                            Provider.of<MatchDataProvider>(context, listen: false).updateMatchData(match_data);

                            // PAGE LINKER
                            context.push('/play/play_deck_choice', extra: match_data);

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