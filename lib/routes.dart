import 'package:solution_challenge/screens/chat_bot.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge/screens/home_screen.dart';

import 'package:solution_challenge/screens/main_navigation_bar.dart';
import 'package:solution_challenge/screens/map_screen.dart';Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case ChatBot.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ChatBot(),
      );
    case MainNavigationBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MainNavigationBar(),
      );
    case MapScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MapScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Text('Screen does not exists!'),
        ),
      );
  }
}