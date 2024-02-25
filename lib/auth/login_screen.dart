import 'package:flutter/material.dart';
import 'package:solution_challenge/auth/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solution_challenge/common/global_variables.dart';
import 'package:solution_challenge/auth/register_screen.dart';

import '../screens/home_screen.dart';
import '../widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  AuthServices authServices = AuthServices();
  String? userName;
  String? password;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 100,
        title: Image(
          image: AssetImage('assets/images/logo.png'),
          color: GlobalVariables.secondary_color,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.1,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 32.0, right: 64),
                child: Text(
                  'Glad to have you back!',
                  style: TextStyle(
                    color: GlobalVariables.secondary_color,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 32.0, right: 48),
                child: Text(
                  'Start tracking your health again',
                  style: TextStyle(color: Colors.green, fontSize: 16),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.1,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      labelText: 'User Name',
                      prefixIcon: const Icon(Icons.person),
                      obscureText: false,
                      onSaved: (val) {
                        setState(() {
                          userName = val;
                        });
                      },
                      validator: (val) {
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFormField(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      obscureText: true,
                      onSaved: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      validator: (val) {
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalVariables.secondary_color,
                      elevation: 0,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      authServices.signInUser(
                        context: context,
                        userName: userName,
                        password: password,
                      );
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Don\'t have an account yet? Sign up',
                    style: TextStyle(
                      fontSize: 16,
                      color: GlobalVariables.secondary_color,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
