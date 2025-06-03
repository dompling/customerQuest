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