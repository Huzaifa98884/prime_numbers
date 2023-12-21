import 'package:flutter/material.dart';
import 'numberWidget.dart';

class NumbersGridWidget extends StatefulWidget {
  final List<int> numbersList;

  NumbersGridWidget({required this.numbersList});

  @override
  _NumbersGridWidgetState createState() => _NumbersGridWidgetState();
}

class _NumbersGridWidgetState extends State<NumbersGridWidget>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.numbersList.length,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
      ),
    );

    for (int i = _controllers.length - 1; i >= 0; i--) {
      int rowIndex = i ~/ 5;
      Future.delayed(
        Duration(
          milliseconds: 500 * (widget.numbersList.length ~/ 5 - rowIndex) + 300,
        ),
        () {
          _controllers[i].forward();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.027,
      ),
      child: Column(
        children: List.generate(
          widget.numbersList.length ~/ 5,
          (rowIndex) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                5,
                (colIndex) {
                  int index = rowIndex * 5 + colIndex;
                  return AnimatedBuilder(
                    animation: _controllers[index],
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(
                          0.0,
                          -MediaQuery.of(context).size.height +
                              _controllers[index].value *
                                  MediaQuery.of(context).size.height,
                        ),
                        child: NumberWidget(number: widget.numbersList[index]),
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
