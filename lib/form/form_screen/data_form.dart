import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solution_challenge/common/utils.dart';
import 'package:solution_challenge/form/form_widgets/custom_picker.dart';
import 'package:solution_challenge/form/form_widgets/submit_button.dart';
import '../../screens/home_screen.dart';
import '../form_widgets/custom_dropdown.dart';
import '../../widgets/custom_text_field.dart';

class DataForm extends StatefulWidget {
  DataForm({super.key});

  @override
  State<DataForm> createState() => _DataFormState();
}

class _DataFormState extends State<DataForm> {
  XFile? _displayImage;

  final _healthFormKey = GlobalKey<FormState>();
  String? _selectedBloodType;
  String? _selectedGender;
  final TextEditingController childNameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController bloodTypeController = TextEditingController();
  final TextEditingController allergiesController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  List<DropdownMenuItem<String>> genders = [
    DropdownMenuItem(
      value: 'M',
      child: Text('Male'),
    ),
    DropdownMenuItem(
      value: 'F',
      child: Text('Female'),
    ),
    DropdownMenuItem(
      value: 'O',
      child: Text('Other'),
    ),
  ];

  void selectImage() async {
    var res = await pickImage();
    setState(() {
      _displayImage = res;
    });
  }
  List<DropdownMenuItem<String>> bloodTypes = [
    DropdownMenuItem(
      value: 'A+',
      child: Text('A+'),
    ),
    DropdownMenuItem(
      value: 'A-',
      child: Text('A-'),
    ),
    DropdownMenuItem(
      value: 'B+',
      child: Text('B+'),
    ),
    DropdownMenuItem(
      value: 'B-',
      child: Text('B-'),
    ),
    DropdownMenuItem(
      value: 'AB+',
      child: Text('AB+'),
    ),
    DropdownMenuItem(
      value: 'AB-',
      child: Text('AB-'),
    ),
    DropdownMenuItem(
      value: 'O+',
      child: Text('O+'),
    ),
    DropdownMenuItem(
      value: 'O-',
      child: Text('O-'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);          },
        ),
        backgroundColor: Colors.transparent, // Transparent AppBar
        elevation: 0, // Remove shadow
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(12.0, 12.0, 8.0, 8.0),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.08,
            ),
            GestureDetector(
              child: _displayImage == null
                  ? Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Image(
                  fit: BoxFit.contain,
                  image: AssetImage(
                    'assets/images/profile_icon.jpg',
                  ),
                ),
              )
                  : Image.file(
                File(
                  _displayImage!.path,
                ),
                height: 180,
                width: 180,
              ),
              onTap: () {
                selectImage();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _healthFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Personal Info Section
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: CustomTextField(
                      controller: childNameController,
                      hintText: 'Child Name',
                      showHint: true,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8.0),
                    child: Text(
                      'Personal Info',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'DOB',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(flex: 3, child: CustomPicker()),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Gender",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: CustomDropdown<String>(
                            selectedValue: _selectedGender,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedGender = newValue;
                              });
                            },
                            dropdownItems: genders,
                            hintText: 'Select Gender',
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Blood Type",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: CustomDropdown<String>(
                            selectedValue: _selectedBloodType,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedBloodType = newValue;
                              });
                            },
                            dropdownItems: bloodTypes,
                            hintText: 'Select a Blood Type',
                          ),
                        ),
                      ],
                    ),
                  ),

                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14.0),
                        child: CustomTextField(
                          controller: addressController,
                          hintText: 'Address',
                          showHint: true,
                        ),
                      ),
                    ],
                  ),

                  // Adding some space between sections

                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                    child: Text(
                      'Health Info',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Weight',
                            style: TextStyle(fontSize: 16),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: CustomTextField(
                            controller: weightController,
                            hintText: 'Weight',
                            showHint: false,
                          ),
                          flex: 3,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 24.0),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            'Height',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: CustomTextField(
                            controller: heightController,
                            hintText: 'Height',
                            showHint: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      controller: allergiesController,
                      hintText: 'Allergies(if any)',
                      showHint: true,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: SubmitButton(
                text: "Submit",
                onTap: () {
                  if (_healthFormKey.currentState!.validate()) {}
                },
              ),
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.7,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.06,
            ),
            Container(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
