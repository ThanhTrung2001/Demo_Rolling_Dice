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
    //1 state = state.where((element) => element.animalName != animal.animalName).toList();
    //2 final list = state
    //     .where((element) => element.animalName != animal.animalName)
    //     .toList();
    // list.length = state
    //     .where((element) => element.animalName != animal.animalName)
    //     .toList()
    //     .length;
    // state = [
    //   for (int i = 0; i < list.length; i++)
    //     Animal(list[i].id, list[i].animalName)
    // ];
    // print(state.length);
    // for (int i = 0; i < state.length; i++) {
    //   print(state[i].animalName);
    // }
    var list = state.map((e) => Animal(e.id, e.animalName)).toList();
    list.removeWhere((element) => element.id == animal.id);
    state = list;
    // print(state.length);
    // state.forEach((element) {
    //   print(element.animalName);
    // });
  }
}

final AnimalListProvider =
    StateNotifierProvider<AnimalList, List<Animal>>((ref) {
  return AnimalList();
});
