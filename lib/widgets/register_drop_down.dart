import 'package:flutter/material.dart';

import '../../common/global_variables.dart';

class RegisterDropDown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> dropdownItems;
  final T? selectedValue;
  final ValueChanged<T?> onChanged;
  final String hintText;

  const RegisterDropDown({
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
        border: Border.all(
          width: 1,
          color: Colors.grey
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),

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
