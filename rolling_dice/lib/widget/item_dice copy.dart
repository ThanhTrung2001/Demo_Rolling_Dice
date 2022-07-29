import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiceItemTest extends ConsumerStatefulWidget {
  final String itemname;
  final VoidCallback delete;
  final ValueChanged saveInput;

  const DiceItemTest(
      {Key? key,
      required this.itemname,
      required this.delete,
      required this.saveInput})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DiceItemState();
}

class _DiceItemState extends ConsumerState<DiceItemTest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0),
        color: Colors.blue,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            initialValue: widget.itemname,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            // onChanged: widget.saveInput,
            onFieldSubmitted: widget.saveInput,
            validator: (value) {
              if (value == null) {
                return "Can't edit the title into <space>";
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: widget.delete, icon: const Icon(Icons.delete)),
            ],
          )
        ],
      ),
    );
  }
}
