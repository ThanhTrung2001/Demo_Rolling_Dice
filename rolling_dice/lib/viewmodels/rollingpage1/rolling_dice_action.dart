import 'package:riverpod/riverpod.dart';
import 'package:rolling_dice/models/action.dart';
import 'package:rolling_dice/models/animal.dart';

class Rolling_Action_Notifier extends StateNotifier<ActionForAnimal>{
  Rolling_Action_Notifier(): super(ActionForAnimal('0','unRoll'));

  void rolling_dice_action(int i){
    state = actionlist[i-1];
  }
}

final Rolling_Action_Provider = StateNotifierProvider<Rolling_Action_Notifier, ActionForAnimal>((ref) {
  return Rolling_Action_Notifier();
});