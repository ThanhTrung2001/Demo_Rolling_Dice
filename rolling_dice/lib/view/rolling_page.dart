import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rolling_dice/models/animal.dart';
import 'package:rolling_dice/models/countdownTimer.dart';
import 'package:rolling_dice/models/dice_count.dart';
import 'package:rolling_dice/models/dice_show.dart';
import 'package:rolling_dice/viewmodels/coundown_timer.dart';
import 'package:rolling_dice/viewmodels/rolling_dice.dart';
import 'package:rolling_dice/viewmodels/rollingpage1/rolling_dice_action.dart';
import 'package:rolling_dice/viewmodels/rollingpage1/rolling_dice_animal.dart';
import 'package:rolling_dice/models/action.dart';
import 'package:rolling_dice/viewmodels/rollingpage1/rolling_dice_showing.dart';
import 'package:rolling_dice/widget/dialog_rolling.dart';

class Rolling_Page extends ConsumerStatefulWidget {
  const Rolling_Page({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Rolling_PageState();
}


class _Rolling_PageState extends ConsumerState<Rolling_Page> {

  @override
  Widget build(BuildContext context) {
    int dice1 = 1;
    int dice2 = 1;
    //watch animal state
    final Animal animal = ref.watch(Rolling_Animal_Provider);
    final Rolling_Animal_Notifier animal_notifier = ref.watch(Rolling_Animal_Provider.notifier);
    //watch action state
    final ActionForAnimal action = ref.watch(Rolling_Action_Provider);
    final Rolling_Action_Notifier action_notifier = ref.watch(Rolling_Action_Provider.notifier);
    //watch Dice number
    final Dice dice = ref.watch(Dice_Provider);
    final Dice_Notifier dice_notifier = ref.watch(Dice_Provider.notifier);
    //watch and update image showing Dice1 number
    final DiceShowing diceShowing = ref.watch(Dice_Showing_Provider);
    final Dice_Showing_Notifier showing_notifier = ref.watch(Dice_Showing_Provider.notifier);
    //watch and update image showing Dice2 number
    final DiceShowing2 diceShowing2 = ref.watch(Dice_Showing_Provider2);
    final Dice_Showing_Notifier2 showing_notifier2 = ref.watch(Dice_Showing_Provider2.notifier);
    //watch and update timer
    final CountDown countDown = ref.watch(CountDown_Provider);
    final CountDown_Notifier countDown_Notifier = ref.watch(CountDown_Provider.notifier);
    return Scaffold(

      appBar: AppBar(title: const Text('Rolling Dice Demo'), centerTitle: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      width: 150,
                      height: 150,
                      child: GestureDetector(
                          onTap: () async {
                              if(countDown.haveJustRoll == false)
                              {
                                await showDialog(
                                barrierDismissible: false,
                                context: context, 
                                builder: (context){
                                  Future.delayed(Duration(milliseconds: 650), (){
                                    Navigator.of(context).pop();
                                  });
                                  return Dialog_Rolling_Dice(dialog_image_link: 'assets/images/dice_splash.gif', dialog_content: 'Rolling Action Dice...');
                                    });
                                  dice1 = dice_notifier.getRandomDice();
                                  showing_notifier.showDiceImage(dice1);
                                  print('dice1 : ${dice1}');
                                  animal_notifier.rolling_dice_animal(dice1);
                                  countDown_Notifier.startCountDown();
                              }
                              else
                              {
                                null;
                              }
                                
                          },
                          child: Image(image: AssetImage('${diceShowing.imageLink}'), fit: BoxFit.fill,),
                        )
                        ),
                    SizedBox(height: 20,),
                    Text('${animal.animalName}'),
                    SizedBox(height: 20,),        
                  ],
                ),
                 Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      width: 150,
                      height: 150,                 
                        child: GestureDetector(
                          onTap: () async {
                              if(countDown.haveJustRoll == false)
                              {
                                await showDialog(
                                barrierDismissible: false,
                                context: context, 
                                builder: (context){
                                  Future.delayed(Duration(milliseconds: 650), (){
                                    Navigator.of(context).pop();
                                  });
                                  return const Dialog_Rolling_Dice(dialog_image_link: 'assets/images/dice_splash.gif', dialog_content: 'Rolling Animal Dice...');
                                });
                              dice2 = dice_notifier.getRandomDice();
                              showing_notifier2.showDiceImage(dice2);
                              print('dice2 : ${dice2}');
                              action_notifier.rolling_dice_action(dice2);
                              countDown_Notifier.startCountDown();
                              }
                              else
                              {
                                null;
                              }
                          },
                          child: Image(image: AssetImage('${diceShowing2.imageLink}'), fit: BoxFit.fill,),
                        )
                        ),
                    SizedBox(height: 20,),
                    Text('${action.action}'),
                    SizedBox(height: 20,),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30,),
            Text(countDown.haveJustRoll == true ? 'Waiting for ${countDown.countDownTimer} seconds for next roll!': 'Ready for Roll!', style:  TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),),
            SizedBox(height: 50,),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(10.0),
                primary: Colors.white,
                backgroundColor: countDown.haveJustRoll == true ?  Color.fromARGB(255, 8, 42, 70) : Colors.blue,
                side: BorderSide(color: countDown.haveJustRoll == true ?  Colors.red : Colors.green,),
              ),
              onPressed: () async{
                            countDown_Notifier.startCountDown();
                            if(countDown.haveJustRoll == false)
                            {
                              showDialog(
                              barrierDismissible: false,
                              context: context, 
                              builder: (context){
                                Future.delayed(Duration(milliseconds: 1000), (){
                                  Navigator.of(context).pop();
                                });
                                return Dialog_Rolling_Dice(dialog_image_link: 'assets/images/dice_splash.gif', dialog_content: 'Rolling 2 Dice...');
                              });
                              dice1 = dice_notifier.getRandomDice();
                              dice2 = dice_notifier.getRandomDice();
                              showing_notifier.showDiceImage(dice1);
                              showing_notifier2.showDiceImage(dice2);
                              animal_notifier.rolling_dice_animal(dice1);
                              action_notifier.rolling_dice_action(dice2);
                              print('${dice1} and ${dice2}');
                              if(dice1 == dice2)
                              {
                                print('You have just make a pairs of matching dices! Congat!');
                              }
                              
                            }
                            else
                            {
                              null;
                            }
                        },
              child: Text(
                'ROLL', style: TextStyle(
                  fontSize: 30, 
                  fontWeight: FontWeight.bold,
                  // color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async{
      //     if(countDown.haveJustRoll == false)
      //     {
      //       await showDialog(
      //       barrierDismissible: false,
      //       context: context, 
      //       builder: (context){
      //         Future.delayed(Duration(milliseconds: 1000), (){
      //           Navigator.of(context).pop();
      //         });
      //         return Dialog_Rolling_Dice(dialog_image_link: 'assets/images/dice_splash.gif', dialog_content: 'Rolling 2 Dice...');
      //       });
      //       dice1 = dice_notifier.getRandomDice();
      //       dice2 = dice_notifier.getRandomDice();
      //       showing_notifier.showDiceImage(dice1);
      //       showing_notifier2.showDiceImage(dice2);
      //       animal_notifier.rolling_dice_animal(dice1);
      //       action_notifier.rolling_dice_action(dice2);
      //       print('${dice1} and ${dice2}');
      //       if(dice1 == dice2)
      //       {
      //         print('You have just make a pairs of matching dices! Congat!');
      //       }
      //       countDown_Notifier.startCountDown();
      //     }
      //     else
      //     {
      //       null;
      //     }
      //   },
      //   child: const Icon(Icons.check_circle_outline,),
      // ),
    );
  }
}