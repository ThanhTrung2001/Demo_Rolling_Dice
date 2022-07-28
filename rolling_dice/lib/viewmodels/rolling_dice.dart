import 'dart:math';

import 'package:riverpod/riverpod.dart';
import 'package:rolling_dice/models/dice_count.dart';

class Dice_Notifier extends StateNotifier<Dice> {
  Dice_Notifier() : super(Dice(1));

  int random(min, max) {
    return min + Random().nextInt(max);
  }

  int getRandomDice() {
    state = Dice(random(1, 6));
    return state.dice_number;
  }
}

final Dice_Provider = StateNotifierProvider<Dice_Notifier, Dice>((ref) {
  return Dice_Notifier();
});

