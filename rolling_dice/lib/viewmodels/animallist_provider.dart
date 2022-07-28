import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rolling_dice/models/animal.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class AnimalList extends StateNotifier<List<Animal>> {
  AnimalList() : super(animallist);

  void add(String newAnimal) {
    state = [...state, Animal(uuid.v4(), newAnimal)];
  }

  void edit(String id, String name) {
    state = [
      for (final animal in state)
        if (animal.id == id) Animal(animal.id, name) else animal
    ];
  }

  void delete(Animal animal) {

    state = state.where((element) => element.id != animal.id).toList();
  }
}

final AnimalListProvider =
    StateNotifierProvider<AnimalList, List<Animal>>((ref) {
  return AnimalList();
});
