import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rolling_dice/models/action.dart';
import 'package:rolling_dice/models/animal.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ActionList2 extends StateNotifier<List<ActionForAnimal>> {
  ActionList2() : super([]);

  void add(String newAction) {
    state = [...state, ActionForAnimal(uuid.v4(), newAction)];
  }

  void edit(String id, String name) {
    // state = [
    //   for (final action in state)
    //     if (action.id == id) ActionForAnimal(action.id, name) else action
    // ];
    var list = state.map((e) => ActionForAnimal(e.id, e.action)).toList();
    for (var action in list) {
      if (action.id == id) {
        action.action = name;
      }
    }
    state = list;
  }

  void delete(ActionForAnimal action) {
    print(action.action);
    var list = [...state];
    list.removeWhere((e)  => e.id == action.id);
    print(list.length);
    state = [...list];
    print(state.length);
  }
}

final actionListProvider2 =
    StateNotifierProvider<ActionList2, List<ActionForAnimal>>((ref) {
  return ActionList2();
});

