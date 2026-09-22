import 'package:flutter/material.dart';
import 'package:headlineclassifier/screens/Homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Headline Classifier',
      home: const HomeScreen(),
    );
  }
}