import 'package:riverpod/riverpod.dart';
import 'package:rolling_dice/models/animal.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Rolling_Animal_Notifier extends StateNotifier<Animal>{
  Rolling_Animal_Notifier(): super(Animal(uuid.v4(),'unRoll'));

  void rolling_dice_animal(int i){
    state = animallist[i-1];
  }
}

final Rolling_Animal_Provider = StateNotifierProvider<Rolling_Animal_Notifier, Animal>((ref) {
  return Rolling_Animal_Notifier();
});