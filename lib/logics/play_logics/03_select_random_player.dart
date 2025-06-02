//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'dart:math';

// CUSTOM FILES
import 'package:loverquest/logics/play_logics/02_players_class.dart';

//------------------------------------------------------------------------------ù



// DEFINING RANDOM PLAYER SELECTION FUNCTION
Players select_random_player (Players player_1_object, Players player_2_object) {

  // CREATING RANDOM INSTANCE
  var random = Random();

  // GENERATING RANDOM NUMBER BETWEEN 1-100
  int random_number = random.nextInt(100) + 1;

  // CHECKING IF THE NUMBER IS EVEN OR ODD
  if ( random_number % 2 == 0) {

    // SETTING AS STARTING PLAYER THE PLAYER ONE
    return player_1_object;

  } else {

    // SETTING AS STARTING PLAYER THE PLAYER TWO
    return player_2_object;

  }

}



//------------------------------------------------------------------------------