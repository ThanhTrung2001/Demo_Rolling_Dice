import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// class Dialog_Add extends StatefulWidget {
//   String dialog_input;
//   final String dialog_title;
//   VoidCallback press;
//   Dialog_Add(
//       {Key? key,
//       required this.dialog_title,
//       required this.dialog_input,
//       required this.press})
//       : super(key: key);

//   @override
//   State<Dialog_Add> createState() => _Dialog_AddState();
// }

// class _Dialog_AddState extends State<Dialog_Add> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
//       elevation: 0,
//       backgroundColor: const Color.fromARGB(104, 94, 94, 94),
//       child: Container(
//         height: size.height * 0.42,
//         width: size.width * 0.85,
//         decoration: BoxDecoration(
//           border:
//               Border.all(width: 5.0, color: const Color.fromARGB(255, 102, 0, 228)),
//           color: const Color.fromARGB(255, 36, 36, 36),
//           borderRadius: const BorderRadius.all(Radius.circular(30.0)),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               widget.dialog_title, style: const TextStyle(color: Colors.white)
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: SizedBox(
//                 height: 50,
//                 width: 200,
//                 child: TextField(
//                   style: const TextStyle(color: Colors.white),
//                   onChanged: (value) {
//                     widget.dialog_input = value;
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(height: 5,),
//             TextButton(
//               onPressed: widget.press, 
//               child: const Text('ADD', style: TextStyle(color: Colors.white)))
//           ],
//         ),
//       ),
//     );
//   }
// }


class Dialog_Adding extends ConsumerStatefulWidget {
  String dialog_input;
  final String dialog_title;
  VoidCallback press;
  TextEditingController controller;
  Dialog_Adding({Key? key, required this.dialog_title,
      required this.dialog_input,
      required this.press,
      required this.controller}): super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Dialog_AddingState();
}

class _Dialog_AddingState extends ConsumerState<Dialog_Adding> {
  
  @override
  Widget build(BuildContext context) {
   Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      elevation: 0,
      backgroundColor: const Color.fromARGB(104, 94, 94, 94),
      child: Container(
        height: size.height * 0.42,
        width: size.width * 0.85,
        decoration: BoxDecoration(
          border:
              Border.all(width: 5.0, color: const Color.fromARGB(255, 102, 0, 228)),
          color: const Color.fromARGB(255, 36, 36, 36),
          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.dialog_title, style: const TextStyle(color: Colors.white)
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 50,
                width: 200,
                child: TextField(
                  controller: widget.controller,
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    widget.dialog_input = value;
                  },
                ),
              ),
            ),
            const SizedBox(height: 5,),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 69, 130, 138)
              ),
              onPressed: widget.press, 
              child: const Text('ADD', style: TextStyle(color: Colors.white)))
          ],
        ),
      ),
    );
  }
}