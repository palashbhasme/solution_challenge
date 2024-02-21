import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge/screens/home_screen.dart';
import 'package:solution_challenge/screens/person_list.dart';
import 'package:solution_challenge/common/global_variables.dart';

import '../form/form_screen/data_form.dart';

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({super.key});
  static const String routeName = '/main_navigation_bar';

  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    DataForm(),
    PersonList()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: _screens[_currentIndex],
        bottomNavigationBar:  Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0),
          child: CustomNavigationBar(
            strokeColor: Colors.transparent,
            borderRadius: Radius.circular(16),
            iconSize: 28,
            elevation: 2,
            unSelectedColor: GlobalVariables.un_selected_app_bar_color ,
            selectedColor: GlobalVariables.selected_app_bar_color,

            items: [
              CustomNavigationBarItem(icon: Icon(Icons.home)),
              CustomNavigationBarItem(icon: Icon(Icons.list_alt_outlined)),
            ],
            onTap: (int index){
              setState(() {
                _currentIndex = index;

              });
            },
            currentIndex: _currentIndex,
            isFloating: true,

          ),
        ),
      ),
    );
  }
}
