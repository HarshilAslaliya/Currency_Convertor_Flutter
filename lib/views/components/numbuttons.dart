import 'package:currency_convertor/model/globals.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NumButton extends StatelessWidget {
  final String text;
  final Function(String) onPressed;

  NumButton(this.text, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 65,
      height: 65,
      child: ElevatedButton(
        onPressed: () => onPressed(text),
        child: Text(text,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: Globals.themeMode ? Colors.white : Globals.darkColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            )),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(15),
          backgroundColor:
              Globals.themeMode ? Colors.grey.shade800 : Colors.grey[300],
          textStyle: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
