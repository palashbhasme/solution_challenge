import 'package:flutter/cupertino.dart';
import 'package:solution_challenge/models/person_details.dart';

class data_form_service {
  void addPerson({
    required BuildContext context,
    required childName,
    required dob,
    required gender,
    required bloodType,
    required address,
    required weight,
    required height,
    required allergies,
    required ismalnourished,
    required image,
  }) {
    try {
      PersonDetails(
          name: childName,
          address: address,
          height: height,
          weight: weight,
          bloodType: bloodType,
          gender: gender,
          isMalnourished: 'no',
          image: image,
          dob: dob,
          allergies: allergies);
    } catch (e) {}
  }
}
