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

// CUSTOM FILES
import 'package:loverquest/logics/play_logics/01_match_data_class.dart';

// HIVE
import 'package:hive/hive.dart';

//------------------------------------------------------------------------------

// CLASS FOR SAVING AND LOADING THE MATCH STATUS ON TMP FILES
class GameStorage {

  // INITIALIZING THE BOX NAME AND KEY
  static const String boxName = "matchDataBox";
  static const String key = "match";

  // SAVE THE MATCH DATA OBJECT
  static Future<void> save_match_data(MatchData data) async {

    // DEFINING THE HIVE BOX VAR
    Box matchBox;

    // CHECKING IF THE BOX WAS PREVIOUSLY OPENED
    if (Hive.isBoxOpen('matchdatabox')) {

      // LOADING THE PREVIOUSLY OPENED INSTANCE
      matchBox = Hive.box('matchdatabox');

    } else {

      // OPENING A NEW INSTANCE
      matchBox = await Hive.openBox('matchdatabox');

    }

    // SAVING THE MATCH DATA
    await matchBox.put(key, data);

  }

  // LOAD A SAVED MATCH DATA OBJECT
  static Future<MatchData> load_match_data() async {

    // DEFINING THE HIVE BOX VAR
    Box matchBox;

    // CHECKING IF THE BOX WAS PREVIOUSLY OPENED
    if (Hive.isBoxOpen('matchdatabox')) {

      // LOADING THE PREVIOUSLY OPENED INSTANCE
      matchBox = Hive.box('matchdatabox');

    } else {

      // OPENING A NEW INSTANCE
      matchBox = await Hive.openBox('matchdatabox');

    }

    // RETURNING THE MATCH DATA
    return matchBox.get(key) ?? MatchData();
  }

  // DELETE A SAVED MATCH DATA OBJECT
  static Future<void> delete_match_data() async {

    // DEFINING THE HIVE BOX VAR
    Box matchBox;

    // CHECKING IF THE BOX WAS PREVIOUSLY OPENED
    if (Hive.isBoxOpen('matchdatabox')) {

      // LOADING THE PREVIOUSLY OPENED INSTANCE
      matchBox = Hive.box('matchdatabox');

    } else {

      // OPENING A NEW INSTANCE
      matchBox = await Hive.openBox('matchdatabox');

    }

    // DELETING THE MATCH DATA
    await matchBox.delete(key);
  }

}

//------------------------------------------------------------------------------