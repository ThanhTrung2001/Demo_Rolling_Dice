import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rolling_dice/models/dice_show.dart';

//dice1
class Dice_Showing_Notifier extends StateNotifier<DiceShowing> {
  Dice_Showing_Notifier(): super(DiceShowing('assets/images/dice-png-1.png'));
  
  void showDiceImage(int number)
  {
    state = DiceShowing('assets/images/dice-png-${number}.png');
  }
}

final Dice_Showing_Provider = StateNotifierProvider<Dice_Showing_Notifier, DiceShowing>((ref) {
  return Dice_Showing_Notifier();
});

//dice2
class Dice_Showing_Notifier2 extends StateNotifier<DiceShowing2> {
  Dice_Showing_Notifier2(): super(DiceShowing2('assets/images/dice-png-1.png'));
  
  void showDiceImage(int number)
  {
    state = DiceShowing2('assets/images/dice-png-${number}.png');
  }
}

final Dice_Showing_Provider2 = StateNotifierProvider<Dice_Showing_Notifier2, DiceShowing2>((ref) {
  return Dice_Showing_Notifier2();
});
