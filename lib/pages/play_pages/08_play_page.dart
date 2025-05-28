//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:loverquest/l10n/app_localization.dart';
import 'package:loverquest/logics/play_logics/05_timer_controller.dart';
import 'package:provider/provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

// CUSTOM FILES
import 'package:loverquest/logics/play_logics/01_match_data_class.dart';
import 'package:loverquest/logics/play_logics/02_players_class.dart';

import 'package:loverquest/logics/decks_logics/03_quest_class.dart';
import 'package:loverquest/logics/play_logics/04_quest_management.dart';
import 'package:loverquest/logics/play_logics/06_game_storage_class.dart';

//------------------------------------------------------------


// DECK SELECTION PAGE DEFINITION
class PlayPage extends StatefulWidget {

  // CLASS CONSTRUCTOR
  const PlayPage({super.key,});

  // LINK TO CLASS STATE / WIDGET CONTENT
  @override
  State<PlayPage> createState() => _PlayPageState();

}



//------------------------------------------------------------------------------



// CLASS STATE / WIDGET CONTENT
class _PlayPageState extends State<PlayPage> {

  //------------------------------------------------------------------------------

  // INITIALIZING THE MATCH DATA OBJECT VAR
  MatchData match_data = MatchData();

  // DEFINING THE IS LOADING VARIABLE
  bool is_loading = true;

  // DEFINING THE BUTTON DISABLED FLAG
  late final Debouncer _buttonDebouncer;

  // INITIALIZING THE NO MORE QUESTS FLAG
  bool no_more_quests = false;

  // INITIALIZING THE PLAYERS VARIABLES
  late Players current_player;

  // DEFINING THE TIMER VARIABLES
  late bool show_timer;
  TimerController timer_controller = TimerController(totalSeconds: 0);

  // DEFINING THE QUEST VARIABLES
  int partial_score = 0;
  late String end_quest_type;
  late String start_quest_type;
  late Quest last_quest;

  //------------------------------------------------------------------------------

  // FUNCTION FOR PLAYING AN ALERT SOUND WHEN THE TIMER FINISHES
  static const platform = MethodChannel('com.herzen.loverquest/audio');

  Future<void> playAlarmSound() async {

    // CHECKING WHICH PLATFORM IS IN USE
    if(kIsWeb) {

      // INITIALIZING THE AUDIO PLAYER
      final player = AudioPlayer();

      // PLAYING THE ALARM SOUND
      await player.play(AssetSource('audio/timer_alarm.mp3'));

    } else {

      try {
        await platform.invokeMethod('playAlarm');
      } on PlatformException catch (e) {
        // ignore: avoid_print
        print("Error: ${e.message}");
      }

    }

  }

  //------------------------------------------------------------------------------

  // CHECK IF SHOW TIMER FUNCTION
  void check_if_show_timer(Quest current_quest) {

    //------------------------------------------------------------------------------

    // CHECKING IF THE QUEST REQUIRES A TIMER
    if (current_quest.timer == 0) {
      setState(() {

        // SETTING THE TIMER HAS TO NOT SHOW
        show_timer = false;
      });


    } else {

      // GETTING THE TIMER CONTROLLER
      timer_controller = TimerController(totalSeconds: current_quest.timer * 60);

      // INITIALIZING THE TIMER
      timer_controller.onTick = () {

        // CHECKING IF THE PAGE IS STILL EXISTING
        if (!mounted) return;

        setState(() {});

      };

      // SETTING THE TIMER ALARM SOUND ON TIMER END
      timer_controller.onComplete = () {

        // CHECKING IF THE PAGE IS STILL EXISTING
        if (!mounted) return;

        playAlarmSound();

        setState(() {});

      };


      setState(() {

        // SETTING THE TIMER HAS TO SHOW
        show_timer = true;

      });
    }

    //------------------------------------------------------------------------------

  }

  //------------------------------------------------------------------------------

  // DELETE TIMER IN THE PROPER WAY
  @override
  void dispose() {
    timer_controller.dispose();
    super.dispose();
  }

  // CLASS INITIAL STATE
  @override
  void initState() {
    super.initState();

    //------------------------------------------------------------------------------

    // GETTING THE DATA FROM THE PROVIDER
    match_data = Provider.of<MatchDataProvider>(context, listen: false).matchData!;

    // INITIAL PAGE PREPARATION FUNCTION
    page_preparation();

    // ENABLING THE ALWAYS ON DISPLAY
    WakelockPlus.enable();

    // INITIALIZING THE BUTTON DOUBLE CLICK CONTROLLER
    _buttonDebouncer = Debouncer();

    //------------------------------------------------------------------------------

  }

  // INITIAL STATE FUNCTION TO LOAD ALL DEFAULTS DECKS
  Future<void> page_preparation() async {

    //------------------------------------------------------------------------------

    // FINDING WHO IS THE FIRST PLAYER
    if (match_data.player_one.player_alias == match_data.current_player_alias) {

      // INITIALIZING THE CURRENT PLAYER VARIABLES
      current_player = match_data.player_one;

    } else {

      // INITIALIZING THE CURRENT PLAYER VARIABLES
      current_player = match_data.player_two;

    }

    // INITIALIZING THE CURRENT PLAYER VARIABLES
    match_data.current_player_alias = current_player.player_alias;

    //------------------------------------------------------------------------------

    // GETTING THE FIRST QUEST
    if (match_data.current_quest.moment == "none") {

      // LOADING THE PLAYERS QUEST LISTS
      match_data = load_players_quest_lists(match_data);

      // GETTING THE END QUEST TYPE
      end_quest_type = getting_end_quest_type(match_data);

      // SETTING THE INITIAL QUEST LIST AND QUEST LIST COUNTER
      current_player = getting_start_quest_type(match_data, current_player);
      match_data.player_one = getting_start_quest_type(match_data, match_data.player_one);
      match_data.player_two = getting_start_quest_type(match_data, match_data.player_two);

      // SETTING THE INITIAL QUEST
      match_data.current_quest = select_random_quest(current_player.player_current_quest_list);
      last_quest = match_data.current_quest;

    } else {

      // GETTING THE END QUEST TYPE
      end_quest_type = getting_end_quest_type(match_data);
      last_quest = match_data.current_quest;

    }

    //------------------------------------------------------------------------------

    // CHECKING IF IS NECESSARY TO SHOW THE TIMER
    check_if_show_timer(match_data.current_quest);

    //------------------------------------------------------------------------------

    // SAVING THE CURRENT MATCH DATA
    await GameStorage.save_match_data(match_data);

    //------------------------------------------------------------------------------

    // CHECKING IF THE PAGE IS STILL EXISTING
    if (!mounted) return;

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
    Future<void> change_quest_and_switch_playing_player() async{

      //------------------------------------------------------------------------------

      // CHECKING IF WE CAN SKIP ALL THE FUNCTION BECAUSE THERE ARE NO MORE QUEST TO DO
      if(match_data.player_one.player_current_quest_list.isEmpty && match_data.player_two.player_current_quest_list.isEmpty) {

        // SETTING THE QUESTS LIST AS EMPTY
        setState(() {
          no_more_quests = true;
        });

        // BLANK RETURN TO AVOID ANY ERROR
        return;

      }

      //------------------------------------------------------------------------------

      // SWITCHING THE PLAYER AND GETTING A NEW QUEST
      setState(() {

        //------------------------------------------------------------------------------

        // ENSURING THAT WE ARE NO TRYING TO REMOVE A QUEST FROM AN EMPTY LIST
        if(current_player.player_current_quest_list.isNotEmpty) {

          // DELETING THE QUEST FROM THE CURRENT QUEST LIST OF THE CURRENT PLAYER
          current_player.player_current_quest_list = remove_skipped_done_quests(current_player.player_current_quest_list, match_data.current_quest);

        }

        //------------------------------------------------------------------------------

        // CHECKING WHO IS THE CURRENT PLAYER
        if (match_data.current_player_alias == match_data.player_one.player_alias) {

          // SETTING THE OTHER PLAYER TURN
          current_player = match_data.player_two;
          match_data.current_player_alias = match_data.player_two.player_alias;

        }
        else {

          // SETTING THE OTHER PLAYER TURN
          current_player = match_data.player_one;
          match_data.current_player_alias = match_data.player_one.player_alias;

        }

        //------------------------------------------------------------------------------

        // INITIALIZING THE QUEST CHANGE FLAG
        bool quest_unchanged = true;

        // WHILE A NEW QUEST HAS NOT BEEN SET, EXECUTE THIS
        do {

          //------------------------------------------------------------------------------

          // CHECKING IF IS NECESSARY TO SWITCH THE QUEST TYPE
          if ((current_player.player_current_quest_list_counter - current_player.player_current_quest_list.length) >= (current_player.player_current_quest_list_counter/4)*match_data.game_pace_multiplier) {

            // SWITCHING PLAYER 1 AND PLAYER 2 LIST TO THE NEXT ONE
            match_data = switch_next_quest_list(match_data);

            // POINTING THE CORRECT OBJECTS
            if (match_data.current_player_alias == match_data.player_one.player_alias) {
              current_player = match_data.player_one;
            } else {
              current_player = match_data.player_two;
            }

          }

          //------------------------------------------------------------------------------

          // CHECKING IF IS POSSIBLE TO GET A NEW QUEST
          if(current_player.player_current_quest_list.isNotEmpty && match_data.current_quest.moment != end_quest_type) {

            // DEFINING THE SAFETY COUNTER+
            int safety_counter = 0;

            do {

              // GETTING THE NEW QUEST
              match_data.current_quest = select_random_quest(current_player.player_current_quest_list);

              // CHECKING IF IS USELESS TO CONTINUE TO TRY TO GET A DIFFERENT QUEST
              if (current_player.player_current_quest_list.length == 1) {break;}

              // UPDATING THE SAFETY COUNTER
              safety_counter++;

            } while (match_data.current_quest.content == last_quest.content && safety_counter < 5);

            // CHECKING IF IS NECESSARY TO SHOW THE TIMER
            check_if_show_timer(match_data.current_quest);

            // FLAG THE QUEST HAS CHANGED
            quest_unchanged = false;

            // CHECKING IF IN THE END SECTION IS NECESSARY TO FORCE SWITCH PLAYER IN ORDER TO GET A NEW QUEST
          }

          // CHECKING IF IS POSSIBLE TO GET A NEW QUEST IN THE END PHASE
          else if (match_data.current_quest.moment == end_quest_type) {

            // CHECKING IF THE CURRENT PLAYER HAS AT LEAST ONE QUEST TO PLAY
            if(current_player.player_current_quest_list.isNotEmpty) {

              // DEFINING THE SAFETY COUNTER+
              int safety_counter = 0;

              do {

                // GETTING THE NEW QUEST
                match_data.current_quest = select_random_quest(current_player.player_current_quest_list);

                // CHECKING IF IS USELESS TO CONTINUE TO TRY TO GET A DIFFERENT QUEST
                if (current_player.player_current_quest_list.length == 1) {break;}

                // UPDATING THE SAFETY COUNTER
                safety_counter++;

              } while (match_data.current_quest.content == last_quest.content && safety_counter < 5);

              // CHECKING IF IS NECESSARY TO SHOW THE TIMER
              check_if_show_timer(match_data.current_quest);

              // FLAG THE QUEST HAS CHANGED
              quest_unchanged = false;

            } else

            // CHECKING IF THE OTHER PLAYER IS PLAYER 2
            if(match_data.current_player_alias == match_data.player_one.player_alias) {

              // CHECKING IF THE PLAYER 2 HAS AT LEAST ONE QUEST IN HIS CURRENT QUEST LIST
              if(match_data.player_two.player_current_quest_list.isNotEmpty) {

                // SETTING THE OTHER PLAYER TURN
                current_player = match_data.player_two;
                match_data.current_player_alias = match_data.player_two.player_alias;

                // GETTING THE NEW QUEST
                match_data.current_quest = select_random_quest(current_player.player_current_quest_list);

                // CHECKING IF IS NECESSARY TO SHOW THE TIMER
                check_if_show_timer(match_data.current_quest);

                // FLAG THE QUEST HAS CHANGED
                quest_unchanged = false;


              } else { quest_unchanged = false; no_more_quests = true;}

            } else {

              // CHECKING IF THE PLAYER 2 HAS AT LEAST ONE QUEST IN HIS CURRENT QUEST LIST
              if(match_data.player_one.player_current_quest_list.isNotEmpty) {

                // SETTING THE OTHER PLAYER TURN
                current_player = match_data.player_one;
                match_data.current_player_alias = match_data.player_one.player_alias;

                // GETTING THE NEW QUEST
                match_data.current_quest = select_random_quest(current_player.player_current_quest_list);

                // CHECKING IF IS NECESSARY TO SHOW THE TIMER
                check_if_show_timer(match_data.current_quest);

                // FLAG THE QUEST HAS CHANGED
                quest_unchanged = false;

              } else { quest_unchanged = false; no_more_quests = true;}

            }

          }

        } while (quest_unchanged);

        //------------------------------------------------------------------------------

      });

      //------------------------------------------------------------------------------

      // SAVING THE CURRENT MATCH DATA
      await GameStorage.save_match_data(match_data);

      //------------------------------------------------------------------------------

      }

    //------------------------------------------------------------------------------

    // SKIP CURRENT QUEST
    Future<void> skip_current_quest () async{

      //------------------------------------------------------------------------------

      // CHECKING IF WE CAN SKIP ALL THE FUNCTION BECAUSE THERE ARE NO MORE QUEST TO DO
      if(match_data.player_one.player_current_quest_list.isEmpty && match_data.player_two.player_current_quest_list.isEmpty) {

        // SETTING THE QUESTS LIST AS EMPTY
        setState(() {
          no_more_quests = true;
        });

        // BLANK RETURN TO AVOID ANY ERROR
        return;

      }

      //------------------------------------------------------------------------------

      // SWITCHING THE PLAYER AND GETTING A NEW QUEST
      setState(() {

        //------------------------------------------------------------------------------

        // ENSURING THAT WE ARE NO TRYING TO REMOVE A QUEST FROM AN EMPTY LIST
        if(current_player.player_current_quest_list.isNotEmpty) {

          // DELETING THE QUEST FROM THE CURRENT QUEST LIST OF THE CURRENT PLAYER
          current_player.player_current_quest_list = remove_skipped_done_quests(current_player.player_current_quest_list, match_data.current_quest);

        }

        //-----------------------------------------------------------------------------

        // INITIALIZING THE QUEST CHANGE FLAG
        bool quest_unchanged = true;

        // WHILE A NEW QUEST HAS NOT BEEN SET, EXECUTE THIS
        do {

          //------------------------------------------------------------------------------

          // CHECKING IF IS NECESSARY TO SWITCH THE QUEST TYPE
          if ((current_player.player_current_quest_list_counter - current_player.player_current_quest_list.length) >= (current_player.player_current_quest_list_counter/4)*match_data.game_pace_multiplier) {

            // SWITCHING PLAYER 1 AND PLAYERS 2 LIST TO THE NEXT ONE
            match_data = switch_next_quest_list(match_data);

            // POINTING THE CORRECT OBJECTS
            if (match_data.current_player_alias == match_data.player_one.player_alias) {
              current_player = match_data.player_one;
            } else {
              current_player = match_data.player_two;
            }

          }

          //------------------------------------------------------------------------------

          // CHECKING IF IS POSSIBLE TO GET A NEW QUEST
          if(current_player.player_current_quest_list.isNotEmpty && match_data.current_quest.moment != end_quest_type) {

            // GETTING THE NEW QUEST
            match_data.current_quest = select_random_quest(current_player.player_current_quest_list);

            // CHECKING IF IS NECESSARY TO SHOW THE TIMER
            check_if_show_timer(match_data.current_quest);

            // FLAG THE QUEST HAS CHANGED
            quest_unchanged = false;

          }

          // CHECKING IF IS POSSIBLE TO GET A NEW QUEST IN THE END PHASE
          else if (match_data.current_quest.moment == end_quest_type) {

            // CHECKING IF THE CURRENT PLAYER HAS AT LEAST ONE QUEST TO PLAY
            if(current_player.player_current_quest_list.isNotEmpty) {

              // GETTING THE NEW QUEST
              match_data.current_quest = select_random_quest(current_player.player_current_quest_list);

              // CHECKING IF IS NECESSARY TO SHOW THE TIMER
              check_if_show_timer(match_data.current_quest);

              // FLAG THE QUEST HAS CHANGED
              quest_unchanged = false;

            } else

            // CHECKING IF THE OTHER PLAYER IS PLAYER 2
            if(match_data.current_player_alias == match_data.player_one.player_alias) {

              // CHECKING IF THE PLAYER 2 HAS AT LEAST ONE QUEST IN HIS CURRENT QUEST LIST
              if(match_data.player_two.player_current_quest_list.isNotEmpty) {

                // SETTING THE OTHER PLAYER TURN
                current_player = match_data.player_two;
                match_data.current_player_alias = match_data.player_two.player_alias;

                // GETTING THE NEW QUEST
                match_data.current_quest = select_random_quest(current_player.player_current_quest_list);

                // CHECKING IF IS NECESSARY TO SHOW THE TIMER
                check_if_show_timer(match_data.current_quest);

                // FLAG THE QUEST HAS CHANGED
                quest_unchanged = false;


              } else { quest_unchanged = false; no_more_quests = true;}

            } else {

              // CHECKING IF THE PLAYER 2 HAS AT LEAST ONE QUEST IN HIS CURRENT QUEST LIST
              if(match_data.player_one.player_current_quest_list.isNotEmpty) {

                // SETTING THE OTHER PLAYER TURN
                current_player = match_data.player_one;
                match_data.current_player_alias = match_data.player_one.player_alias;

                // GETTING THE NEW QUEST
                match_data.current_quest = select_random_quest(current_player.player_current_quest_list);

                // CHECKING IF IS NECESSARY TO SHOW THE TIMER
                check_if_show_timer(match_data.current_quest);

                // FLAG THE QUEST HAS CHANGED
                quest_unchanged = false;

              } else { quest_unchanged = false; no_more_quests = true;}

            }

          }

        } while (quest_unchanged);

        //------------------------------------------------------------------------------

      });

      //------------------------------------------------------------------------------

      // SAVING THE CURRENT MATCH DATA
      await GameStorage.save_match_data(match_data);

      //------------------------------------------------------------------------------

    }

    //------------------------------------------------------------------------------

    // CHECKING IF IS NECESSARY TO SHOW THE GAME OVER UI OR THE PLAY UI
    if (no_more_quests) {

      // PAGE CONTENT WHEN THE GAME IS OVER
      return Scaffold(

        // PAGE CONTENT
          body: SafeArea(

            // SAFE AREA CONTENT
            child: Container(

              // PAGE PADDING
                padding: EdgeInsets.all(10),

                // PAGE ALIGNMENT
                alignment: Alignment.topCenter,

                // SCROLLABLE CONTAINER
                child: SingleChildScrollView(

                  // MAIN COLUMN
                  child: Column(

                    // SIZE PARAMETERS
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,

                    // COLUMN CONTENT
                    children: [

                      //------------------------------------------------------------------------------

                      // SPACER
                      const SizedBox(height: 80),

                      //------------------------------------------------------------------------------

                      // APP LOGO
                      Image.asset(
                        'assets/images/main_icon.png',
                        width: 140,
                        height: 140,
                        fit: BoxFit.contain,
                      ),

                      //------------------------------------------------------------------------------

                      // SPACER
                      const SizedBox(height: 45),

                      //------------------------------------------------------------------------------

                      // TITLE
                      Text(

                        // TEXT
                        AppLocalizations.of(context)!.play_page_end_page_title,

                        // TEXT ALIGNMENT
                        textAlign: TextAlign.center,

                        // TEXT STYLE
                        style: TextStyle(

                          fontSize: 25,
                          fontWeight: FontWeight.bold,


                        ),

                      ),

                      //------------------------------------------------------------------------------

                      // SPACER
                      const SizedBox(height: 10),

                      //------------------------------------------------------------------------------

                      // SUBTITLE
                      Text(

                        // TEXT
                        AppLocalizations.of(context)!.play_page_end_page_subtitle,

                        // TEXT ALIGNMENT
                        textAlign: TextAlign.center,

                        // TEXT STYLE
                        style: TextStyle(

                          fontSize: 19,
                          fontWeight: FontWeight.w400,

                        ),

                      ),

                      //------------------------------------------------------------------------------

                      // SPACER
                      const SizedBox(height: 45),

                      //------------------------------------------------------------------------------

                      // NEW GAME BUTTON BOX
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

                            // PAGE LINKER
                            context.go('/play');

                          },

                          // BUTTON CONTENT
                          child: Text(

                            // TEXT
                            AppLocalizations.of(context)!.play_page_end_page_go_home_button_label,

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

                    ], // Children

                  ),

                )

            ),

          )

      );


    } else {


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
                    match_data.play_local ? Row(

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

                    ) : const SizedBox.shrink(),

                    //------------------------------------------------------------------------------

                    // SPACER
                    const SizedBox(height: 30),

                    //------------------------------------------------------------------------------

                    // QUEST BOX
                    Container(

                      // SIZE
                      width: double.infinity,

                      // PADDING
                      padding: EdgeInsets.symmetric(
                          horizontal: 25, vertical: 25),

                      // ALIGNMENT
                      alignment: Alignment.topCenter,

                      // STYLING
                      decoration: BoxDecoration(

                        // BACKGROUND COLOR
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,

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
                              match_data.current_quest.content,

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

                            // PLAY BUTTONS CONTAINER
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
                                          foregroundColor: WidgetStateProperty
                                              .all(Theme
                                              .of(context)
                                              .colorScheme
                                              .onPrimary),

                                          // NORMAL BACKGROUND COLOR
                                          backgroundColor: WidgetStateProperty
                                              .all(Color.fromRGBO(
                                              157, 241, 129,
                                              0.49411764705882355)),

                                          // PADDING
                                          padding: WidgetStateProperty.all(
                                              EdgeInsets.only(left: 15,
                                                  right: 15,
                                                  top: 15,
                                                  bottom: 15)),

                                          // BORDER RADIUS
                                          shape: WidgetStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(100),
                                            ),
                                          ),

                                        ),

                                        // ON PRESSED CALL
                                        onPressed: () {
                                          _buttonDebouncer.debounce(
                                            duration: Duration(milliseconds: 100),
                                            onDebounce: () async {
                                              await change_quest_and_switch_playing_player();
                                            },
                                          );
                                        },

                                        // BUTTON CONTENT
                                        child: Row(

                                          // ALIGNMENT
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,

                                          children: [

                                            //------------------------------------------------------------------------------

                                            // SCISSOR ICON
                                            Icon(

                                              // ICONS
                                              Icons.verified_rounded,

                                              // ICONS COLOR
                                              color: Theme
                                                  .of(context)
                                                  .colorScheme
                                                  .onPrimary,

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
                                                AppLocalizations.of(context)!
                                                    .play_page_completed_button,

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
                                        foregroundColor: WidgetStateProperty
                                            .all(Theme
                                            .of(context)
                                            .colorScheme
                                            .onPrimary),

                                        // NORMAL BACKGROUND COLOR
                                        backgroundColor: WidgetStateProperty
                                            .all(Color.fromRGBO(
                                            219, 157, 80,
                                            0.8784313725490196)),

                                        // PADDING
                                        padding: WidgetStateProperty.all(
                                            EdgeInsets.only(left: 15,
                                                right: 15,
                                                top: 15,
                                                bottom: 15)),

                                        // BORDER RADIUS
                                        shape: WidgetStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius
                                                .circular(100),
                                          ),
                                        ),

                                      ),

                                      // ON PRESSED CALL
                                      onPressed: () {
                                        _buttonDebouncer.debounce(
                                          duration: Duration(milliseconds: 100),
                                          onDebounce: () async {
                                            await skip_current_quest();
                                          },
                                        );
                                      },

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
                                            color: Theme
                                                .of(context)
                                                .colorScheme
                                                .onPrimary,

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
                                              AppLocalizations.of(context)!
                                                  .play_page_replace_button,

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
                    show_timer ? Container(

                      // SIZE
                      width: double.infinity,

                      // PADDING
                      padding: EdgeInsets.symmetric(
                          horizontal: 25, vertical: 25),

                      // ALIGNMENT
                      alignment: Alignment.topCenter,

                      // STYLING
                      decoration: BoxDecoration(

                        // BACKGROUND COLOR
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,

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

                              // TIMER TITLE TEXT
                              AppLocalizations.of(context)!
                                  .play_page_timer_label,

                              // TEXT STYLE
                              style: TextStyle(

                                  fontSize: 25,
                                  fontWeight: FontWeight.bold

                              ),

                            ),

                            //------------------------------------------------------------------------------

                            // SPACER
                            const SizedBox(height: 5),

                            //------------------------------------------------------------------------------

                            // TIMER TEXT
                            Text(

                              // TIMER TEXT
                              timer_controller.formattedTime(),

                              // TEXT STYLE
                              style: TextStyle(

                                  fontSize: 48,
                                  fontWeight: FontWeight.bold

                              ),

                            ),

                            //------------------------------------------------------------------------------

                            // SPACER
                            const SizedBox(height: 5),

                            //------------------------------------------------------------------------------

                            // BUTTON ROW
                            Row(

                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [

                                //------------------------------------------------------------------------------

                                // PLAY/PAUSE BUTTON BOX
                                SizedBox(

                                  // FIXED SIZE
                                  width: 60,
                                  height: 60,

                                  // QUEST DONE BUTTON
                                  child: ElevatedButton(

                                    // BUTTON STYLE PARAMETERS
                                      style: ButtonStyle(

                                        // NORMAL TEXT COLOR
                                        foregroundColor: WidgetStateProperty
                                            .all(Theme
                                            .of(context)
                                            .colorScheme
                                            .onPrimary),

                                        // NORMAL BACKGROUND COLOR
                                        backgroundColor: WidgetStateProperty
                                            .all(Color.fromRGBO(
                                            86, 86, 86, 0.49411764705882355)),

                                        // PADDING
                                        padding: WidgetStateProperty.all(
                                            EdgeInsets.only(left: 5,
                                                right: 5,
                                                top: 5,
                                                bottom: 5)),

                                        // BORDER RADIUS
                                        shape: WidgetStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                100),
                                          ),
                                        ),

                                      ),

                                      // ON PRESSED CALL
                                      onPressed: () {
                                        setState(() {
                                          // CHECKING WHICH BEHAVIOR DO
                                          if (timer_controller.isRunning) {
                                            timer_controller.pause();
                                          } else {
                                            timer_controller.start();
                                          }
                                        });
                                      },

                                      // BUTTON CONTENT
                                      child: Row(

                                        // ALIGNMENT
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,

                                        children: [

                                          //------------------------------------------------------------------------------

                                          // SCISSOR ICON
                                          Icon(

                                            // CHECKING WHICH ICON SHOW
                                            timer_controller.isRunning ? Icons
                                                .pause : Icons.play_arrow,

                                            // ICON COLOR
                                            color: Theme
                                                .of(context)
                                                .colorScheme
                                                .onPrimary,

                                            // ICON SIZE
                                            size: 30,

                                          ),

                                          //------------------------------------------------------------------------------

                                        ],

                                      )

                                  ),

                                ),

                                //------------------------------------------------------------------------------

                                const SizedBox(width: 15),

                                //------------------------------------------------------------------------------

                                // RESET BUTTON BOX
                                SizedBox(

                                  // FIXED SIZE
                                  width: 60,
                                  height: 60,

                                  // QUEST DONE BUTTON
                                  child: ElevatedButton(

                                    // BUTTON STYLE PARAMETERS
                                      style: ButtonStyle(

                                        // NORMAL TEXT COLOR
                                        foregroundColor: WidgetStateProperty
                                            .all(Theme
                                            .of(context)
                                            .colorScheme
                                            .onPrimary),

                                        // NORMAL BACKGROUND COLOR
                                        backgroundColor: WidgetStateProperty
                                            .all(Color.fromRGBO(
                                            86, 86, 86, 0.49411764705882355)),

                                        // PADDING
                                        padding: WidgetStateProperty.all(
                                            EdgeInsets.only(left: 5,
                                                right: 5,
                                                top: 5,
                                                bottom: 5)),

                                        // BORDER RADIUS
                                        shape: WidgetStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                100),
                                          ),
                                        ),

                                      ),

                                      // ON PRESSED CALL
                                      onPressed: () {
                                        setState(() {
                                          timer_controller.reset();
                                        });
                                      },


                                      // BUTTON CONTENT
                                      child: Row(

                                        // ALIGNMENT
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,

                                        children: [

                                          //------------------------------------------------------------------------------

                                          // SCISSOR ICON
                                          Icon(

                                            // ICONS
                                            Icons.restart_alt_rounded,

                                            // ICONS COLOR
                                            color: Theme
                                                .of(context)
                                                .colorScheme
                                                .onPrimary,

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

                    ) : const SizedBox.shrink(),

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

}



//------------------------------------------------------------------------------




