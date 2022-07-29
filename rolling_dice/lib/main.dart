import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rolling_dice/view/rolling_page_2.dart';
import 'package:rolling_dice/view/testpage.dart';

void main() {
  runApp(const ProviderScope(child: CallMaterial()));
}

class CallMaterial extends StatelessWidget {
  const CallMaterial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      theme: ThemeData(
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      home: const TestPage(),
    );
  }
}
