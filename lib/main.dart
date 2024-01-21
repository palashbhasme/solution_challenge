import 'package:flutter/material.dart';
import 'package:solution_challenge/screens/DataForm.dart';
import 'package:solution_challenge/screens/person_list.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PersonList(),
    );
  }
}


