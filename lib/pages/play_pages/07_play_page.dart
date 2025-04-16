//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:loverquest/l10n/app_localization.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

// CUSTOM FILES
import 'package:loverquest/logics/decks_logics/quests_reader.dart';
import 'package:loverquest/logics/play_logics/player_class.dart';
import 'package:loverquest/logics/play_logics/quest_management.dart';
import 'package:loverquest/logics/play_logics/save_current_match.dart';

//------------------------------------------------------------


// DECK SELECTION PAGE DEFINITION
class PlayPage extends StatefulWidget {

  // CLASS ATTRIBUTES
  final bool game_type;
  final Players player_1_object;
  final Players player_2_object;
  final Players first_player;
  final List<Quest> early_quests_list;
  final List<Quest> mid_quests_list;
  final List<Quest> late_quests_list;
  final List<Quest> end_quests_list;
  final Quest passed_current_quest;
  final List<Quest> passed_current_quest_list;

  // CLASS CONSTRUCTOR
  const PlayPage({
    required this.game_type,
    required this.player_1_object,
    required this.player_2_object,
    required this.first_player,
    required this.early_quests_list,
    required this.mid_quests_list,
    required this.late_quests_list,
    required this.end_quests_list,
    required this.passed_current_quest,
    required this.passed_current_quest_list,

    super.key,
  });

  // LINK TO CLASS STATE / WIDGET CONTENT
  @override
  State<PlayPage> createState() => _PlayPageState();

}



//------------------------------------------------------------------------------



// CLASS STATE / WIDGET CONTENT
class _PlayPageState extends State<PlayPage> {

  //------------------------------------------------------------------------------

  // INITIALIZING THE IS LOADING VARIABLE
  bool is_loading = true;

  //------------------------------------------------------------------------------

  // INITIALIZING TIMER'S VARIABLES
  int total_seconds = 0;
  int remaining_seconds = 0;
  Timer? _timer;
  bool is_running = false;

  //------------------------------------------------------------------------------

  // INITIALIZING THE PLAYERS VARIABLES
  late Players current_player;
  List<Players> players_list = [];

  //------------------------------------------------------------------------------

  // INITIALIZING THE TIMER VARIABLE
  late bool show_timer;
  bool is_pressed = false;

  //------------------------------------------------------------------------------

  // INITIALIZING THE QUEST VARIABLES
  late Quest current_quest;
  int partial_score = 0;

  //------------------------------------------------------------------------------

  // RESUME COUNTDOWN FUNCTION
  void start_resume_countdown() {

    // CHECKING IF THE TIMER ALREADY AT ZERO
    if (remaining_seconds != 0) {

      // CHANGING THE BUTTON ICON
      is_pressed = true;

      // SETTING THE TIMER AS RUNNING
      is_running = true;

      // CHECKING IF THERE IS A PREVIOUS TIMER
      if (_timer != null) {

        // DELETING THE PREVIOUS TIMER
        _timer?.cancel();

      }

      // CREATING A TIMER THAT WILL EXECUTE THE FUNCTION EVERY SECOND
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {

        // CHECKING IF THE TIMER IS ZERO, IF NOT IT LOWERS THE REMAINING SECONDS OF ONE
        if (remaining_seconds > 0) {
          setState(() {
            remaining_seconds--;
          });

          // DELETE THE TIMER AND SET THE RUNNING VAR TO FALSE
        } else {
          _timer?.cancel();

          // PLAY ALERT SOUND
          playAlarmSound();

          setState(() {
            is_running = false;
          });
        }
      });

    } else {

      // IF THE TIMER IS ALREADY ZERO, DO NOTHING
      setState(() {
        is_running = false;
      });

      return;

    }

  }

  //------------------------------------------------------------------------------

  // PAUSE COUNTDOWN FUNCTION
  void pause_countdown() {

    // CANCELLING THE TIMER AND SETTING THE RUNNING VAR TO FALSE
    _timer?.cancel();

    setState(() {

      // CHANGING THE BUTTON ICON
      is_pressed = false;

      // SETTING TO OFF THE RUNNING VAR
      is_running = false;

    });

  }

  //------------------------------------------------------------------------------

  // RESET COUNTDOWN FUNCTION
  void reset_countdown() {

    // CANCELLING THE TIMER AND SETTING THE RUNNING VAR TO FALSE
    _timer?.cancel();

    // RESETTING THE REMAINING SECONDS AND SETTING TO FALSE THE RUNNING VAR
    setState(() {

      // CHANGING THE BUTTON ICON
      is_pressed = false;

      // CONVERTING THE MINUTES IN SECONDS
      total_seconds = current_quest.timer * 60;

      // SETTING THE REMAINING TIME AS THE TOTAL TIME
      remaining_seconds = total_seconds;

      // SETTING TO OFF THE RUNNING VAR
      is_running = false;

    });

  }

  //------------------------------------------------------------------------------

  // FUNCTION FOR PLAYING AN ALERT SOUND WHEN THE TIMER FINISHES
  static const platform = MethodChannel('com.herzen.loverquest/audio');

  Future<void> playAlarmSound() async {
    try {
      await platform.invokeMethod('playAlarm');
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print("Errore: ${e.message}");
    }
  }

  //------------------------------------------------------------------------------

  // FUNCTION TO CONVERT THE INPUT SECONDS IN STRING MINUTES FOR THE UI WIDGET
  String _formatTime(int seconds) {

    // GETTING THE INTEGER NUMBER OF MINUTE USING THE DIVISION WITHOUT REMAINDER
    int minutes = seconds ~/ 60;

    // GETTING THE INTEGER NUMBER OF SECONDS USING MODULE OPERATOR
    int secs = seconds % 60;

    // RETURNING THE STRING COMPOSED OF THE MINUTES AND SECONDS. IF THE SECOND NUMBER IS COMPOSED WITH ONLY ONE NUMBER, A 0 WILL BE ADDED TO THE LEFT
    return "$minutes:${secs.toString().padLeft(2, '0')}";
  }

  //------------------------------------------------------------------------------

  // CHECK IF SHOW TIMER FUNCTION
  void check_if_show_timer(Quest current_quest) {

    //------------------------------------------------------------------------------

    // CHECKING IF THE TIMER IS REQUIRED
    if (current_quest.timer == 0) {

      setState(() {

        // HIDING THE TIMER
        show_timer = false;

      });

    } else {

      setState(() {

        // SHOWING THE TIMER
        show_timer = true;

        // SETTING THE TIMER VALUE
        remaining_seconds = current_quest.timer * 60;

      });

    }

    //------------------------------------------------------------------------------

  }

  //------------------------------------------------------------------------------

  //
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // CLASS INITIAL STATE
  @override
  void initState() {
    super.initState();

    //------------------------------------------------------------------------------

    // INITIAL PAGE PREPARATION FUNCTION
    page_preparation();

    //------------------------------------------------------------------------------

    // ENABLING THE ALWAYS ON DISPLAY
    WakelockPlus.enable();

  }

  // INITIAL STATE FUNCTION TO LOAD ALL DEFAULTS DECKS
  Future<void> page_preparation() async {

    //------------------------------------------------------------------------------

    // INITIALIZING THE CURRENT PLAYER VARIABLE
    current_player = widget.first_player;

    //------------------------------------------------------------------------------

    // GETTING THE FIRST QUEST
    if (widget.passed_current_quest.moment == "none") {

      // GETTING THE PLAYER 1 QUEST LISTS AND COUNTERS
      widget.player_1_object.player_early_quest_list = filter_quest_list_by_sex(widget.player_1_object, widget.early_quests_list);
      widget.player_1_object.player_early_quest_list_counter = widget.player_1_object.player_early_quest_list.length;
      widget.player_1_object.player_mid_quest_list = filter_quest_list_by_sex(widget.player_1_object, widget.mid_quests_list);
      widget.player_1_object.player_mid_quest_list_counter = widget.player_1_object.player_mid_quest_list.length;
      widget.player_1_object.player_late_quest_list = filter_quest_list_by_sex(widget.player_1_object, widget.late_quests_list);
      widget.player_1_object.player_late_quest_list_counter = widget.player_1_object.player_late_quest_list.length;
      widget.player_1_object.player_end_quest_list = filter_quest_list_by_sex(widget.player_1_object, widget.end_quests_list);
      widget.player_1_object.player_end_quest_list_counter = widget.player_1_object.player_end_quest_list.length;

      // GETTING THE PLAYER 2 QUEST LISTS
      widget.player_2_object.player_early_quest_list = filter_quest_list_by_sex(widget.player_2_object, widget.early_quests_list);
      widget.player_2_object.player_early_quest_list_counter = widget.player_2_object.player_early_quest_list.length;
      widget.player_2_object.player_mid_quest_list = filter_quest_list_by_sex(widget.player_2_object, widget.mid_quests_list);
      widget.player_2_object.player_mid_quest_list_counter = widget.player_2_object.player_mid_quest_list.length;
      widget.player_2_object.player_late_quest_list = filter_quest_list_by_sex(widget.player_2_object, widget.late_quests_list);
      widget.player_2_object.player_late_quest_list_counter = widget.player_2_object.player_late_quest_list.length;
      widget.player_2_object.player_end_quest_list = filter_quest_list_by_sex(widget.player_2_object, widget.end_quests_list);
      widget.player_2_object.player_end_quest_list_counter = widget.player_2_object.player_end_quest_list.length;


      // SETTING THE INITIAL QUEST
      current_quest = select_random_quest(current_player.player_early_quest_list);

      // SETTING THE INITIAL QUEST LIST
      current_player.player_current_quest_list = current_player.player_early_quest_list;

      // SETTING THE INITIAL QUEST LIST COUNTER
      current_player.player_current_quest_list_counter = current_player.player_early_quest_list_counter;

    } else {

      // SETTING THE INITIAL QUEST
      current_quest = widget.passed_current_quest;

    }

    //------------------------------------------------------------------------------

    // CHECKING IF IS NECESSARY TO SHOW THE TIMER
    check_if_show_timer(current_quest);

    //------------------------------------------------------------------------------

    // POPULATING THE PLAYERS LIST
    players_list = [widget.player_1_object, widget.player_2_object, current_player];

    //------------------------------------------------------------------------------

    // SAVING THE CURRENT MATCH DATA
    await GameStorage.save_game_data(widget.game_type, players_list, current_quest);

    //------------------------------------------------------------------------------

    // UPDATING THE WIDGET STATUS WITH THE LOADED DATA
    setState(() {
      is_loading = false;
    });

    //------------------------------------------------------------------------------

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

    // DEFINING THE FUNCTION THAT WILL CHANGE THE CURRENT PLAYER
    void switch_playing_player() async{

      setState(() {

        // CHECKING IF THERE ARE OTHER QUEST IN ORDER TO ALLOW THE PLAYER SWITCH
        if (widget.player_1_object.player_end_quest_list.isNotEmpty && widget.player_2_object.player_end_quest_list.isNotEmpty) {

          //------------------------------------------------------------------------------

          // DELETING THE QUEST FROM LIST
          current_player.player_current_quest_list = remove_skipped_done_quests(current_player.player_current_quest_list, current_quest);

          //------------------------------------------------------------------------------

          // CHECKING IF THE LIST IS EMPTY OR HAS HALF OF THE CONTENT IN ORDER TO SWITCH TO THE NEXT LIST
          if ( (current_player.player_current_quest_list.isEmpty || (current_player.player_current_quest_list.length <= (current_player.player_current_quest_list_counter/ 3)*2 ) ) && current_quest.moment != "end") {

            // SWITCHING PLAYER 1 LIST TO THE NEXT ONE
            switch_next_quest_list(widget.player_1_object, current_quest);

            // SWITCHING PLAYER 2 LIST TO THE NEXT ONE
            switch_next_quest_list(widget.player_2_object, current_quest);

          }

          //------------------------------------------------------------------------------

          // CHECKING WHO IS THE CURRENT PLAYER
          if (current_player == widget.player_1_object) {

            // SETTING THE OTHER PLAYER TURN
            current_player = widget.player_2_object;

          } else {

            // SETTING THE OTHER PLAYER TURN
            current_player = widget.player_1_object;

          }

          //------------------------------------------------------------------------------

          // CHECKING IF IS POSSIBLE TO GET ANOTHER QUEST
          if (current_player.player_current_quest_list.isNotEmpty) {

            // GETTING THE NEW QUEST
            current_quest = select_random_quest(current_player.player_current_quest_list);

            // CHECKING IF IS NECESSARY TO SHOW THE TIMER
            check_if_show_timer(current_quest);

          }

          //------------------------------------------------------------------------------

        } else {

          // RETURNING A BLANK VALUE TO AVOID ERRORS
          return;

        }

      });

      //------------------------------------------------------------------------------

      // SAVING THE CURRENT MATCH DATA
      await GameStorage.save_game_data(widget.game_type, players_list,  current_quest);

      //------------------------------------------------------------------------------

    }

    //------------------------------------------------------------------------------

    // SKIP CURRENT QUEST
    void skip_current_quest () async{

      setState(() {

        // CHECKING IF THE PLAYERS HAS ENDED THE QUESTS
        if (current_player.player_end_quest_list.isNotEmpty) {

          //------------------------------------------------------------------------------

          // DELETING THE QUEST FROM LIST
          current_player.player_current_quest_list = remove_skipped_done_quests(current_player.player_current_quest_list, current_quest);

          //------------------------------------------------------------------------------

          // CHECKING IF THE LIST IS EMPTY OR HAS HALF OF THE CONTENT IN ORDER TO SWITCH TO THE NEXT LIST
          if ( (current_player.player_current_quest_list.isEmpty || (current_player.player_current_quest_list.length <= (current_player.player_current_quest_list_counter / 3)*2 ) ) && current_quest.moment != "end") {

            // SWITCHING PLAYER 1 LIST TO THE NEXT ONE
            switch_next_quest_list(widget.player_1_object, current_quest);

            // SWITCHING PLAYER 2 LIST TO THE NEXT ONE
            switch_next_quest_list(widget.player_2_object, current_quest);

          }

          //------------------------------------------------------------------------------

          // CHECKING IF IS POSSIBLE TO GET ANOTHER QUEST
          if (current_player.player_current_quest_list.isNotEmpty) {

            // GETTING THE NEW QUEST
            current_quest = select_random_quest(current_player.player_current_quest_list);

            // CHECKING IF IS NECESSARY TO SHOW THE TIMER
            check_if_show_timer(current_quest);

          }

          //------------------------------------------------------------------------------

        } else if (widget.player_2_object.player_end_quest_list.isNotEmpty) {

          // SWITCHING TO THE NEXT PLAYER IN ORDER TO LET THE GAME CONTINUE
          switch_playing_player();

        } else {

          // RETURNING A BLANK VALUE TO AVOID ERRORS
          return;

        }

      });

      //------------------------------------------------------------------------------

      // SAVING THE CURRENT MATCH DATA
      await GameStorage.save_game_data(widget.game_type, players_list,  current_quest);

      //------------------------------------------------------------------------------

    }

    //------------------------------------------------------------------------------

    // PAGE CONTENT
    return Scaffold(

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

                // ALIGNMENT
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,

                // COLUMN CONTENT
                children: [

                  //------------------------------------------------------------------------------

                  // SPACER
                  const SizedBox(height: 45),

                  //------------------------------------------------------------------------------

                  // PLAYER DATA CONTAINER
                  !widget.game_type ?Row(

                    // ALIGNMENT
                    mainAxisAlignment: MainAxisAlignment.center,

                    // ROW CONTENT
                    children: [

                      //------------------------------------------------------------------------------

                      // PAGE LOGO
                      Image.asset(
                        current_player.player_icon_path,
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),

                      //------------------------------------------------------------------------------

                      // SPACER
                      const SizedBox(width: 15),

                      //------------------------------------------------------------------------------

                      // PAGE TITLE CONTAINER
                      Flexible(

                        // TITLE
                        child: Text(
                          // TEXT
                          current_player.player_alias,

                          // TEXT ALIGNMENT
                          textAlign: TextAlign.center,

                          // TEXT STYLE
                          style: TextStyle(

                            fontSize: 30,
                            fontWeight: FontWeight.bold,

                          ),
                        ),

                      ),

                      //------------------------------------------------------------------------------

                    ],

                  ):SizedBox.shrink(),

                  //------------------------------------------------------------------------------

                  // SPACER
                  const SizedBox(height: 30),

                  //------------------------------------------------------------------------------

                  // QUEST BOX
                  Container(

                    // SIZE
                    width: double.infinity,

                    // PADDING
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),

                    // ALIGNMENT
                    alignment: Alignment.topCenter,

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
                        crossAxisAlignment: CrossAxisAlignment.center,

                        // COLUMN CONTENT
                        children: [

                          //------------------------------------------------------------------------------

                          // PAGE TITLE CONTAINER
                          FractionallySizedBox(

                            // DYNAMIC WIDTH
                            widthFactor: 0.8,

                            // TITLE
                            child: Text(
                              // TEXT
                              AppLocalizations.of(context)!.play_page_title,

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
                          const SizedBox(height: 15),

                          //------------------------------------------------------------------------------

                          // QUEST TEXT BOX
                          Text(

                            // TEXT
                            current_quest.content,

                            // TEXT STYLE
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,

                            ),
                          ),

                          //------------------------------------------------------------------------------

                          // SPACER
                          const SizedBox(height: 15),

                          //------------------------------------------------------------------------------

                          // PLAY DISCARD BUTTONS CONTAINER
                          Container(

                            // SIZE
                            width: double.infinity,

                            // ALIGNMENT
                            alignment: Alignment.center,

                            // BUTTON BOX
                            child: Row(

                              mainAxisAlignment: MainAxisAlignment.center,

                              // BOX CONTENT
                              children: [

                                //------------------------------------------------------------------------------

                                // QUEST DONE BUTTON BOX
                                SizedBox(

                                  // FIXED WIDTH
                                  width: 140,

                                  // QUEST DONE BUTTON
                                  child: ElevatedButton(

                                    // BUTTON STYLE PARAMETERS
                                      style: ButtonStyle(

                                        // NORMAL TEXT COLOR
                                        foregroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onPrimary),

                                        // NORMAL BACKGROUND COLOR
                                        backgroundColor: WidgetStateProperty.all(Color.fromRGBO(
                                            157, 241, 129, 0.49411764705882355)),

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
                                      onPressed: () { switch_playing_player(); },

                                      // BUTTON CONTENT
                                      child: Row(

                                        // ALIGNMENT
                                        mainAxisAlignment: MainAxisAlignment.center,

                                        children: [

                                          //------------------------------------------------------------------------------

                                          // SCISSOR ICON
                                          Icon(

                                            // ICONS
                                            Icons.verified_rounded,

                                            // ICONS COLOR
                                            color: Theme.of(context).colorScheme.onPrimary,

                                          ),

                                          //------------------------------------------------------------------------------

                                          // SPACER
                                          const SizedBox(width: 5),

                                          //------------------------------------------------------------------------------

                                          //BUTTON TEXT CONTAINER
                                          Flexible(

                                            // BUTTON TEXT
                                            child: Text(

                                              // TEXT
                                              AppLocalizations.of(context)!.play_page_completed_button,

                                              // TEXT ALIGNMENT
                                              textAlign: TextAlign.center,

                                              // TEXT STYLE
                                              style: TextStyle(

                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,

                                              ),

                                            ),

                                          )

                                          //------------------------------------------------------------------------------

                                        ],

                                      )

                                  ),

                                ),

                                //------------------------------------------------------------------------------

                                // SPACER
                                const SizedBox(width: 15),

                                //------------------------------------------------------------------------------

                                // QUEST DONE BUTTON BOX
                                SizedBox(

                                  // FIXED WIDTH
                                  width: 140,

                                  // SKIP QUEST  BUTTON
                                  child: ElevatedButton(

                                    // BUTTON STYLE PARAMETERS
                                      style: ButtonStyle(

                                        // NORMAL TEXT COLOR
                                        foregroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onPrimary),

                                        // NORMAL BACKGROUND COLOR
                                        backgroundColor: WidgetStateProperty.all(Color.fromRGBO(
                                            219, 157, 80, 0.8784313725490196)),

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
                                      onPressed: () { skip_current_quest(); },

                                      // BUTTON CONTENT
                                      child: Row(

                                        // ALIGNMENT
                                        mainAxisAlignment: MainAxisAlignment.center,

                                        children: [

                                          //------------------------------------------------------------------------------

                                          // SCISSOR ICON
                                          Icon(

                                            // ICONS
                                            Icons.cut,

                                            // ICONS COLOR
                                            color: Theme.of(context).colorScheme.onPrimary,

                                          ),

                                          //------------------------------------------------------------------------------

                                          // SPACER
                                          const SizedBox(width: 5),

                                          //------------------------------------------------------------------------------

                                          // BUTTON TEXT CONTAINER
                                          Flexible(

                                            // BUTTON TEXT
                                            child: Text(

                                              // TEXT
                                              AppLocalizations.of(context)!.play_page_replace_button,
                                              //'',

                                              // TEXT ALIGNMENT
                                              textAlign: TextAlign.center,

                                              // TEXT STYLE
                                              style: TextStyle(

                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,

                                              ),

                                            ),

                                          ),

                                          //------------------------------------------------------------------------------

                                        ],

                                      )

                                  ),


                                ),

                                //------------------------------------------------------------------------------

                              ],

                            ),

                          )

                          //------------------------------------------------------------------------------

                        ]

                    ),

                  ),

                  //------------------------------------------------------------------------------

                  // SPACER
                  const SizedBox(height: 15),

                  //------------------------------------------------------------------------------

                  // TIMER BOX
                  show_timer ?Container(

                    // SIZE
                    width: double.infinity,

                    // PADDING
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),

                    // ALIGNMENT
                    alignment: Alignment.topCenter,

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
                        crossAxisAlignment: CrossAxisAlignment.center,

                        // COLUMN CONTENT
                        children: [

                          //------------------------------------------------------------------------------

                          // TIMER TEXT
                          Text(

                            // TIMER TEXT
                            _formatTime(remaining_seconds),

                            // TEXT STYLE
                            style: TextStyle(

                                fontSize: 48,
                                fontWeight: FontWeight.bold

                            ),

                          ),

                          //------------------------------------------------------------------------------

                          // SPACER
                          SizedBox(height: 5),

                          //------------------------------------------------------------------------------

                          // BUTTON ROW
                          Row(

                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [

                              //------------------------------------------------------------------------------

                              // QUEST DONE BUTTON BOX
                              SizedBox(

                                // FIXED SIZE
                                width: 60,
                                height: 60,

                                // QUEST DONE BUTTON
                                child: ElevatedButton(

                                  // BUTTON STYLE PARAMETERS
                                    style: ButtonStyle(

                                      // NORMAL TEXT COLOR
                                      foregroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onPrimary),

                                      // NORMAL BACKGROUND COLOR
                                      backgroundColor: WidgetStateProperty.all(Color.fromRGBO(
                                          86, 86, 86, 0.49411764705882355)),

                                      // PADDING
                                      padding: WidgetStateProperty.all(EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5)),

                                      // BORDER RADIUS
                                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                      ),

                                    ),

                                    // ON PRESSED CALL
                                    onPressed: is_running ? pause_countdown : () => start_resume_countdown(),

                                    // BUTTON CONTENT
                                    child: Row(

                                      // ALIGNMENT
                                      mainAxisAlignment: MainAxisAlignment.center,

                                      children: [

                                        //------------------------------------------------------------------------------

                                        // SCISSOR ICON
                                        Icon(

                                          // ICONS
                                          is_pressed ? Icons.pause : Icons.play_arrow,

                                          // ICONS COLOR
                                          color: Theme.of(context).colorScheme.onPrimary,

                                          size: 30,

                                        ),

                                        //------------------------------------------------------------------------------

                                      ],

                                    )

                                ),

                              ),

                              //------------------------------------------------------------------------------

                              SizedBox(width: 15),

                              //------------------------------------------------------------------------------

                              // QUEST DONE BUTTON BOX
                              SizedBox(

                                // FIXED SIZE
                                width: 60,
                                height: 60,

                                // QUEST DONE BUTTON
                                child: ElevatedButton(

                                  // BUTTON STYLE PARAMETERS
                                    style: ButtonStyle(

                                      // NORMAL TEXT COLOR
                                      foregroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onPrimary),

                                      // NORMAL BACKGROUND COLOR
                                      backgroundColor: WidgetStateProperty.all(Color.fromRGBO(
                                          86, 86, 86, 0.49411764705882355)),

                                      // PADDING
                                      padding: WidgetStateProperty.all(EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5)),

                                      // BORDER RADIUS
                                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                      ),

                                    ),

                                    // ON PRESSED CALL
                                    onPressed: reset_countdown,

                                    // BUTTON CONTENT
                                    child: Row(

                                      // ALIGNMENT
                                      mainAxisAlignment: MainAxisAlignment.center,

                                      children: [

                                        //------------------------------------------------------------------------------

                                        // SCISSOR ICON
                                        Icon(

                                          // ICONS
                                          Icons.restart_alt_rounded,

                                          // ICONS COLOR
                                          color: Theme.of(context).colorScheme.onPrimary,

                                          size: 30,

                                        ),

                                        //------------------------------------------------------------------------------

                                      ],

                                    )

                                ),

                              ),

                              //------------------------------------------------------------------------------

                            ],

                          ),

                          //------------------------------------------------------------------------------

                        ]

                    ),

                  ): SizedBox.shrink(),

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




