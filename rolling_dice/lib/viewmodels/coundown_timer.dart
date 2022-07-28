import 'dart:async';
import 'package:riverpod/riverpod.dart';
import 'package:rolling_dice/models/countdownTimer.dart';

class CountDown_Notifier extends StateNotifier<CountDown> {
  CountDown_Notifier(): super(CountDown(false, 1));
  void startCountDown()
  {
    Timer timer;
    if(state.haveJustRoll == false)
    {
      state.haveJustRoll == true;
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if(state.countDownTimer > 0)
        {
          state = CountDown(true, state.countDownTimer - 1);
        }
        else
        {
          timer.cancel();
          state = CountDown(false, 1);
        }
       });
    }
  }
}

final CountDown_Provider = StateNotifierProvider<CountDown_Notifier, CountDown>((ref) {
  return CountDown_Notifier();
});