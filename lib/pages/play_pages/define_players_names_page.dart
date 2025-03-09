//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:loverquest/l10n/app_localization.dart';

// CUSTOM FILES
import 'package:loverquest/pages/play_pages/select_start_player_page.dart';
import 'package:loverquest/logics/play_logics/player_class.dart';

//------------------------------------------------------------------------------



// PLAY PAGE DEFINITION
class DefinePlayersNamesPage extends StatefulWidget {

  // DEFINING PREVIOUS PAGE INFO
  final String couple_type;
  final bool game_type;

  // CLASS CONSTRUCTOR
  const DefinePlayersNamesPage({required this.couple_type, required this.game_type, super.key});

  @override
  State<DefinePlayersNamesPage> createState() => _DefinePlayersNamesPageState();
}



//------------------------------------------------------------------------------



class _DefinePlayersNamesPageState extends State<DefinePlayersNamesPage> {

  //------------------------------------------------------------------------------

  // DEFINING PLAYERS NAMES TEXT FIELD TEXT CONTROLLER
  final TextEditingController _player_1_controller = TextEditingController();
  final TextEditingController _player_2_controller = TextEditingController();

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
  void alias_check_to_go(player_1_sex, player_2_sex, player_1_image_path, player_2_image_path, couple_type, game_type) {

    // ACQUIRING PLAYER ALIAS AVOIDING SPACES
    String player_1_alias = _player_1_controller.text.trim();
    String player_2_alias = _player_2_controller.text.trim();

    // CHECKING IF ALIAS ARE EMPTY
    if (player_1_alias.isEmpty || player_2_alias.isEmpty) {

      // SHOWING ERROR POPUP
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(

          // POP-UP CONTENT
          content: Row(

            // ALIGNMENT
            mainAxisAlignment: MainAxisAlignment.center,

            // SIZE
            mainAxisSize: MainAxisSize.max,

            // ROW CONTENT
            children: [

              // ERROR TEXT
              Flexible(

                child: Text(
                  // TEXT
                  AppLocalizations.of(context)!.define_players_name_error_label,

                  // TEXT STYLE
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color.fromRGBO(226, 226, 226, 1.0),
                  ),

                  // TEXT GO TO NEXT ROW
                  softWrap: true,

                  // MAX NUMBERS OF TEXT LINE
                  maxLines: 3,

                  // WHAT SHOW IF LONGER
                  overflow: TextOverflow.ellipsis,

                ),

              )

            ],

          ),

          // POP-UP DURATION
          duration: Duration(seconds: 4),

          // POP-UP BACKGROUND COLOR
          backgroundColor: Color.fromRGBO(73, 32, 32, 1.0),

        ),
      );

    } else {

      // CREATING PLAYER 1 OBJECT
      Players player_1 = Players(player_icon_path: player_1_image_path, player_alias: player_1_alias, player_sex: player_1_sex);

      // CREATING PLAYER 2 OBJECT
      Players player_2 = Players(player_icon_path: player_2_image_path, player_alias: player_2_alias, player_sex: player_2_sex);

      // GOING TO NEXT PAGE
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SelectStartPlayerPage(couple_type: couple_type, game_type: game_type, player_1_object: player_1, player_2_object: player_2,)),
      );

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

    if (widget.couple_type == "hetero") {

      // CHANGING IMAGE PATH
      player_1_image_path = "assets/images/female_player_icon.png";
      player_2_image_path = "assets/images/male_player_icon.png";

      // SETTING SEX - FALSE MALE - TRUE FEMALE
      player_1_sex = true;
      player_2_sex = false;

    } else if (widget.couple_type == "lesbian") {

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
                        alias_check_to_go(player_1_sex, player_2_sex, player_1_image_path, player_2_image_path, widget.couple_type, widget.game_type);

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