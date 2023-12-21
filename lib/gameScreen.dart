import 'package:flutter/material.dart';
import 'package:prime_numbers/constants/animatedImagesWidget.dart';
import 'package:prime_numbers/constants/animatedText.dart';
import 'package:prime_numbers/customWidgets/customAppBar.dart';

import 'constants/numbersGridWidget.dart';

class GameScreen extends StatefulWidget {
  List<int> numbersList = [
    1,
    3,
    100,
    7,
    12,
    13,
    24,
    97,
    110,
    83,
    24,
    19,
    150,
    17,
    2,
    41,
    30,
    43,
    35,
    47,
    68,
    53,
    26,
    59,
    89,
    67,
    20,
    89,
    54,
    79
  ];
  GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Image.asset('assets/images/bg_image.jpeg', fit: BoxFit.fill),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                AnimatedText(),
                AnimatedImagesWidget(),
                NumbersGridWidget(numbersList: widget.numbersList)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
