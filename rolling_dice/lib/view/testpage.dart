import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rolling_dice/viewmodels/testriverpod.dart';
import 'package:rolling_dice/widget/dialog_add.dart';
import 'package:rolling_dice/widget/item_dice.dart';

class TestPage extends ConsumerStatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestPageState();
}

class _TestPageState extends ConsumerState<TestPage> {
  final actioncontroller = TextEditingController();
    String actionnew = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                height: 10,
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
                                  .read(actionListProvider2.notifier)
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
                child: const ListviewAction(),
              ),
            ],
          ),
        )
    );
  }
}

class ListviewAction extends ConsumerWidget {
  const ListviewAction({
    Key? key,
  }) : super(key: key);
      
  @override
  Widget build(BuildContext context, ref) {
    final actionLists = ref.watch(actionListProvider2);
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
                      .read(actionListProvider2.notifier)
                      .delete(actionLists[index]);
                },
                saveInput: (value) {
                  ref
                      .read(actionListProvider2.notifier)
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