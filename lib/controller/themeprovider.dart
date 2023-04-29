import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData theme = ThemeData.light();

  ThemeData get theme1 => theme;

  void toggleTheme() {
    final isDark = theme == ThemeData.dark();
    if (isDark) {
      theme = ThemeData.light();
    } else {
      theme = ThemeData.dark();
    }
    notifyListeners();
  }
}
