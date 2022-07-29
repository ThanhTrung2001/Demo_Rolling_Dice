import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rolling_dice/models/action.dart';
import 'package:rolling_dice/models/animal.dart';
import 'package:rolling_dice/viewmodels/actionlist_provider.dart';
import 'package:rolling_dice/viewmodels/animallist_provider.dart';
import 'package:rolling_dice/widget/dialog_add.dart';
import 'package:rolling_dice/widget/item_dice.dart';

class InputPage extends ConsumerStatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InputPageState();
}

class _InputPageState extends ConsumerState<InputPage> {
  final actioncontroller = TextEditingController();
  final animalcontroller = TextEditingController();
  String animalnew = '';
  String actionnew = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final notifier = ref.read(AnimalListProvider.notifier);

    // final notifieraction = ref.read(ActionListProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          shadowColor: Colors.transparent,
          backgroundColor: const Color.fromARGB(255, 71, 73, 161),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 5,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 104, 74, 31),
                  ),
                  onPressed: () {
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return Dialog_Adding(
                            controller: animalcontroller,
                            dialog_title: 'Insert your new Animal: ',
                            dialog_input: animalnew,
                            press: () {
                              ref
                                  .read(AnimalListProvider.notifier)
                                  .add(animalcontroller.text);
                              Navigator.of(context).pop();
                            },
                          );
                        });
                  },
                  child: const Text('Add Animal',
                      style: TextStyle(color: Colors.white))),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 170,
                width: size.width,
                child: ListviewAnimal(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return Dialog_Adding(
                            controller: actioncontroller,
                            dialog_title: 'Insert your new Action: ',
                            dialog_input: actionnew,
                            press: () {
                              ref
                                  .read(ActionListProvider.notifier)
                                  .add(actioncontroller.text);
                              Navigator.of(context).pop();
                            },
                          );
                        });
                  },
                  child: const Text(
                    'Add Action',
                    style: TextStyle(color: Colors.white),
                  )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 170,
                width: size.width,
                child: ListviewAction(),
              ),
            ],
          ),
        ));
  }
}

class ListviewAction extends ConsumerWidget {
  const ListviewAction({
    Key? key,
  }) : super(key: key);
      
  @override
  Widget build(BuildContext context, ref) {
    final actionLists = ref.watch(ActionListProvider);
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: actionLists.length,
      itemBuilder: (context, index) {
        return SizedBox(
            width: 170,
            child: DiceItem(
                itemname: actionLists[index].action,
                delete: () {
                  print(actionLists[index].action);
                  ref
                      .read(ActionListProvider.notifier)
                      .delete(actionLists[index]);
                },
                saveInput: (value) {
                  ref
                      .read(ActionListProvider.notifier)
                      .edit(actionLists[index].id, value);
                }));
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          width: 10,
        );
      },
    );
  }
}

//animal
class ListviewAnimal extends ConsumerWidget {
  const ListviewAnimal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final animalLists = ref.watch(AnimalListProvider);
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: animalLists.length,
      itemBuilder: (context, index) {
        return SizedBox(
            width: 170,
            child: DiceItem(
                itemname: animalLists[index].animalName,
                delete: () async {
                  ref
                      .read(AnimalListProvider.notifier)
                      .delete(animalLists[index]);
                },
                saveInput: (value) {
                  if (value != '') {
                    ref
                        .read(AnimalListProvider.notifier)
                        .edit(animalLists[index].id, value);
                  }
                  // notifier.edit(animalLists[index].id,
                  //     animalcontroller1.text);
                }));
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          width: 10,
        );
      },
    );
  }
}
