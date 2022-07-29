import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rolling_dice/models/animal.dart';
import 'package:rolling_dice/models/countdownTimer.dart';
import 'package:rolling_dice/models/dice_count.dart';
import 'package:rolling_dice/view/input_page.dart';
import 'package:rolling_dice/viewmodels/actionlist_provider.dart';
import 'package:rolling_dice/viewmodels/animallist_provider.dart';
import 'package:rolling_dice/viewmodels/coundown_timer.dart';
import 'package:rolling_dice/viewmodels/rolling_dice.dart';
import 'package:rolling_dice/models/action.dart';

class RollingPage2 extends ConsumerStatefulWidget {
  const RollingPage2({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RollingPage2State();
}

class _RollingPage2State extends ConsumerState<RollingPage2> {
  
  final notifier = AnimalList();
  final notifierAction = ActionList();
  final controller1 = CarouselSliderController();
  final controller2 = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    int dice1 = 1;
    int dice2 = 1;
    bool isPlaying = true;
    bool isPlaying2 = true;
    final Dice dice = ref.watch(Dice_Provider);
    final Dice_Notifier dice_notifier = ref.watch(Dice_Provider.notifier);
    //watch and update timer
    final CountDown_Notifier countDown_Notifier = ref.watch(CountDown_Provider.notifier);
  //Animal
    final List<Animal> animalLists = ref.watch(AnimalListProvider);
  //Action

    return Scaffold(
      appBar: AppBar(
        title: (const Text(
          'ROLLING DICE',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 160, 209, 24)),
        )),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          shadowColor: Colors.transparent,
          backgroundColor: const Color.fromARGB(255, 71, 73, 161),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              ref.watch(CountDown_Provider).haveJustRoll == true
                  ? 'Waiting for ${ref.watch(CountDown_Provider).countDownTimer} seconds for next roll!'
                  : 'Ready for Roll!',
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
             const SizedBox(
              height: 10,
            ),
            TextButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const InputPage()));
                },
                icon: const Icon(Icons.edit),
                label: const Text("Edit Dice's Face")),
            const SizedBox(
              height: 20,
            ),
            CaroulAnimal(controller1: controller1, animalLists: ref.watch(AnimalListProvider)),
            const SizedBox(height: 30),
            CaroulAction(controller2: controller2, actionLists: ref.watch(ActionListProvider)),
            const SizedBox(height: 30),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(10.0),
                primary: Colors.white,
                backgroundColor: ref.watch(CountDown_Provider).haveJustRoll == true
                    ? const Color.fromARGB(255, 8, 42, 70)
                    : Colors.blue,
                side: BorderSide(
                    color: ref.watch(CountDown_Provider).haveJustRoll == true
                        ? Colors.red
                        : Colors.green,
                    width: 3),
              ),
              onPressed: () {
                if (ref.watch(CountDown_Provider).haveJustRoll == false) {
                  dice1 = dice_notifier.getRandomDice();
                  dice2 = dice_notifier.getRandomDice();
                  print('$dice1 and $dice2');
                  Future.delayed(Duration(milliseconds: (dice1 + 1) * 650), () {
                    isPlaying = false;
                  });
                  Stream.periodic(const Duration(milliseconds: 650))
                      .takeWhile((_) => isPlaying)
                      .forEach((element) {
                    controller1.nextPage();
                  });
                  Future.delayed(Duration(milliseconds: (dice2 + 1) * 650), () {
                    isPlaying2 = false;
                  });
                  Stream.periodic(const Duration(milliseconds: 650))
                      .takeWhile((_) => isPlaying2)
                      .forEach((element) {
                    controller2.previousPage();
                  });
                  if (dice1 > dice2) {
                    Future.delayed(Duration(milliseconds: (dice1 - 1) * 650),
                        () {
                      countDown_Notifier.startCountDown();
                    });
                  } else {
                    Future.delayed(Duration(milliseconds: (dice2 - 1) * 650),
                        () {
                      countDown_Notifier.startCountDown();
                    });
                  }
                } else {
                  null;
                }
              },
              child: const Text(
                'ROLL',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  // color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CaroulAnimal extends ConsumerWidget {
  const CaroulAnimal({
    Key? key,
    required this.controller1,
    required this.animalLists,
  }) : super(key: key);

  final CarouselSliderController controller1;
  final List<Animal> animalLists;

  @override
  Widget build(BuildContext context,ref) {
    return Container(
      height: 200,
      width: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: CarouselSlider.builder(
        controller: controller1,
        // enableAutoSlider: true,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        autoSliderTransitionTime: const Duration(milliseconds: 1000),
        slideTransform: const CubeTransform(),
        scrollDirection: Axis.horizontal,
        autoSliderDelay: const Duration(milliseconds: 700),
        unlimitedMode: true,
        itemCount: animalLists.length,
        clipBehavior: Clip.hardEdge,
        onSlideChanged: (count) {},

        slideBuilder: (index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: 3.0, color: Color.fromARGB(255, 51, 51, 51)),
              color: (index % 2 == 0)
                  ? Colors.blue
                  : const Color.fromARGB(255, 60, 101, 134),
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset:
                      const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Container(
                alignment: Alignment.center,
                height: 190,
                width: 190,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                  color: (index % 2 == 0)
                      ? Colors.blue
                      : const Color.fromARGB(255, 41, 89, 128),
                  borderRadius: BorderRadius.circular(45.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset:
                          const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Text(
                  animalLists[index].animalName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                )),
          );
        },
      ),
    );
  }
}

class CaroulAction extends ConsumerWidget {
  const CaroulAction({
    Key? key,
    required this.controller2,
    required this.actionLists,
  }) : super(key: key);

  final CarouselSliderController controller2;
  final List<ActionForAnimal> actionLists;

  @override
  Widget build(BuildContext context,ref) {
    return Container(
      height: 200,
      width: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: CarouselSlider.builder(
        key: null,
        // enableAutoSlider: false,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        autoSliderTransitionTime: const Duration(milliseconds: 1000),
        slideTransform: const CubeTransform(),
        scrollDirection: Axis.horizontal,
        unlimitedMode: true,
        autoSliderDelay: const Duration(milliseconds: 700),
        controller: controller2,
        itemCount: actionLists.length,
        slideBuilder: (index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: 3.0,
                  color: const Color.fromARGB(255, 51, 51, 51)),
              color: (index % 2 == 0)
                  ? Colors.blue
                  : const Color.fromARGB(255, 41, 89, 128),
            ),
            alignment: Alignment.center,
            child: Container(
                alignment: Alignment.center,
                height: 190,
                width: 190,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                  color: (index % 2 == 0)
                      ? Colors.blue
                      : const Color.fromARGB(255, 41, 89, 128),
                  borderRadius: BorderRadius.circular(45.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(
                          0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Text(
                  actionLists[index].action,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                )),
          );
        },
      ),
    );
  }
}
