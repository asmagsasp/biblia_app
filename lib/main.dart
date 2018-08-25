import 'package:flutter/material.dart';
import 'splash_screen.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Bíblia Católica',
      theme: new ThemeData.dark(),
      home: new SplashScreen()
    );
  }
}

