//@dart=2.9
import 'package:flutter/material.dart';
import '../store/storage_manger.dart';

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
    primaryColor: const Color(0xFFDAA45C),
    backgroundColor: Colors.black,
    buttonColor: Colors.white,
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Color(0xFFDAA45C),
      ),
      bodyText2: TextStyle(
        color: Colors.white,
      ),
      caption: TextStyle(
        color: Colors.white,
      ),
    ),
  );

  final lightTheme = ThemeData(
    primaryColor: const Color(0xFFDAA45C),
    backgroundColor: Colors.white,
    buttonColor: Color(0xff5A6C64),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Color(0xFFDAA45C),
      ),
      bodyText2: TextStyle(
        color: Colors.black,
      ),
      caption: TextStyle(
        color: Color(0xff5A6C64),
      ),
    ),
  );

  ThemeData _themeData = ThemeData();
  ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      var themeMode = value ?? 'light';

      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
