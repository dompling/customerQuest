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

//------------------------------------------------------------------------------

// PLAY PAGE DEFINITION
class SelectGameSpeed extends StatelessWidget {

  // CLASS CONSTRUCTOR
  const SelectGameSpeed({super.key});

  @override
  Widget build(BuildContext context) {

    // INITIALIZING THE MATCH DATA OBJECT
    MatchData match_data = Provider.of<MatchDataProvider>(context, listen: false).matchData!;

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
                    'assets/images/hourglass.png',
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
                      AppLocalizations.of(context)!.select_game_speed_page_title,

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

                  // FIRST SPEED BUTTON BOX
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

                        // SETTING THE GAME PACE MULTIPLIER IN MATCH DATA
                        match_data.game_pace_multiplier = 1;

                        // SAVING THE MATCH DATA CONTENT INSIDE THE PROVIDER
                        Provider.of<MatchDataProvider>(context, listen: false).updateMatchData(match_data);

                        // PAGE LINKER
                        context.go('/play/game');

                      },

                      //------------------------------------------------------------------------------

                      // BUTT0N CONTENT
                      child: Row(

                        // ROW CONTENT
                        children: [

                          //------------------------------------------------------------------------------

                          // CARD ICON
                          Image.asset(
                            'assets/images/speed_1.png',
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
                                  AppLocalizations.of(context)!.select_game_speed_speed_1_title,

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

                                // SUBTITLE TEXT
                                Text(
                                  // TEXT
                                  AppLocalizations.of(context)!.select_game_speed_speed_1_subtitle,

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

                      //------------------------------------------------------------------------------

                    ),

                  ),

                  //------------------------------------------------------------------------------

                  // SPACER
                  const SizedBox(height: 15),

                  //------------------------------------------------------------------------------

                  // SECOND SPEED BUTTON BOX
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

                        // SETTING THE GAME PACE MULTIPLIER IN MATCH DATA
                        match_data.game_pace_multiplier = 2;

                        // SAVING THE MATCH DATA CONTENT INSIDE THE PROVIDER
                        Provider.of<MatchDataProvider>(context, listen: false).updateMatchData(match_data);

                        // PAGE LINKER
                        context.go('/play/game');

                      },

                      //------------------------------------------------------------------------------

                      // BUTT0N CONTENT
                      child: Row(

                        // ROW CONTENT
                        children: [

                          //------------------------------------------------------------------------------

                          // CARD ICON
                          Image.asset(
                            'assets/images/speed_2.png',
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
                                  AppLocalizations.of(context)!.select_game_speed_speed_2_title,

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

                                // SUBTITLE TEXT
                                Text(
                                  // TEXT
                                  AppLocalizations.of(context)!.select_game_speed_speed_2_subtitle,

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

                      //------------------------------------------------------------------------------

                    ),

                  ),

                  //------------------------------------------------------------------------------

                  // SPACER
                  const SizedBox(height: 15),

                  //------------------------------------------------------------------------------

                  // THIRD SPEED BUTTON BOX
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

                        // SETTING THE GAME PACE MULTIPLIER IN MATCH DATA
                        match_data.game_pace_multiplier = 3;

                        // SAVING THE MATCH DATA CONTENT INSIDE THE PROVIDER
                        Provider.of<MatchDataProvider>(context, listen: false).updateMatchData(match_data);

                        // PAGE LINKER
                        context.go('/play/game');

                      },

                      //------------------------------------------------------------------------------

                      // BUTT0N CONTENT
                      child: Row(

                        // ROW CONTENT
                        children: [

                          //------------------------------------------------------------------------------

                          // CARD ICON
                          Image.asset(
                            'assets/images/speed_3.png',
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
                                  AppLocalizations.of(context)!.select_game_speed_speed_3_title,

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

                                // SUBTITLE TEXT
                                Text(
                                  // TEXT
                                  AppLocalizations.of(context)!.select_game_speed_speed_3_subtitle,

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

                      //------------------------------------------------------------------------------

                    ),

                  ),

                  //------------------------------------------------------------------------------

                  // SPACER
                  const SizedBox(height: 15),

                  //------------------------------------------------------------------------------

                  // FOURTH SPEED BUTTON BOX
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

                        // SETTING THE GAME PACE MULTIPLIER IN MATCH DATA
                        match_data.game_pace_multiplier = 4;

                        // SAVING THE MATCH DATA CONTENT INSIDE THE PROVIDER
                        Provider.of<MatchDataProvider>(context, listen: false).updateMatchData(match_data);

                        // PAGE LINKER
                        context.go('/play/game');

                      },

                      //------------------------------------------------------------------------------

                      // BUTT0N CONTENT
                      child: Row(

                        // ROW CONTENT
                        children: [

                          //------------------------------------------------------------------------------

                          // CARD ICON
                          Image.asset(
                            'assets/images/speed_4.png',
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
                                  AppLocalizations.of(context)!.select_game_speed_speed_4_title,

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

                                // SUBTITLE TEXT
                                Text(
                                  // TEXT
                                  AppLocalizations.of(context)!.select_game_speed_speed_4_subtitle,

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

                      //------------------------------------------------------------------------------

                    ),

                  ),

                  //------------------------------------------------------------------------------

                ],

              ),

            ),

          ),

        ),

      ),

    );

  }
}



//------------------------------------------------------------------------------