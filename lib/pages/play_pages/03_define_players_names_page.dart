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
import 'package:loverquest/logics/play_logics/02_players_class.dart';

//------------------------------------------------------------------------------



// PLAY PAGE DEFINITION
class DefinePlayersNamesPage extends StatefulWidget {

  // CLASS CONSTRUCTOR
  const DefinePlayersNamesPage({super.key});

  @override
  State<DefinePlayersNamesPage> createState() => _DefinePlayersNamesPageState();
}

class _DefinePlayersNamesPageState extends State<DefinePlayersNamesPage> {

  //------------------------------------------------------------------------------

  // INITIALIZING THE MATCH DATA OBJECT VAR
  MatchData match_data = MatchData();

  // DEFINING PLAYERS NAMES TEXT FIELD TEXT CONTROLLER
  final TextEditingController _player_1_controller = TextEditingController();
  final TextEditingController _player_2_controller = TextEditingController();

  //------------------------------------------------------------------------------

  // INITIAL PAGE STATE
  @override
  void initState()  {
    super.initState();

    // GETTING THE DATA FROM THE PROVIDER
    match_data = Provider.of<MatchDataProvider>(context, listen: false).matchData!;

  }

  //------------------------------------------------------------------------------

  // RELEASING CONTROLLERS WHEN THE PAGE IS DISMISSED
  @override
  void dispose() {
    _player_1_controller.dispose();
    _player_2_controller.dispose();
    super.dispose();
  }

  //------------------------------------------------------------------------------

  // CHECKING CONTINUE TO NEXT PAGE CONDITION
  void alias_check_to_go(bool player_1_sex, bool player_2_sex, String player_1_image_path, String player_2_image_path, String couple_type, bool game_type) {

    // ACQUIRING PLAYER ALIAS AVOIDING SPACES
    String player_1_alias = _player_1_controller.text.trim();
    String player_2_alias = _player_2_controller.text.trim();

    // CHECKING IF ALIAS ARE EMPTY
    if (player_1_alias.isEmpty || player_2_alias.isEmpty) {

      // SHOWING THE FIELD ERROR SNACKBAR
      show_error_snackbar(context, AppLocalizations.of(context)!.define_players_name_error_label);

    } else {

      // CREATING PLAYER 1 OBJECT
      Players player_1 = Players(player_icon_path: player_1_image_path, player_alias: player_1_alias, player_sex: player_1_sex);

      // CREATING PLAYER 2 OBJECT
      Players player_2 = Players(player_icon_path: player_2_image_path, player_alias: player_2_alias, player_sex: player_2_sex);

      // SETTING THE PLAYERS IN THE MATCH DATA
      match_data.player_one = player_1;
      match_data.player_two = player_2;

      // SAVING THE MATCH DATA CONTENT INSIDE THE PROVIDER
      Provider.of<MatchDataProvider>(context, listen: false).updateMatchData(match_data);

      // PAGE LINKER
      context.push('/play/start_player');

    }


  }

  //------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    //------------------------------------------------------------------------------

    // DEFINING IMAGES AND SEX BASED ON COUPLE TYPE
    String player_1_image_path;
    String player_2_image_path;
    bool player_1_sex;
    bool player_2_sex;

    if (match_data.couple_type == "hetero") {

      // CHANGING IMAGE PATH
      player_1_image_path = "assets/images/female_player_icon.png";
      player_2_image_path = "assets/images/male_player_icon.png";

      // SETTING SEX - FALSE MALE - TRUE FEMALE
      player_1_sex = true;
      player_2_sex = false;

    } else if (match_data.couple_type == "lesbian") {

      // CHANGING IMAGE PATH
      player_1_image_path = "assets/images/female_player_icon.png";
      player_2_image_path = "assets/images/female_player_icon_alt.png";

      // SETTING SEX - FALSE MALE - TRUE FEMALE
      player_1_sex = true;
      player_2_sex = true;

    } else {

      // CHANGING IMAGE PATH
      player_1_image_path = "assets/images/male_player_icon.png";
      player_2_image_path = "assets/images/male_player_icon_alt.png";

      // SETTING SEX - FALSE MALE - TRUE FEMALE
      player_1_sex = false;
      player_2_sex = false;

    }

    //------------------------------------------------------------------------------

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
                    'assets/images/define_players_names_icon.png',
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
                      AppLocalizations.of(context)!.define_players_name_page_title,

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

                  // PLAYER ONE BOX
                  Container(

                    // SIZE
                    width: double.infinity,

                    // PADDING
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),

                    // BACKGROUND COLOR AND BORDER RADIUS
                    decoration: BoxDecoration(

                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),

                    ),

                    // CONTAINER CONTENT
                    child: Row(

                      // ALIGNMENT
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [

                        //------------------------------------------------------------------------------

                        // BOX LOGO
                        Image.asset(
                          player_1_image_path,
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                        ),

                        //------------------------------------------------------------------------------

                        // SPACER
                        const SizedBox(width: 20),

                        //------------------------------------------------------------------------------

                        // TITLE AND TEXTBOX CONTAINER
                        Expanded(
                          child: Column(

                            // ALIGNMENT
                            crossAxisAlignment: CrossAxisAlignment.start,

                            // COLUMN CONTENT
                            children: [

                              // CARD TEXT
                              Text(
                                // TEXT
                                AppLocalizations.of(context)!.define_players_name_player_one_label,

                                // TEXT STYLE
                                style: TextStyle(
                                  fontSize: 18.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              //------------------------------------------------------------------------------

                              // SPACER
                              const SizedBox(height: 9),

                              //------------------------------------------------------------------------------

                              // CARD TEXT
                              TextField(

                                // TEXT CONTROLLER
                                controller: _player_1_controller,

                                // INPUT TEXT STYLING
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),

                                // TEXT FIELD STYLING
                                decoration: InputDecoration(

                                  // HINT TEXT
                                  hintText: AppLocalizations.of(context)!.define_players_name_textfield_hint_label,

                                  // HINT TEXT STYLE
                                  hintStyle: TextStyle(
                                    fontSize: 13,
                                    fontStyle: FontStyle.normal,
                                  ),

                                  // BORDER
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none
                                  ),

                                  // BACKGROUND COLOR
                                  filled: true,
                                  fillColor: Colors.grey[800],

                                  // PADDING
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 20,
                                  ),

                                ),

                              ),

                            ],

                          ),

                        ),

                        //------------------------------------------------------------------------------

                      ],

                    ),

                  ),

                  //------------------------------------------------------------------------------

                  // SPACER
                  const SizedBox(height: 15),

                  //------------------------------------------------------------------------------

                  // PLAYER TWO BOX
                  Container(

                    // SIZE
                    width: double.infinity,

                    // PADDING
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),

                    // BACKGROUND COLOR AND BORDER RADIUS
                    decoration: BoxDecoration(

                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),

                    ),

                    // CONTAINER CONTENT
                    child: Row(

                      // ALIGNMENT
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [

                        //------------------------------------------------------------------------------

                        // BOX LOGO
                        Image.asset(
                          player_2_image_path,
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                        ),

                        //------------------------------------------------------------------------------

                        // SPACER
                        const SizedBox(width: 20),

                        //------------------------------------------------------------------------------

                        // TITLE AND TEXTBOX CONTAINER
                        Expanded(
                          child: Column(

                            // ALIGNMENT
                            crossAxisAlignment: CrossAxisAlignment.start,

                            // COLUMN CONTENT
                            children: [

                              // CARD TEXT
                              Text(
                                // TEXT
                                AppLocalizations.of(context)!.define_players_name_player_two_label,

                                // TEXT STYLE
                                style: TextStyle(
                                  fontSize: 18.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              //------------------------------------------------------------------------------

                              // SPACER
                              const SizedBox(height: 9),

                              //------------------------------------------------------------------------------

                              // CARD TEXT
                              TextField(

                                // TEXT CONTROLLER
                                controller: _player_2_controller,

                                // INPUT TEXT STYLING
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),

                                // TEXT FIELD STYLING
                                decoration: InputDecoration(

                                  // HINT TEXT
                                  hintText: AppLocalizations.of(context)!.define_players_name_textfield_hint_label,

                                  // HINT TEXT STYLE
                                  hintStyle: TextStyle(
                                    fontSize: 13,
                                    fontStyle: FontStyle.normal,
                                  ),

                                  // BORDER
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none
                                  ),

                                  // BACKGROUND COLOR
                                  filled: true,
                                  fillColor: Colors.grey[800],

                                  // PADDING
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 20,
                                  ),

                                ),

                              ),

                            ],

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

                  // BUTTON BOX
                  SizedBox(

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

                        // CHECKING ALIAS BEFORE GOING TO THE NEXT PAGE
                        alias_check_to_go(player_1_sex, player_2_sex, player_1_image_path, player_2_image_path, match_data.couple_type, match_data.play_local);

                      },

                      // BUTTON CONTENT
                      child: Text(

                        // TEXT
                        AppLocalizations.of(context)!.define_players_name_confirm_button,

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