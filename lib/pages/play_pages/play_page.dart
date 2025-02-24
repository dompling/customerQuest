//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';
import 'dart:async';

// CUSTOM FILES
import 'package:loverquest/logics/decks_logics/quests_reader.dart';
import 'package:loverquest/logics/play_logics/player_class.dart';
import 'package:loverquest/logics/play_logics/quest_selector.dart';

//------------------------------------------------------------------------------


// DECK SELECTION PAGE DEFINITION
class PlayPage extends StatefulWidget {

  // CLASS ATTRIBUTES
  final Players player_1_object;
  final Players player_2_object;
  final Players first_player;
  final List<Quest> early_quests_list;
  final int early_quests_total_score;
  final List<Quest> mid_quests_list;
  final int mid_quests_total_score;
  final List<Quest> late_quests_list;
  final int late_quests_total_score;
  final List<Quest> end_quests_list;
  final int end_quests_total_score;

  // CLASS CONSTRUCTOR
  const PlayPage({
    required this.player_1_object,
    required this.player_2_object,
    required this.first_player,
    required this.early_quests_list,
    required this.early_quests_total_score,
    required this.mid_quests_list,
    required this.mid_quests_total_score,
    required this.late_quests_list,
    required this.late_quests_total_score,
    required this.end_quests_list,
    required this.end_quests_total_score,

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
  int _totalSeconds = 0;
  int _remainingSeconds = 0;
  Timer? _timer;
  bool _isRunning = false;

  //------------------------------------------------------------------------------

  // INITIALIZING THE PLAYERS VARIABLES
  late Players current_player;

  //------------------------------------------------------------------------------

  // INITIALIZING THE TIMER VARIABLE
  late bool show_timer;

  //------------------------------------------------------------------------------

  // INITIALIZING THE QUEST VARIABLES
  late Quest current_quest;

  //------------------------------------------------------------------------------

  // START COUNTDOWN FUNCTION
  void _startCountdown(int minutes) {

    setState(() {

      // CONVERTING THE MINUTES IN SECONDS
      _totalSeconds = minutes * 60;

      // SETTING THE REMAINING TIME AS THE TOTAL TIME
      _remainingSeconds = _totalSeconds;

      // SETTING THE TIMER AS RUNNING
      _isRunning = true;

    });

    // STARTING THE TIMER
    _resumeCountdown();

  }

  //------------------------------------------------------------------------------

  // RESUME COUNTDOWN FUNCTION
  void _resumeCountdown() {

    // CREATING A TIMER THAT WILL EXECUTE THE FUNCTION EVERY SECOND
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {

      // CHECKING IF THE TIMER IS ZERO, IF NOT IT LOWERS THE REMAINING SECONDS OF ONE
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });

        // DELETE THE TIMER AND SET THE RUNNING VAR TO FALSE
      } else {
        _timer?.cancel();
        setState(() {
          _isRunning = false;
        });
      }
    });
  }

  //------------------------------------------------------------------------------

  // PAUSE COUNTDOWN FUNCTION
  void _pauseCountdown() {

    // CANCELLING THE TIMER AND SETTING THE RUNNING VAR TO FALSE
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });

  }

  //------------------------------------------------------------------------------

  // RESET COUNTDOWN FUNCTION
  void _resetCountdown() {

    // CANCELLING THE TIMER AND SETTING THE RUNNING VAR TO FALSE
    _timer?.cancel();

    // RESETTING THE REMAINING SECONDS AND SETTING TO FALSE THE RUNNING VAR
    setState(() {
      _remainingSeconds = _totalSeconds;
      _isRunning = false;
    });

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

        print('DEBUG | I WILL NOT SHOW THE TIMER !');

        // HIDING THE TIMER
        show_timer = false;

      });

    } else {

      setState(() {

        print('DEBUG | I WILL SHOW THE TIMER !');

        // SHOWING THE TIMER
        show_timer = true;

        // SETTING THE TIMER VALUE
        _remainingSeconds = current_quest.timer * 60;

      });

    }

    //------------------------------------------------------------------------------

  }

  //------------------------------------------------------------------------------


  // CLASS INITIAL STATE
  @override
  void initState() {
    super.initState();

    //------------------------------------------------------------------------------

    // INITIAL PAGE PREPARATION FUNCTION
    page_preparation();

    //------------------------------------------------------------------------------

  }

  // INITIAL STATE FUNCTION TO LOAD ALL DEFAULTS DECKS
  Future<void> page_preparation() async {

    //------------------------------------------------------------------------------

    // INITIALIZING THE CURRENT PLAYER VARIABLE
    current_player = widget.first_player;

    //------------------------------------------------------------------------------

    // GETTING THE FIRST QUEST
    current_quest = select_random_quest(widget.early_quests_list);

    //------------------------------------------------------------------------------

    // CHECKING IF IS NECESSARY TO SHOW THE TIMER
    check_if_show_timer(current_quest);

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
    void switch_playing_player(current_player) {

      // CHECKING WHO IS THE CURRENT PLAYER
      if (current_player == widget.player_1_object) {

        // SETTING THE OTHER PLAYER TURN
        current_player = widget.player_2_object;

      } else {

        // SETTING THE OTHER PLAYER TURN
        current_player = widget.player_1_object;

      }



    }

    //------------------------------------------------------------------------------

    //

    //------------------------------------------------------------------------------

    return Scaffold(

      // APP BAR
      appBar: AppBar(),

      // SCAFFOLD CONTENT
      body: SafeArea(

        child: Container(

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
                        current_player.player_alias,

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
                      _formatTime(_remainingSeconds),
                      style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    ),

                    // SPACER
                    SizedBox(height: 20),

                    // BUTTON ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _isRunning ? _pauseCountdown : () => _resumeCountdown(),
                          child: Text(_isRunning ? "Pausa" : "Riprendi"),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: _resetCountdown,
                          child: Text("Reset"),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _startCountdown(2); // Imposta il timer a 2 minuti (modificabile)
                      },
                      child: Text("Avvia 2 minuti"),
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

    );

  }

}



//------------------------------------------------------------------------------




