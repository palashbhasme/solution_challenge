import 'package:flutter/material.dart';


import '../../common/global_variables.dart';class CustomPicker extends StatefulWidget {
  const CustomPicker({Key? key}) : super(key: key);

  @override
  _CustomPickerState createState() => _CustomPickerState();
}

class _CustomPickerState extends State<CustomPicker> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null && pickedDate != _selectedDate) {
          setState(() {
            _selectedDate = pickedDate;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
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
        child: Row(
          children: [
            Expanded(
              child: Text(
                _selectedDate != null
                    ? "${_selectedDate!.day.toString().padLeft(2, '0')}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year}"
                    : 'Select Date',
                style: TextStyle(
                  // Adjust your text style
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2101),
                );

                if (pickedDate != null && pickedDate != _selectedDate) {
                  setState(() {
                    _selectedDate = pickedDate;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
