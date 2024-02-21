import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solution_challenge/routes.dart';
import 'package:solution_challenge/screens/chat_bot.dart';
import 'package:solution_challenge/screens/home_screen.dart';
import 'package:solution_challenge/screens/login_screen.dart';
import 'package:solution_challenge/screens/main_navigation_bar.dart';


void main() async{
  await dotenv.load(fileName: ".env");
  runApp(
     MyApp(),
  );
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter-VariableFont'
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: HomeScreen(),
    );
  }
}


