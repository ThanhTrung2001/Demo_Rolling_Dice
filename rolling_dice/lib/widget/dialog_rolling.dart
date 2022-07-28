import 'package:flutter/material.dart';

class Dialog_Rolling_Dice extends StatefulWidget {
  final String dialog_image_link;
  final String dialog_content;
  const Dialog_Rolling_Dice({
    Key? key, 
    required this.dialog_image_link,
    required this.dialog_content }) : super(key: key);

  @override
  State<Dialog_Rolling_Dice> createState() => _Dialog_Rolling_DiceState();
}

class _Dialog_Rolling_DiceState extends State<Dialog_Rolling_Dice> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0)),
        elevation: 0,
        backgroundColor: Color.fromARGB(104, 94, 94, 94),
        child: Container(
          height: size.height*0.42,
          width: size.width*0.85,
          decoration: BoxDecoration(
            border: Border.all(width: 5.0, color: Color.fromARGB(255, 102, 0, 228)),
            color: Color.fromARGB(255, 36, 36, 36),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage(widget.dialog_image_link), height: 225, width: 300,),
              Padding(
                padding: EdgeInsets.all(10.0), 
                child: Text(widget.dialog_content, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),),)
            ],
          ),
        ),
    );
  }
}