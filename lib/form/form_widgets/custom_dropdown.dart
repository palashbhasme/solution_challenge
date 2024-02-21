import 'package:flutter/material.dart';

import '../../common/global_variables.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> dropdownItems;
  final T? selectedValue;
  final ValueChanged<T?> onChanged;
  final String hintText;

  const CustomDropdown({
    Key? key,
    required this.dropdownItems,
    required this.onChanged,
    this.selectedValue,
    this.hintText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: GlobalVariables.text_field_color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8.0,
            spreadRadius: 1.0,
            offset: Offset(0, 2.0),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: selectedValue,
          icon: Icon(Icons.arrow_drop_down), // Customizable icon
          items: dropdownItems,
          onChanged: onChanged,
          hint: Text(hintText),
          isExpanded: true,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          dropdownColor: Colors.white, // Dropdown background color
        ),
      ),
    );
  }
}
