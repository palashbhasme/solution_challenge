import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/custom_text_field.dart';

class DataFrom extends StatelessWidget {
  DataFrom({super.key});

  final _signUpFormKey = GlobalKey<FormState>();

  final TextEditingController childNameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController bloodTypeController = TextEditingController();
  final TextEditingController guardianNameController = TextEditingController();
  final TextEditingController relationshipController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 120,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.brown)),
                    height: 140,
                    width: 140,
                    child: Image.network(
                        'https://writingcenter.fas.harvard.edu/sites/hwpi.harvard.edu/files/styles/os_files_xxla'
                        'rge/public/writingcenter/files/person-icon.png?m=1614398157&itok=Bvj8bd7F'),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Colors.white,
              child: Form(
                key: _signUpFormKey,
                child: Column(
                  children: [  // Personal Info Section
                    Text(
                      'Personal Info',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: childNameController,
                      decoration: InputDecoration(labelText: 'Child Name'),
                    ),
                    TextField(
                      controller: dateOfBirthController,
                      decoration: InputDecoration(labelText: 'Date of Birth'),
                    ),
                    TextField(
                      controller: genderController,
                      decoration: InputDecoration(labelText: 'Gender'),
                    ),

                    // Guardian Info Section
                    SizedBox(height: 20), // Adding some space between sections
                    Text(
                      'Guardian Info',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: guardianNameController,
                      decoration: InputDecoration(labelText: 'Guardian Name'),
                    ),
                    TextField(
                      controller: relationshipController,
                      decoration: InputDecoration(labelText: 'Relationship'),
                    ),
                    TextField(
                      controller: contactController,
                      decoration: InputDecoration(labelText: 'Contact'),
                    ),

                    // Health Info Section
                    SizedBox(height: 20),
                    TextField(
                      controller: addressController,
                      decoration: InputDecoration(labelText: 'Address'),
                    ),
                  // Adding some space between sections
                    Text(
                      'Health Info',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                    TextField(
                      controller: weightController,
                      decoration: InputDecoration(labelText: 'Weight'),
                    ),
                    TextField(
                      controller: heightController,
                      decoration: InputDecoration(labelText: 'Height'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
