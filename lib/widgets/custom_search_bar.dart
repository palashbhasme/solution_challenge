import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child: TextField(
        maxLines: 1,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Inter-VariableFont'
        ),
        decoration: InputDecoration(
          filled: true,
          hintText: 'Search...',
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none
          ),
          suffixIcon: Icon(Icons.search)
        ),

      ),
    );
  }
}
