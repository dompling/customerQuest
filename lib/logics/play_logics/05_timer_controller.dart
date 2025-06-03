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
import 'dart:async';

//------------------------------------------------------------------------------

// DEFINING THE TIMER CONTROLLER CLASS
class TimerController {

  // TIMER ATTRIBUTES
  Timer? _timer;
  int totalSeconds;
  int remainingSeconds;
  bool isRunning = false;


  // TIMER METHODS
  Function()? onTick;
  Function()? onComplete;

  // CLASS CONSTRUCTOR
  TimerController({required this.totalSeconds}) : remainingSeconds = totalSeconds;

  //------------------------------------------------------------------------------

  // FUNCTION THAT WILL START THE TIMER
  void start() {

    // CHECKING IF THE TIMER CAN BE STARTED
    if (isRunning || remainingSeconds <= 0) return;

    // SETTING THE TIMER AS RUNNING
    isRunning = true;

    // DELETING PREVIOUS TIMERS
    _timer?.cancel();

    // STARTING THE COUNTDOWN
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        onTick?.call();
      } else {
        pause();
        onComplete?.call();
      }
    });
  }

  //------------------------------------------------------------------------------

  // FUNCTION THAT WILL STOP THE TIMER
  void pause() {
    if (!isRunning) return;
    _timer?.cancel();
    isRunning = false;
  }

  //------------------------------------------------------------------------------

  // FUNCTION THAT WILL RESET THE TIMER
  void reset() {
    pause();
    remainingSeconds = totalSeconds;
    onTick?.call();
  }

  //------------------------------------------------------------------------------

  // FUNCTION THAT WILL DELETE THE TIMER
  void dispose() {
    _timer?.cancel();
  }

  //------------------------------------------------------------------------------

  // FUNCTION THAT WILL GIVE THE CORRECT FORMAT FOR THE TIMER VALUES
  String formattedTime() {
    final minutes = remainingSeconds ~/ 60;
    final secs = remainingSeconds % 60;
    return "$minutes:${secs.toString().padLeft(2, '0')}";
  }

  //------------------------------------------------------------------------------

}
