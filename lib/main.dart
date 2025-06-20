import 'package:flutter/material.dart';
import 'uiview/splash_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: Colors.white,
    ),
    home: SplashScreen(),
  ));
}
