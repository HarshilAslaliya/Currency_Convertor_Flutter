import 'package:flutter/material.dart';

import 'numbuttons.dart';

class NumPad extends StatelessWidget {
  final Function(String) onKeyPressed;

  NumPad({required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumButton('1', onKeyPressed),
              NumButton('2', onKeyPressed),
              NumButton('3', onKeyPressed),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumButton('4', onKeyPressed),
              NumButton('5', onKeyPressed),
              NumButton('6', onKeyPressed),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumButton('7', onKeyPressed),
              NumButton('8', onKeyPressed),
              NumButton('9', onKeyPressed),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumButton('DEL', onKeyPressed),
              NumButton('0', onKeyPressed),
              Transform.rotate(angle: -0.3,child: NumButton('✔', onKeyPressed)),
            ],
          ),
          SizedBox(height: 15,),
        ],
      ),
    );
  }
}
