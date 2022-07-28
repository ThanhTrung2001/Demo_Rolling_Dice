import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rolling_dice/models/action.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ActionList extends StateNotifier<List<ActionForAnimal>> {
  ActionList() : super(actionlist);

  void add(String newAction) {
    state = [...state, ActionForAnimal(uuid.v4(), newAction)];
  }

  void edit(String id, String name) {
    state = [
      for (final action in state)
        if (action.id == id) ActionForAnimal(action.id, name) else action
    ];
  }

  void delete(ActionForAnimal action) {
     state = state.where((element) => element.id != action.id).toList();
  }
}

final ActionListProvider =
    StateNotifierProvider<ActionList, List<ActionForAnimal>>((ref) {
  return ActionList();
});
