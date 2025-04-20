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
